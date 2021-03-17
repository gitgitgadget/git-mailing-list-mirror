Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CC8C433E9
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D6B64F5E
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhCQN2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhCQN2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:28:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9635BC06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so1830200wrn.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KR64Jj+2t6866ECYBYFZOD39qZgshHf7lAYmZv1hc+4=;
        b=BGdd2UvHejYq3ZTdEjfKMz8hemZregjjC8SFxYPaWlYp5/2GDBbPtAfyzpwTZrtaTA
         719fv8+ZKsFBm6ceU4an6K2cM6lrhwHLyHEvjzig9BPt90OtWRNDuZ0c/XPteFmqlXq/
         OJwm5ZiUMPUL4Qqr7rKY8BTo7hCe9LZNui11VHybSRYlIclJmzEFe2JNbXeaVRyVeDO9
         YoxsPqVTj4nJzDtCLxM4u1I0bnTcHuYqAsfru29clW/l7FWqJjEVJhze19icd0Hz3J6o
         Gv37Ug4uemx8Z1ug92yP7D10GDCEnPvW/Nnb1popDYxHoHcWc66sQqSBNrmiH1ecBYRi
         NL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KR64Jj+2t6866ECYBYFZOD39qZgshHf7lAYmZv1hc+4=;
        b=eWin5Ca0xVSTXElhImbH9YMWQ36wvmxsEbDSdeWmwQU87Tad0BjLwVRa4uSAF5yiTY
         d/TUYV3pkjWwPYScJY9hrN42O6kzjc1R+8S78kENRAS+pdeIrWyZqbdyXs97GKM+ifnq
         DaaFu4Qzvz+MLKNinofqIGsTCnxtc8K3rAYeDx72RgD8+T75RiOAp7QCqediAABFgSM8
         R/tuJyBhXQA1yPRHShANh7I3ghqr1fM9w7gnVqeaYOzew33cjze1Ai4pYaYeDWByIU77
         G4gelLGW11v8W2Lfwww97dpmK7Yn4GhaU/T4COFXHPZLsZGTyhR5j83XgYm2ueGNhI//
         Bd3A==
X-Gm-Message-State: AOAM533GnU8cbLhr+5RV9lBnpoyst+qXk3RTYHZ22FZm+SB1CV80zXWE
        UElWymDCKVw5IQhSWoVgI3ue8a8dRXPuzw==
X-Google-Smtp-Source: ABdhPJxwPxXTkOTmT6bM7L7cdp8fitsj1iIXnIFHt0Z0S2EMdrAv9Lrugske2dlCuamdOJeyOQV02A==
X-Received: by 2002:a5d:64ae:: with SMTP id m14mr4452773wrp.153.1615987715059;
        Wed, 17 Mar 2021 06:28:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm26061448wrt.70.2021.03.17.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:28:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        dstolee@microsoft.com
Subject: [RFC/PATCH 3/5] ls-files: add and use a new --sparse option
Date:   Wed, 17 Mar 2021 14:28:12 +0100
Message-Id: <20210317132814.30175-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
References: <dffe8821fde290a1e19b2968098b007b9ac213e6.1615912983.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-ls-files.txt           |  4 ++
 builtin/ls-files.c                       | 10 ++++-
 t/t1091-sparse-checkout-builtin.sh       |  9 ++--
 t/t1092-sparse-checkout-compatibility.sh | 57 ++++++++++++++++--------
 4 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 6d11ab506b..1145e960a4 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -71,6 +71,10 @@ OPTIONS
 --unmerged::
 	Show unmerged files in the output (forces --stage)
 
+--sparse::
+	Show sparse directories in the output instead of expanding
+	them (forces --stage)
+
 -k::
 --killed::
 	Show files on the filesystem that need to be removed due
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 4db75351f2..1ebbb63c10 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -26,6 +26,7 @@ static int show_deleted;
 static int show_cached;
 static int show_others;
 static int show_stage;
+static int show_sparse;
 static int show_unmerged;
 static int show_resolve_undo;
 static int show_modified;
@@ -639,6 +640,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			DIR_SHOW_IGNORED),
 		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
+		OPT_BOOL(0, "sparse", &show_sparse,
+			N_("show unexpanded sparse directories in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
@@ -705,12 +708,17 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		tag_skip_worktree = "S ";
 		tag_resolve_undo = "U ";
 	}
+	if (show_sparse) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_SHOW_IGNORED) || show_killed)
 		require_work_tree = 1;
