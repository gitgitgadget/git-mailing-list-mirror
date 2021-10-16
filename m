Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F618C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1A360E96
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhJPJnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244008AbhJPJlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA8C061768
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so30784647wro.3
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbUlSJSQbhS8yBSQC8Uq4EqVjfNsgUACswHUTPxNl6g=;
        b=F2pnEnATgtZ0xvqqtYTy9aZG5q5GgSzpYfjZFsRfDB4FrR9XwsY9GGaOYtZ0SxtGJr
         v5BmylUyK9G7Kyuj0SsBNHXVceYXJHx33LUyyLTLc5GyIcsefpv8vLktD2aMMDtpQHhO
         nwspAnMf+xX7dkfMeJBgNyExTu0o3h9/ufh/U0j+SKuI3ylREyVx7n1B1Q+NZjHyIeMl
         YsqV9raHO8JGwLjD/MyE+ftrUrLuy/3hB+A6ZCnuora16UVIOgCxDEXjJBiOzpuHWv20
         n+6ezGzxX8sJ0shdZMWxN+TB8J/3OS5veB4RFVhJvmmQVB4hsGPg9NSAuJ+VT5MdfDcj
         2qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbUlSJSQbhS8yBSQC8Uq4EqVjfNsgUACswHUTPxNl6g=;
        b=pCjYKFXgSAWyGfC6ilYtpph2JnIShaWZEtHvb/eZ1tdRO5gfreNdOjDqesjCv032a4
         8583+6rLD4l8HOh9vT9PciBiPTQK10W+9HY9MtytB7j7q6doyIYyJOP6771fSFIateAC
         x1p6FgfDbsMwT5mqRvycvPdrmi0KBsQWaWfcYw77qjzpM5ZzkPUzQoTaqLODk1Eij9F1
         TaO07xkBJhGF/oRBItezWe+vtPunumob0W1nj3xfWGFyStRV6MgYFC4hKp2/CsZ0lCxr
         sQHhNb2rjRzdXRQdNd8QwVAfqfbkGK6PPN2qqh/nrv17kB96X2xoF3ROBIFpsYIj28tX
         k5xA==
X-Gm-Message-State: AOAM531+AR1MAa7uCGsPktbe9ktSn2fkfse58ltwUy2VaMbK+WKJ7sf1
        qB5IU8FFldqc2bwnEC5V+7wmDE4w3jrM9g==
X-Google-Smtp-Source: ABdhPJySAP4MU3Qoa1A9bLB9SETdk2CpbobeYQ62WMd9Rv5LcdzCKu8juO17bOaofkHgJ86y7CJZCg==
X-Received: by 2002:adf:c992:: with SMTP id f18mr20460869wrh.138.1634377185806;
        Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 21/21] refs API: post-migration API renaming [2/2]
Date:   Sat, 16 Oct 2021 11:39:27 +0200
Message-Id: <patch-v2-21.21-0135fb5949f-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
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
 refs/files-backend.c                  | 18 +++++++++---------
 sequencer.c                           |  2 +-
 t/helper/test-ref-store.c             |  2 +-
 worktree.c                            |  6 +++---
 7 files changed, 22 insertions(+), 29 deletions(-)
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
index 4e06745c97a..cd9b8bb1141 100644
--- a/refs.c
+++ b/refs.c
@@ -270,7 +270,7 @@ char *refs_resolve_refdup(struct ref_store *refs,
 	const char *result;
 	int ignore_errno;
 
-	result = refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+	result = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 					 oid, flags, &ignore_errno);
 	return xstrdup_or_null(result);
 }
@@ -296,7 +296,7 @@ int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid,
 	int ignore_errno;
 	struct ref_store *refs = get_main_ref_store(the_repository);
 
-	if (refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags,
 				    oid, flags, &ignore_errno))
 		return 0;
 	return -1;
@@ -310,7 +310,7 @@ int read_ref(const char *refname, struct object_id *oid)
 int refs_ref_exists(struct ref_store *refs, const char *refname)
 {
 	int ignore_errno;
-	return !!refs_werrres_ref_unsafe(refs, refname, RESOLVE_REF_READING,
+	return !!refs_resolve_ref_unsafe(refs, refname, RESOLVE_REF_READING,
 					 NULL, NULL, &ignore_errno);
 }
 
@@ -660,7 +660,7 @@ int expand_ref(struct repository *repo, const char *str, int len,
 		this_result = refs_found ? &oid_from_ref : oid;
 		strbuf_reset(&fullref);
 		strbuf_addf(&fullref, *p, len, str);
-		r = refs_werrres_ref_unsafe(refs, fullref.buf,
+		r = refs_resolve_ref_unsafe(refs, fullref.buf,
 					    RESOLVE_REF_READING,
 					    this_result, &flag,
 					    &ignore_errno);
@@ -696,7 +696,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len,
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
-		ref = refs_werrres_ref_unsafe(refs, path.buf,
+		ref = refs_resolve_ref_unsafe(refs, path.buf,
 					      RESOLVE_REF_READING,
 					      oid ? &hash : NULL, NULL,
 					      &ignore_errno);
@@ -1383,7 +1383,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	int flag;
 	int ignore_errno;
 
-	if (refs_werrres_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
 				    &oid, &flag, &ignore_errno))
 		return fn("HEAD", &oid, flag, cb_data);
 
@@ -1779,7 +1779,7 @@ const char *resolve_ref_unsafe(const char *refname, int resolve_flags,
 {
 	int ignore_errno;
 
-	return refs_werrres_ref_unsafe(get_main_ref_store(the_repository), refname,
+	return refs_resolve_ref_unsafe(get_main_ref_store(the_repository), refname,
 				       resolve_flags, oid, flags, &ignore_errno);
 }
 
@@ -1795,7 +1795,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
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
index 6c854dda533..abb6091fcf5 100644
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
@@ -3209,7 +3209,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 			int type;
 			const char *ref;
 
-			ref = refs_werrres_ref_unsafe(&refs->base, refname,
+			ref = refs_resolve_ref_unsafe(&refs->base, refname,
 						      RESOLVE_REF_NO_RECURSE,
 						      NULL, &type,
 						      &ignore_errno);
diff --git a/sequencer.c b/sequencer.c
index 1223dc2d2bf..cf10f9a332e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1334,7 +1334,7 @@ void print_commit_summary(struct repository *r,
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
2.33.1.1338.g20da966911a

