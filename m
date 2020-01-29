Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442CBC33CB7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194E62082E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="Lnr3coRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgA2LM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42016 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgA2LM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id k11so5006668wrd.9
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kdmdJ9wlO1X4rPbxugwNxNK8y6+/JefcUJoqNZWSdME=;
        b=Lnr3coRLYn02Ej9fUGTM67MGgWQud5ccvvVS3IApGJvJo7MfTraN/MHbpSjShGRsnF
         gSkr6T6tW/h9pxPazxJ2dGZA47IEIJV8aqxnp4ymXrTPB1atB0fHBuKxT+SH2IxdtCAM
         KpRKNWA0Sxp0swJggpQzZKRSjN/Bv+DFyoW+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kdmdJ9wlO1X4rPbxugwNxNK8y6+/JefcUJoqNZWSdME=;
        b=eas8dZ/ogm7Z1pDBwr087VVhceehIL4wvBjjnAgzyzrnTi6inrvWaYwzNgvDC+DHGF
         nW2N7V4Bk1BXNAbDh/KG/RuktTRev4kgsI8N3/rocUBqahpW5yF5IylNr0yWlIlr6mhV
         nWLiJlAAJoPqquSqDbjKl08dS7z5t6ja9mt0qv4ZlLwuJ6Edga9Z7ltXul3xG7PBQApV
         N6LtjNhIjDbL3vI8y4vWlu+YOfncnqj1vSY9OO/D76SVT+TZQ6Hm0osDAcoWTNds7174
         fdnswrOyUn/DmObz5nBaYveRbqm8oNh7Wcb8GpsQfZvelR3aFbgw9KZtIem0xtbbbn5o
         ZxHA==
X-Gm-Message-State: APjAAAVBzMDmQxnTPiK5VHqCU4y1RxKAcHTuI7tDL30Bfz7zB9PqV7Z9
        P5Ev4tOkbOWCSclKq02bwdKjFMpAzRw=
X-Google-Smtp-Source: APXvYqw/AXu0Rh+Zl00QHM7VAmL2jLNSNBpiwPgn9aUEWhf0TXHofa30gIN9X44r8em/8bhzKWn1rA==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr33096657wrq.243.1580296375908;
        Wed, 29 Jan 2020 03:12:55 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:55 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 6/6] git-p4: check for access to remote host earlier
Date:   Wed, 29 Jan 2020 11:12:46 +0000
Message-Id: <20200129111246.12196-7-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-6-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
 <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org>
 <20200129111246.12196-4-luke@diamand.org>
 <20200129111246.12196-5-luke@diamand.org>
 <20200129111246.12196-6-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check we can talk to the remote host before starting the git-fastimport
subchild.

Otherwise we fail to connect, and then exit, leaving git-fastimport
still running since we did not wait() for it.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index a69a24bf4c..eb5bc28cf9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3826,6 +3826,8 @@ def run(self, args):
                     b = b[len(self.projectName):]
                 self.createdBranches.add(b)
 
+        p4_check_access()
+
         self.openStreams()
 
         err = None
-- 
2.20.1.390.gb5101f9297

