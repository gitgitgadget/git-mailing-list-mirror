Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 039F720372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdJOWIo (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55004 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751364AbdJOWHj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:39 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7CCC46044B;
        Sun, 15 Oct 2017 22:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105258;
        bh=NBCPkDfnEVvyZ4kF/Mwdn2+qHVAYHqVsHUdb1Qoa10U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0h1ti6QWHq8GGhx2h9BjvpH3+llKcCPZpfSzGVfBfQyldEXzXnaTz+StAVLn3daWc
         zQfm1BQs8xbpdq8b3lbDvCyDYFiOrJ9V4gsL22CUtXPPDCeg4v8RqLglcPM2LYEfjx
         xBe0LuvOHwa1O56ArDIY2QRmCA4zUXM2Ok9sQC3fMmpg4pxrAZ38F10891V2jvBfmB
         8BESqvGjh0g5CCqr4Lm8oQSBTOPFhekd9bdhzj8n8mO6+atTQy0ssTHi5oY/nK3vNl
         qqR6hD2Umj2kMhytsaLn+rYIaRhMc8h+oiOR7QUpuEzojGJKe+yQcDpdKPowbiOHAG
         KYLqBDcNMslmvS1DS7H8wrYgyimlYMV2UjEP3jcfhHmHeJUx4uLna25hR7omV8Ubhk
         /Dmx0SDhD17ekbRN/ffSqnqKnKaRmISgazPsLy9TxTQZLsnQA4uzgwF8wOBRYsB0g2
         gIbXBJvHv7xJD9iMeCqdpIlHrBQXTYIovQ5C5cI4NNlKneoBb5k
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 03/25] refs: convert delete_ref and refs_delete_ref to struct object_id
Date:   Sun, 15 Oct 2017 22:06:50 +0000
Message-Id: <20171015220712.97308-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert delete_ref and refs_delete_ref to take a pointer to struct
object_id.  Update the documentation accordingly, including referring to
null_oid in lowercase, as it is not a #define constant.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/branch.c          |  2 +-
 builtin/replace.c         |  2 +-
 builtin/reset.c           |  2 +-
 builtin/tag.c             |  2 +-
 builtin/update-ref.c      |  2 +-
 refs.c                    | 21 +++++++++++----------
 refs.h                    | 12 ++++++------
 refs/files-backend.c      |  2 +-
 t/helper/test-ref-store.c |  6 +++---
 9 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index b67593288c..f5237541a2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -257,7 +257,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			goto next;
 		}
 