-	if (show_unmerged)
+	if (show_unmerged || show_sparse)
 		/*
 		 * There's no point in showing unmerged unless
 		 * you also show the stage information.
+		 * The same goes for the --sparse option.
 		 */
 		show_stage = 1;
 	if (show_tag || show_stage)
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ff1ad570a2..c823df423c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -208,12 +208,13 @@ test_expect_success 'sparse-checkout disable' '
 test_expect_success 'sparse-index enabled and disabled' '
 	git -C repo sparse-checkout init --cone --sparse-index &&
 	test_cmp_config -C repo true extensions.sparseIndex &&
-	test-tool -C repo read-cache --table >cache &&
-	grep " tree " cache &&
+	git -C repo ls-files --sparse >cache &&
+	grep "^040000 " cache >lines &&
+	test_line_count = 3 lines &&
 
 	git -C repo sparse-checkout disable &&
-	test-tool -C repo read-cache --table >cache &&
-	! grep " tree " cache &&
+	git -C repo ls-files --sparse >cache &&
+	! grep "^040000 " cache &&
 	git -C repo config --list >config &&
 	! grep extensions.sparseindex config
 '
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d97bf9b645..48d3920490 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -136,48 +136,67 @@ test_sparse_match () {
 	test_cmp sparse-checkout-err sparse-index-err
 }
 
+test_index_entry_like () {
+	dir=$1
+	shift
+	fmt=$1
+	shift
+	rev=$1
+	shift
+	entry=$1
+	shift
+	file=$1
+	shift
+	hash=$(git -C "$dir" rev-parse "$rev") &&
+	printf "$fmt\n" "$hash" "$entry" >expected &&
+	if grep "$entry" "$file" >line
+	then
+		test_cmp expected line
+	else
+		cat cache &&
+		false
+	fi
+}
+
 test_expect_success 'sparse-index contents' '
 	init_repos &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse >cache &&
 	for dir in folder1 folder2 x
 	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
-			|| return 1
+		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$dir/" cache || return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set folder1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse >cache &&
 	for dir in deep folder2 x
 	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
-			|| return 1
+		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$dir/" cache || return 1
 	done &&
 
 	git -C sparse-index sparse-checkout set deep/deeper1 &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
+	git -C sparse-index ls-files --sparse >cache &&
 	for dir in deep/deeper2 folder1 folder2 x
 	do
-		TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
-		grep "040000 tree $TREE	$dir/" cache \
-			|| return 1
+		test_index_entry_like sparse-index "040000 %s 0\t%s" "HEAD:$dir" "$dir/" cache || return 1
 	done &&
 
+	grep 040000 cache >lines &&
+	test_line_count = 4 lines &&
+
 	# Disabling the sparse-index removes tree entries with full ones
 	git -C sparse-index sparse-checkout init --no-sparse-index &&
 
-	test-tool -C sparse-index read-cache --table >cache &&
-	! grep "040000 tree" cache &&
-	test_sparse_match test-tool read-cache --table
+	git -C sparse-index ls-files --sparse >cache &&
+	! grep "^040000 " cache >lines &&
+	test_sparse_match git ls-tree -r HEAD
 '
 
 test_expect_success 'expanded in-memory index matches full index' '
 	init_repos &&
-	test_sparse_match test-tool read-cache --expand --table
+	test_sparse_match git ls-tree -r HEAD
 '
 
 test_expect_success 'status with options' '
@@ -394,9 +413,9 @@ test_expect_success 'submodule handling' '
 	test_all_match git commit -m "add submodule" &&
 
 	# having a submodule prevents "modules" from collapse
-	test-tool -C sparse-index read-cache --table >cache &&
-	grep "100644 blob .*	modules/a" cache &&
-	grep "160000 commit $(git -C initial-repo rev-parse HEAD)	modules/sub" cache
+	git -C sparse-index ls-files --sparse >cache &&
+	test_index_entry_like sparse-index "100644 %s 0\t%s" "HEAD:modules/a" "modules/a" cache &&
+	test_index_entry_like sparse-index "160000 %s 0\t%s" "HEAD:modules/sub" "modules/sub" cache
 '
 
 test_expect_success 'sparse-index is expanded and converted back' '
-- 
2.31.0.260.g719c683c1d

