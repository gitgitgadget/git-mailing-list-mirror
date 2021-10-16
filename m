Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D5C433FE
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1692F6108E
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhJPJme (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbhJPJlv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:51 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB88C061771
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l38-20020a05600c1d2600b0030d80c3667aso4046737wms.5
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XqUfuYNmPmcLugwVlKfE2Jjb4eJpHqrjGGmswPW08C8=;
        b=Y03VuSZRBirsW9elQ2I6HmU5SL9WlUY4FbuUTdgYWwLtZZ9gjUIMBF6A3+dY7YjgC6
         Vhwwh1CQVX9jEVZzxFwrvC33OfrRLufM2LApvjThsKwSpNP+uvL6D306YYuu6GR0aPO/
         VKCkMqM2P5jfa6Rqlm04Z+G9rbIwVbYpR4B3ywXzzjn1vaNpiTCIDGq8jrQWAntw+OO+
         ZmG3Ukx0JP+LL7R6gGuY6PHKNzrvdI43oeRuCslBAp8AdYvMuJv5zZzCVCK8q1f1nZc9
         MR6es50N51zZ7QYumOo1uLEiJX8rz0e918KlnW9dHzebkGnz1sRiR39VswxekYVK6JEW
         0pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XqUfuYNmPmcLugwVlKfE2Jjb4eJpHqrjGGmswPW08C8=;
        b=B+9Ag0Lfx2bbUNB+obSk85ZIlVCyipGYBf4tED8W55/DrnHBi+xbeJEUAzieyVg+Pr
         dr/+SQ3kd8TT/FsyHADFMQlY64Tnxw1Xk20stv1HLjmMRLqimv62sxBWaf56sjNv+nz/
         WFqF53LzPT1t6gPHRuHD+w+uQt+E6XlkhYs6jXMUIzA8Evs/P/uzj7E/+Cg0obQiDOlX
         czuQJMV7lUQUZfVVYnQfW4QgwAu+7NuNE15YUCoUXuUlgaYpp7SbP3xbjTc0zxtQmi1A
         oCaOzZbhbc2zI7YVetBMky7i9mrSvSRFWRsRnjgoX5CLnZe2/eqJrCooRl0v74W2ll1B
         uiBA==
X-Gm-Message-State: AOAM5309v7nHyEnu19g/WpRu8/j/8u8nTKGkJ9Hpp3bpxi7PVTc9qKfF
        u2UuV1j/5MfRb7vF53gxRZeHn7PSHe/X7w==
X-Google-Smtp-Source: ABdhPJytGyaQ7FvURXLrXBI0jxqJndE8yZFwH4dDfXxcwrARRC0oCEBHT7oa262wyJ8vVO58ufUmhQ==
X-Received: by 2002:a1c:2209:: with SMTP id i9mr31934555wmi.20.1634377175336;
        Sat, 16 Oct 2021 02:39:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/21] refs/files: remove "name exist?" check in lock_ref_oid_basic()
Date:   Sat, 16 Oct 2021 11:39:13 +0200
Message-Id: <patch-v2-07.21-7db3b446632-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In lock_ref_oid_basic() we'll happily lock a reference that doesn't
exist yet. That's normal, and is how references are initially born,
but we don't need to retain checks here in lock_ref_oid_basic() about
the state of the ref, when what we're checking is either checked
already, or something we're about to discover by trying to lock the
ref with raceproof_create_file().

The one exception is the caller in files_reflog_expire(), who passes
us a "type" to find out if the reference is a symref or not. We can
move the that logic over to that caller, which can now defer its
discovery of whether or not the ref is a symref until it's needed. In
the preceding commit an exhaustive regression test was added for that
case in a new test in "t1417-reflog-updateref.sh".

