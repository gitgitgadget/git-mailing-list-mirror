Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DB6C7618E
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 00:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjDUAlZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjDUAlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 20:41:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA82212D
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 17:41:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-74e3899037cso5298985a.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682037681; x=1684629681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btQXZd5p/VZcnYh9a+WqD6JatMOdNKTfjwr9eMFVUw8=;
        b=ZJzhfF4ccZo7vzRo9PdxLpMVNGB071D8PgXqmLUbjw6ztfSDHaOT2e3nH1kRpXBcQA
         62QcP4KUiAengQ+UabpfPlI8+fHv8Oo8yP7escRZucNx4Gkwo7OKa8NBkh73u+sIDNcm
         a0P0HwQuOKoYwJ5ItwdPx1PpGOHt4M5bloyHynIyw6WrhFFu5lCtsd8/vYbcL+vZKVpe
         3TxltLzASXbPegWSiLDBCrmXymn6gTxFdy0kMPOUtbtpEoQ/l2JuNjysZ0bEbZYamQy7
         1r1hmAE9tjEBDTsabrE04sbba2G+gtglZ7Vw8rNsg7QsPMNEkH+5bwzWJLwV4WOMS+07
         WLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682037681; x=1684629681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btQXZd5p/VZcnYh9a+WqD6JatMOdNKTfjwr9eMFVUw8=;
        b=Ii4PmI3+nhPZkBsgC+FIvkKEcX3gQeXBUN7meF0BKk1nGREo6qWkBwHCNyLaVqSjqB
         oZuYHyF2Uf+I1XaSj1s+qy72YANeqTFBUKsmzD5RKApaNo4UVMoAMhOetbkP7q/zInsK
         y754NWDoXTEkeqBWyhf3WTPEpWnyjhbSGSjZ1R0VQC++c+k4S8SGGl3yEjLFWYn6hdci
         dpezXez6swWeRLp6WkoLfd3DTnjrebGKdmgzfrZGgMyybFpk8n2DxzYXp5z20iLuriXY
         KwCSSkvSF7thezmCasniIJudVwoNtpElnTACJ+OQ9D5lJ5MSsV7YfOqor8C3PKB/LCfx
         bolw==
X-Gm-Message-State: AAQBX9eonmo1kg/WXDxatJXFYcSwAOKirAIYg2eGpXNs+VuoFrDwpWnf
        PMHFEQNevOLFSIvnsH4p5Gu93ZWfV4DCUQ==
X-Google-Smtp-Source: AKy350a516atxsIN+ayfaLoTW2tRMcjEX4DJHrRuzNTOKZHZYJ2/k27ICFaLpLvtM/Jgwrj6sglZUg==
X-Received: by 2002:a05:6214:301c:b0:5fe:dffc:ff1c with SMTP id ke28-20020a056214301c00b005fedffcff1cmr4386254qvb.51.1682037681174;
        Thu, 20 Apr 2023 17:41:21 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id o20-20020a0cf4d4000000b005f66296da7bsm773667qvm.94.2023.04.20.17.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 17:41:20 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v4] write-tree: integrate with sparse index
Date:   Thu, 20 Apr 2023 20:41:08 -0400
Message-Id: <20230421004108.32554-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230419072148.4297-1-cheskaqiqi@gmail.com>
References: <20230419072148.4297-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update 'git write-tree' to allow using the sparse-index in memory
without expanding to a full one.

The recursive algorithm for update_one() was already updated in 2de37c5
(cache-tree: integrate with sparse directory entries, 2021-03-03) to
handle sparse directory entries in the index. Hence we can just set the
requires-full-index to false for "write-tree".

The `p2000` tests demonstrate a ~96% execution time reduction for 'git
write-tree' using a sparse index:

Test                                           before  after
-----------------------------------------------------------------
2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---

* Modified the code to ensure prepare_repo_settings() is called only 
when inside a repository.

* Change 'write-tree on all' to just 'write-tree'.

* Have a baseline 'test_all_match git write-tree' before making any 
changes to the index.

* Add 'git status --porcelain=v2'.

* Ensuring that SKIP_WORKTREE files weren't materialized on disk by
using "test_path_is_missing".

* Use 'test_all_match' on the 'git update-index'.


 builtin/write-tree.c                     |  9 ++++++---
 t/t1092-sparse-checkout-compatibility.sh | 20 +++++++++++++++-----
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index 32e302a813..a9d5c20cde 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -38,12 +38,15 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
 			     write_tree_usage, 0);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
-
 	ret = write_index_as_tree(&oid, &the_index, get_index_file(), flags,
 				  tree_prefix);
 	switch (ret) {
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9bbc0d646b..d3eb31326b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2055,22 +2055,32 @@ test_expect_success 'grep sparse directory within submodules' '
 	test_cmp actual expect
 '
 
-test_expect_success 'write-tree on all' '
+test_expect_success 'write-tree' '
 	init_repos &&
 
+	test_all_match git write-tree &&
+
 	write_script edit-contents <<-\EOF &&
 	echo text >>"$1"
 	EOF
 
+	# make a change inside the sparse cone
 	run_on_all ../edit-contents deep/a &&
-	run_on_all git update-index deep/a &&
+	test_all_match git update-index deep/a &&
 	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
 
+	# make a change outside the sparse cone
 	run_on_all mkdir -p folder1 &&
 	run_on_all cp a folder1/a &&
 	run_on_all ../edit-contents folder1/a &&
-	run_on_all git update-index folder1/a &&
-	test_all_match git write-tree
+	test_all_match git update-index folder1/a &&
+	test_all_match git write-tree &&
+	test_all_match git status --porcelain=v2 &&
+	
+	# check that SKIP_WORKTREE files are not materialized
+	test_path_is_missing sparse-checkout/folder2/a &&
+	test_path_is_missing sparse-index/folder2/a
 '
 
 test_expect_success 'sparse-index is not expanded: write-tree' '
@@ -2080,7 +2090,7 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
 
 	echo "test1" >>sparse-index/a &&
 	git -C sparse-index update-index a &&
-	ensure_not_expanded write-tree
+	ensure_not_expanded write-tree 
 '
 
 test_done
-- 
2.39.0

