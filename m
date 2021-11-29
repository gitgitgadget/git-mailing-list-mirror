Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B364C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhK2W5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhK2W5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:57:17 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D5C06139E
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q3so16110197wru.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tnD+EksciJjt6lu/AUx/uUiNsF4xuT/jBC7k5GvwHgg=;
        b=WB/0688XrSHQ3RYQPI6xYbKfSa1pJheV2fuKKmankoqGotsHrWiQyGqg/2fx5gwYw0
         F2H8ihMJcAh2R/fLVeNCY/XAMt46H7vZisF4FBNqMemDfJDcn2hSb9j3wGBJoBYvA3mU
         E0K2FxusmA7iwQE3yWTpMyLcodk4FZwFqVCF4Z6osb8n9mcTVvrBhJSLaGzjvPaVXNDe
         TT1UEoo1N7ypzTsEwOw1W36wTvBDPK11ndrLuCjj9RUyLYTHdjmFwY8m6ZuQtPl3QP43
         L7LkudojW9CEhAjn+ZECuR2Em1GElwoifa3SLio1ilE4jvg7zzBppYFSPzZ7vZ5s/opv
         EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tnD+EksciJjt6lu/AUx/uUiNsF4xuT/jBC7k5GvwHgg=;
        b=Fkj2JQrzZ2W87GyrNgaOU9kIXyDi5Xo32VgBOX4hYqO5SOMR0owotpp+bp3BNMtfdo
         4W5BHf1SV3k4/Zc/LSvoKEvLmlMutvf0043IUlQH7plPkHOQQ+BKohWZ46gMI46hQGvz
         wxDK7kwMZrmuUpjEpd6R22gTo1J7wdLbqLex1G/Y/eC93JfKtMzAAp6W4xSGkWao37Ok
         X7r5XfM152ME3PynMLep4QgySz6nlPFleQARJXr6SPQDu7dv/ZRffE9RiDsofbZRwsGb
         iiizxDLKv9TaWZrl97B2PcZJ4RbFWHPJfy+hf1doJwZBw0syvJtVufYXHyCXwDLma3uH
         hpPw==
X-Gm-Message-State: AOAM530U6iaK3lBYxq69VB5JmdbWMyqpXCMFw0gMCk1p1xks2QTivfnM
        gSqwJH4+4KZCEvVQrJJCEATNtjMVASY=
X-Google-Smtp-Source: ABdhPJynF3WY8gnVWuUOlBCzNpjg/FbYjnBjdfqzhLeWcJj/Uy2U48zgXagFIB2pXT9016IawV5tig==
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr35278955wrw.319.1638211788880;
        Mon, 29 Nov 2021 10:49:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm14210016wri.6.2021.11.29.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:49:48 -0800 (PST)
Message-Id: <93fe3f03fb2a10f36aff4a6e4702053daeaa1d64.1638211786.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 18:49:43 +0000
Subject: [PATCH v2 3/6] refs: allow skipping OID verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This introduces the REF_SKIP_OID_VERIFICATION flag, which lets the ref-store
test helper write non-existent or unparsable objects into the ref storage.

Use this to make t1006 and t3800 independent of the files storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.h               |  8 ++++++-
 refs/files-backend.c | 50 +++++++++++++++++++++++++-------------------
 t/t1006-cat-file.sh  |  5 ++---
 t/t3800-mktag.sh     |  6 ++++--
 4 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/refs.h b/refs.h
index d5099d4984e..46e68fd4c2a 100644
--- a/refs.h
+++ b/refs.h
@@ -611,12 +611,18 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
  */
 #define REF_FORCE_CREATE_REFLOG (1 << 1)
 
+/*
+ * Blindly write an object_id. This is useful for testing data corruption
+ * scenarios.
+ */
+#define REF_SKIP_OID_VERIFICATION (1 << 10)
+
 /*
  * Bitmask of all of the flags that are allowed to be passed in to
  * ref_transaction_update() and friends:
  */
 #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS \
-	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG)
+	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION)
 
 /*
  * Add a reference update to transaction. `new_oid` is the value that
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cfdec1e820..28a349b24ad 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1351,7 +1351,8 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 }
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err);
+				 const struct object_id *oid,
+				 int skip_oid_verification, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1468,7 +1469,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1488,7 +1489,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1724,26 +1725,31 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * errors, rollback the lockfile, fill in *err and return -1.
  */
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err)
+				 const struct object_id *oid,
+				 int skip_oid_verification, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(the_repository, oid);
-	if (!o) {
-		strbuf_addf(err,
-			    "trying to write ref '%s' with nonexistent object %s",
-			    lock->ref_name, oid_to_hex(oid));
-		unlock_ref(lock);
-		return -1;
-	}
-	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
-		strbuf_addf(err,
-			    "trying to write non-commit object %s to branch '%s'",
-			    oid_to_hex(oid), lock->ref_name);
-		unlock_ref(lock);
-		return -1;
+	if (!skip_oid_verification) {
+		o = parse_object(the_repository, oid);
+		if (!o) {
+			strbuf_addf(
+				err,
+				"trying to write ref '%s' with nonexistent object %s",
+				lock->ref_name, oid_to_hex(oid));
+			unlock_ref(lock);
+			return -1;
+		}
+		if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
+			strbuf_addf(
+				err,
+				"trying to write non-commit object %s to branch '%s'",
+				oid_to_hex(oid), lock->ref_name);
+			unlock_ref(lock);
+			return -1;
+		}
 	}
 	fd = get_lock_file_fd(&lock->lk);
 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
@@ -2150,7 +2156,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 }
 
 static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
-				   struct object_id *peeled)
+				      struct object_id *peeled)
 {
 	BUG("ref_iterator_peel() called for reflog_iterator");
 }
@@ -2534,8 +2540,10 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, &update->new_oid,
-						 err)) {
+		} else if (write_ref_to_lockfile(
+				   lock, &update->new_oid,
+				   update->flags & REF_SKIP_OID_VERIFICATION,
+				   err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
 			/*
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 658628375c8..f5333196b07 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -452,9 +452,8 @@ test_expect_success 'the --allow-unknown-type option does not consider replaceme
 	# Create it manually, as "git replace" will die on bogus
 	# types.
 	head=$(git rev-parse --verify HEAD) &&
-	test_when_finished "rm -rf .git/refs/replace" &&
-	mkdir -p .git/refs/replace &&
-	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+	test_when_finished "test-tool ref-store main delete-refs 0 msg refs/replace/$bogus_short_sha1" &&
+	test-tool ref-store main update-ref msg "refs/replace/$bogus_short_sha1" $head $ZERO_OID 1024 &&
 
 	cat >expect <<-EOF &&
 	commit
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 0544d58a6ea..128d374f740 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -72,7 +72,8 @@ check_verify_failure () {
 
 		# Manually create the broken, we cannot do it with
 		# update-ref
-		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID 1024 &&
 
 		# Unlike fsck-ing unreachable content above, this
 		# will always fail.
@@ -83,7 +84,8 @@ check_verify_failure () {
 		# Make sure the earlier test created it for us
 		git rev-parse "$bad_tag" &&
 
-		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+		test-tool -C bad-tag ref-store main delete-refs 0 msg "$tag_ref" &&
+		test-tool -C bad-tag ref-store main update-ref msg "$tag_ref" $bad_tag $ZERO_OID 1024 &&
 
 		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
 		git -C bad-tag for-each-ref "$tag_ref" >actual &&
-- 
gitgitgadget

