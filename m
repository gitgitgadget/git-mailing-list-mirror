Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29833C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiKITfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 14:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiKITe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 14:34:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA02AE10
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 11:34:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id t25so49625951ejb.8
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzyRBfBRALVo+sfJlD9vYw/3ec3PlMNP5wnDVwI4uJM=;
        b=gq2EC5haI6XdpErpvsaycHeAipkQAJT/AeGTPk1SseIV2kw3R2YOd42bWzo10ZFQxD
         naNJBXn5OA3rMwsbe4XN+CNjg0O8WWaMO8bT2P3FpTjzXGUjBG/+amtk8Vwxp1B+cN8V
         Lo86TOULGBEbwM7g1jW8ao91h61yQ/BQ99yg7W+3lDssH0AwIHzNT+rnK3ClIrIfzW7r
         Ru9MfLZUrR9rXM/epajGTYMT9gB6bkLpXLRrEVis3ca15p877SoGXzik7KE0nDg/pPDY
         SDZStvTCt3vJntqNu2x9gv7R6WGNbFjetYACFxT5CTKAQgeE0yGmG3f/FbwqFw1FdNRO
         PcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzyRBfBRALVo+sfJlD9vYw/3ec3PlMNP5wnDVwI4uJM=;
        b=seWiXM3IIsLpIsl9yXQfPDU3yb7qM4gpyOid9409k3IXnz+4fi3gffzz2wMCDHDRkf
         EdoVTnC+sOA4E+RoJ53Y3WHH15Wsn+frg/sudwaGp9ODqqov5f6ZHdDJkofL+o30/v5+
         tojbou5IHAvs5NJ2FrwnLlg6gn3WSNPHYYORRDVhcEuFGUWQMOwnL+n7ybQv03qEAoF0
         oK2QrYQchH69WdsZSrxY6YhwRiC9io7FPOWoH+hoqxXciN8PS0fDH18LyXN6nABOcWCc
         GiIJs2Ect+fanPBcHkqkdir+RK9ngEsVNINKmKWvfN+x7tWEnGYXNMeQavY+1EfeGGTp
         Y/WQ==
X-Gm-Message-State: ACrzQf1FRD464w548+7abqDJ28WIO1oOjQ37Nknu9H+RMa5RMexMvmUn
        XpaKd8PmzC7VX6uq8hO2A/vIrNXmrPC99A==
X-Google-Smtp-Source: AMsMyM5zRUv1X+Jj1j9mOcZzsAKrn18KzmWZaXY4g/NFaHqQCYnAmX41WFVY/PmJTZuzhltiU9Zt+w==
X-Received: by 2002:a17:906:cc5b:b0:7a9:e58d:bad9 with SMTP id mm27-20020a170906cc5b00b007a9e58dbad9mr57913543ejb.237.1668022487303;
        Wed, 09 Nov 2022 11:34:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q21-20020a056402041500b004589da5e5cesm7387566edv.41.2022.11.09.11.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:34:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 7/8] submodule tests: test "git branch -t" output and stderr
Date:   Wed,  9 Nov 2022 20:34:35 +0100
Message-Id: <RFC-patch-7.8-00a9e789be7-20221109T192315Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
References: <20221109004708.97668-1-chooglen@google.com> <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "git branch" command will currently make use of the
"--super-prefix", as it will indirectly call submodule_move_head(),
which will have access to the "--super-prefix".

The output could thus be affected by the "--super-prefix". Right now
it isn't in this case, but let's exhaustively assert that that's the
case by testing the output of all of these "git branch -t" commands.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-submodule-update.sh | 98 ++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 2d31fcfda1f..302d095ad9b 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -245,6 +245,17 @@ reset_work_tree_to_interested () {
 	git -C submodule_update/.git/modules/sub1 config submodule.sub2.url "bogus"
 }
 
+test_branch_t_output () {
+	local branchname="$1" &&
+	local start_point="$2" &&
+	cat >expect <<-EOF &&
+	branch '$branchname' set up to track '$start_point'.
+	EOF
+	git branch -t "$branchname" "$start_point" >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+}
+
 # Test that the superproject contains the content according to commit "$1"
 # (the work tree must match the index for everything but submodules but the
 # index must exactly match the given commit including any submodule SHA-1s).
