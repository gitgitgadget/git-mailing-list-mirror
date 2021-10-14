Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0CC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A15961130
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJNAJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhJNAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:09:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF548C061769
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i12so13777871wrb.7
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SM8XJKLKk9TtRkPMKMNSjNc5hu3LS4nterCbfmlXPNI=;
        b=H1200iul4lBOeHu5HORivR7NzEYbiXNw6gWhx90voUhw7x9FAFCHl1ZZ9vc4kB8a/z
         00gLcFSBaZJijTDwMdUCEHR10UIXktap21z0pwCh1mQTRNPXBH5KzLNtYdxBUcus4N+g
         D6s0tb9kwwbfLAQd9pDqZBTCDQWJMathdRe6ZRoQCdkeY9cwz7mhLukdYoyyqcTsg77R
         my05wS2EQZDqedSkCnwA31h4nnSACqaHS3pi5TUNhF+08+55i2Rm5p+Xank+R4Xk2d33
         f9IrLUjYX+mV7NzBquNkviVNyKnRBf9250WMrJZN5zdBUN1pcmZae3Ads252XThAlftd
         sgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SM8XJKLKk9TtRkPMKMNSjNc5hu3LS4nterCbfmlXPNI=;
        b=6Uo7Q8he143BEnc8DqWxorNp3JMH0dc5hmvgGr7eCDX5RepV97WnDybob4t9VEDowF
         nPq0J05Ihr7wjzivA6t3eeVHh16OSMOqlLRkS6W/9pzIolorWjFogwdr1fFygvzKS8AC
         GELOXKtbDdWLtefsarbhgknaLRsjgwIgGeQnJF5lcxQnx4U6q5h8qFT65lcHJwm/aYrG
         UISy7ib7obOUeJirAX4m62VOPyUGCRyv7gV16VaJnXwlKayXBM1Vqgadk9mjFXstjlwy
         bIbqvdZMPlM8uRZbEes0T6exo4dPiOwhF2yF/ghx9RU+r7oNpwygomIC3TsM0zgCq1l+
         WorA==
X-Gm-Message-State: AOAM531bhB1z5vjIzYO+ACx25Rv6V8XS+42RmTPsoFzkL9So7elqIYeB
        emuq6NkWFi/jpszlmvQq8wba/T5OxPJ8oA==
X-Google-Smtp-Source: ABdhPJwGecXDRvpws01/BzgjtmaERHwcpEtOw31xBMlE20VMlk3wgs2QpVeIw4PjAdXnXYIbTr034A==
X-Received: by 2002:a1c:750b:: with SMTP id o11mr2396732wmc.5.1634170009338;
        Wed, 13 Oct 2021 17:06:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm670711wmi.43.2021.10.13.17.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:06:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 20/20] refs API: post-migration API renaming [2/2]
Date:   Thu, 14 Oct 2021 02:06:32 +0200
Message-Id: <patch-20.20-54b18e3a719-20211013T235900Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the transitory refs_werrres_ref_unsafe() function to
refs_resolve_ref_unsafe(), now that all callers of the old function
have learned to pass in a "failure_errno" parameter.

The coccinelle semantic patch added in the preceding commit works, but
I couldn't figure out how to get spatch(1) to re-flow these argument
lists (and sometimes make lines way too long), so this rename was done
with:

    perl -pi -e 's/refs_werrres_ref_unsafe/refs_resolve_ref_unsafe/g' \
    $(git grep -l refs_werrres_ref_unsafe -- '*.c')

But after that "make contrib/coccinelle/refs.cocci.patch" comes up
empty, so the result would have been the same. Let's remove that
transitory semantic patch file, we won't need to retain it for any
other in-flight changes, refs_werrres_ref_unsafe() only existed within
this patch series.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/refs.pending.cocci |  5 -----
 refs.c                                | 16 ++++++++--------
 refs.h                                |  2 --
 refs/files-backend.c                  | 16 ++++++++--------
 sequencer.c                           |  2 +-
 t/helper/test-ref-store.c             |  2 +-
 worktree.c                            |  6 +++---
 7 files changed, 21 insertions(+), 28 deletions(-)
 delete mode 100644 contrib/coccinelle/refs.pending.cocci

diff --git a/contrib/coccinelle/refs.pending.cocci b/contrib/coccinelle/refs.pending.cocci
deleted file mode 100644
index b33cb8a12aa..00000000000
--- a/contrib/coccinelle/refs.pending.cocci
+++ /dev/null
@@ -1,5 +0,0 @@
-@@
-expression refs, refname, resolve_flags, oid, flags, failure_errno;
-@@
-- refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
-+ refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
diff --git a/refs.c b/refs.c
index a19f156b66a..75c6eafa847 100644
--- a/refs.c
+++ b/refs.c
@@ -269,7 +269,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 	const char *result;
 	int ignore_errno;
 
-	result = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 					 oid, flags, &ignore_errno);
 	return xstrdup_or_null(result);
 }
@@ -295,7 +295,7 @@ int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid,
 	int ignore_errno;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
-	if (refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 				    oid, flags, &ignore_errno))
 		return 0;
 	return -1;
@@ -309,7 +309,7 @@ int read_ref(const char *refname, struct object_id *oid)
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	int ignore_errno;
-	return !!refs_werrres_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
 					 NULL, NULL, &ignore_errno);
 }
 
