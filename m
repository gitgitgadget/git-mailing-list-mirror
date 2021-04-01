Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C621C43461
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 780C86112E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhDARxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhDARu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:50:29 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D9C02D54D
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:23 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b9so2265968wrt.8
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tUFUaBwZpxy4xLgtQxuoUKmW481VJeosYXJytJus27E=;
        b=YMkW3J/gK9W2l0WseD22dnmv51vLx7TWPywe4k0teYR3/6m89IQTFPtfVTHosXPhBP
         fWvpplu025+6Xhsnq1lplPa16q4DJScoXglXDpY8PJhPIr3lSbYtI6okOPjQwpqbSnCl
         FXhRIFdNL8cO4sjbo9zNw/GzySQpZex0vmhGB9KecvKBpB/ZDhZ9bHp5khkb6mwF4y2z
         PLMsK1B3e7RcFRh68Dx+hono6zyZOpqZuAtouM2nQ41cl7qMS3CptBC0E2bTGJptsX9Z
         U91CauaWVMfEOESf1Z6QbyRdcvZjC9tgZCm180rxwQkGdx4FiBASumxwHWTv5ybQEHpd
         GvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tUFUaBwZpxy4xLgtQxuoUKmW481VJeosYXJytJus27E=;
        b=WVd5E2fCn1u8mygA1ZhhouoOZrMtb4aH0cajnZV0rm2jmW4Vj3gfYwifbyG3TTfOFt
         7BBFOcnG/S5/foYE2epJXCw8QCRm0G8OnDB+eDy0LGSnT1iscCnEOynoGF3LHRXVYI2t
         cNCsu6eshuOosRyd2JuRYtrk3PLebkbMPvEL5i382ugVdmu9MRibuM8B1yGZd2Bhrfu4
         PcGcBDh2sH8U/fmz9TGQ9lK/nae8YbJx1QwCBTtbZmlEOsLvoM7BtvVBbzmOqVpdt9MC
         E7+cNypFUE/lAUpkqTK0tldIEptR9VRKdJxl7kVhOAzTLbYCJA/C2oW0ASkGJk2jXVVq
         5WVw==
X-Gm-Message-State: AOAM531ReANqlzJC8L5BZTiNSDeUFeBnZ3fjdctBJCCI3kRRwrirHcsO
        EffCH94kISxNdygJ5MUZSeOYxec9nGI=
X-Google-Smtp-Source: ABdhPJzUtQJmO7k9ZrgffRkB7THUa4/+SPBldp7G5Ee8OAbZGIu2YIIr95upyU5AgaEUlulgiEw/gA==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr10434368wru.312.1617291682022;
        Thu, 01 Apr 2021 08:41:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm8815883wmh.13.2021.04.01.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:21 -0700 (PDT)
Message-Id: <3eafd0b5cb09dbba8af2abf1a8d602ad27ad3bc4.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:05 +0000
Subject: [PATCH 23/23] t7527: test status with untracked-cache and
 fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
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
index 1fd230f1d4c6..ad2188169db7 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -163,6 +163,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.useBuiltinFSMonitor= add . &&
@@ -482,4 +484,99 @@ test_expect_success 'worktree with .git file' '
 	test_must_fail git -C wt-secondary fsmonitor--daemon --is-running
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
+	test_might_fail git fsmonitor--daemon --stop
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
+				test_might_fail git fsmonitor--daemon --stop 2>/dev/null
+			'
+		else
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
+				git config core.useBuiltinFSMonitor true &&
+				git fsmonitor--daemon --start &&
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