-		if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : oid.hash,
+		if (delete_ref(NULL, name, is_null_oid(&oid) ? NULL : &oid,
 			       REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
diff --git a/builtin/replace.c b/builtin/replace.c
index 3e71a77152..2854eaa0f3 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -128,7 +128,7 @@ static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 static int delete_replace_ref(const char *name, const char *ref,
 			      const struct object_id *oid)
 {
-	if (delete_ref(NULL, ref, oid->hash, 0))
+	if (delete_ref(NULL, ref, oid, 0))
 		return 1;
 	printf("Deleted replace ref '%s'\n", name);
 	return 0;
diff --git a/builtin/reset.c b/builtin/reset.c
index 9cd89b2305..5f3632e05b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -269,7 +269,7 @@ static int reset_refs(const char *rev, const struct object_id *oid)
 		update_ref_oid(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
 			   UPDATE_REFS_MSG_ON_ERR);
 	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig->hash, 0);
+		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
 	set_reflog_message(&msg, "updating HEAD", rev);
 	update_ref_status = update_ref_oid(msg.buf, "HEAD", oid, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
diff --git a/builtin/tag.c b/builtin/tag.c
index 695cb0778e..272f0d3103 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -97,7 +97,7 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 static int delete_tag(const char *name, const char *ref,
 		      const struct object_id *oid, const void *cb_data)
 {
-	if (delete_ref(NULL, ref, oid->hash, 0))
+	if (delete_ref(NULL, ref, oid, 0))
 		return 1;
 	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 	return 0;
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6b90c5dead..bf0f80ebae 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -434,7 +434,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 * NULL_SHA1 as "don't care" here:
 		 */
 		return delete_ref(msg, refname,
-				  (oldval && !is_null_oid(&oldoid)) ? oldoid.hash : NULL,
+				  (oldval && !is_null_oid(&oldoid)) ? &oldoid : NULL,
 				  flags);
 	else
 		return update_ref(msg, refname, oid.hash, oldval ? oldoid.hash : NULL,
diff --git a/refs.c b/refs.c
index c590a992fb..25170d9143 100644
--- a/refs.c
+++ b/refs.c
@@ -620,25 +620,25 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 	return ret;
 }
 
-static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
+static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
 {
 	static struct lock_file lock;
 	const char *filename;
 
 	filename = git_path("%s", pseudoref);
 
-	if (old_sha1 && !is_null_sha1(old_sha1)) {
+	if (old_oid && !is_null_oid(old_oid)) {
 		int fd;
-		unsigned char actual_old_sha1[20];
+		struct object_id actual_old_oid;
 
 		fd = hold_lock_file_for_update_timeout(
 				&lock, filename, LOCK_DIE_ON_ERROR,
 				get_files_ref_lock_timeout_ms());
 		if (fd < 0)
 			die_errno(_("Could not open '%s' for writing"), filename);
-		if (read_ref(pseudoref, actual_old_sha1))
+		if (read_ref(pseudoref, actual_old_oid.hash))
 			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
+		if (oidcmp(&actual_old_oid, old_oid)) {
 			warning("Unexpected sha1 when deleting %s", pseudoref);
 			rollback_lock_file(&lock);
 			return -1;
@@ -655,7 +655,7 @@ static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1
 
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
-		    const unsigned char *old_sha1,
+		    const struct object_id *old_oid,
 		    unsigned int flags)
 {
 	struct ref_transaction *transaction;
@@ -663,12 +663,13 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 
 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
 		assert(refs == get_main_ref_store());
-		return delete_pseudoref(refname, old_sha1);
+		return delete_pseudoref(refname, old_oid);
 	}
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, old_sha1,
+	    ref_transaction_delete(transaction, refname,
+				   old_oid ? old_oid->hash : NULL,
 				   flags, msg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		error("%s", err.buf);
@@ -682,10 +683,10 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 }
 
 int delete_ref(const char *msg, const char *refname,
-	       const unsigned char *old_sha1, unsigned int flags)
+	       const struct object_id *old_oid, unsigned int flags)
 {
 	return refs_delete_ref(get_main_ref_store(), msg, refname,
-			       old_sha1, flags);
+			       old_oid, flags);
 }
 
 int copy_reflog_msg(char *buf, const char *msg)
diff --git a/refs.h b/refs.h
index a02b628c8f..09575fc2bf 100644
--- a/refs.h
+++ b/refs.h
@@ -371,19 +371,19 @@ int refs_reflog_exists(struct ref_store *refs, const char *refname);
 int reflog_exists(const char *refname);
 
 /*
- * Delete the specified reference. If old_sha1 is non-NULL, then
+ * Delete the specified reference. If old_oid is non-NULL, then
  * verify that the current value of the reference is old_sha1 before
- * deleting it. If old_sha1 is NULL, delete the reference if it
- * exists, regardless of its old value. It is an error for old_sha1 to
- * be NULL_SHA1. msg and flags are passed through to
+ * deleting it. If old_oid is NULL, delete the reference if it
+ * exists, regardless of its old value. It is an error for old_oid to
+ * be null_oid. msg and flags are passed through to
  * ref_transaction_delete().
  */
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
-		    const unsigned char *old_sha1,
+		    const struct object_id *old_oid,
 		    unsigned int flags);
 int delete_ref(const char *msg, const char *refname,
-	       const unsigned char *old_sha1, unsigned int flags);
+	       const struct object_id *old_oid, unsigned int flags);
 
 /*
  * Delete the specified references. If there are any problems, emit
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9db9237f1e..9c4766aa57 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1283,7 +1283,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    orig_oid.hash, REF_NODEREF)) {
+			    &orig_oid, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 05d8c4d8af..4624238641 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -218,12 +218,12 @@ static int cmd_delete_ref(struct ref_store *refs, const char **argv)
 	const char *refname = notnull(*argv++, "refname");
 	const char *sha1_buf = notnull(*argv++, "old-sha1");
 	unsigned int flags = arg_flags(*argv++, "flags");
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 
-	if (get_sha1_hex(sha1_buf, old_sha1))
+	if (get_oid_hex(sha1_buf, &old_oid))
 		die("not sha-1");
 
-	return refs_delete_ref(refs, msg, refname, old_sha1, flags);
+	return refs_delete_ref(refs, msg, refname, &old_oid, flags);
 }
 
 static int cmd_update_ref(struct ref_store *refs, const char **argv)
-- 
2.15.0.rc0.271.g36b669edcc

