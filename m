Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307E220248
	for <e@80x24.org>; Thu,  4 Apr 2019 22:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfDDWyA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 18:54:00 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48240 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDWx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 18:53:59 -0400
Received: by mail-yw1-f74.google.com with SMTP id j63so3115742ywb.15
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 15:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=cf/6PLfT9ri9VgKFqonTHmhTHeiamOrEOuJA+PZeHHM=;
        b=audYSIGr60vA7O/07YOw4xqi82VlRkkvtuCOXO5vrkAop4XZpNGT8HoFEhNum6IVTM
         /Qh0cuaemkccqWbtGtis6Mub5ZEEY29ku6Likk32E6eV6vKZ1zOGx5abrICdUd94E+pg
         k+R3PsxSADTUBvMaJFQr/F0GQhZvV811pBLa4CVt7RsibOz+kQDT/uKxh4hHu/s40KCM
         R+UTz/cfTxtWiKLOPdhRe3Y8+mQKXG2dZ+YBYEQs5KRYghmHgtsLZVgUPYxz6ynv6c61
         RGBSuEe2zILCdsriR0Sk7wpTDX34Y4L+DwKfMahR+/wVcffNJHer/9/EBzBy/6gzn4S0
         h/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=cf/6PLfT9ri9VgKFqonTHmhTHeiamOrEOuJA+PZeHHM=;
        b=IQaRQg4rm90Pbw7NELp273XW11oLgF60V8DM3CS0IaHML7ZdS4X4qzc5S0+owdo6Ti
         m5Ias0UcbJj+Wg1jPSo65CUlXhSIb79jJ754fzorOyKIvg/zQBrr4n1PwzdSKnzaGenn
         cNwUuBFMUhWvqM/QUHg10DlXjxdjWky14itI1HQhnnK+RtDxku3EG8JsW6ud0aYY9GyW
         pF3f2lBjvlQ4joLelFlZ1BZClL5oSP4j9uoZArrnSF68Z59wUDAtH4agFeCsp+gRoctZ
         iGW6wgpHtKyXmDWeb9kUvGbWXBGIqDc9x1z9m+Jgr6LesOz4kv6bBvmvP/qD2wD156z5
         tu6g==
X-Gm-Message-State: APjAAAWyB0UGz13LVMgJWChj5AStKOvWqwj1vj06u5+8X3C1C8KUhsIV
        quxm/JsG/eFWyExWla4vCzdoMnxKSk1S/dfrw5PIkvG52MrrePcgRW9Xmv/kAGkTQoHIozHudxc
        OVBId/10YhGvrcHxzR4POF17u718k2wE3+DJ8nqHEmv0PA9GmtMWhCKUJXh4suoI=
X-Google-Smtp-Source: APXvYqzHyr9F40qGJRw6tYq9dwIT7YJejrwr4XtILqTd9eFeufBiwPrmp1rgQ4+GdiZ0nRRYhzJe4DbFLYFJjg==
X-Received: by 2002:a25:8386:: with SMTP id t6mr1826866ybk.55.1554418438948;
 Thu, 04 Apr 2019 15:53:58 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:53:56 -0700
In-Reply-To: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
Message-Id: <9f327d6d8dc5e71eb0039aef3ac76ea16c2adab3.1554417917.git.steadmon@google.com>
Mime-Version: 1.0
References: <6de682d5e48186970644569586fc6613763d5caa.1554312374.git.steadmon@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v2] rev-list: exclude promisor objects at walk time
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For large repositories, enumerating the list of all promisor objects (in
order to exclude them from a rev-list walk) can take a significant
amount of time).

When --exclude-promisor-objects is passed to rev-list, don't enumerate
the promisor objects. Instead, filter them (and any children objects)
during the actual graph walk.

Remove the mark_uninteresting() function as it's not used anywhere else.

Helped-By: Jonathan Tan <jonathantanmy@google.com>
Helped-By: Jeff King <peff@peff.net>
Helped-By: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Josh Steadmon <steadmon@google.com>
---

