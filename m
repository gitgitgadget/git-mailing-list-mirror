Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42443C4707E
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C8661244
	for <git@archiver.kernel.org>; Sat, 22 May 2021 13:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhEVN7V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 09:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhEVN6y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 09:58:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67B0C061343
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n2so23816324wrm.0
        for <git@vger.kernel.org>; Sat, 22 May 2021 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wqD1wAVn4t0gvnt0JUw+dLSMFpMCzqYvNsIe2Nw5PRU=;
        b=MbvSFlskADutqq/lVXHWTfU1+N5rnPq5HBb0tmaPzeI58kruKFZignhJoZWoIbFVoN
         bolgdon25U59niXgQd6d9LzHJTwOviv1yKmtYVGyqwDW5aqmsHw5hmqSAGojHOOJBExs
         0zoDOesRcU6L2PVA7ehHuNzN7t0MCVErr4E6d84X+jG/BRYIH9t9wjK68w9TivlOzpe7
         0++lR0zhbFdd48JlGsQx9y4V/szni0jpvp0kUezEs4rs4tI03WB0ZivdRWNTjAE5vwBU
         C2pPndOzwT9z3boqkx0z3N/AO32+3KOi23yyo73yyhfMbVkenCUJxM4jJZ2hAFLsOaG7
         obSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wqD1wAVn4t0gvnt0JUw+dLSMFpMCzqYvNsIe2Nw5PRU=;
        b=GBmgChdrVqk6gnoX+q60xs0+oizhetpAA6xbaj7uFuUTaFDjiLMjJ5vOfw7r3BCn94
         O5b+ATWn2gpkXBOifTeceZ686OIZBa+TGz80DKC3jVWOhxkbhbqV6VffYCkkKWyBqaFe
         Ws1svIOoa1RCTqUqYnCNeDgzuGpkGTRjtVC0Sd/dYwNrqsmvT5hY8kus04tVIvWft0Mk
         ztXVd5e8l1zdVuVeHQIHh15qEeDP1Kqx4ua/dOSxea05wUPLzXRa6Cv0kcUccwexzIKQ
         WnyNNOVAc5/aToZnNdCvhYkTTAVDhVZMA/H8RR8OW6Xr0eQ4pvsHty6SOL2Dn0XmkZnL
         aqIw==
X-Gm-Message-State: AOAM532pArFCJWMkzz7U3XdezhHyMcfZVpR3j6emFW2xWLPqRFiwnb+d
        B0LgayMAT4lxmi2lrR693e8YFmVDnbk=
X-Google-Smtp-Source: ABdhPJw7N4/TjDt21XbAGFdNL3ajruvpOzW8hqA7KNYWYJS/Y0wMQixu4SnqK6iUWwiejFhyiTgekQ==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr14308714wre.183.1621691847263;
        Sat, 22 May 2021 06:57:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm2568628wmc.41.2021.05.22.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 06:57:26 -0700 (PDT)
Message-Id: <1483c68855cbdf2adfa27e1a429e1693ce3ba6ff.1621691828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
        <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 May 2021 13:57:06 +0000
Subject: [PATCH v2 27/28] t7527: test status with untracked-cache and
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
 t/t7527-builtin-fsmonitor.sh | 97 ++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index eaed44ebad63..106adc2a7ee0 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -153,6 +153,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.useBuiltinFSMonitor= add . &&
@@ -472,4 +474,99 @@ test_expect_success 'worktree with .git file' '
 	test_must_fail git -C wt-secondary fsmonitor--daemon status
 '
 
+# TODO Repeat one of the "edit" tests on wt-secondary and confirm that
+# TODO we get the same events and behavior -- that is, that fsmonitor--daemon
+# TODO correctly listens to events on both the working directory and to the
+# TODO referenced GITDIR.
+
+test_expect_success 'cleanup worktrees' '
+	kill_repo wt-secondary &&
+	kill_repo wt-base
+'
+
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

