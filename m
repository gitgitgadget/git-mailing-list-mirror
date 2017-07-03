Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36851201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbdGCS4k (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:56:40 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53020 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753245AbdGCSzv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:51 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 69182280B9;
        Mon,  3 Jul 2017 18:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108149;
        bh=74CtX6nq9tRMuauzMG6D9+VqwoZgWS3sDwWymbOfgB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlTP9rLghSlzoR0+5q7CN9bSs06MZMiwpzxPEdD2MZBdFLJNAOvPg9pz9V3g12k+Z
         Ee7CslbKrXxWaNBv4zWhEhCTsSUJ9z1NALmUibsdkqDVKw/eEMnQuLfaLc7JlKycJP
         9/Nrqf9CDQftR21sMaDFDev9YVF33dXFwo8ZBYOfHiSU+6ZTt093EMJ1d/SxJkvJua
         5FlQ6qITnVs4X4oC/pcj2QxQkMFd4p66CdOClzXrExZiq+NE/y+4SmyitW87Xq72vZ
         pJ0DIFDgJ1Rl9qTjSKEZw+0dMfggyqw0igh2UJtw4yzE5CElYcj3UgRAe2KJh3kiy9
         kz0R7P5Yy0VNd9fy02YaaUkUto2eG90F6lhEtsquAqFt9OIb2l+SC8kDeMs9HCnGac
         RZRQ2+nSGKcuhBwLzbCVDKKGFkrhZZUJBhF5olXEkRsbtKXC1Fc08m9v2eMQmgznos
         8jv4rhe8tK9tNCvDx25aqHkqvnvZjN4RunSHr8NDRrgSrfb0dUf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 12/12] sha1_name: convert GET_SHA1* flags to GET_OID*
Date:   Mon,  3 Jul 2017 18:55:33 +0000
Message-Id: <20170703185533.51530-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the flags for get_oid_with_context and friends to use "OID"
instead of "SHA1" in their names.

