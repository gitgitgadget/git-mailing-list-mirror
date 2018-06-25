Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5D11F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934494AbeFYOfa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:30 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46445 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934477AbeFYOf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id h5-v6so12085061qtm.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iA5eucZCPYlxWlrstE9G/XpDjF09VpP7DLbIRwYWDc4=;
        b=ba082LmV7JzYqWxeG8YiJ9f/amwq9tTQLSu5xzOOg+7MuOz1DncM4SpJhM5SDTlH2E
         40IQcn9ECsGXiCjgwd2UH8mN0Z08Qea3LjzsK93ES3GsAeCVIrn51iHWytohSwapzL4H
         cHaAi3siVYmeyJ4zYZFjASEAXi/Y/RSRT2+C1pW0Nr+zLpAf9C/X1KIGMNe8MJhR9/TP
         sbMqDesG4HfcWMPXXjPTYgxB0i9iq6bjXeJy3IGvYerNCFvQ7+o3f3XUNPZZ4l9xwmgy
         I4GqG7OxW1eNMetgk82XluKW5AnWjBCqKhoxAKtxmOAE7mvqXKQcW1wGouFCFem4SkGC
         wReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iA5eucZCPYlxWlrstE9G/XpDjF09VpP7DLbIRwYWDc4=;
        b=Hld0p6ti2zdKU87InB/fSHJMRbI9fX31vbPR3OouRpWyR7Qn5tCRU05dXjV5pB5zwl
         iDP4oJ8jE4W4sjvMCukLmJVtnrjeBu98wkttDXlnePYc/A92Aoa2IFndioQrDYRYOuaO
         amv31Vt2cYgnvjJojbaltyGMga0SJLZSbZfLhjys6IJvK3aX3HMhVjDuvxQ1mvFZo/Aj
         0/sCG4noBgFty0hnViv/VKgFACO0JK7llSx1E4ph6kkQ8iRwL7VPqG2Lok0syHZSbGCx
         FM6+0jv6Cs6x3yEod4Y1tAQ3bhXtz9UiZahkIvsnabw1mp9ll0RjCFWL0w4qkJDm8aZz
         7fxQ==
X-Gm-Message-State: APt69E102TfDX5bIujVbLhBM1KoR3iN1HrTCW/8nU642js/dNGvfeCEO
        bI/P74FPAkRvdLmXAwXouif1Z3SX
X-Google-Smtp-Source: ADUXVKIHXiH4xQE3BNp7oR1n/U1jMKRstPVxgo1XXdh8p/UBdlvLQ+ldgC2u58b57XbY4JfIjTfUfA==
X-Received: by 2002:ac8:c8:: with SMTP id d8-v6mr11228773qtg.202.1529937325570;
        Mon, 25 Jun 2018 07:35:25 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:25 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 16/24] config: create core.multiPackIndex setting
Date:   Mon, 25 Jun 2018 10:34:26 -0400
Message-Id: <20180625143434.89044-17-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.multiPackIndex config setting controls the multi-pack-
index (MIDX) feature. If false, the setting will disable all reads
from the multi-pack-index file.

Add comparison commands in t5319-multi-pack-index.sh to check
typical Git behavior remains the same as the config setting is turned
on and off. This currently includes 'git rev-list' and 'git log'
commands to trigger several object database reads.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt    |  4 +++
 cache.h                     |  1 +
 config.c                    |  5 ++++
 environment.c               |  1 +
 t/t5319-multi-pack-index.sh | 55 +++++++++++++++++++++++++++++++------
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..ab895ebb32 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -908,6 +908,10 @@ core.commitGraph::
 	Enable git commit graph feature. Allows reading from the
 	commit-graph file.
 
+core.multiPackIndex::
+	Use the multi-pack-index file to track multiple packfiles using a
+	single index. See linkgit:technical/multi-pack-index[1].
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index 89a107a7f7..d12aa49710 100644
--- a/cache.h
+++ b/cache.h
@@ -814,6 +814,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
+extern int core_multi_pack_index;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index fbbf0f8e9f..95d8da4243 100644
--- a/config.c
+++ b/config.c
@@ -1313,6 +1313,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.multipackindex")) {
+		core_multi_pack_index = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2a6de2330b..b9bc919cdb 100644
--- a/environment.c
+++ b/environment.c
@@ -67,6 +67,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_commit_graph;
+int core_multi_pack_index;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ccde83bca4..f7f55ea181 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -3,6 +3,8 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+objdir=.git/objects
+
 midx_read_expect() {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
@@ -61,12 +63,42 @@ test_expect_success 'write midx with one v1 pack' '
 	midx_read_expect 1 17 4 .
 '
 
+midx_git_two_modes() {
+	git -c core.multiPackIndex=false $1 >expect &&
+	git -c core.multiPackIndex=true $1 >actual &&
+	test_cmp expect actual
+}
+
+compare_results_with_midx() {
+	MSG=$1
+	test_expect_success "check normal git operations: $MSG" '
+		midx_git_two_modes "rev-list --objects --all" &&
+		midx_git_two_modes "log --raw"
+	'
+}
+
 test_expect_success 'write midx with one v2 pack' '
-	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 1 17 4 .
+	git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 1 17 4 $objdir
 '
 
+midx_git_two_modes() {
+	git -c core.multiPackIndex=false $1 >expect &&
+	git -c core.multiPackIndex=true $1 >actual &&
+	test_cmp expect actual
+}
+
+compare_results_with_midx() {
+	MSG=$1
+	test_expect_success "check normal git operations: $MSG" '
+		midx_git_two_modes "rev-list --objects --all" &&
+		midx_git_two_modes "log --raw"
+	'
+}
+
+compare_results_with_midx "one v2 pack"
+
 test_expect_success 'Add more objects' '
 	for i in `test_seq 6 10`
 	do
@@ -92,11 +124,13 @@ test_expect_success 'Add more objects' '
 '
 
 test_expect_success 'write midx with two packs' '
-	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 2 33 4 .
+	git pack-objects --index-version=1 $objdir/pack/test-2 <obj-list2 &&
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 2 33 4 $objdir
 '
 
+compare_results_with_midx "two packs"
+
 test_expect_success 'Add more packs' '
 	for j in `test_seq 1 10`
 	do
@@ -117,17 +151,20 @@ test_expect_success 'Add more packs' '
 		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
 		} >obj-list &&
 		git update-ref HEAD $commit &&
-		git pack-objects --index-version=2 pack/test-pack <obj-list &&
+		git pack-objects --index-version=2 $objdir/pack/test-pack <obj-list &&
 		i=$(expr $i + 1) || return 1 &&
 		j=$(expr $j + 1) || return 1
 	done
 '
 
+compare_results_with_midx "mixed mode (two packs + extra)"
+
 test_expect_success 'write midx with twelve packs' '
-	git multi-pack-index --object-dir=. write &&
-	midx_read_expect 12 73 4 .
+	git multi-pack-index --object-dir=$objdir write &&
+	midx_read_expect 12 73 4 $objdir
 '
 
+compare_results_with_midx "twelve packs"
 
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data() {
-- 
2.18.0.24.g1b579a2ee9

