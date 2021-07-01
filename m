Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C249C11F69
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C306141C
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbhGAOuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbhGAOuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7167C0613DE
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:06 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so3145364wms.5
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CanizR/UrFodlfR4fnEKm8+XPFHtacDLVABF8p2xfR4=;
        b=LO/5hAaLBO8lxBK0Kgt+4lIChL5qOpwDGriLdfumMpum69O+bTbe9ArH64zRQvBHP+
         pyUvP5MIjqD72xK/rA4ofnCURe2U7k7Fy7XfrBDiaHa5u4xAWCrtUzpstqG4dbF/rr9q
         cCRQ2S4Y2vcDDabQWcQcVRZ83MjcVV/KhYBDd1xs8vAbQUEfxKH45mIdQHKmdt2qMVlU
         lY4uUVwwmBKV85UNIuSzpvl+cAnSokr5QK3xXWtCbMlDZ9JArA6Kv3iIe5Vn0Dou5Vqs
         GP91plcEYAxEvrMb0l1AjyPzYod4wrMH8OGawG8QLWxbJ2lA1rWNxSlPd7iDqvzfVYpu
         GohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CanizR/UrFodlfR4fnEKm8+XPFHtacDLVABF8p2xfR4=;
        b=FOacgZIfxUlg3089VPTSGdngfHNran3V+9S2PVHv5t8jJTp2/6X3MaxGa0lZ5c0pjg
         +/LhAYc9ZQa42UzKiCXRXYAL64oiqS2AwSfyLMDb0GAyqAj9ZXcmxijP/Gx4iFsrGWiB
         EJ6Hn9TkzFZnRxWD6w3p/aEr2AvHHwxo8YH/pgvRWaEZB/UrrKshS0oOyD1593f2o6FL
         sCmSQz7h8pEctah819m8Cfi20PC9dWfv/xkX/z60wlsRkFi5Vb9t560x6HjrNzyqtYxj
         8+rRNWQjhYXm1eYo7MNy9MlA8z704C311U/l+bOAw/33B717sG33uwaI3UYPx7GoS6DC
         7IVA==
X-Gm-Message-State: AOAM532/nuSou/t2wW+sYbtF880ZY5OlaC8BaCY+kOiLpA3AyvcLtyZs
        M7LXKVw3GZAr6NH7haVthq+hBouQYpw=
X-Google-Smtp-Source: ABdhPJzZbzyWVOQXREC6Ydx4nECNICpB2r5d18I6jkybLUgLyPUwFVkz8KAWyAS8Zd2lBuQIorDe7Q==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr11192356wmi.87.1625150885439;
        Thu, 01 Jul 2021 07:48:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9sm169405wru.3.2021.07.01.07.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:05 -0700 (PDT)
Message-Id: <97dce46d1d04527a540de37d814ca094e487623a.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:42 +0000
Subject: [PATCH v3 32/34] t7527: test status with untracked-cache and
 fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
features and a series of edits and verify that status output is
identical.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 58b56dc9940..d1832702397 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -152,6 +152,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.useBuiltinFSMonitor= add . &&
@@ -494,4 +496,89 @@ test_expect_success 'cleanup worktrees' '
 	stop_daemon_delete_repo wt-base
 '
 
+# The next few tests perform arbitrary/contrived file operations and
+# confirm that status is correct.  That is, that the data (or lack of
+# data) from fsmonitor doesn't cause incorrect results.  And doesn't
+# cause incorrect results when the untracked-cache is enabled.
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
+	test_might_fail git config --unset core.useBuiltinFSMonitor &&
+	git update-index --no-fsmonitor &&
+	test_might_fail git fsmonitor--daemon stop
+'
+
+matrix_clean_up_repo () {
+	git reset --hard HEAD
+	git clean -fd
+}
+
+matrix_try () {
+	uc=$1
+	fsm=$2
+	fn=$3
+
+	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
+		matrix_clean_up_repo &&
+		$fn &&
+		if test $uc = false -a $fsm = false
+		then
+			git status --porcelain=v1 >.git/expect.$fn
+		else
+			git status --porcelain=v1 >.git/actual.$fn
+			test_cmp .git/expect.$fn .git/actual.$fn
+		fi
+	'
+
+	return $?
+}
+
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+for uc_val in $uc_values
+do
+	if test $uc_val = false
+	then
+		test_expect_success "Matrix[uc:$uc_val] disable untracked cache" '
+			git config core.untrackedcache false &&
+			git update-index --no-untracked-cache
+		'
+	else
+		test_expect_success "Matrix[uc:$uc_val] enable untracked cache" '
+			git config core.untrackedcache true &&
+			git update-index --untracked-cache
+		'
+	fi
+
+	fsm_values="false true"
+	for fsm_val in $fsm_values
+	do
+		if test $fsm_val = false
+		then
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
+				test_might_fail git config --unset core.useBuiltinFSMonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop 2>/dev/null
+			'
+		else
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
+				git config core.useBuiltinFSMonitor true &&
+				git fsmonitor--daemon start &&
+				git update-index --fsmonitor
+			'
+		fi
+
+		matrix_try $uc_val $fsm_val edit_files
+		matrix_try $uc_val $fsm_val delete_files
+		matrix_try $uc_val $fsm_val create_files
+		matrix_try $uc_val $fsm_val rename_files
+		matrix_try $uc_val $fsm_val file_to_directory
+		matrix_try $uc_val $fsm_val directory_to_file
+	done
+done
+
 test_done
-- 
gitgitgadget

