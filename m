Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9CC433E3
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20229207E8
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 18:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ue4gfJUJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgGPSps (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgGPSpq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 14:45:46 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC57C08C5C0
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:46 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so8136097wrv.9
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 11:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=n2gPO7GdyilwpZ+StCNh0Wc6vWKegCa2Ei2TAGhVmxg=;
        b=ue4gfJUJ9ncO2c972rUJqOS2YSGnujhj57w9Qfe4XugUDDFlT3IAsDc9Ka/r8KvU5K
         ouJCbH2i0dF3BU1VXMCyYBkP23+imz2oIvJ5UzfIgp1Ds/DsPPF1S4JYtFAoF6qWjAQF
         RHRDbXaCoig33isfMOHNieGH3RtFk2Oqfxpm7bYdYiXXQMtFE+xM3wfYLndVUP7r3FvM
         r8pSRZRLQM4ZXZ9SjsQK9y9Q+BVD3PdCaF82CySdaLm3860RUn5VPzZwdgZbGWwRAj0Z
         sjRtGjWfsykrtmh1gebMwIpOGwW1rw4Q/tcg7xxGaQH26IX4narKAkxPyFRCSxtSVhTq
         zwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=n2gPO7GdyilwpZ+StCNh0Wc6vWKegCa2Ei2TAGhVmxg=;
        b=W2IKPMoyViKNUKADBkHGYXKBsczOmPmvegDWyRw79eKqe6f1n72Te/p9y5GjLVzcTY
         fpnDrimsUOl7irsRGrhYQr+RoZk7iqP/eMZRnJ5nh+DqLLtRvAXW/K1NpV+/fv04Vf+g
         g9Y1I/5rR6Paa/SniYCd6/dJ1dwA62/wFYOHbASRzHDdhQ4K0rC1mVFLDAFHsKop8amT
         wGpSJi00Kdn43JPZ3WPJepNdEimEm7VV44ljA4A8aUXqgAZv4luFZpfLEnVuGajqHnjp
         onQGXKq7fQE2QrwHOySOOWe8TEatHXelP7157NmtbGF5l82IxR/5Bp/arNPTybdMbz+o
         644Q==
X-Gm-Message-State: AOAM533edNHF8NAoavBF5igtjCXgzkFxId7X1uNBYthP81oBO3tf65lw
        y0GszvILTlXZTVej1xGCuLafN5KV
X-Google-Smtp-Source: ABdhPJzdqSh4bVoKC/EoZc+x6X913jkMExEBvNoaY/vD0C8ZyuxTVVVWIqZnN+gOzv6GVxZKY6r3UA==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr6448335wrq.189.1594925144401;
        Thu, 16 Jul 2020 11:45:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17sm10723925wrp.70.2020.07.16.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 11:45:43 -0700 (PDT)
Message-Id: <79cd5dd480a4218d4563120c03046375594cc23e.1594925141.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
        <pull.673.v3.git.1594925141.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jul 2020 18:45:40 +0000
Subject: [PATCH v3 2/3] Modify pseudo refs through ref backend storage
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

The following behaviors change:

* Updates to pseudorefs (eg. ORIG_HEAD) with
  core.logAllRefUpdates=always will create reflogs for the pseudoref.

* non-HEAD pseudoref symrefs are also dereferenced on deletion. Update
  t1405 accordingly.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/git-update-ref.txt |  13 ++--
 refs.c                           | 120 ++-----------------------------
 t/t1400-update-ref.sh            |  10 +--
 t/t1405-main-ref-store.sh        |   5 +-
 4 files changed, 23 insertions(+), 125 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 3e737c2360..d401234b03 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -148,12 +148,13 @@ still see a subset of the modifications.
 
 LOGGING UPDATES
 ---------------
-If config parameter "core.logAllRefUpdates" is true and the ref is one under
-"refs/heads/", "refs/remotes/", "refs/notes/", or the symbolic ref HEAD; or
-the file "$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
-a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
-symbolic refs before creating the log name) describing the change
-in ref value.  Log lines are formatted as:
+If config parameter "core.logAllRefUpdates" is true and the ref is one
+under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
+like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
+`git update-ref` will append a line to the log file
+"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
+the log name) describing the change in ref value.  Log lines are
+formatted as:
 
     oldsha1 SP newsha1 SP committer LF
 
diff --git a/refs.c b/refs.c
index 639cba93b4..d676acb1f4 100644
--- a/refs.c
+++ b/refs.c
@@ -771,102 +771,6 @@ long get_files_ref_lock_timeout_ms(void)
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
@@ -875,11 +779,6 @@ int refs_delete_ref(struct ref_store *refs, const char *msg,
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
@@ -1202,18 +1101,13 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
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
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 7414b898f8..65d349fb33 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -160,10 +160,10 @@ test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
 	git reflog exists $outside
 '
 
-test_expect_success 'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD' '
+test_expect_success 'core.logAllRefUpdates=always creates reflog for ORIG_HEAD' '
 	test_config core.logAllRefUpdates always &&
 	git update-ref ORIG_HEAD $A &&
-	test_must_fail git reflog exists ORIG_HEAD
+	git reflog exists ORIG_HEAD
 '
 
 test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always' '
@@ -476,7 +476,7 @@ test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
 test_expect_success 'given old value for missing pseudoref, do not create' '
 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
 	test_must_fail git rev-parse PSEUDOREF &&
-	test_i18ngrep "could not read ref" err
+	test_i18ngrep "unable to resolve reference" err
 '
 
 test_expect_success 'create pseudoref' '
@@ -497,7 +497,7 @@ test_expect_success 'overwrite pseudoref with correct old value' '
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
 	test $C = $(git rev-parse PSEUDOREF) &&
-	test_i18ngrep "unexpected object ID" err
+	test_i18ngrep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref' '
@@ -509,7 +509,7 @@ test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
 	test $A = $(git rev-parse PSEUDOREF) &&
-	test_i18ngrep "unexpected object ID" err
+	test_i18ngrep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 331899ddc4..a8d695cd4f 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -31,9 +31,12 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
+	m=$(git rev-parse master) &&
 	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
 	test_must_fail git rev-parse FOO -- &&
-	test_must_fail git rev-parse refs/tags/new-tag --
+	test_must_fail git rev-parse refs/tags/new-tag --&&
+	test_must_fail git rev-parse master -- &&
+	git update-ref refs/heads/master $m
 '
 
 test_expect_success 'rename_refs(master, new-master)' '
-- 
gitgitgadget

