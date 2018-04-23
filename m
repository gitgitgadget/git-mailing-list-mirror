Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29E801F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeDWXkR (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932684AbeDWXkK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:10 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A88B1609A1;
        Mon, 23 Apr 2018 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526809;
        bh=tgRoEBG6hCFjchcZ2jboKLb9vSUMdFvhAfhNKkReuC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ntzexKT+m95v7iT9DfcV5eKZprqYj9q8CCglRUNeIUXVX8C1rHnoT2hJL99bb77OO
         DQdLgDV+704uS2c1KKuUDiCHt5GinJHaDC9eTU+KEaLXi+JSuHyeNnYQ6kxNjCx4uL
         8lTjKnSyGr6YjC6Y3qSudS1KvWpE2rQqRT7dSw8K8PXFdjIoerdVxYXzK7bRTUNyug
         eV3tewsP44xq2zxYNJHDZTdN/kqm1heQobFxqkKj6NY0MS9il6EfwWycXFThxBKsV+
         nuFZ84EkNaoUsrDEaP2WlDGmotR70yxs+ZhhPIChfEHcQNCxHZKIozhq5QknaAfbrq
         wYzM2rP1W3CCVCkgqgOoGlBsEpYpP9YsJ4o56Y7U4Fud10Mj2cuiGkRc3goX5v726s
         NRCgCDOQRFxwbF4NKfO+VIR5LD0n1iX7ba1CXRaCkdCTT9CghTt5cg1LgN8NGsN8uY
         p3zhmIfzVk6z21lHbOjPkTQIpeb7m+PR5qwCfXBVp3As+fkux3G
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 05/41] packfile: convert has_sha1_pack to object_id
Date:   Mon, 23 Apr 2018 23:39:15 +0000
Message-Id: <20180423233951.276447-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert this function to take a pointer to struct object_id and rename
it has_object_pack for consistency with has_object_file.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/count-objects.c | 2 +-
 builtin/fsck.c          | 2 +-
 builtin/prune-packed.c  | 2 +-
 diff.c                  | 2 +-
 packfile.c              | 4 ++--
 packfile.h              | 2 +-
 revision.c              | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index b054713e1a..d51e2ce1ec 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -66,7 +66,7 @@ static int count_loose(const struct object_id *oid, const char *path, void *data
 	else {
 		loose_size += on_disk_bytes(st);
 		loose++;
-		if (verbose && has_sha1_pack(oid->hash))
+		if (verbose && has_object_pack(oid))
 			packed_loose++;
 	}
 	return 0;
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 087360a675..3eb82ac44f 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -227,7 +227,7 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (is_promisor_object(&obj->oid))
 			return;
-		if (has_sha1_pack(obj->oid.hash))
+		if (has_object_pack(&obj->oid))
 			return; /* it is in pack - forget about it */
 		printf("missing %s %s\n", printable_type(obj),
 			describe_object(obj));
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index 419238171d..4ff525e50f 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -25,7 +25,7 @@ static int prune_object(const struct object_id *oid, const char *path,
 {
 	int *opts = data;
 
-	if (!has_sha1_pack(oid->hash))
+	if (!has_object_pack(oid))
 		return 0;
 
 	if (*opts & PRUNE_PACKED_DRY_RUN)
diff --git a/diff.c b/diff.c
index 1289df4b1f..314c57e3c0 100644
--- a/diff.c
+++ b/diff.c
@@ -3472,7 +3472,7 @@ static int reuse_worktree_file(const char *name, const struct object_id *oid, in
 	 * objects however would tend to be slower as they need
 	 * to be individually opened and inflated.
 	 */
-	if (!FAST_WORKING_DIRECTORY && !want_file && has_sha1_pack(oid->hash))
+	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
 		return 0;
 
 	/*
diff --git a/packfile.c b/packfile.c
index 5c219d0229..e65f943664 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1854,10 +1854,10 @@ int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack
 	return 0;
 }
 
-int has_sha1_pack(const unsigned char *sha1)
+int has_object_pack(const struct object_id *oid)
 {
 	struct pack_entry e;
-	return find_pack_entry(the_repository, sha1, &e);
+	return find_pack_entry(the_repository, oid->hash, &e);
 }
 
 int has_pack_index(const unsigned char *sha1)
diff --git a/packfile.h b/packfile.h
index a92c0b241c..14ca34bcbd 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,7 +136,7 @@ extern const struct packed_git *has_packed_and_bad(const unsigned char *sha1);
  */
 extern int find_pack_entry(struct repository *r, const unsigned char *sha1, struct pack_entry *e);
 
-extern int has_sha1_pack(const unsigned char *sha1);
+extern int has_object_pack(const struct object_id *oid);
 
 extern int has_pack_index(const unsigned char *sha1);
 
diff --git a/revision.c b/revision.c
index b42c836d7a..ce0e7b71f2 100644
--- a/revision.c
+++ b/revision.c
@@ -3086,7 +3086,7 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_sha1_pack(commit->object.oid.hash))
+	if (revs->unpacked && has_object_pack(&commit->object.oid))
 		return commit_ignore;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
