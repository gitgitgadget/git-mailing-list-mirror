Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD2C433E1
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC5B22B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKbdZie9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbgGaP13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGaP10 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392C1C061757
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c80so8863724wme.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=REvNbgCbLdiwG5PR2A7BtECr40Mn6g8Dym7KBsXV8fg=;
        b=GKbdZie9l5IhUFDLBMXqrXWheUwClC6iQsHIE/Ic5PrXPri4jC0ywxwThm71nITek8
         18oIH3GBup5fIz0DyqemgISJX0g2rifbsVpRBhGUYA64PstaCfn72JLuG5THFYi28I13
         ebkzyavna56HS19bB2ewJ30fecD5qrhhKGNIOkW/kf1UwSrJPfc5ytV3GLap8Nrg6s6+
         ex86py4vcZsV2rQfZGruLdDU75T8lf5pSINWg0q9188v2DHzs53xdNmzz3GBsUY0r6wH
         t747T2T+ZjMIZQvi+cPpDf7Ubwjv/BVT9YBNiv/UyS6TXxzXZ9TpZaUKdQ9pZ5XKQaME
         lE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=REvNbgCbLdiwG5PR2A7BtECr40Mn6g8Dym7KBsXV8fg=;
        b=kXSTSRT7q3xC+5X4E9U/BBO54cpwOBBF3e+ksiSY1uVhagLQrR1/PcmXhInB6s2P3Q
         74mqE/I9Fe10zrG1NLVoOg+1s/O3U4K4HyqgE/K+ILLXzlukU2ImebwaxqeKJkJuyMiU
         48/0BMuBI070rbYDwnyJonoshzOcbuM4W32kKfZp+lJfpfcmqhB1vfkuGaoXFkSqGKfx
         L99i4l6+cQfEizvV4+340YQKQgCR6UVya8DOYL6a/W7fiROZ/7btu8Fyk5Nf4dK0nfRx
         MWHTncDPjBemv44TZhqVW7uIQfGfc5sgQkRuHdK1dx3q8AUBhNt1PuqW7dTrMRbfRlzs
         wUyA==
X-Gm-Message-State: AOAM531ij9pV4gMVJABcXrqaSlxuPm5HCev3n4SpttBf0O4mXFjaHkav
        o/Ju3yX7lpk/+UHuc9MzNvEiFaG4
X-Google-Smtp-Source: ABdhPJzrHYgDtxURbmFoq/rqoJ5mBXS4p7WRosu1AQh7TZLV6EpbYW+RzQjWR6GCBXmGxGoynITryg==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr4166081wmf.47.1596209243874;
        Fri, 31 Jul 2020 08:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n18sm14578898wrw.45.2020.07.31.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:23 -0700 (PDT)
Message-Id: <400ffe531f36f51e36dd7f9357e6ae7ae5fa7575.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:00 +0000
Subject: [PATCH v20 04/21] Modify pseudo refs through ref backend storage
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
index 2dd851fe81..5c25821ad5 100644
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
@@ -1210,18 +1109,13 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
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
index 331899ddc4..74af927fba 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -31,7 +31,10 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
 	git rev-parse FOO -- &&
 	git rev-parse refs/tags/new-tag -- &&
-	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
+	m=$(git rev-parse master) &&
+	REF_NO_DEREF=1 &&
+	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
+	test_must_fail git rev-parse --symbolic-full-name FOO &&
 	test_must_fail git rev-parse FOO -- &&
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
-- 
gitgitgadget

