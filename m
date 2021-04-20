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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C6CC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5276C61001
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhDTMv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232109AbhDTMvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09449C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so44879011edt.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5T7u6roYjSWgMNFrwRYVMNFeyOqZRdQBChFIcg+8Fms=;
        b=Nuv2U2Bxs+Iuli7/gyPvghh47qcECTSEWXgGH92v+T9qEIokrqKjcaSZ69S3Ue5QaJ
         FWiI+s7VO1/tqFeBk94B7P8WNLhRP1WyEqUp89vTsbFzJz7kffmY/3WdTaSSMIO6gNGA
         USQ1F5EXBR/CNTIPTFB6EE67iPNtN3PB9tH5zeRnt45wlYnC0r1aosG9Iu5Lh43yTu3P
         AjNdXh7YIMSF5ikn3KcXaijxbPCe8LjKL2o4or2T6PxojT/eTwoiSrWhLDHsVIosRKeM
         JfRNf+TpOqqFzVq4Eq5LlIKPlT9KiehL5HF8cjDbpucmGZv9E3KgZ4RY+xjlyaImr4Oi
         X/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5T7u6roYjSWgMNFrwRYVMNFeyOqZRdQBChFIcg+8Fms=;
        b=RTrAMX8HBSEd1UQBmLJ8GP413uUPli3WzMHe3plu9Is58/e6qGgtKOQicE4zJCsYYS
         0nxIF4QnRpCzo39UMEP3RkaUvcwc4a662L93QHFSFQvHudXecuy34H+uCjMvvBCdwSej
         kALrCdyE9hF+IYCxw7dACVuWbs+NHfTN0zZ6nwBJpH/qBIsr0w5nTYc+rASzreuM1ML5
         X9S+y26G8P+VEFxkybkFVyzicyERuELF0TqQukefPufuy3uctot9k5wa+XcCQ8zsK7+f
         4dY4KHllvPdBK770n/+gJU42+TysJYyuBX8Z+j+YShIvxZ7Vsp24niQ+ak74jmr6vJKY
         mZ6g==
X-Gm-Message-State: AOAM531Vol6yrfY5Znphk292bTxpGto6yKUX7TPDR3vNyyBNAmmqJFyB
        KHyAsC9KuusiSUySDbC765ll2j78/kf8NA==
X-Google-Smtp-Source: ABdhPJy9AaIx0KYzizt8efxmzYerQBVr/3kVOqmn72dQVjDykltsyugqsDWo6aSuxJzXKeMKwWGCNA==
X-Received: by 2002:aa7:d587:: with SMTP id r7mr30845136edq.388.1618923049507;
        Tue, 20 Apr 2021 05:50:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] {commit,tree,blob,tag}.c: add a create_{commit,tree,blob,tag}()
Date:   Tue, 20 Apr 2021 14:50:38 +0200
Message-Id: <patch-05.10-5213d500b9-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a create_*() function for our built-in types as a handy but
trivial wrapper around their calls to create_object().

This allows for slightly simplifying code added in
96af91d410c (commit-graph: verify objects exist, 2018-06-27). The
remaining three functions are added for consistency for now.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blob.c                      | 7 ++++++-
 commit-graph.c              | 2 +-
 commit.c                    | 7 ++++++-
 commit.h                    | 1 +
 t/helper/test-fast-rebase.c | 4 ++--
 tag.c                       | 7 ++++++-
 tree.c                      | 7 ++++++-
 7 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/blob.c b/blob.c
index 182718aba9..d98b6badc7 100644
--- a/blob.c
+++ b/blob.c
@@ -5,11 +5,16 @@
 
 const char *blob_type = "blob";
 
+static struct blob *create_blob(struct repository *r, const struct object_id *oid)
+{
+	return create_object(r, oid, alloc_blob_node(r));
+}
+
 struct blob *lookup_blob(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_blob_node(r));
+		return create_blob(r, oid);
 	return object_as_type(obj, OBJ_BLOB, 0);
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index f18380b922..c456f84f41 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2504,7 +2504,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 		hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
 
 		graph_commit = lookup_commit(r, &cur_oid);
-		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
+		odb_commit = create_commit(r, &cur_oid);
 		if (parse_commit_internal(odb_commit, 0, 0)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
diff --git a/commit.c b/commit.c
index 8ea55a447f..3580c62b92 100644
--- a/commit.c
+++ b/commit.c
@@ -57,11 +57,16 @@ struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref
 	return c;
 }
 
+struct commit *create_commit(struct repository *r, const struct object_id *oid)
+{
+	return create_object(r, oid, alloc_commit_node(r));
+}
+
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_commit_node(r));
+		return create_commit(r, oid);
 	return object_as_type(obj, OBJ_COMMIT, 0);
 }
 
diff --git a/commit.h b/commit.h
index df42eb434f..09e2167f8c 100644
--- a/commit.h
+++ b/commit.h
@@ -63,6 +63,7 @@ enum decoration_type {
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
 const struct name_decoration *get_name_decoration(const struct object *obj);
 
+struct commit *create_commit(struct repository *r, const struct object_id *oid);
 struct commit *lookup_commit(struct repository *r, const struct object_id *oid);
 struct commit *lookup_commit_reference(struct repository *r,
 				       const struct object_id *oid);
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 373212256a..e3d3e991a5 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -51,7 +51,7 @@ static char *get_author(const char *message)
 	return NULL;
 }
 
-static struct commit *create_commit(struct tree *tree,
+static struct commit *make_a_commit(struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent)
 {
@@ -177,7 +177,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 		if (!result.clean)
 			die("Aborting: Hit a conflict and restarting is not implemented.");
 		last_picked_commit = commit;
-		last_commit = create_commit(result.tree, commit, last_commit);
+		last_commit = make_a_commit(result.tree, commit, last_commit);
 	}
 	fprintf(stderr, "\nDone.\n");
 	/* TODO: There should be some kind of rev_info_free(&revs) call... */
diff --git a/tag.c b/tag.c
index 3e18a41841..ed7037256e 100644
--- a/tag.c
+++ b/tag.c
@@ -99,11 +99,16 @@ struct object *deref_tag_noverify(struct object *o)
 	return o;
 }
 
+static struct tag *create_tag(struct repository *r, const struct object_id *oid)
+{
+	return create_object(r, oid, alloc_tag_node(r));
+}
+
 struct tag *lookup_tag(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_tag_node(r));
+		return create_tag(r, oid);
 	return object_as_type(obj, OBJ_TAG, 0);
 }
 
diff --git a/tree.c b/tree.c
index 410e3b477e..00958c581e 100644
--- a/tree.c
+++ b/tree.c
@@ -102,11 +102,16 @@ int cmp_cache_name_compare(const void *a_, const void *b_)
 				  ce2->name, ce2->ce_namelen, ce_stage(ce2));
 }
 
+static struct tree *create_tree(struct repository *r, const struct object_id *oid)
+{
+	return create_object(r, oid, alloc_tree_node(r));
+}
+
 struct tree *lookup_tree(struct repository *r, const struct object_id *oid)
 {
 	struct object *obj = lookup_object(r, oid);
 	if (!obj)
-		return create_object(r, oid, alloc_tree_node(r));
+		return create_tree(r, oid);
 	return object_as_type(obj, OBJ_TREE, 0);
 }
 
-- 
2.31.1.723.ga5d7868e4a