This transform was made by running the following one-liner on the
affected files:

  perl -pi -e 's/GET_SHA1/GET_OID/g'

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/cat-file.c  |  4 ++--
 builtin/grep.c      |  2 +-
 builtin/log.c       |  2 +-
 builtin/rev-parse.c |  2 +-
 cache.h             | 28 +++++++++++------------
 refs.c              |  2 +-
 revision.c          |  6 ++---
 sha1_name.c         | 64 ++++++++++++++++++++++++++---------------------------
 8 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 695168a98..823608bef 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -63,7 +63,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_oid_with_context(obj_name, GET_SHA1_RECORD_PATH,
+	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
 				 &oid, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
@@ -360,7 +360,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 			     struct expand_data *data)
 {
 	struct object_context ctx;
-	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
+	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
 	result = get_oid_with_context(obj_name, flags, &data->oid, &ctx);
diff --git a/builtin/grep.c b/builtin/grep.c
index a309ab7c2..48aa39f99 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1206,7 +1206,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_oid_with_context(arg, GET_SHA1_RECORD_PATH,
+		if (get_oid_with_context(arg, GET_OID_RECORD_PATH,
 					 &oid, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
diff --git a/builtin/log.c b/builtin/log.c
index 60fac9d4d..3dbdf8cad 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -484,7 +484,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_oid_with_context(obj_name, GET_SHA1_RECORD_PATH,
+	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
 				 &oidc, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
 	if (!obj_context.path ||
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 041b7898c..2bd28d3c0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -702,7 +702,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
 				quiet = 1;
-				flags |= GET_SHA1_QUIETLY;
+				flags |= GET_OID_QUIETLY;
 				continue;
 			}
 			if (opt_with_value(arg, "--short", &arg)) {
diff --git a/cache.h b/cache.h
index c68f44e10..c14351cba 100644
--- a/cache.h
+++ b/cache.h
@@ -1351,27 +1351,27 @@ struct object_context {
 	 */
 	struct strbuf symlink_path;
 	/*
-	 * If GET_SHA1_RECORD_PATH is set, this will record path (if any)
+	 * If GET_OID_RECORD_PATH is set, this will record path (if any)
 	 * found when resolving the name. The caller is responsible for
 	 * releasing the memory.
 	 */
 	char *path;
 };
 
-#define GET_SHA1_QUIETLY           01
-#define GET_SHA1_COMMIT            02
-#define GET_SHA1_COMMITTISH        04
-#define GET_SHA1_TREE             010
-#define GET_SHA1_TREEISH          020
-#define GET_SHA1_BLOB             040
-#define GET_SHA1_FOLLOW_SYMLINKS 0100
-#define GET_SHA1_RECORD_PATH     0200
-#define GET_SHA1_ONLY_TO_DIE    04000
+#define GET_OID_QUIETLY           01
+#define GET_OID_COMMIT            02
+#define GET_OID_COMMITTISH        04
+#define GET_OID_TREE             010
+#define GET_OID_TREEISH          020
+#define GET_OID_BLOB             040
+#define GET_OID_FOLLOW_SYMLINKS 0100
+#define GET_OID_RECORD_PATH     0200
+#define GET_OID_ONLY_TO_DIE    04000
 
-#define GET_SHA1_DISAMBIGUATORS \
-	(GET_SHA1_COMMIT | GET_SHA1_COMMITTISH | \
-	GET_SHA1_TREE | GET_SHA1_TREEISH | \
-	GET_SHA1_BLOB)
+#define GET_OID_DISAMBIGUATORS \
+	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
+	GET_OID_TREE | GET_OID_TREEISH | \
+	GET_OID_BLOB)
 
 extern int get_oid(const char *str, struct object_id *oid);
 extern int get_oid_commit(const char *str, struct object_id *oid);
diff --git a/refs.c b/refs.c
index 88658ba76..90ecb1d4a 100644
--- a/refs.c
+++ b/refs.c
@@ -818,7 +818,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
-		if (flags & GET_SHA1_QUIETLY)
+		if (flags & GET_OID_QUIETLY)
 			exit(128);
 		else
 			die("Log for %s is empty.", refname);
diff --git a/revision.c b/revision.c
index 4813d8f0a..08caf8bb0 100644
--- a/revision.c
+++ b/revision.c
@@ -1453,7 +1453,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	unsigned int a_flags, b_flags;
 	int symmetric = 0;
 	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
-	unsigned int oc_flags = GET_SHA1_COMMITTISH | GET_SHA1_RECORD_PATH;
+	unsigned int oc_flags = GET_OID_COMMITTISH | GET_OID_RECORD_PATH;
 
 	a_name = arg;
 	if (!*a_name)
@@ -1549,7 +1549,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	int local_flags;
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
-	unsigned get_sha1_flags = GET_SHA1_RECORD_PATH;
+	unsigned get_sha1_flags = GET_OID_RECORD_PATH;
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
 
@@ -1600,7 +1600,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	}
 
 	if (revarg_opt & REVARG_COMMITTISH)
-		get_sha1_flags |= GET_SHA1_COMMITTISH;
+		get_sha1_flags |= GET_OID_COMMITTISH;
 
 	if (get_oid_with_context(arg, get_sha1_flags, &oid, &oc))
 		return revs->ignore_missing ? 0 : -1;
diff --git a/sha1_name.c b/sha1_name.c
index ec8dd9a8d..f7fad38c9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -381,23 +381,23 @@ static int get_short_oid(const char *name, int len, struct object_id *oid,
 {
 	int status;
 	struct disambiguate_state ds;
-	int quietly = !!(flags & GET_SHA1_QUIETLY);
+	int quietly = !!(flags & GET_OID_QUIETLY);
 
 	if (init_object_disambiguation(name, len, &ds) < 0)
 		return -1;
 
-	if (HAS_MULTI_BITS(flags & GET_SHA1_DISAMBIGUATORS))
+	if (HAS_MULTI_BITS(flags & GET_OID_DISAMBIGUATORS))
 		die("BUG: multiple get_short_oid disambiguator flags");
 
-	if (flags & GET_SHA1_COMMIT)
+	if (flags & GET_OID_COMMIT)
 		ds.fn = disambiguate_commit_only;
-	else if (flags & GET_SHA1_COMMITTISH)
+	else if (flags & GET_OID_COMMITTISH)
 		ds.fn = disambiguate_committish_only;
-	else if (flags & GET_SHA1_TREE)
+	else if (flags & GET_OID_TREE)
 		ds.fn = disambiguate_tree_only;
-	else if (flags & GET_SHA1_TREEISH)
+	else if (flags & GET_OID_TREEISH)
 		ds.fn = disambiguate_treeish_only;
-	else if (flags & GET_SHA1_BLOB)
+	else if (flags & GET_OID_BLOB)
 		ds.fn = disambiguate_blob_only;
 	else
 		ds.fn = default_disambiguate_hint;
@@ -497,7 +497,7 @@ int find_unique_abbrev_r(char *hex, const unsigned char *sha1, int len)
 	exists = has_sha1_file(sha1);
 	while (len < 40) {
 		struct object_id oid_ret;
-		status = get_short_oid(hex, len, &oid_ret, GET_SHA1_QUIETLY);
+		status = get_short_oid(hex, len, &oid_ret, GET_OID_QUIETLY);
 		if (exists
 		    ? !status
 		    : status == SHORT_NAME_NOT_FOUND) {
@@ -654,9 +654,9 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 	if (!refs_found)
 		return -1;
 
-	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
+	if (warn_ambiguous_refs && !(flags & GET_OID_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_oid(str, len, &tmp_oid, GET_SHA1_QUIETLY)))
+	     !get_short_oid(str, len, &tmp_oid, GET_OID_QUIETLY)))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
@@ -701,13 +701,13 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				}
 			}
 			if (at_time) {
-				if (!(flags & GET_SHA1_QUIETLY)) {
+				if (!(flags & GET_OID_QUIETLY)) {
 					warning("Log for '%.*s' only goes "
 						"back to %s.", len, str,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
 			} else {
-				if (flags & GET_SHA1_QUIETLY) {
+				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
 				die("Log for '%.*s' only has %d entries.",
@@ -724,7 +724,7 @@ static int get_parent(const char *name, int len,
 		      struct object_id *result, int idx)
 {
 	struct object_id oid;
-	int ret = get_oid_1(name, len, &oid, GET_SHA1_COMMITTISH);
+	int ret = get_oid_1(name, len, &oid, GET_OID_COMMITTISH);
 	struct commit *commit;
 	struct commit_list *p;
 
@@ -755,7 +755,7 @@ static int get_nth_ancestor(const char *name, int len,
 	struct commit *commit;
 	int ret;
 
-	ret = get_oid_1(name, len, &oid, GET_SHA1_COMMITTISH);
+	ret = get_oid_1(name, len, &oid, GET_OID_COMMITTISH);
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(&oid);
@@ -841,11 +841,11 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	else
 		return -1;
 
-	lookup_flags &= ~GET_SHA1_DISAMBIGUATORS;
+	lookup_flags &= ~GET_OID_DISAMBIGUATORS;
 	if (expected_type == OBJ_COMMIT)
-		lookup_flags |= GET_SHA1_COMMITTISH;
+		lookup_flags |= GET_OID_COMMITTISH;
 	else if (expected_type == OBJ_TREE)
-		lookup_flags |= GET_SHA1_TREEISH;
+		lookup_flags |= GET_OID_TREEISH;
 
 	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
@@ -896,7 +896,7 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 static int get_describe_name(const char *name, int len, struct object_id *oid)
 {
 	const char *cp;
-	unsigned flags = GET_SHA1_QUIETLY | GET_SHA1_COMMIT;
+	unsigned flags = GET_OID_QUIETLY | GET_OID_COMMIT;
 
 	for (cp = name + len - 1; name + 2 <= cp; cp--) {
 		char ch = *cp;
@@ -1353,35 +1353,35 @@ int get_oid(const char *name, struct object_id *oid)
 int get_oid_committish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_SHA1_COMMITTISH,
+	return get_oid_with_context(name, GET_OID_COMMITTISH,
 				    oid, &unused);
 }
 
 int get_oid_treeish(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_SHA1_TREEISH,
+	return get_oid_with_context(name, GET_OID_TREEISH,
 				    oid, &unused);
 }
 
 int get_oid_commit(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_SHA1_COMMIT,
+	return get_oid_with_context(name, GET_OID_COMMIT,
 				    oid, &unused);
 }
 
 int get_oid_tree(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_SHA1_TREE,
+	return get_oid_with_context(name, GET_OID_TREE,
 				    oid, &unused);
 }
 
 int get_oid_blob(const char *name, struct object_id *oid)
 {
 	struct object_context unused;
-	return get_oid_with_context(name, GET_SHA1_BLOB,
+	return get_oid_with_context(name, GET_OID_BLOB,
 				    oid, &unused);
 }
 
@@ -1497,10 +1497,10 @@ static int get_oid_with_context_1(const char *name,
 	int ret, bracket_depth;
 	int namelen = strlen(name);
 	const char *cp;
-	int only_to_die = flags & GET_SHA1_ONLY_TO_DIE;
+	int only_to_die = flags & GET_OID_ONLY_TO_DIE;
 
 	if (only_to_die)
-		flags |= GET_SHA1_QUIETLY;
+		flags |= GET_OID_QUIETLY;
 
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
@@ -1543,7 +1543,7 @@ static int get_oid_with_context_1(const char *name,
 			namelen = strlen(cp);
 		}
 
-		if (flags & GET_SHA1_RECORD_PATH)
+		if (flags & GET_OID_RECORD_PATH)
 			oc->path = xstrdup(cp);
 
 		if (!active_cache)
@@ -1582,8 +1582,8 @@ static int get_oid_with_context_1(const char *name,
 		int len = cp - name;
 		unsigned sub_flags = flags;
 
-		sub_flags &= ~GET_SHA1_DISAMBIGUATORS;
-		sub_flags |= GET_SHA1_TREEISH;
+		sub_flags &= ~GET_OID_DISAMBIGUATORS;
+		sub_flags |= GET_OID_TREEISH;
 
 		if (!get_oid_1(name, len, &tree_oid, sub_flags)) {
 			const char *filename = cp+1;
@@ -1592,7 +1592,7 @@ static int get_oid_with_context_1(const char *name,
 			new_filename = resolve_relative_path(filename);
 			if (new_filename)
 				filename = new_filename;
-			if (flags & GET_SHA1_FOLLOW_SYMLINKS) {
+			if (flags & GET_OID_FOLLOW_SYMLINKS) {
 				ret = get_tree_entry_follow_symlinks(tree_oid.hash,
 					filename, oid->hash, &oc->symlink_path,
 					&oc->mode);
@@ -1607,7 +1607,7 @@ static int get_oid_with_context_1(const char *name,
 				}
 			}
 			hashcpy(oc->tree, tree_oid.hash);
-			if (flags & GET_SHA1_RECORD_PATH)
+			if (flags & GET_OID_RECORD_PATH)
 				oc->path = xstrdup(filename);
 
 			free(new_filename);
@@ -1631,12 +1631,12 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(name, GET_SHA1_ONLY_TO_DIE, prefix, &oid, &oc);
+	get_oid_with_context_1(name, GET_OID_ONLY_TO_DIE, prefix, &oid, &oc);
 }
 
 int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
 {
-	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
+	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
 		die("BUG: incompatible flags for get_sha1_with_context");
 	return get_oid_with_context_1(str, flags, NULL, oid, oc);
 }
