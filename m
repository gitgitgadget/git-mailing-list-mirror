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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0F6C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4EE22288
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgLXJZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 04:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgLXJZU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 04:25:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B38C061794
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 01:24:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id h16so1624809edt.7
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 01:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgfJcznEdXgN3Vr7ylEJTQExlTZipzxMs1j1WRRtktw=;
        b=AqTPq3dV0wluF5K2LZj4BvaN5Phjsww0zzqvICBgCm0D4Optfj1GU97uJiuYhL6lyY
         XTJP6RJRrnJeFvw2f/dVOUm2P2LD0gbFC1pSerjC4kgewpeYIDQkVire7Bqy4WF0GV1O
         1UVOQzb028z5k7lizjZy03+8dJTKd+v8i2Lccs2V9k0chw0VWdbXi9smv34oyTRdhTVk
         bGpUesAj0xxbEKDFW/EklQh6zWOo2FZ2wRM0WuYOpGG77INdIiDDuIu6e/3RpGG/E3K1
         EB2JGWJnhdD1HHkLtbFDlk9mHc+zG9C7uaUpIkKtXG7/MxDiRfxE1x2b2FPTlDQa+4mi
         04WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UgfJcznEdXgN3Vr7ylEJTQExlTZipzxMs1j1WRRtktw=;
        b=ZqUIqJbIUJslpw7zpbBSX5QEctQTzCH0VV+8XsnfcKp21Mb+JFX7APznkFZw8nk/Is
         Qpn+KUG9kEPEXt4JpGepXT1A+BXQJSaJXu298A9kHfWHPB+uixWxe4Lzcu40aqOfve7m
         exTfOG46LcDTQHw/o/3QGlrtX794BtTsjImVppO3gMrimm1aEA7mt09/esilCnKE+n0t
         PAfH3k9l/zua1YPhem3B10qnCbpEF+Ba/VwIfYkFB6r+9vMQ2iVCkScnKedXfIf4zrB3
         CTPloUB/T6Aqsn9SRCVNAIsLunWNL+rX7c406aKvKT6Y1WlQIjgcoqCgstCMvyU70EQM
         DpSQ==
X-Gm-Message-State: AOAM531k3XUVuUsNwvx5gK0dmvg8VVFQz6XjCrPIm4EhDggJnK2wzd3E
        kTEKahFqV9ClY5E8nQhnOfoL4rfIdyU=
X-Google-Smtp-Source: ABdhPJz/g3Pcj2toa+rWaghk/NFEIJZ+SYnV3TvTs37PaJEVEn7+BqJbTiXJg1YjUmgMy9PowUFSfQ==
X-Received: by 2002:a05:6402:318f:: with SMTP id di15mr28060661edb.237.1608801878280;
        Thu, 24 Dec 2020 01:24:38 -0800 (PST)
Received: from localhost.localdomain (94-21-146-153.pool.digikabel.hu. [94.21.146.153])
        by smtp.gmail.com with ESMTPSA id z26sm32030297edl.71.2020.12.24.01.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Dec 2020 01:24:37 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t7800-difftool: don't accidentally match tmp dirs
Date:   Thu, 24 Dec 2020 10:24:31 +0100
Message-Id: <20201224092431.13354-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.30.0.rc2.444.gff896a3b01
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

Fix this by tightening those test cases: filter out difftool's
temporary directories from its output, and use here docs to list and
test_cmp to check all files expected to present in those directories
explicitly.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t7800-difftool.sh | 112 ++++++++++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 34 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a578b35761..fe02fe1688 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -439,73 +439,104 @@ run_dir_diff_test () {
 }
 
 run_dir_diff_test 'difftool -d' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+
+	file
+	file2
+	sub
+	EOF
 	git difftool -d $symlinks --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep -v ^/ output >actual &&
+	test_cmp expect actual
 '
 
 run_dir_diff_test 'difftool --dir-diff' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+
+	file
+	file2
+	sub
+	EOF
 	git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep -v ^/ output >actual &&
