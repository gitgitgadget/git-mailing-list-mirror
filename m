Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97568C07E9B
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823A96117A
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhGKQdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbhGKQdp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520FC0613DD
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so2738254wms.1
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCUNNcBmvvoCqS7c9KX/3qk8HkkrgW4bxUHoFrPnHAs=;
        b=BTWiEmtkrDpMRce7LU/tWyPK4gTOX7HtMht/otMmgZKKyt2SSI0Xkz1dCi7C7/S4DC
         PnyKanYm/vg519A5pg5JkvYHloKHf58L5qTIXBClSR4UgD2wLnzPhnmMfsReBFv99F6Q
         b5eEjXdCjx3nl8sDJoVcaC1D89pYpK2TF3IvWmw6rAvPoohh/FQi5Rf3O5ObhpEWHims
         lSgPpskxBfuDAlI6Lt/FJec3BywMLEWA78OaEuH4X9kZJz/6TXOGO+mWh8gaxJVBuadk
         F8v2wpmkKyifDxsBFIyXP1r8qTTN9rfcOhWmd/IgV4NTlqBSrihJ78b4/lM6QAF2HUcI
         D3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCUNNcBmvvoCqS7c9KX/3qk8HkkrgW4bxUHoFrPnHAs=;
        b=IkzPGPG+DVIf2W3TPZIKjr+f8Cs4K0OTk4eC+NkOFk+pdA2/l9VFWwe3QEkTva2U/F
         HRu6EOCI2Xd/hBl8TnYe8KHAzWJR88o6g5LHkEvGIcTAPMd31Fp49I6kqPChWt3rfEFb
         d4ryoAA0eQn0M36Yw89fVXSkYn9I2EQtLU0hq98DiYItbBQH05b78f3i69jxwQtjEKpQ
         jNsL6BRF49yzRkvd+tzKiOSxdclZJScArm7Dpg3S0GwvMUeglNzOrlyF5DnxdYtm5Shh
         u6A5TSrjLL3cFex22r72JkphKxxZEoVI6PZEfNqONhTl6uAYel8N6M80pYwFKak6rZ3R
         letA==
X-Gm-Message-State: AOAM533pPcERC2YJVji5t2PunHGnj1w2+rOMfWPM6tiD+RE/SdCza+wV
        Imm7oY5GgaolfxnzWwWuXXjDAAUyUl9UfA==
X-Google-Smtp-Source: ABdhPJxYYuAii0vtfvgB35GEUEhySkmIGpa+v2J6WPBCWtC3SadKRiV8b/lLOx1v4JIgupYjzvyjhA==
X-Received: by 2002:a05:600c:4304:: with SMTP id p4mr9758761wme.43.1626021055602;
        Sun, 11 Jul 2021 09:30:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 12/17] refs API: make refs_resolve_ref_unsafe() static
Date:   Sun, 11 Jul 2021 18:30:36 +0200
Message-Id: <patch-12.17-07d550015ac-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove public users of refs_resolve_ref_unsafe() over to
refs_resolve_ref_unsafe_with_errno(), and explicitly ignore the
provided errno in those callers. At that point the only remaining
users are the legacy functions in refs.c itself, so we can make the
wrapper static.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c                    | 29 +++++++++++++++--------------
 refs.h                    |  8 +-------
 refs/files-backend.c      | 24 ++++++++++++++----------
 t/helper/test-ref-store.c |  5 +++--
 worktree.c                | 18 ++++++++++++------
 5 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/refs.c b/refs.c
index 7a9cdb1d720..214f3f4f79f 100644
--- a/refs.c
+++ b/refs.c
@@ -267,6 +267,21 @@ int ref_resolves_to_object(const char *refname,
 	return 1;
 }
 
+static const char *refs_resolve_ref_unsafe(struct ref_store *refs,
+					   const char *refname,
+					   int resolve_flags,
+					   struct object_id *oid, int *flags)
+{
+	int failure_errno = 0;
+	const char *refn;
+	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						  oid, flags, &failure_errno);
+	if (!refn)
+		/* For unmigrated legacy callers */
+		errno = failure_errno;
+	return refn;
+}
+
 char *refs_resolve_refdup(struct ref_store *refs,
 			  const char *refname, int resolve_flags,
 			  struct object_id *oid, int *flags)
