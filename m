Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C586AC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69946137D
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhJSLmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhJSLmK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:42:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA9C061777
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e5-20020a17090a804500b001a116ad95caso2430581pjw.2
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaAP2QAIoZTZsr+6wUC+yxCPQXY2JRO7stjPsRNyWwo=;
        b=N6O5Mot6A6d6lizV8Y9PkMeP72GZ3NSk5VUMDVuFMvbTt1ousJfKNrU3lt+HOIXz/G
         h0wKRzIPbxkg88XwZJ4gJBTA7z4354Kf0QZXCyZQ9zKdt9+0hbIpiD/skQSyoRZGMJcD
         apuJeNxAiXoYIlSYdsQ17Zvn7OvnwBKI+rDeMz1yrVwtiNpCe+Jlow3DwK/rcqQZq3qE
         QmAv5GHZqQvT7hTifGM0mZx0wUOXOvOfi2GzitdxmgpE1BpnbbGO3OKNV8LlN042qUuK
         edaRV9Gr5CeG6ek7BPz38YBvzIoeLIu4aV5xOw2Sgc3QGTe8wOyN868HBVqy3s35GqG2
         KZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaAP2QAIoZTZsr+6wUC+yxCPQXY2JRO7stjPsRNyWwo=;
        b=oFQv61DDcFno4XFIz9XbhD3u8xEq2dPsjBDpjdrPp4Smrwyj9wBOa+84ELjmws9K96
         NA1LWKhLU7c0k/lj5vRYFbb+G4o5QbxjYoAWcQhBjjmVXVu1QpGBTQWKzE6GTpTIvzEs
         5iNjWRVjjlmWihPpXamse1BGJz4istnrHk4584VvbcPeqXFB0qYsi2/MRto34pEhVkOb
         xdu6b6Mjygu9TRStWD4j48edcpBO+wFzIGUK7YptGq0lf14QsdnfC9aSss7amTt+KYKf
         DtRPrmNW1rC39sx/ksrq+Q8/FGlMN9olgb0qms5ZoIvLH5n7t+qKcOh7iUFSlt00B7nZ
         eIhA==
X-Gm-Message-State: AOAM5324SLzeKUuz9glIrpc/Kf7jWCLVTd1HfdDsMRWdMN5BsMusuh9W
        n4XtTIHzMuO4Qu73o4wjzDJv4A2D7NI=
X-Google-Smtp-Source: ABdhPJw1dapzjOO3/7235ThjEi62KIsf980e62tgqzN+1C1Uysxp0M/FdPlX22stXrbW33MuS1Gr7g==
X-Received: by 2002:a17:902:c206:b0:13f:68f:675c with SMTP id 6-20020a170902c20600b0013f068f675cmr33452109pll.8.1634643572337;
        Tue, 19 Oct 2021 04:39:32 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:32 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v6 08/12] packfile-uri: support for excluding trees
Date:   Tue, 19 Oct 2021 19:38:32 +0800
Message-Id: <c7a885ebec703f383f5935517170b4ab755b5411.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

This commit introduce the exclusion of tree objects. The exclusion range
is designed by an enum named `exclude_level` in "pack-objects.c" that
enumerate three values, "ET_SELF", "ET_INCLUDE" and "ET_REACHABLE".

Exclusion scope on different level:

1. When a tree is specified to be excluded with level "ET_SELF",
only the tree object itself will be excluded.

2. When a tree specified to be excluded with level "ET_INCLUDE",
exclude the tree itself, as well as all the trees and blobs it contains.

3. When it is specified with level "ET_REACHABLE", the excluding scope
is as same as level "ET_INCLUDE", because tree do not have any
ancestors.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/pack-objects.c | 18 ++++++++++++++++++
 list-objects.c         |  8 ++++++--
 object.c               |  1 +
 object.h               |  1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e7b27ef443..6713e734fb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1250,6 +1250,21 @@ static int match_packfile_uri_exclusions(struct configured_exclusion *ex)
 	return 0;
 }
 
+static int want_exclude_object(struct object_list *objects)
+{
+	struct object_list *p;
+	struct configured_exclusion *ex;
+
+	if (!objects)
+		return 0;
+	for (p = objects; p; p = p->next) {
+		ex = oidmap_get(&configured_exclusions, &p->item->oid);
+		if (match_packfile_uri_exclusions(ex) && ex->level > ET_SELF)
+			return 1;
+	}
+	return 0;
+}
+
 static int want_found_object(const struct object_id *oid, int exclude,
 			     struct packed_git *p)
 {
@@ -1400,11 +1415,14 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (uri_protocols.nr) {
 		if (referred_objs) {
 			struct commit *commit = referred_objs->commit;
+			struct object_list *trees = referred_objs->trees;
 			if (commit) {
 				commit_ex = oidmap_get(&configured_exclusions, &commit->object.oid);
 				if (match_packfile_uri_exclusions(commit_ex) && commit_ex->level > ET_SELF)
 					return 0;
 			}
+			if (want_exclude_object(trees))
+				return 0;
 		}
 
 		ex = oidmap_get(&configured_exclusions, oid);
diff --git a/list-objects.c b/list-objects.c
index b32213ecf1..40292e2cc8 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -114,8 +114,11 @@ static void process_tree_contents(struct traversal_context *ctx,
 	struct name_entry entry;
 	enum interesting match = ctx->revs->diffopt.pathspec.nr == 0 ?
 		all_entries_interesting : entry_not_interesting;
+	struct referred_objects *referred_buf;
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
+	referred_buf = xmemdupz(referred_objs, sizeof(struct referred_objects));
+	object_list_insert(&tree->object, &referred_buf->trees);
 
 	while (tree_entry(&desc, &entry)) {
 		if (match != all_entries_interesting) {
@@ -136,7 +139,7 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			t->object.flags |= NOT_USER_GIVEN;
-			process_tree(ctx, t, base, entry.path, referred_objs);
+			process_tree(ctx, t, base, entry.path, referred_buf);
 		}
 		else if (S_ISGITLINK(entry.mode))
 			process_gitlink(ctx, entry.oid.hash,
@@ -149,9 +152,10 @@ static void process_tree_contents(struct traversal_context *ctx,
 				    entry.path, oid_to_hex(&tree->object.oid));
 			}
 			b->object.flags |= NOT_USER_GIVEN;
-			process_blob(ctx, b, base, entry.path, referred_objs);
+			process_blob(ctx, b, base, entry.path, referred_buf);
 		}
 	}
+	free(referred_buf);
 }
 
 static void process_tree(struct traversal_context *ctx,
diff --git a/object.c b/object.c
index f86b52c4d6..895068cbc2 100644
--- a/object.c
+++ b/object.c
@@ -334,6 +334,7 @@ void add_object_array_with_path_and_referred_commit(struct object *obj, const ch
 	struct referred_objects *referred_objs;
 	referred_objs = xmalloc(sizeof(struct referred_objects));
 	referred_objs->commit = referred_commit;
+	referred_objs->trees = NULL;
 
 	if (nr >= alloc) {
 		alloc = (alloc + 32) * 2;
diff --git a/object.h b/object.h
index 4db0ecc3f2..618d674249 100644
--- a/object.h
+++ b/object.h
@@ -65,6 +65,7 @@ struct object_array {
 
 struct referred_objects{
     struct commit *commit;
+    struct object_list *trees;
 };
 #define OBJECT_ARRAY_INIT { 0, 0, NULL }
 
-- 
2.31.1.453.g945ddc3a74.dirty

