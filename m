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
	by dcvr.yhbt.net (Postfix) with ESMTP id DFFEF1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbeFGOEF (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:04:05 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40555 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbeFGOEC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:04:02 -0400
Received: by mail-qk0-f196.google.com with SMTP id r66-v6so6604822qkr.7
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ym+YT3Tt6GMO2qg1FKjS3Md+DTN3KBhiVOr3oTBfdss=;
        b=br9YUqS39Yj6qpRKVZNb64M6LcWkJXzXHV0mWlCR+/1VwvzphQ72zOV1oYDo/Ak8kt
         LrunZSELAJJqXCzdMmOG2HkF6hV3SmYYWzIsWoGo6qMf0qCz/U9nOWdDbwhwuHT1hBf6
         uAInlK7bBRKs/tmtc40K8nXM4N/LqOo1ZwrV7tN9q1V8Cq7XD5TICR0ASLSEf4jVI4mC
         N4yzuJ+zJZXQRCpYxu5TRLWJh5APlgyS0B2qf5Orzy5okXRtWUlCSNCMQC5Ca2I28bvc
         LTPwNcTaXqqaMNri8mf246TvQB3e3MDVhnR/wFOPv9kFgjUNtH1Z8N4LxWjlFYhNX5Wi
         +DhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ym+YT3Tt6GMO2qg1FKjS3Md+DTN3KBhiVOr3oTBfdss=;
        b=iNUXUB3X6p9qB3y2SBbYJ10CXRYCsWW+6JTzIryf7Pz+Eqcz07DZuXIgokwcaK1O2L
         pIboTpQ70h8HSm55oUXFH/ZClIoihp86/FEL/uvdfFYqVFcO4LNf7tgzuKguF1RXCE9p
         D5uczWsMNbCHJ9HkmKqggsAtLdrbAPFC4asSyROOjpOgrOdf03Hih+kojOnIv9s75Yom
         037MIKaYew/4+E2KXiSmhcopKZN3jLJpVy9JqKfIRzUuTOsAtQWfsLxKQI2ejIIBFOfI
         qNAolqTwZ6VF6BFd2aVYIc6Si9B6VL9s+VapPlnTTtIGdmzr1nSUo54zBlKczrlODsI7
         BYEA==
X-Gm-Message-State: APt69E0UhgLKdM+789dne6Nu+ZEpImoSxRI0cqOC/PARtiC//SN2uMpf
        EMEGJarC0qyAO9CHp6gIfVroEmpq
X-Google-Smtp-Source: ADUXVKIO04Pbe9xCs8StQUj/SEV071qOdgrKc8YLfjiwmrZj7Ufp1q8H6R/G15Mqvm3rTp+aVLXGpg==
X-Received: by 2002:a37:150b:: with SMTP id f11-v6mr1608269qkh.170.1528380241100;
        Thu, 07 Jun 2018 07:04:01 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:04:00 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 15/23] midx: create core.midx config setting
Date:   Thu,  7 Jun 2018 10:03:30 -0400
Message-Id: <20180607140338.32440-16-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The core.midx config setting controls the multi-pack-index (MIDX)
feature. If false, the setting will disable all reads from the
multi-pack-index file.

Add comparison commands in t5319-midx.sh to check typical Git behavior
remains the same as the config setting is turned on and off. This
currently includes 'git rev-list' and 'git log' commands to trigger
several object database reads.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt |  4 +++
 cache.h                  |  1 +
 config.c                 |  5 ++++
 environment.c            |  1 +
 t/t5319-midx.sh          | 57 ++++++++++++++++++++++++++++++++--------
 5 files changed, 57 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a9..e78150e452 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -908,6 +908,10 @@ core.commitGraph::
 	Enable git commit graph feature. Allows reading from the
 	commit-graph file.
 
+core.midx::
+	Enable multi-pack-index feature. Allows reading from the multi-
+	pack-index file.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/cache.h b/cache.h
index 89a107a7f7..c7967f7643 100644
--- a/cache.h
+++ b/cache.h
@@ -814,6 +814,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_commit_graph;
+extern int core_midx;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index fbbf0f8e9f..0df3dbdf74 100644
--- a/config.c
+++ b/config.c
@@ -1313,6 +1313,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.midx")) {
+		core_midx = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.sparsecheckout")) {
 		core_apply_sparse_checkout = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2a6de2330b..dcb4417604 100644
--- a/environment.c
+++ b/environment.c
@@ -67,6 +67,7 @@ enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 char *notes_ref_name;
 int grafts_replace_parents = 1;
 int core_commit_graph;
+int core_midx;
 int core_apply_sparse_checkout;
 int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index 709652c635..1a50987778 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -3,6 +3,8 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
+objdir=.git/objects
+
 midx_read_expect() {
 	NUM_PACKS=$1
 	NUM_OBJECTS=$2
@@ -62,13 +64,42 @@ test_expect_success 'write midx with one v1 pack' '
 	midx_read_expect 1 17 5 .
 '
 
+midx_git_two_modes() {
+	git -c core.midx=false $1 >expect &&
+	git -c core.midx=true $1 >actual &&
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
-	pack=$(git pack-objects --index-version=2,0x40 pack/test <obj-list) &&
-	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx &&
-	git midx --object-dir=. write &&
-	midx_read_expect 1 17 5 .
+	pack=$(git pack-objects --index-version=2,0x40 $objdir/pack/test <obj-list) &&
+	git midx --object-dir=$objdir write &&
+	midx_read_expect 1 17 5 $objdir
 '
 
+midx_git_two_modes() {
+	git -c core.midx=false $1 >expect &&
+	git -c core.midx=true $1 >actual &&
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
@@ -94,12 +125,13 @@ test_expect_success 'Add more objects' '
 '
 
 test_expect_success 'write midx with two packs' '
-	pack1=$(git pack-objects --index-version=1 pack/test-1 <obj-list) &&
-	pack2=$(git pack-objects --index-version=1 pack/test-2 <obj-list2) &&
-	git midx --object-dir=. write &&
-	midx_read_expect 2 33 5 .
+	pack2=$(git pack-objects --index-version=1 $objdir/pack/test-2 <obj-list2) &&
+	git midx --object-dir=$objdir write &&
+	midx_read_expect 2 33 5 $objdir
 '
 
+compare_results_with_midx "two packs"
+
 test_expect_success 'Add more packs' '
 	for j in `test_seq 1 10`
 	do
@@ -120,17 +152,20 @@ test_expect_success 'Add more packs' '
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
-	git midx --object-dir=. write &&
-	midx_read_expect 12 73 5 .
+	git midx --object-dir=$objdir write &&
+	midx_read_expect 12 73 5 $objdir
 '
 
+compare_results_with_midx "twelve packs"
 
 # usage: corrupt_data <file> <pos> [<data>]
 corrupt_data() {
-- 
2.18.0.rc1

