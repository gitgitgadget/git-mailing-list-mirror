Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9CC55178
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36B422202
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIVJvUDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410338AbgJ0W6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:58:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37838 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgJ0W6M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:58:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id c16so3043197wmd.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2020 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/u28iYhIxNhzmuQuqq53BAOEl/z6SgoAiMnnfdwkBrU=;
        b=bIVJvUDxN8pEUudQZFZwWOeOvwCNKSuKl5RO4h/hY8kFqFRd+4Vave1UCmV+0yW3Kp
         PR/eEp2b713NLu8TiGFI1gGzFP99DnrjSms1r9FcxHoMP2KaW0ANOAMD7ELNWsLwRNAd
         Z0V/WtoNROvQg+iygv5ymNLZI0qWT0uNU46qqBP0FoNw4rRAnqEl1RRsqIJ2wivC8TcY
         K0B2wMj4dcx/2YwMU6VCtDyCV+Ner17nTxDqzHtxjxR51ldNe7nHgG/e9ajF4IJ4IzN4
         pVUmpkO2Xo66BDSqQh5SnR0cO71ItCMHs0ab+GAofJdG3yQw7vdHisFXj/ZOuIZRCiX3
         5qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/u28iYhIxNhzmuQuqq53BAOEl/z6SgoAiMnnfdwkBrU=;
        b=OTZwlhmql8D2Sf2P+6KhoFI2ZMl6DhH80LyHCB3PziHgope6Oe3vIZxG9z5lUXsJa6
         0N+Ho5QEySlqjBWc5w5KCNbnmHFUuY8XlsmoC3tuvftyn6Dx8RUdaKIlquRj/1krfi+x
         omjJljEQhbLM3iYyYXRXoqgFT0YPpGnKWMbh8pP5NNGGntB5+bJu2iHi1BH/EnQ2CVgp
         BGs8Om95E9u5PsgolNuKN/sB2gInHqYSJaYYdkXdw+wBxvc8wsE3XwM8a0nTwfkdV4zb
         12OcFK1C/vwOag2beunGcIZDfBhSp0YJuhdhWe8gCLS19msqXjc7m8qXa/vrOnKSemw6
         0wvA==
X-Gm-Message-State: AOAM531lXT7wcQNggjPoiSWbo9IVGSgutcndWWYMsasl94yoe36EZZfD
        5Fb9/PTnDXzzwq0NWKo2diLoaNoW/p0=
X-Google-Smtp-Source: ABdhPJwrSZE3TQy3hNJ9wdP919GvYr6wEfP+HRTrngsmVyeX59y+iXuvaWqoj/eNHUxQGWrV2dnxNA==
X-Received: by 2002:a1c:96ca:: with SMTP id y193mr4952874wmd.22.1603839489833;
        Tue, 27 Oct 2020 15:58:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g17sm4087894wrw.37.2020.10.27.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 15:58:09 -0700 (PDT)
Message-Id: <f997166db4c29d971a2343f70c9d9a0505a8cc4b.1603839487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.760.git.1603839487.gitgitgadget@gmail.com>
References: <pull.760.git.1603839487.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 22:58:04 +0000
Subject: [PATCH 1/4] t5411: start using the default branch name "main"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a straight-forward search-and-replace in the test script;
However, this is not yet complete because it requires many more
replacements in `t/t5411/`, too many for a single patch (the Git mailing
list rejects mails larger than 100kB). For that reason, we disable this
test script temporarily via the `PREPARE_FOR_MAIN_BRANCH` prereq.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5411-proc-receive-hook.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t5411-proc-receive-hook.sh b/t/t5411-proc-receive-hook.sh
index 746487286f..06bbb02ed2 100755
--- a/t/t5411-proc-receive-hook.sh
+++ b/t/t5411-proc-receive-hook.sh
@@ -7,11 +7,16 @@ test_description='Test proc-receive hook'
 
 . ./test-lib.sh
 
+test_have_prereq PREPARE_FOR_MAIN_BRANCH || {
+	test_skip="In transit for the default branch name 'main'"
+	test_done
+}
+
 . "$TEST_DIRECTORY"/t5411/common-functions.sh
 
 setup_upstream_and_workbench () {
-	# Refs of upstream : master(A)
-	# Refs of workbench: master(A)  tags/v123
+	# Refs of upstream : main(A)
+	# Refs of workbench: main(A)  tags/v123
 	test_expect_success "setup upstream and workbench" '
 		rm -rf upstream.git &&
 		rm -rf workbench &&
@@ -25,10 +30,10 @@ setup_upstream_and_workbench () {
 			git config core.abbrev 7 &&
 			git tag -m "v123" v123 $A &&
 			git remote add origin ../upstream.git &&
-			git push origin master &&
-			git update-ref refs/heads/master $A $B &&
+			git push origin main &&
+			git update-ref refs/heads/main $A $B &&
 			git -C ../upstream.git update-ref \
-				refs/heads/master $A $B
+				refs/heads/main $A $B
 		) &&
 		TAG=$(git -C workbench rev-parse v123) &&
 
@@ -99,8 +104,8 @@ start_httpd
 # Re-initialize the upstream repository and local workbench.
 setup_upstream_and_workbench
 
-# Refs of upstream : master(A)
-# Refs of workbench: master(A)  tags/v123
+# Refs of upstream : main(A)
+# Refs of workbench: main(A)  tags/v123
 test_expect_success "setup for HTTP protocol" '
 	git -C upstream.git config http.receivepack true &&
 	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-- 
gitgitgadget

