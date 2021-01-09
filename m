Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAA2C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 319E72343F
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAIRGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 12:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIRGE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 12:06:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA1BC061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 09:05:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 190so10287842wmz.0
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2J0aZIlVeGQ1qToT+N1HHjWxo5AmInC8VWT+NX9CyU=;
        b=HbAXLzx9XRp2G5VfDlhAYaq+hvfFRFiSiNdbgzmKKYqjvUsRA98TjYs4pIoKBsmeFN
         Vp59cRB+brWNm3AwQtuuJZ10l8rt3hcRCC+H0V9msIrj/WkcXG2iAa+tTl4twrVGxqFL
         qO1y1Y1Z9Do0/1ie4LPBSRO6yu4QgGLsQnLP0uMddgcLsTmpRTLIei/088WNqQjJgmf4
         HySqvs/UXIF1XkYV25fDMXhev2aryv0/aPxQmtgOFj1ByigfkV1ldIf1ZmYg52SUOuXL
         cl2snHu44HxlvAow/0hej/UtSe7NNeNEL9IisQiCBoVQ6+agxYyccQcRWRxdXkaDGDLt
         8mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2J0aZIlVeGQ1qToT+N1HHjWxo5AmInC8VWT+NX9CyU=;
        b=dFpvhHsTO/N1DU0uVjWCuYWAk7mnvP2B9j4kKQlEn1iKa4TrIAsWr6gluHWKY+fD4u
         ZA+PBOrfg2zdYW61WLlVbtLwTkpc9BDW+1RaYbB/JKWQD2ZBckoAg3RNmGc4ykWP2LlV
         hf6x2vMDnpVWfS5ig0lqyVnPpmHhLQgq72nRg7V2SjXpPvuP7DHbl4TiCH3/hXOdJQgu
         NyCA82udMaX9kitb0m8dHK1R+a5akcB85H15C96ETxCO3y1Oo7ht7aD6pLVMEMOt9HGX
         O3ne+xwdcDP1JxkQ/8C4si8tlGwIS29naIpG0RivXTD14Gh7U743GyOyDNOSWotRxxaG
         6u6A==
X-Gm-Message-State: AOAM53195QssrMLgDUSySdCGB/bwx/u2Sa+2+WdPhoijU1gf1dzP5Bph
        PqR56ycrMBnzYwb4wDkI0kc=
X-Google-Smtp-Source: ABdhPJyg/OUNlrzzbJqCUGyAVg7jO6WIUa0lcOB/WY1VJtxdr+A/1E7oRW99pa34biUSFGV8IfmmDg==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr7659859wmh.38.1610211922317;
        Sat, 09 Jan 2021 09:05:22 -0800 (PST)
Received: from localhost.localdomain (84-236-109-1.pool.digikabel.hu. [84.236.109.1])
        by smtp.gmail.com with ESMTPSA id b127sm18798874wmc.45.2021.01.09.09.05.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jan 2021 09:05:21 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] t7800-difftool: don't accidentally match tmp dirs
Date:   Sat,  9 Jan 2021 18:05:13 +0100
Message-Id: <20210109170513.31084-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.30.0.337.g235c185d39
In-Reply-To: <20210108092036.GR8396@szeder.dev>
References: <20210108092036.GR8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a bunch of test cases in 't7800-difftool.sh' we 'grep' for specific
filenames in 'git difftool's output, and those test cases are prone to
occasional failures because those filenames might be part of the name
of difftool's temporary directory as well, e.g.:

  +git difftool --dir-diff --no-symlinks --extcmd ls v1
  +grep sub output
  +test_line_count = 2 sub-output
  test_line_count: line count for sub-output != 2
  /tmp/git-difftool.Ssubfq/left/:
  sub
  /tmp/git-difftool.Ssubfq/right/:
  sub
  error: last command exited with $?=1
  not ok 50 - difftool --dir-diff v1 from subdirectory --no-symlinks

Fix this by tightening the 'grep' patterns looking for those
interesting filenames to match only lines where a filename stands on
its own.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7800-difftool.sh | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a578b35761..32291fb67b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -440,20 +440,20 @@ run_dir_diff_test () {
 
 run_dir_diff_test 'difftool -d' '
 	git difftool -d $symlinks --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep "^sub$" output &&
+	grep "^file$" output
 '
 
 run_dir_diff_test 'difftool --dir-diff' '
 	git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep "^sub$" output &&
+	grep "^file$" output
 '
 
 run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
 	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep "^sub$" output &&
+	grep "^file$" output
 '
 
 run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
@@ -462,11 +462,11 @@ run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
 		# "sub" must only exist in "right"
 		# "file" and "file2" must be listed in both "left" and "right"
-		grep sub output >sub-output &&
+		grep "^sub$" output >sub-output &&
 		test_line_count = 1 sub-output &&
-		grep file"$" output >file-output &&
+		grep "^file$" output >file-output &&
 		test_line_count = 2 file-output &&
-		grep file2 output >file2-output &&
+		grep "^file2$" output >file2-output &&
 		test_line_count = 2 file2-output
 	)
 '
@@ -477,11 +477,11 @@ run_dir_diff_test 'difftool --dir-diff v1 from subdirectory' '
 		git difftool --dir-diff $symlinks --extcmd ls v1 >output &&
 		# "sub" and "file" exist in both v1 and HEAD.
 		# "file2" is unchanged.
-		grep sub output >sub-output &&
+		grep "^sub$" output >sub-output &&
 		test_line_count = 2 sub-output &&
-		grep file output >file-output &&
+		grep "^file$" output >file-output &&
 		test_line_count = 2 file-output &&
-		! grep file2 output
+		! grep "^file2$" output
 	)
 '
 
@@ -491,9 +491,9 @@ run_dir_diff_test 'difftool --dir-diff branch from subdirectory w/ pathspec' '
 		git difftool --dir-diff $symlinks --extcmd ls branch -- .>output &&
 		# "sub" only exists in "right"
 		# "file" and "file2" must not be listed
-		grep sub output >sub-output &&
+		grep "^sub$" output >sub-output &&
 		test_line_count = 1 sub-output &&
-		! grep file output
+		! grep "^file$" output
 	)
 '
 
@@ -503,9 +503,9 @@ run_dir_diff_test 'difftool --dir-diff v1 from subdirectory w/ pathspec' '
 		git difftool --dir-diff $symlinks --extcmd ls v1 -- .>output &&
 		# "sub" exists in v1 and HEAD
 		# "file" is filtered out by the pathspec
-		grep sub output >sub-output &&
+		grep "^sub$" output >sub-output &&
 		test_line_count = 2 sub-output &&
-		! grep file output
+		! grep "^file$" output
 	)
 '
 
@@ -518,8 +518,8 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
 		cd sub &&
 		git difftool --dir-diff $symlinks --extcmd ls \
 			branch -- sub >output &&
-		grep sub output &&
-		! grep file output
+		grep "^sub$" output &&
+		! grep "^file$" output
 	)
 '
 
@@ -527,7 +527,7 @@ run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
 	test_when_finished git reset --hard &&
 	rm file2 &&
 	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
-	grep file2 output
+	grep "^file2$" output
 '
 
 run_dir_diff_test 'difftool --dir-diff with unmerged files' '
-- 
2.30.0.337.g235c185d39