The improved diagnostics here were added in
5b2d8d6f218 (lock_ref_sha1_basic(): improve diagnostics for ref D/F
conflicts, 2015-05-11), and then much of the surrounding code went
away recently in my 245fbba46d6 (refs/files: remove unused "errno ==
EISDIR" code, 2021-08-23).

The refs_resolve_ref_unsafe() code being removed here looks like it
should be tasked with doing that, but it's actually redundant to other
code.

The reason for that is as noted in 245fbba46d6 this once widely used
function now only has a handful of callers left, which all handle this
case themselves.

To the extent that we're racy between their check and ours removing
this check actually improves the situation, as we'll be doing fewer
things between the not-under-lock initial check and acquiring the
lock.

Why this is OK for all the remaining callers of lock_ref_oid_basic()
is noted below. There are only two of those callers:

* "git branch -[cm] <oldbranch> <newbranch>":

  In files_copy_or_rename_ref() we'll call this when we copy or rename
  refs via rename_ref() and copy_ref(). but only after we've checked
  if the refname exists already via its own call to
  refs_resolve_ref_unsafe() and refs_rename_ref_available().

  As the updated comment to the latter here notes neither of those are
  actually needed. If we delete not only this code but also
  refs_rename_ref_available() we'll do just fine, we'll just emit a
  less friendly error message if e.g. "git branch -m A B/C" would have
  a D/F conflict with a "B" file.

  Actually we'd probably die before that in case reflogs for the
  branch existed, i.e. when the try to rename() or copy_file() the
  relevant reflog, since if we've got a D/F conflict with a branch
  name we'll probably also have the same with its reflogs (but not
  necessarily, we might have reflogs, but it might not).

  As some #leftoverbits that code seems buggy to me, i.e. the reflog
  "protocol" should be to get a lock on the main ref, and then perform
  ref and/or reflog operations. That code dates back to
  c976d415e53 (git-branch: add options and tests for branch renaming,
  2006-11-28) and probably pre-dated the solidifying of that
  convention. But in any case, that edge case is not our bug or
  problem right now.

* "git reflog expire <ref>":

  In files_reflog_expire() we'll call this without previous ref
  existence checking in files-backend.c, but that code is in turn
  called by code that's just finished checking if the refname whose
  reflog we're expiring exists.

  See ae35e16cd43 (reflog expire: don't lock reflogs using previously
  seen OID, 2021-08-23) for the current state of that code, and
  5e6f003ca8a (reflog_expire(): ignore --updateref for symbolic
  references, 2015-03-03) for the code we'd break if we only did a
  "update = !!ref" here, which is covered by the aforementioned
  regression test in "t1417-reflog-updateref.sh".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 48 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0af6ee44552..16e78326381 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1001,7 +1001,7 @@ static int create_reflock(const char *path, void *cb)
  * Locks a ref returning the lock on success and NULL on failure.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
-					   const char *refname, int *type,
+					   const char *refname,
 					   struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
@@ -1013,16 +1013,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	CALLOC_ARRAY(lock, 1);
 
 	files_ref_path(refs, &ref_file, refname);
-	if (!refs_resolve_ref_unsafe(&refs->base, refname,
-				     RESOLVE_REF_NO_RECURSE,
-				     &lock->old_oid, type)) {
-		if (!refs_verify_refname_available(&refs->base, refname,
-						   NULL, NULL, err))
-			strbuf_addf(err, "unable to resolve reference '%s': %s",
-				    refname, strerror(errno));
-
-		goto error_return;
-	}
 
 	/*
 	 * If the ref did not exist and we are creating it, make sure
@@ -1364,14 +1354,14 @@ static int commit_ref_update(struct files_ref_store *refs,
 			     struct strbuf *err);
 
 /*
- * Check whether an attempt to rename old_refname to new_refname would
- * cause a D/F conflict with any existing reference (other than
- * possibly old_refname). If there would be a conflict, emit an error
+ * Emit a better error message than lockfile.c's
+ * unable_to_lock_message() would in case there is a D/F conflict with
+ * another existing reference. If there would be a conflict, emit an error
  * message and return false; otherwise, return true.
  *
  * Note that this function is not safe against all races with other
- * processes (though rename_ref() catches some races that might get by
- * this check).
+ * processes, and that's not its job. We'll emit a more verbose error on D/f
+ * conflicts if we get past it into lock_ref_oid_basic().
  */
 static int refs_rename_ref_available(struct ref_store *refs,
 			      const char *old_refname,
@@ -1492,7 +1482,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1514,7 +1504,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1921,7 +1911,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_oid_basic(refs, refname, NULL, &err);
+	lock = lock_ref_oid_basic(refs, refname, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3125,7 +3115,6 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	struct strbuf log_file_sb = STRBUF_INIT;
 	char *log_file;
 	int status = 0;
-	int type;
 	struct strbuf err = STRBUF_INIT;
 	const struct object_id *oid;
 
@@ -3139,7 +3128,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
@@ -3201,9 +3190,20 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		 * a reference if there are no remaining reflog
 		 * entries.
 		 */
-		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
-			!(type & REF_ISSYMREF) &&
-			!is_null_oid(&cb.last_kept_oid);
+		int update = 0;
+
+		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
+		    !is_null_oid(&cb.last_kept_oid)) {
+			int ignore_errno;
+			int type;
+			const char *ref;
+
+			ref = refs_werrres_ref_unsafe(&refs->base, refname,
+						      RESOLVE_REF_NO_RECURSE,
+						      NULL, &type,
+						      &ignore_errno);
+			update = !!(ref && !(type & REF_ISSYMREF));
+		}
 
 		if (close_lock_file_gently(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
-- 
2.33.1.1338.g20da966911a