Re-implemented following Jonathan & Jeff's advice (and also previously
Jonathan Nieder's, although I didn't understand it at the time). Thanks
for the feedback all.


 list-objects.c | 26 ++++++++++++++++++++++++++
 revision.c     | 16 ----------------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index dc77361e11..d1eaa0999e 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -30,6 +30,7 @@ static void process_blob(struct traversal_context *ctx,
 	struct object *obj = &blob->object;
 	size_t pathlen;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	if (!ctx->revs->blob_objects)
 		return;
@@ -37,6 +38,11 @@ static void process_blob(struct traversal_context *ctx,
 		die("bad blob object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (ctx->revs->exclude_promisor_objects &&
+	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
+	    oi.whence == OI_PACKED &&
+	    oi.u.packed.pack->pack_promisor)
+		return;
 
 	/*
 	 * Pre-filter known-missing objects when explicitly requested.
@@ -149,6 +155,7 @@ static void process_tree(struct traversal_context *ctx,
 	int baselen = base->len;
 	enum list_objects_filter_result r = LOFR_MARK_SEEN | LOFR_DO_SHOW;
 	int failed_parse;
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	if (!revs->tree_objects)
 		return;
@@ -156,6 +163,11 @@ static void process_tree(struct traversal_context *ctx,
 		die("bad tree object");
 	if (obj->flags & (UNINTERESTING | SEEN))
 		return;
+	if (ctx->revs->exclude_promisor_objects &&
+	    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
+	    oi.whence == OI_PACKED &&
+	    oi.u.packed.pack->pack_promisor)
+		return;
 
 	failed_parse = parse_tree_gently(tree, 1);
 	if (failed_parse) {
@@ -318,6 +330,7 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 				     struct strbuf *base)
 {
 	int i;
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	assert(base->len == 0);
 
@@ -326,6 +339,12 @@ static void traverse_trees_and_blobs(struct traversal_context *ctx,
 		struct object *obj = pending->item;
 		const char *name = pending->name;
 		const char *path = pending->path;
+		if (ctx->revs->exclude_promisor_objects &&
+		    !oid_object_info_extended(the_repository, &obj->oid, &oi, 0) &&
+		    oi.whence == OI_PACKED &&
+		    oi.u.packed.pack->pack_promisor)
+			continue;
+
 		if (obj->flags & (UNINTERESTING | SEEN))
 			continue;
 		if (obj->type == OBJ_TAG) {
@@ -353,9 +372,16 @@ static void do_traverse(struct traversal_context *ctx)
 {
 	struct commit *commit;
 	struct strbuf csp; /* callee's scratch pad */
+	struct object_info oi = OBJECT_INFO_INIT;
 	strbuf_init(&csp, PATH_MAX);
 
 	while ((commit = get_revision(ctx->revs)) != NULL) {
+		if (ctx->revs->exclude_promisor_objects &&
+		    !oid_object_info_extended(the_repository, &commit->object.oid, &oi, 0) &&
+		    oi.whence == OI_PACKED &&
+		    oi.u.packed.pack->pack_promisor)
+			continue;
+
 		/*
 		 * an uninteresting boundary commit may not have its tree
 		 * parsed yet, but we are not going to show them anyway
diff --git a/revision.c b/revision.c
index eb8e51bc63..85974e941d 100644
--- a/revision.c
+++ b/revision.c
@@ -3067,17 +3067,6 @@ void reset_revision_walk(void)
 	clear_object_flags(SEEN | ADDED | SHOWN);
 }
 
-static int mark_uninteresting(const struct object_id *oid,
-			      struct packed_git *pack,
-			      uint32_t pos,
-			      void *cb)
-{
-	struct rev_info *revs = cb;
-	struct object *o = parse_object(revs->repo, oid);
-	o->flags |= UNINTERESTING | SEEN;
-	return 0;
-}
-
 define_commit_slab(indegree_slab, int);
 define_commit_slab(author_date_slab, timestamp_t);
 
@@ -3316,11 +3305,6 @@ int prepare_revision_walk(struct rev_info *revs)
 	    (revs->limited && limiting_can_increase_treesame(revs)))
 		revs->treesame.name = "treesame";
 
-	if (revs->exclude_promisor_objects) {
-		for_each_packed_object(mark_uninteresting, revs,
-				       FOR_EACH_OBJECT_PROMISOR_ONLY);
-	}
-
 	if (revs->no_walk != REVISION_WALK_NO_WALK_UNSORTED)
 		commit_list_sort_by_date(&revs->commits);
 	if (revs->no_walk)
-- 
2.21.0.392.gf8f6787159e-goog