+	test_cmp expect actual
 '
 
 run_dir_diff_test 'difftool --dir-diff ignores --prompt' '
+	cat >expect <<-\EOF &&
+	file
+	file2
+
+	file
+	file2
+	sub
+	EOF
 	git difftool --dir-diff $symlinks --prompt --extcmd ls branch >output &&
-	grep sub output &&
-	grep file output
+	grep -v ^/ output >actual &&
+	test_cmp expect actual
 '
 
 run_dir_diff_test 'difftool --dir-diff branch from subdirectory' '
 	(
 		cd sub &&
+		cat >expect <<-\EOF &&
+		file
+		file2
+
+		file
+		file2
+		sub
+		EOF
 		git difftool --dir-diff $symlinks --extcmd ls branch >output &&
-		# "sub" must only exist in "right"
-		# "file" and "file2" must be listed in both "left" and "right"
-		grep sub output >sub-output &&
-		test_line_count = 1 sub-output &&
-		grep file"$" output >file-output &&
-		test_line_count = 2 file-output &&
-		grep file2 output >file2-output &&
-		test_line_count = 2 file2-output
+		grep -v ^/ output >actual &&
+		test_cmp expect actual
 	)
 '
 
 run_dir_diff_test 'difftool --dir-diff v1 from subdirectory' '
 	(
 		cd sub &&
+		cat >expect <<-\EOF &&
+		file
+		sub
+
+		file
+		sub
+		EOF
 		git difftool --dir-diff $symlinks --extcmd ls v1 >output &&
-		# "sub" and "file" exist in both v1 and HEAD.
-		# "file2" is unchanged.
-		grep sub output >sub-output &&
-		test_line_count = 2 sub-output &&
-		grep file output >file-output &&
-		test_line_count = 2 file-output &&
-		! grep file2 output
+		grep -v ^/ output >actual &&
+		test_cmp expect actual
 	)
 '
 
 run_dir_diff_test 'difftool --dir-diff branch from subdirectory w/ pathspec' '
 	(
 		cd sub &&
+		cat >expect <<-\EOF &&
+
+		sub
+		EOF
 		git difftool --dir-diff $symlinks --extcmd ls branch -- .>output &&
-		# "sub" only exists in "right"
-		# "file" and "file2" must not be listed
-		grep sub output >sub-output &&
-		test_line_count = 1 sub-output &&
-		! grep file output
+		grep -v ^/ output >actual &&
+		test_cmp expect actual
 	)
 '
 
 run_dir_diff_test 'difftool --dir-diff v1 from subdirectory w/ pathspec' '
 	(
 		cd sub &&
+		cat >expect <<-\EOF &&
+		sub
+
+		sub
+		EOF
 		git difftool --dir-diff $symlinks --extcmd ls v1 -- .>output &&
-		# "sub" exists in v1 and HEAD
-		# "file" is filtered out by the pathspec
-		grep sub output >sub-output &&
-		test_line_count = 2 sub-output &&
-		! grep file output
+		grep -v ^/ output >actual &&
+		test_cmp expect actual
 	)
 '
 
@@ -516,18 +547,31 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory with GIT_DIR set' '
 		GIT_WORK_TREE=$(pwd) &&
 		export GIT_WORK_TREE &&
 		cd sub &&
+		cat >expect <<-\EOF &&
+
+		sub
+		EOF
 		git difftool --dir-diff $symlinks --extcmd ls \
 			branch -- sub >output &&
-		grep sub output &&
-		! grep file output
+		grep -v ^/ output >actual &&
+		test_cmp expect actual
 	)
 '
 
 run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
 	test_when_finished git reset --hard &&
 	rm file2 &&
+	cat >expect <<-\EOF &&
+	file
+	file2
+
+	file
+	file2
+	sub
+	EOF
 	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
-	grep file2 output
+	grep -v ^/ output >actual &&
+	test_cmp expect actual
 '
 
 run_dir_diff_test 'difftool --dir-diff with unmerged files' '
-- 
2.30.0.rc2.444.gff896a3b01

