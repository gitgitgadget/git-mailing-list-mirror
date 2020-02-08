Return-Path: <SRS0=24Vd=34=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1457C35254
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93EE22314
	for <git@archiver.kernel.org>; Sat,  8 Feb 2020 09:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDbHr3hq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgBHJIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Feb 2020 04:08:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37164 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgBHJI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Feb 2020 04:08:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so5251839wmf.2
        for <git@vger.kernel.org>; Sat, 08 Feb 2020 01:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/E7cK3VSiOwE85cFoKaYycycoziCZiL2QoxWjjLcEQ=;
        b=FDbHr3hqag5akZNKfylSfOUnqOLzT4U1XQ3Bfn5VEHaEWuoqGu9QZroG979GubdEfx
         wV724Wwh3hJS7MrTRZaCXUgOAJ7Gtj0ZfAf7t/yiXfGs1+L6bqb4KvQ8ppWjuwC0f/4m
         CHcYI8ajJZnpeIXSjYBWxz9vBS2rJv3xiYgMSi5gFn+tjkH3bz4Ns1zXXqiHEoEYNmUW
         hhE6kK6DB7jWlEcPiMv02Z5JVuEL/0lHAtEMHUmLArS0MwHgsgdP+xxuQ5vS/993XFUm
         nHwFjGqXwYtHSTl4inGlaVIUqkIDxOabbyIhGJJqqM6LnbuQgwAHaGyDPdqzKMxDbpf4
         r3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/E7cK3VSiOwE85cFoKaYycycoziCZiL2QoxWjjLcEQ=;
        b=gW4j2w3WUOr7Q5O5GcuuAsd2HGXHs75G6e5xjxiiHCs3NCCu9xEFo/79PYZxLkhL0H
         ckhIlT3nPtHrrQRKDDQEfFGg2pwbmzBPgvHfRfaVZcmYeiNKJPlMvszoowBNdX+45YRT
         CtB8u/19QGEU0rqYFb6Y7N3qELTM3vFjnLhSyh8pW/6KE+sITqqJYdI9f1b7+ydLB/d/
         h82C/xpPGrKSDenKofSeccoXDHZJ3cz+5GmTLj0CR59tdwJudsUql1BHXbz0xg4h8Gnt
         KHC71qPDGu3PdVbP852g19sMtQt7q1QcvJ+MvNSTHwtb3FIbAfsFX3y2znqxtsbTnZk2
         NUqQ==
X-Gm-Message-State: APjAAAU1kZUGGxLMWnnsjgKn4NF9pwa87sljiIUqHWDLjb8vt5BFRqp4
        X21xAae+CezfxX5Me3XbCAMDjFSp
X-Google-Smtp-Source: APXvYqxTKcYCbVrioiSh4YfUHRkMOPmMF3U6FYyx1cRTs1+AwBc3V2tmxANDXkOUwRjW2zuLZh7AQQ==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr3508178wmi.14.1581152907375;
        Sat, 08 Feb 2020 01:08:27 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id e1sm6999346wrt.84.2020.02.08.01.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 01:08:26 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/13] bisect: use the standard 'if (!var)' way to check for 0
Date:   Sat,  8 Feb 2020 10:06:54 +0100
Message-Id: <20200208090704.26506-4-mirucam@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200208090704.26506-1-mirucam@gmail.com>
References: <20200208090704.26506-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using 'var == 0' in an if condition, let's use '!var' and
make 'bisect.c' more consistent with the rest of the code.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index e81c91d02c..83cb5b3a98 100644
--- a/bisect.c
+++ b/bisect.c
@@ -572,7 +572,7 @@ static int sqrti(int val)
 {
 	float d, x = val;
 
-	if (val == 0)
+	if (!val)
 		return 0;
 
 	do {
@@ -869,7 +869,7 @@ static void check_good_are_ancestors_of_bad(struct repository *r,
 		goto done;
 
 	/* Bisecting with no good rev is ok. */
-	if (good_revs.nr == 0)
+	if (!good_revs.nr)
 		goto done;
 
 	/* Check if all good revs are ancestor of the bad rev. */
-- 
2.25.0

