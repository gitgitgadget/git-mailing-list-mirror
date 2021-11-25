Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E449C433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbhKYQM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356394AbhKYQKy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:10:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9BAC0619E0
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so12603913wrn.6
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tnD+EksciJjt6lu/AUx/uUiNsF4xuT/jBC7k5GvwHgg=;
        b=dxiNBqwAlCz28JlfMemvcimCAwYWAcSOD0Vl0ncMOhxBvIbudzF6swZP0EkBgw6rYD
         k6W26J1sk/E3xLNSp/mDJB0JI2DmXZG10NzkxuV9l5umpr9THaHgJRjjPmaGjDWMaiea
         YN+/TVW3/3YQcvHcxV1ezbVgDS10aOski2RAyBsyzcdWVVfLcD6VQS6o0dfDwA76o9cJ
         c/sVPmKO+NMyJKxBYvjigz67+nm7mnjvmifSkiW9H4u1wLmbI2jr4OnpzfRg3rkuNUpZ
         FYaYS9w64EDpUIM2LvLqdMjjikOA1nBNrAq3RC6WrfE2nA/hUosrEq5S3fj/5MRM+MnO
         Jwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tnD+EksciJjt6lu/AUx/uUiNsF4xuT/jBC7k5GvwHgg=;
        b=rmzXHqJhMRSbH4elHMlxrCY1kn+ZP5LOp4LVwYRZiIvgX6CT6Ws3icxOBSfL6OPiMl
         dwlf0/O0xPGAkXg1GCTkaXFsbTDkfdnG7BT49kpuLtnMZEVmfKkBxIWQrDDsBC5+2GI7
         bxhgneSBDEZ/S+/UTQkB6fe3I/ijJS8OOaC8LA9ILvW6VcKc0tf2wLHQ1t9B+cRv5FwZ
         p/TCbXBcsWVp1kRL4yTI0/5vcnIDykBdjauJcOArhgTTQ1c4282wMpSguORZbriVy+YO
         7mLUah9gTDkLtyttwokS0EJRjaO2fxnxMqHdS6DxOhvBeW9UE0h7yJn2IAn9UnwjSPuG
         pIew==
X-Gm-Message-State: AOAM531dTjMUjh2bm2hleQqhmVipU/I6VRl5StSH9xJP74Ejemye9Pvn
        xACx7C+ard46vf1K+sZikVlandEtd+c=
X-Google-Smtp-Source: ABdhPJwRhVvu1pfwmdPCJAM9sB7b/7X5cNLBntmRZwqq3GTEU6t8jGhtjClWqEZ8goUDP6HNASHAFQ==
X-Received: by 2002:adf:e8d1:: with SMTP id k17mr7546795wrn.465.1637855764528;
        Thu, 25 Nov 2021 07:56:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22sm3288514wme.19.2021.11.25.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:56:03 -0800 (PST)
Message-Id: <900cea2ade9e86b135e4189070a68deea5e9b575.1637855761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:56:01 +0000
Subject: [PATCH 2/2] refs: allow skipping OID verification
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