@@ -1780,20 +1795,6 @@ const char *refs_resolve_ref_unsafe_with_errno(struct ref_store *refs,
 	return NULL;
 }
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs, const char *refname,
-				    int resolve_flags, struct object_id *oid,
-				    int *flags)
-{
-	int failure_errno = 0;
-	const char *refn;
-	refn = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
-						  oid, flags, &failure_errno);
-	if (!refn)
-		/* For unmigrated legacy callers */
-		errno = failure_errno;
-	return refn;
-}
-
 /* backend functions */
 int refs_init_db(struct strbuf *err)
 {
diff --git a/refs.h b/refs.h
index d80184dd8e0..a3284adb8f8 100644
--- a/refs.h
+++ b/refs.h
@@ -63,14 +63,8 @@ struct worktree;
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
 
-const char *refs_resolve_ref_unsafe(struct ref_store *refs,
-				    const char *refname,
-				    int resolve_flags,
-				    struct object_id *oid,
-				    int *flags);
 /**
- * refs_resolve_ref_unsafe_with_errno() is like
- * refs_resolve_ref_unsafe(), but provide access to errno code that
+ * refs_resolve_ref_unsafe_with_errno() provides access to errno code that
  * lead to a failure. We guarantee that errno is set to a meaningful
  * value on non-zero return.
  */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b3bc2f57387..158c0146484 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -280,10 +280,11 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 					 create_dir_entry(dir->cache, refname.buf,
 							  refname.len, 1));
 		} else {
-			if (!refs_resolve_ref_unsafe(&refs->base,
-						     refname.buf,
-						     RESOLVE_REF_READING,
-						     &oid, &flag)) {
+			int ignore_errno;
+			if (!refs_resolve_ref_unsafe_with_errno(&refs->base,
+								refname.buf,
+								RESOLVE_REF_READING,
+								&oid, &flag, &ignore_errno)) {
 				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_oid(&oid)) {
@@ -1354,9 +1355,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 		goto out;
 	}
 
-	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
-				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				&orig_oid, &flag)) {
+	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, oldrefname,
+						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+						&orig_oid, &flag, &ignore_errno)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
@@ -1769,10 +1770,13 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 */
 		int head_flag;
 		const char *head_ref;
+		int ignore_errno;
 
-		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
-						   RESOLVE_REF_READING,
-						   NULL, &head_flag);
+		head_ref = refs_resolve_ref_unsafe_with_errno(&refs->base,
+							      "HEAD",
+							      RESOLVE_REF_READING,
+							      NULL, &head_flag,
+							      &ignore_errno);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index bba5f841c6a..ca69a793171 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -123,9 +123,10 @@ static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
 	int flags;
 	const char *ref;
+	int ignore_errno;
 
-	ref = refs_resolve_ref_unsafe(refs, refname, resolve_flags,
-				      &oid, &flags);
+	ref = refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+						 &oid, &flags, &ignore_errno);
 	printf("%s %s 0x%x\n", oid_to_hex(&oid), ref ? ref : "(null)", flags);
 	return ref ? 0 : 1;
 }
diff --git a/worktree.c b/worktree.c
index 1dcdb481d61..1dbdec82461 100644
--- a/worktree.c
+++ b/worktree.c
@@ -28,11 +28,13 @@ static void add_head_info(struct worktree *wt)
 {
 	int flags;
 	const char *target;
+	int ignore_errno;
 
-	target = refs_resolve_ref_unsafe(get_worktree_ref_store(wt),
-					 "HEAD",
-					 0,
-					 &wt->head_oid, &flags);
+	target = refs_resolve_ref_unsafe_with_errno(get_worktree_ref_store(wt),
+						    "HEAD",
+						    0,
+						    &wt->head_oid, &flags,
+						    &ignore_errno);
 	if (!target)
 		return;
 
@@ -417,6 +419,7 @@ const struct worktree *find_shared_symref(const char *symref,
 		const char *symref_target;
 		struct ref_store *refs;
 		int flags;
+		int ignore_errno;
 
 		if (wt->is_bare)
 			continue;
@@ -433,8 +436,11 @@ const struct worktree *find_shared_symref(const char *symref,
 		}
 
 		refs = get_worktree_ref_store(wt);
-		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-							NULL, &flags);
+		symref_target = refs_resolve_ref_unsafe_with_errno(refs,
+								   symref,
+								   0, NULL,
+								   &flags,
+								   &ignore_errno);
 		if ((flags & REF_ISSYMREF) &&
 		    symref_target && !strcmp(symref_target, target)) {
 			existing = wt;
-- 
2.32.0-dev