@@ -659,7 +659,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_werrres_ref_unsafe(refs, fullref.buf,
+		r = refs_resolve_ref_unsafe(refs, fullref.buf,
 					    RESOLVE_REF_READING,
 					    this_result, &flag,
 					    &ignore_errno);
@@ -695,7 +695,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_werrres_ref_unsafe(refs, path.buf,
+		ref = refs_resolve_ref_unsafe(refs, path.buf,
 					      RESOLVE_REF_READING,
 					      oid ? &hash : NULL, NULL,
 					      &ignore_errno);
@@ -1382,7 +1382,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	int flag;
 	int ignore_errno;
 
-	if (refs_werrres_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
 				    &oid, &flag, &ignore_errno))
 		return fn("HEAD", &oid, flag, cb_data);
 
@@ -1778,7 +1778,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 {
 	int ignore_errno;
 
-	return refs_werrres_ref_unsafe(get_main_ref_store(the_repository), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
 				       resolve_flags, oid, flags, &ignore_errno);
 }
 
@@ -1794,7 +1794,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
 	if (!refs)
 		return -1;
 
-	if (!refs_werrres_ref_unsafe(refs, refname, 0, oid, &flags,
+	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags,
 				     &ignore_errno) || is_null_oid(oid))
 		return -1;
 	return 0;
diff --git a/refs.h b/refs.h
index d908a161c06..45c34e99e3a 100644
--- a/refs.h
+++ b/refs.h
@@ -68,8 +68,6 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-#define refs_werrres_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno) \
-	refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags, failure_errno)
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3d4544dcf0..e9d754d5ad3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -281,7 +281,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 							  refname.len));
 		} else {
 			int ignore_errno;
-			if (!refs_werrres_ref_unsafe(&refs->base,
+			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
 						     &oid, &flag, &ignore_errno)) {
@@ -1034,7 +1034,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (!refs_werrres_ref_unsafe(&refs->base, lock->ref_name, 0,
+	if (!refs_resolve_ref_unsafe(&refs->base, lock->ref_name, 0,
 				     &lock->old_oid, NULL, &ignore_errno))
 		oidclr(&lock->old_oid);
 	goto out;
@@ -1410,7 +1410,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_werrres_ref_unsafe(&refs->base, oldrefname,
+	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 				     &orig_oid, &flag, &ignore_errno)) {
 		ret = error("refname %s not found", oldrefname);
@@ -1456,7 +1456,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!copy && refs_werrres_ref_unsafe(&refs->base, newrefname,
+	if (!copy && refs_resolve_ref_unsafe(&refs->base, newrefname,
 					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 					     NULL, NULL, &ignore_errno) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -1825,7 +1825,7 @@ static int commit_ref_update(struct files_ref_store *refs,
 		const char *head_ref;
 		int ignore_errno;
 
-		head_ref = refs_werrres_ref_unsafe(&refs->base, "HEAD",
+		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
 						   NULL, &head_flag,
 						   &ignore_errno);
@@ -1875,7 +1875,7 @@ static void update_symref_reflog(struct files_ref_store *refs,
 	int ignore_errno;
 
 	if (logmsg &&
-	    refs_werrres_ref_unsafe(&refs->base, target,
+	    refs_resolve_ref_unsafe(&refs->base, target,
 				    RESOLVE_REF_READING, &new_oid, NULL,
 				    &ignore_errno) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
@@ -2163,7 +2163,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
-		if (!refs_werrres_ref_unsafe(iter->ref_store,
+		if (!refs_resolve_ref_unsafe(iter->ref_store,
 					     diter->relative_path, 0,
 					     &iter->oid, &flags,
 					     &ignore_errno)) {
@@ -2511,7 +2511,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * to record and possibly check old_oid:
 			 */
 			int ignore_errno;
-			if (!refs_werrres_ref_unsafe(&refs->base,
+			if (!refs_resolve_ref_unsafe(&refs->base,
 						     referent.buf, 0,
 						     &lock->old_oid, NULL,
 						     &ignore_errno)) {
diff --git a/sequencer.c b/sequencer.c
index 7052f791410..d848c5dc985 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1333,7 +1333,7 @@ void print_commit_summary(struct repository *r,
 	diff_setup_done(&rev.diffopt);
 
 	refs = get_main_ref_store(the_repository);
-	head = refs_werrres_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
+	head = refs_resolve_ref_unsafe(refs, "HEAD", 0, NULL, NULL,
 				       &resolve_errno);
 	if (!head) {
 		errno = resolve_errno;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 2f91fb9b227..3986665037a 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -125,7 +125,7 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	const char *ref;
 	int ignore_errno;
 
-	ref = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 				      &oid, &flags, &ignore_errno);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
diff --git a/worktree.c b/worktree.c
index 7d7cf058154..2c155b10150 100644
--- a/worktree.c
+++ b/worktree.c
@@ -30,7 +30,7 @@ static void add_head_info(struct worktree *wt)
 	const char *target;
 	int ignore_errno;
 
-	target = refs_werrres_ref_unsafe(get_worktree_ref_store(wt),
+	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
 					 "HEAD",
 					 0,
 					 &wt->head_oid, &flags,
@@ -437,7 +437,7 @@ const struct worktree *find_shared_symref(const char *symref,
 		}
 
 		refs = get_worktree_ref_store(wt);
-		symref_target = refs_werrres_ref_unsafe(refs, symref, 0,
+		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
 							NULL, &flags,
 							&ignore_errno);
 		if ((flags & REF_ISSYMREF) &&
@@ -574,7 +574,7 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 
 		strbuf_reset(&refname);
 		strbuf_worktree_ref(wt, &refname, "HEAD");
-		if (refs_werrres_ref_unsafe(get_main_ref_store(the_repository),
+		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					    refname.buf,
 					    RESOLVE_REF_READING,
 					    &oid, &flag, &ignore_errno))
-- 
2.33.1.1346.g48288c3c089

