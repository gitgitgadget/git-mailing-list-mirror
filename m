Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB43B207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbdEFWNE (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:13:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37650 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754578AbdEFWLn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9926D280B6;
        Sat,  6 May 2017 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108677;
        bh=iv8Yph1qhCJhnIUXlSeW6d3aDnpvBJvDlqfYpoW0trw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JKeUPicb/dpJHUzn8SbDq8Xih207WqhOOIq3ojOKVLJVlEdPZVWC8ycfhCL1fYJ8m
         ang+Tk81ISauqj/kU/kzq7sL0UxwtZsXWNT5ZZXK7NbLTsBGUc/LCWtkT/pTyIq1Ap
         m1aykrKI8fCHxXZFiM4NiJCbLiM5QbskmLh0ypy7RcJnEQMtc1xUPiyBh96yHaRKX8
         MixlyWv0NmsMv/Z+ZmsBPfD078s8/CVomvlskoaW6JO71w6XmhWiGa4w3ZeIHc28QM
         Q6uuf6ShqxMtd15SScih5279nNU2L77PD04jDE2c3RbN5c3Qy+ivcwWTteoDV2t9zC
         k84s6qwpD6fxCOmg3eqwxBUthZoea3w+Nc/eFB3/3QyhxiH6BpKWTdMo15BnWrd5jR
         6tqdD9L1881dlvM7+D5PHetLy8xEPaCZLIO6FSTXUiz3NMgrQPS6h1YbvN4XSF6NvZ
         WHzbAAB8o2FVi9yQc9zNOlO1Uip5zzo2d9VkLAt0N9HRO3zfnUy
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 42/53] revision: convert remaining parse_object callers to object_id
Date:   Sat,  6 May 2017 22:10:27 +0000
Message-Id: <20170506221038.296722-43-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 revision.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/revision.c b/revision.c
index f82c56e1f..80f74bb7b 100644
--- a/revision.c
+++ b/revision.c
@@ -177,23 +177,23 @@ void add_pending_object(struct rev_info *revs,
 
 void add_head_to_pending(struct rev_info *revs)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object *obj;
-	if (get_sha1("HEAD", sha1))
+	if (get_oid("HEAD", &oid))
 		return;
-	obj = parse_object(sha1);
+	obj = parse_object(oid.hash);
 	if (!obj)
 		return;
 	add_pending_object(revs, obj, "HEAD");
 }
 
 static struct object *get_reference(struct rev_info *revs, const char *name,
-				    const unsigned char *sha1,
+				    const struct object_id *oid,
 				    unsigned int flags)
 {
 	struct object *object;
 
-	object = parse_object(sha1);
+	object = parse_object(oid->hash);
 	if (!object) {
 		if (revs->ignore_missing)
 			return object;
@@ -206,7 +206,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 void add_pending_oid(struct rev_info *revs, const char *name,
 		      const struct object_id *oid, unsigned int flags)
 {
-	struct object *object = get_reference(revs, name, oid->hash, flags);
+	struct object *object = get_reference(revs, name, oid, flags);
 	add_pending_object(revs, object, name);
 }
 
@@ -1157,7 +1157,7 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 	if (ref_excluded(cb->all_revs->ref_excludes, path))
 	    return 0;
 
-	object = get_reference(cb->all_revs, path, oid->hash, cb->all_flags);
+	object = get_reference(cb->all_revs, path, oid, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
 	add_pending_oid(cb->all_revs, path, oid, cb->all_flags);
 	return 0;
@@ -1292,7 +1292,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned flags)
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 			    int exclude_parent)
 {
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct object *it;
 	struct commit *commit;
 	struct commit_list *parents;
@@ -1303,17 +1303,17 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 		flags ^= UNINTERESTING | BOTTOM;
 		arg++;
 	}
-	if (get_sha1_committish(arg, sha1))
+	if (get_sha1_committish(arg, oid.hash))
 		return 0;
 	while (1) {
-		it = get_reference(revs, arg, sha1, 0);
+		it = get_reference(revs, arg, &oid, 0);
 		if (!it && revs->ignore_missing)
 			return 0;
 		if (it->type != OBJ_TAG)
 			break;
 		if (!((struct tag*)it)->tagged)
 			return 0;
-		hashcpy(sha1, ((struct tag*)it)->tagged->oid.hash);
+		oidcpy(&oid, &((struct tag*)it)->tagged->oid);
 	}
 	if (it->type != OBJ_COMMIT)
 		return 0;
@@ -1434,7 +1434,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	struct object_context oc;
 	char *dotdot;
 	struct object *object;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int local_flags;
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
@@ -1444,7 +1444,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 	dotdot = strstr(arg, "..");
 	if (dotdot) {
-		unsigned char from_sha1[20];
+		struct object_id from_oid;
 		const char *next = dotdot + 2;
 		const char *this = arg;
 		int symmetric = *next == '.';
@@ -1470,8 +1470,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				return -1;
 			}
 		}
-		if (!get_sha1_committish(this, from_sha1) &&
-		    !get_sha1_committish(next, sha1)) {
+		if (!get_sha1_committish(this, from_oid.hash) &&
+		    !get_sha1_committish(next, oid.hash)) {
 			struct object *a_obj, *b_obj;
 
 			if (!cant_be_filename) {
@@ -1479,8 +1479,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				verify_non_filename(revs->prefix, arg);
 			}
 
-			a_obj = parse_object(from_sha1);
-			b_obj = parse_object(sha1);
+			a_obj = parse_object(from_oid.hash);
+			b_obj = parse_object(oid.hash);
 			if (!a_obj || !b_obj) {
 			missing:
 				if (revs->ignore_missing)
@@ -1568,11 +1568,11 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	if (revarg_opt & REVARG_COMMITTISH)
 		get_sha1_flags = GET_SHA1_COMMITTISH;
 
-	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc))
+	if (get_sha1_with_context(arg, get_sha1_flags, oid.hash, &oc))
 		return revs->ignore_missing ? 0 : -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
-	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_mode(revs, object, arg, oc.mode);
 	return 0;
@@ -2287,12 +2287,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->show_merge)
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr && !got_rev_arg) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct object *object;
 		struct object_context oc;
-		if (get_sha1_with_context(revs->def, 0, sha1, &oc))
+		if (get_sha1_with_context(revs->def, 0, oid.hash, &oc))
 			diagnose_missing_default(revs->def);
-		object = get_reference(revs, revs->def, sha1, 0);
+		object = get_reference(revs, revs->def, &oid, 0);
 		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
 	}
 
