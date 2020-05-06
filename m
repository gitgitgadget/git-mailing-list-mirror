Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C0C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0CF206D5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 08:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA70+mAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgEFIAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 04:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728290AbgEFIAs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 04:00:48 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE42C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 01:00:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so476523pjb.3
        for <git@vger.kernel.org>; Wed, 06 May 2020 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNlZHvW1cgA6bCjxfw3juRdvEUSWfAvm7+3h/d3dAX0=;
        b=WA70+mAiAorI72C9P3Afv3lGl6Y+YpyAA3wAHD5RSWAfHjMb7UUEriKu2kXn0PEY8V
         I6yXQj9DzlhPd38nU/c7PxtzhJiVE9ubxYc+lZwfe+yrmFHfzr3dOqPc3RCobk/cmQ38
         mhkz/VqqEEI+GfjoLHQDM8R0rMjg2/56n63Syd+ZOVe8T4DoliU+9Q5vKfBSf4FKuOc1
         ZHr93z9MFJQzjPACS3NR+kj3Wc67LB9tkcO4tlrWyUM3Gn2apQ67z3rtwRauA2zid3TS
         Z3EKHWNoa5T3BFZtVZFtAel6Upar/gRMiM59HRwwsoWuqZVh7QmW/69baU3t/PUwBi9C
         CA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNlZHvW1cgA6bCjxfw3juRdvEUSWfAvm7+3h/d3dAX0=;
        b=o6Bb4f/nQjBu9x3ehw91Pt1HC4EKVXR2qizOJkx6qxTxzKN4vC9VOuHWgsTvRP2gFp
         o5+2RiTkNS0RMKuDQzb7z6vgH501ylrZG8KgL+GTwvpZLdPUaKp3tjrHtMYCZXpC+n3x
         nCeRWZc900uBP0lx9AUxn4+S6y3SSPYM9Mo8pmB+OwDG74+P6Cg4v3aXjGaCnVvM4ynb
         dQXemP9kOHXcY49n9ymuHSqq/utL/NPeOuEJcQHxuSHKYjKEq51Fqa4yaEgsXdHoNWoM
         jQt2zWf8Io4G3kbZmwBnEVa/1chuiKjtMtSI2VTqGTRLfmoRW5/6CMLbt0ZHlhPuFFgi
         n7xA==
X-Gm-Message-State: AGi0PuYa/mIW/k4viGnBFMwyFtvMZF1Ts/FV6enyGkYFzNnZVnr1b+g6
        NMI58IhkLEWNbkF2BJW2V8UbBMvqAKKi5A==
X-Google-Smtp-Source: APiQypJeSpmDtPHhP9XgGdCoTI3XuTlwOxxOu8LWskphP81Mx/XaajSmS3TyPZ2ExLzEcCw0aIXHXQ==
X-Received: by 2002:a17:90a:1b0c:: with SMTP id q12mr7263730pjq.116.1588752045807;
        Wed, 06 May 2020 01:00:45 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id s44sm4312629pjc.28.2020.05.06.01.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 01:00:45 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, sandals@crustytoothpaste.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v6 2/4] gitfaq: changing the remote of a repository
Date:   Wed,  6 May 2020 13:30:21 +0530
Message-Id: <20200506080023.12521-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
References: <20200506080023.12521-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add issue in 'Common Issues' section which addresses the problem of
changing the remote of a repository.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 Documentation/gitfaq.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 11d9bac859..875cfa0acd 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -233,6 +233,17 @@ I asked Git to ignore various files, yet they are still tracked::
 	and add a pattern to `.gitignore` that matches the <file>.
 	See linkgit:gitignore[5] for details.
 
+[[changing-remote-of-the-repository]]
+I want to change the remote of my repository. How do I do that?::
+	A remote is an identifier for a location to which Git pushes your
+	changes as well as fetches any new changes from (if any).  There
+	might be different circumstances in which one might need to change
+	the remote URL (see linkgit:git-remote[1]).  To change the remote URL
+	one may use: git remote set-url <name> <newurl>
++
+One can list the remotes of a repository using `git remote -v` command.
+The default name of a remote is 'origin'.
+
 Hooks
 -----
 
-- 
2.26.2

