Return-Path: <SRS0=tGm0=AR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5907C433DF
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8334A20724
	for <git@archiver.kernel.org>; Mon,  6 Jul 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASAQfc5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgGFR3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729634AbgGFR3h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jul 2020 13:29:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA04C061794
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 10:29:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f7so39014029wrw.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 10:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NAz3yDAVwk0JxVBz8Ws4dPLrVAp18bVekntZp44EBRU=;
        b=ASAQfc5Bb+mgIN4dXr+GLnHoWQoI13eyVq6LrhpvGN1CPB9nlSbmORep7hT2TlxwAV
         ZvYac9RMTM4xp9tGrONNzSAx0hAIKXYbFG1ylaevysciEqpGnoB/Q6z/vGnBytODz4p0
         hHlA5FiZ/5n05Qt4i5PUJoMMKIKL8kOQynY2eALP/cvR7ap4iujVsonHM/5gAeoQCdpf
         kz4Ovxgkhnk2pZ6ifmSLCwLETYCCETxejWuv/wC+IvZhoy/UJ6OUMA0nmYdU5myLY7Iz
         +YTkextBHvsei6TpJwxhE0NDVxvIJkYXPag/eLCwg+9iey9mJzo9bhMYgiq2aTrUmGDU
         5Wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NAz3yDAVwk0JxVBz8Ws4dPLrVAp18bVekntZp44EBRU=;
        b=ssbqYuXQc7088lTCEDjCuWDQGzfNbPjzofrFxMMAAtzECQkPwSrZsjQTsoc7X6qWJT
         /nD/O4A/FrD/rsQFbhpnUvdnVRgXg/bHpbPhylLav5uEo2a8PDog02Ani7GBkPUDXsN8
         VUBi7fihzqB4krbITqSJFgossO6yXXwgBMJZJOUPCyoKKmBUQNPtLWa5/2SCyw2AOuw1
         4JND7GHwICgwhPAvuu2RGmFVlYw+3swACnYIXsjDsQL6BQ5vG49CB3g5ZubUNfjrZyBG
         fSDAGsFY4e+xPVlNbYKZUzlGSxibTLkCLywgVLdqbMwTOv6sUJ7RWSFzxwDlCr1A7SZN
         NqCA==
X-Gm-Message-State: AOAM5333GCjTqHehnvPPxkl/09HhIc6yvQgiwMG/xws8pNR/HRPmiB0m
        aUTkinhyedOFAlOKP0XBfJ6rjpMO
X-Google-Smtp-Source: ABdhPJwHFJQH+M0H4erLQK0n7ZiSdoZZnhLkKs48c0a12ULLKT2UAcgVvxPf9dxe4ZPNfWTBdSwmtQ==
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr46785689wrq.291.1594056575074;
        Mon, 06 Jul 2020 10:29:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm157450wmm.15.2020.07.06.10.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:29:34 -0700 (PDT)
Message-Id: <6821f57bdf326f161f152a8af0e47b54513c77b1.1594056572.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.git.1594056572.gitgitgadget@gmail.com>
References: <pull.673.git.1594056572.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 17:29:31 +0000
Subject: [PATCH 1/2] Modify pseudo refs through ref backend storage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

The previous behavior was introduced in commit 74ec19d4be
("pseudorefs: create and use pseudoref update and delete functions",
Jul 31, 2015), with the justification "alternate ref backends still
need to store pseudorefs in GIT_DIR".

Refs such as REBASE_HEAD are read through the ref backend. This can
only work consistently if they are written through the ref backend as
well. Tooling that works directly on files under .git should be
updated to use git commands to read refs instead.

This needs the following fixes

* Only write log for HEAD pseudo ref. Fixes t1400
  'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD'

* t1400: change hard coded error messages to check for.

* don't deref non-HEAD pseudoref symrefs. This fixes t1405. Without
  this, a deleting a FOO symref pointing to refs/heads/master will remove
  master too.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c                | 120 +++---------------------------------------
 refs/files-backend.c  |  11 ++--
 t/t1400-update-ref.sh |   6 +--
 3 files changed, 17 insertions(+), 120 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7b..a2fd42364f 100644
--- a/refs.c
+++ b/refs.c
@@ -739,102 +739,6 @@ long get_files_ref_lock_timeout_ms(void)
 	return timeout_ms;
 }
 