@@ -323,7 +334,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -345,7 +356,7 @@ test_submodule_switch_common () {
 		(
 			cd submodule_update &&
 			mkdir sub1 &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -360,7 +371,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to replace_sub1_with_file &&
 		(
 			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_sub1 &&
 			$command replace_file_with_sub1 &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -384,7 +395,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to replace_sub1_with_directory &&
 		(
 			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			test_branch_t_output replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
 			$command replace_directory_with_sub1 &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -406,7 +417,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -418,7 +429,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
@@ -447,7 +458,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -459,7 +470,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command replace_sub1_with_directory test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
@@ -474,7 +485,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -487,7 +498,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			replace_gitfile_with_git_dir sub1 &&
 			$command replace_sub1_with_file test_must_fail &&
 			test_superproject_content origin/add_sub1 &&
@@ -512,7 +523,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
@@ -527,7 +538,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
 			$command invalid_sub1 &&
 			test_superproject_content origin/invalid_sub1 &&
 			test_submodule_content sub1 origin/add_sub1 &&
@@ -542,7 +553,7 @@ test_submodule_switch_common () {
 		reset_work_tree_to invalid_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t valid_sub1 origin/valid_sub1 &&
+			test_branch_t_output valid_sub1 origin/valid_sub1 &&
 			$command valid_sub1 &&
 			test_superproject_content origin/valid_sub1 &&
 			test_dir_is_empty sub1 &&
@@ -596,7 +607,7 @@ test_submodule_switch_func () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 test_must_fail &&
 			test_superproject_content origin/no_submodule &&
@@ -635,7 +646,7 @@ test_submodule_forced_switch () {
 		reset_work_tree_to no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
@@ -675,7 +686,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -688,7 +699,7 @@ test_submodule_recursing_with_args_common () {
 		(
 			cd submodule_update &&
 			mkdir sub1 &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
 			test_submodule_content sub1 origin/add_sub1
@@ -701,7 +712,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested replace_sub1_with_file &&
 		(
 			cd submodule_update &&
-			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
+			test_branch_t_output replace_file_with_sub1 origin/replace_file_with_sub1 &&
 			$command replace_file_with_sub1 &&
 			test_superproject_content origin/replace_file_with_sub1 &&
 			test_submodule_content sub1 origin/replace_file_with_sub1
@@ -713,19 +724,20 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested replace_sub1_with_directory &&
 		(
 			cd submodule_update &&
-			git branch -t replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
+			test_branch_t_output replace_directory_with_sub1 origin/replace_directory_with_sub1 &&
 			$command replace_directory_with_sub1 &&
 			test_superproject_content origin/replace_directory_with_sub1 &&
 			test_submodule_content sub1 origin/replace_directory_with_sub1
 		)
 	'
+
 	# Switching to a commit with nested submodules recursively checks them out
 	test_expect_success "$command: nested submodules are checked out" '
 		prolog &&
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recursively &&
 			$command modify_sub1_recursively &&
 			test_superproject_content origin/modify_sub1_recursively &&
 			test_submodule_content sub1 origin/modify_sub1_recursively &&
@@ -740,7 +752,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			$command remove_sub1 &&
 			test_superproject_content origin/remove_sub1 &&
 			! test -e sub1 &&
@@ -753,7 +765,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t remove_sub1 origin/remove_sub1 &&
+			test_branch_t_output remove_sub1 origin/remove_sub1 &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules &&
 			$command remove_sub1 &&
@@ -769,7 +781,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file &&
 			test -f sub1
@@ -786,7 +798,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			: >sub1/untrackedfile &&
 			test_must_fail $command replace_sub1_with_file &&
 			test_superproject_content origin/add_sub1 &&
@@ -801,7 +813,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
-			git branch -t no_submodule origin/no_submodule &&
+			test_branch_t_output no_submodule origin/no_submodule &&
 			$command no_submodule &&
 			test_superproject_content origin/no_submodule &&
 			! test_path_is_dir sub1 &&
@@ -817,7 +829,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1
@@ -830,7 +842,7 @@ test_submodule_recursing_with_args_common () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t invalid_sub1 origin/invalid_sub1 &&
+			test_branch_t_output invalid_sub1 origin/invalid_sub1 &&
 			test_must_fail $command invalid_sub1 2>err &&
 			test_i18ngrep sub1 err &&
 			test_superproject_content origin/add_sub1 &&
@@ -844,13 +856,13 @@ test_submodule_recursing_with_args_common () {
 		(
 			cd submodule_update &&
 			git -C sub1 checkout -b keep_branch &&
-			git -C sub1 rev-parse HEAD >expect &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			git -C sub1 rev-parse HEAD >expect.rev-parse &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1 &&
 			git -C sub1 rev-parse keep_branch >actual &&
-			test_cmp expect actual &&
+			test_cmp expect.rev-parse actual &&
 			test_must_fail git -C sub1 symbolic-ref HEAD
 		)
 	'
@@ -894,7 +906,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			: >sub1 &&
 			test_must_fail $command add_sub1 &&
 			test_superproject_content origin/no_submodule &&
@@ -908,7 +920,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			: >sub1 &&
 			mkdir .git/info &&
 			echo sub1 >.git/info/exclude &&
@@ -925,7 +937,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory &&
 			test_submodule_content sub1 origin/replace_sub1_with_directory
@@ -937,7 +949,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules &&
 			$command replace_sub1_with_directory &&
@@ -954,7 +966,7 @@ test_submodule_switch_recursing_with_args () {
 		(
 			cd submodule_update &&
 			rm -rf .git/modules/sub1/info &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			mkdir .git/modules/sub1/info &&
 			echo ignored >.git/modules/sub1/info/exclude &&
 			: >sub1/ignored &&
@@ -969,7 +981,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			git -c submodule.recurse=true $cmd_args modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
 			test_submodule_content sub1 origin/modify_sub1
@@ -981,7 +993,7 @@ test_submodule_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_nested_sub &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1_recursively origin/modify_sub1_recursively &&
+			test_branch_t_output modify_sub1_recursively origin/modify_sub1_recursively &&
 			$command modify_sub1_recursively &&
 			test_superproject_content origin/modify_sub1_recursively &&
 			test_submodule_content sub1 origin/modify_sub1_recursively &&
@@ -1009,7 +1021,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested no_submodule &&
 		(
 			cd submodule_update &&
-			git branch -t add_sub1 origin/add_sub1 &&
+			test_branch_t_output add_sub1 origin/add_sub1 &&
 			>sub1 &&
 			$command add_sub1 &&
 			test_superproject_content origin/add_sub1 &&
@@ -1023,7 +1035,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			$command replace_sub1_with_directory &&
 			test_superproject_content origin/replace_sub1_with_directory
 		)
@@ -1034,7 +1046,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_directory origin/replace_sub1_with_directory &&
+			test_branch_t_output replace_sub1_with_directory origin/replace_sub1_with_directory &&
 			replace_gitfile_with_git_dir sub1 &&
 			rm -rf .git/modules/sub1 &&
 			$command replace_sub1_with_directory &&
@@ -1049,7 +1061,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t replace_sub1_with_file origin/replace_sub1_with_file &&
+			test_branch_t_output replace_sub1_with_file origin/replace_sub1_with_file &&
 			: >sub1/expect &&
 			$command replace_sub1_with_file &&
 			test_superproject_content origin/replace_sub1_with_file
@@ -1062,7 +1074,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested invalid_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t valid_sub1 origin/valid_sub1 &&
+			test_branch_t_output valid_sub1 origin/valid_sub1 &&
 			$command valid_sub1 &&
 			test_superproject_content origin/valid_sub1 &&
 			test_submodule_content sub1 origin/valid_sub1
@@ -1077,7 +1089,7 @@ test_submodule_forced_switch_recursing_with_args () {
 		reset_work_tree_to_interested add_sub1 &&
 		(
 			cd submodule_update &&
-			git branch -t modify_sub1 origin/modify_sub1 &&
+			test_branch_t_output modify_sub1 origin/modify_sub1 &&
 			echo "gitdir: bogus/path" >sub1/.git &&
 			$command modify_sub1 &&
 			test_superproject_content origin/modify_sub1 &&
-- 
2.38.0.1467.g709fbdff1a9

