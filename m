Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E687C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiHSKJN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348337AbiHSKI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:08:58 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D95B8A46
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:51 -0700 (PDT)
Received: (qmail 17681 invoked by uid 109); 19 Aug 2022 10:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 943 invoked by uid 111); 19 Aug 2022 10:08:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/11] mark unused read_tree_recursive() callback parameters
Message-ID: <Yv9hMTaIwk2Ui6/7@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We pass a callback to read_tree_recursive(), but not every callback
needs every parameter. Let's mark the unused ones to satisfy
-Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c      |  2 +-
 archive-zip.c      |  2 +-
 archive.c          |  3 ++-
 builtin/checkout.c |  2 +-
 builtin/log.c      |  7 ++++---
 builtin/ls-tree.c  | 13 ++++++++-----
 merge-recursive.c  |  2 +-
 7 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 45e5d91407..0d66a1e0a8 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -421,7 +421,7 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return tar_filter_config(var, value, cb);
 }
 
-static int write_tar_archive(const struct archiver *ar,
+static int write_tar_archive(const struct archiver *UNUSED(ar),
 			     struct archiver_args *args)
 {
 	int err = 0;
diff --git a/archive-zip.c b/archive-zip.c
index 854bceb018..d63782dc31 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -618,7 +618,7 @@ static int archive_zip_config(const char *var, const char *value,
 	return userdiff_config(var, value);
 }
 
-static int write_zip_archive(const struct archiver *ar,
+static int write_zip_archive(const struct archiver *UNUSED(ar),
 			     struct archiver_args *args)
 {
 	int err;
diff --git a/archive.c b/archive.c
index d5109abb89..8b165e935b 100644
--- a/archive.c
+++ b/archive.c
@@ -382,7 +382,8 @@ struct path_exists_context {
 	struct archiver_args *args;
 };
 
-static int reject_entry(const struct object_id *oid, struct strbuf *base,
+static int reject_entry(const struct object_id *UNUSED(oid),
+			struct strbuf *base,
 			const char *filename, unsigned mode,
 			void *context)
 {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 713410ce2c..d18c8c886e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -125,7 +125,7 @@ static int post_checkout_hook(struct commit *old_commit, struct commit *new_comm
 }
 
 static int update_some(const struct object_id *oid, struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+		       const char *pathname, unsigned mode, void *UNUSED(context))
 {
 	int len;
 	struct cache_entry *ce;
diff --git a/builtin/log.c b/builtin/log.c
index 9b937d59b8..79a2e4d0bb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -645,9 +645,10 @@ static int show_tag_object(const struct object_id *oid, struct rev_info *rev)
 	return 0;
 }
 
-static int show_tree_object(const struct object_id *oid,
-		struct strbuf *base,
-		const char *pathname, unsigned mode, void *context)
+static int show_tree_object(const struct object_id *UNUSED(oid),
+			    struct strbuf *UNUSED(base),
+			    const char *pathname, unsigned mode,
+			    void *context)
 {
 	FILE *file = context;
 	fprintf(file, "%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index e279be8bb6..48df337605 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -142,7 +142,7 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 }
 
 static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
-			 const char *pathname, unsigned mode, void *context)
+			 const char *pathname, unsigned mode, void *UNUSED(context))
 {
 	size_t baselen;
 	int recurse = 0;
@@ -213,7 +213,7 @@ static void show_tree_common_default_long(struct strbuf *base,
 
 static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 			     const char *pathname, unsigned mode,
-			     void *context)
+			     void *UNUSED(context))
 {
 	int early;
 	int recurse;
@@ -230,7 +230,8 @@ static int show_tree_default(const struct object_id *oid, struct strbuf *base,
 }
 
 static int show_tree_long(const struct object_id *oid, struct strbuf *base,
-			  const char *pathname, unsigned mode, void *context)
+			  const char *pathname, unsigned mode,
+			  void *UNUSED(context))
 {
 	int early;
 	int recurse;
@@ -259,7 +260,8 @@ static int show_tree_long(const struct object_id *oid, struct strbuf *base,
 }
 
 static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
-			       const char *pathname, unsigned mode, void *context)
+			       const char *pathname, unsigned mode,
+			       void *UNUSED(context))
 {
 	int early;
 	int recurse;
@@ -279,7 +281,8 @@ static int show_tree_name_only(const struct object_id *oid, struct strbuf *base,
 }
 
 static int show_tree_object(const struct object_id *oid, struct strbuf *base,
-			    const char *pathname, unsigned mode, void *context)
+			    const char *pathname, unsigned mode,
+			    void *UNUSED(context))
 {
 	int early;
 	int recurse;
diff --git a/merge-recursive.c b/merge-recursive.c
index 775ebe2182..08c1c36d33 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -456,7 +456,7 @@ static void unpack_trees_finish(struct merge_options *opt)
 	clear_unpack_trees_porcelain(&opt->priv->unpack_opts);
 }
 
-static int save_files_dirs(const struct object_id *oid,
+static int save_files_dirs(const struct object_id *UNUSED(oid),
 			   struct strbuf *base, const char *path,
 			   unsigned int mode, void *context)
 {
-- 
2.37.2.928.g0821088f4a