-static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
-			   const struct object_id *old_oid, struct strbuf *err)
-{
-	const char *filename;
-	int fd;
-	struct lock_file lock = LOCK_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	int ret = -1;
-
-	if (!oid)
-		return 0;
-
-	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
-
-	filename = git_path("%s", pseudoref);
-	fd = hold_lock_file_for_update_timeout(&lock, filename, 0,
-					       get_files_ref_lock_timeout_ms());
-	if (fd < 0) {
-		strbuf_addf(err, _("could not open '%s' for writing: %s"),
-			    filename, strerror(errno));
-		goto done;
-	}
-
-	if (old_oid) {
-		struct object_id actual_old_oid;
-
-		if (read_ref(pseudoref, &actual_old_oid)) {
-			if (!is_null_oid(old_oid)) {
-				strbuf_addf(err, _("could not read ref '%s'"),
-					    pseudoref);
-				rollback_lock_file(&lock);
-				goto done;
-			}
-		} else if (is_null_oid(old_oid)) {
-			strbuf_addf(err, _("ref '%s' already exists"),
-				    pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		} else if (!oideq(&actual_old_oid, old_oid)) {
-			strbuf_addf(err, _("unexpected object ID when writing '%s'"),
-				    pseudoref);
-			rollback_lock_file(&lock);
-			goto done;
-		}
-	}
-
-	if (write_in_full(fd, buf.buf, buf.len) < 0) {
-		strbuf_addf(err, _("could not write to '%s'"), filename);
-		rollback_lock_file(&lock);
-		goto done;
-	}
-
-	commit_lock_file(&lock);
-	ret = 0;
-done:
-	strbuf_release(&buf);
-	return ret;
-}
-
-static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
-{
-	const char *filename;
-
-	filename = git_path("%s", pseudoref);
-
-	if (old_oid && !is_null_oid(old_oid)) {
-		struct lock_file lock = LOCK_INIT;
-		int fd;
-		struct object_id actual_old_oid;
-
-		fd = hold_lock_file_for_update_timeout(
-				&lock, filename, 0,
-				get_files_ref_lock_timeout_ms());
-		if (fd < 0) {
-			error_errno(_("could not open '%s' for writing"),
-				    filename);
-			return -1;
-		}
-		if (read_ref(pseudoref, &actual_old_oid))
-			die(_("could not read ref '%s'"), pseudoref);
-		if (!oideq(&actual_old_oid, old_oid)) {
-			error(_("unexpected object ID when deleting '%s'"),
-			      pseudoref);
-			rollback_lock_file(&lock);
-			return -1;
-		}
-
-		unlink(filename);
-		rollback_lock_file(&lock);
-	} else {
-		unlink(filename);
-	}
-
-	return 0;
-}
-
 int refs_delete_ref(struct ref_store *refs, const char *msg,
 		    const char *refname,
 		    const struct object_id *old_oid,
@@ -843,11 +747,6 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store(the_repository));
-		return delete_pseudoref(refname, old_oid);
-	}
-
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
@@ -1170,18 +1069,13 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 	struct strbuf err = STRBUF_INIT;
 	int ret = 0;
 
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
-		assert(refs == get_main_ref_store(the_repository));
-		ret = write_pseudoref(refname, new_oid, old_oid, &err);
-	} else {
-		t = ref_store_transaction_begin(refs, &err);
-		if (!t ||
-		    ref_transaction_update(t, refname, new_oid, old_oid,
-					   flags, msg, &err) ||
-		    ref_transaction_commit(t, &err)) {
-			ret = 1;
-			ref_transaction_free(t);
-		}
+	t = ref_store_transaction_begin(refs, &err);
+	if (!t ||
+	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
+				   &err) ||
+	    ref_transaction_commit(t, &err)) {
+		ret = 1;
+		ref_transaction_free(t);
 	}
 	if (ret) {
 		const char *str = _("update_ref failed for ref '%s': %s");
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6516c7bc8c..9951c2e403 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1228,7 +1228,6 @@ static int files_delete_refs(struct ref_store *ref_store, const char *msg,
 
 	for (i = 0; i < refnames->nr; i++) {
 		const char *refname = refnames->items[i].string;
-
 		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
 			result |= error(_("could not remove reference %s"), refname);
 	}
@@ -2436,7 +2435,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	update->backend_data = lock;
 
 	if (update->type & REF_ISSYMREF) {
-		if (update->flags & REF_NO_DEREF) {
+		if (update->flags & REF_NO_DEREF ||
+		    (ref_type(update->refname) == REF_TYPE_PSEUDOREF &&
+		     strcmp(update->refname, "HEAD"))) {
 			/*
 			 * We won't be reading the referent as part of
 			 * the transaction, so we have to read it here
@@ -2782,8 +2783,10 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		struct ref_update *update = transaction->updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_NEEDS_COMMIT ||
-		    update->flags & REF_LOG_ONLY) {
+		if ((ref_type(lock->ref_name) != REF_TYPE_PSEUDOREF ||
+		     !strcmp(lock->ref_name, "HEAD")) &&
+		    (update->flags & REF_NEEDS_COMMIT ||
+		     update->flags & REF_LOG_ONLY)) {
 			if (files_log_ref_write(refs,
 						lock->ref_name,
 						&lock->old_oid,
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 27171f8261..6b8030e8fe 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -476,7 +476,7 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
 	test_path_is_missing .git/PSEUDOREF &&
-	test_i18ngrep "could not read ref" err
+	test_i18ngrep "unable to resolve reference" err
 '
 
 test_expect_success 'create pseudoref' '
@@ -497,7 +497,7 @@ test_expect_success 'overwrite pseudoref with correct old value' '
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
 	test $C = $(cat .git/PSEUDOREF) &&
-	test_i18ngrep "unexpected object ID" err
+	test_i18ngrep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref' '
@@ -509,7 +509,7 @@ test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
 	test $A = $(cat .git/PSEUDOREF) &&
-	test_i18ngrep "unexpected object ID" err
+	test_i18ngrep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
-- 
gitgitgadget

