Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD78ECAAD5
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbiILRBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 13:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiILRBk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 13:01:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB33136D
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:01:39 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h8so9397119wrf.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date;
        bh=OYEKWKKtLSushDVJYy+4zt563GKsMFPt2KC7mZrGXuk=;
        b=FSe+2S3sgI94SY8BiKc5SdZcEwSi7TgxWC25JJ5BEkydXw0K2OXwrZSHM6yI52KrIr
         a5byu2ZkOwmx9snXFpCL16kmRuyHPeaObAj9VkFhg1/R9cyZFMWEF+hj7wBUWHF0FUf3
         2r3Z056xe3wbN5neN86Qn8TZ9/8leReCwHbxPaEg9jcfBFZI31GuAeaf1E8iykUArmZ9
         hy9vIgNk6xia1TaA5ZsGrEr4YCurP0jd2I6s9eVUSjorqm4qY59+US/E0emAzBqZTxFU
         TKOs5TMCqjzOVNIi/qYP6oywtVnudibX2DWWHKNs7NfXhBrF3YcCKjpWb0QP5J+0wx44
         HuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=OYEKWKKtLSushDVJYy+4zt563GKsMFPt2KC7mZrGXuk=;
        b=3EwHZLAVJuMjH3L89ji8ix3ZSs70tiDFARan7kRRI/xnUxAbk3vHHEDZjt1rJq1pE3
         SwcGZOLsNmmJd43Zf36Uh2x/ytkSxUCpEv67irY3Qge/kK5+tbjxEvc80L4qiV35DvJs
         p8FlvNxgfw93QLQGr37n2JpwctldruiJXP2JeQy+/e/cj31a2gxOUgHtfwQrp9k8VUs2
         VD5/VfyXHPsl6DWfCtY1yaa+TvFNKcXShO6ViEGPinAb5qP7K4j3Jt9bAUaJPFYSwKto
         p5KVe7pR9eFmxoARhriCgV4PV3NhpVJ1dYfhW7TvbVd3jZGACFRI2txsQyOm/Wd4crBy
         NTaA==
X-Gm-Message-State: ACgBeo3fa79hFfFO1zL44LgJgxTXMCfpzqRk34GXeCPcBZqYeB9zwIcW
        5Qi/OndYbNDPWgPvGcznjMP2+pjpDs8=
X-Google-Smtp-Source: AA6agR5Xv8fEl46CpF+9wdJzMjqCWh4Oc4JpyPhMVlHhQ/W1t5ii9PSfPmnk/L1Mc4lblq5zIiTBQQ==
X-Received: by 2002:a05:6000:681:b0:22a:3007:df45 with SMTP id bo1-20020a056000068100b0022a3007df45mr11835399wrb.149.1663002097302;
        Mon, 12 Sep 2022 10:01:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a5d6909000000b0022a3a887ceasm8216460wru.49.2022.09.12.10.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:01:36 -0700 (PDT)
Message-Id: <pull.1325.git.git.1663002096207.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Sep 2022 17:01:35 +0000
Subject: [PATCH] refs: unify parse_worktree_ref() and ref_type()
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

The logic to handle worktree refs (worktrees/NAME/REF and
main-worktree/REF) existed in two places:

* ref_type() in refs.c

* parse_worktree_ref() in worktree.c

Collapse this logic together in one function parse_worktree_ref():
this avoids having to cross-check the result of parse_worktree_ref()
and ref_type().

Introduce enum ref_worktree_type, which is slightly different from
enum ref_type. The latter is a misleading name (one would think that
'ref_type' would have the symref option).

Instead, enum ref_worktree_type only makes explicit how a refname
relates to a worktree. From this point of view, HEAD and
refs/bisect/abc are the same: they specify the current worktree
implicitly.

The files-backend must avoid packing refs/bisect/* and friends into
packed-refs, so expose is_per_worktree_ref() separately.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
    refs: unify parse_worktree_ref() and ref_type()
    
    The logic to handle worktree refs (worktrees/NAME/REF and
    main-worktree/REF) existed in two places:
    
     * ref_type() in refs.c
    
     * parse_worktree_ref() in worktree.c
    
    Collapse this logic together in one function parse_worktree_ref(): this
    avoids having to cross-check the result of parse_worktree_ref() and
    ref_type().
    
    Introduce enum ref_worktree_type, which is slightly different from enum
    ref_type. The latter is a misleading name (one would think that
    'ref_type' would have the symref option).
    
    Instead, enum ref_worktree_type only makes explicit how a refname
    relates to a worktree. From this point of view, HEAD and refs/bisect/abc
    are the same: they specify the current worktree implicitly.
    
    The files-backend must avoid packing refs/bisect/* and friends into
    packed-refs, so expose is_per_worktree_ref() separately.
    
    Signed-off-by: Han-Wen Nienhuys hanwen@google.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1325%2Fhanwen%2Fparse-worktree-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1325/hanwen/parse-worktree-ref-v1
Pull-Request: https://github.com/git/git/pull/1325

 builtin/reflog.c      |  3 +-
 reflog.c              | 13 ++-----
 refs.c                | 75 ++++++++++++++++++++++++++--------------
 refs.h                | 29 ++++++++++++----
 refs/files-backend.c  | 80 +++++++++++++++++++------------------------
 refs/packed-backend.c |  2 +-
 worktree.c            | 59 ++++---------------------------
 worktree.h            | 10 ------
 8 files changed, 120 insertions(+), 151 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9407f835cb6..bd568d2d931 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -26,7 +26,8 @@ static int collect_reflog(const char *ref, const struct object_id *oid, int unus
 	 * Avoid collecting the same shared ref multiple times because
 	 * they are available via all worktrees.
 	 */
-	if (!worktree->is_current && ref_type(ref) == REF_TYPE_NORMAL)
+	if (!worktree->is_current &&
+	    parse_worktree_ref(ref, NULL, NULL, NULL) == REF_WORKTREE_SHARED)
 		return 0;
 
 	strbuf_worktree_ref(worktree, &newref, ref);
diff --git a/reflog.c b/reflog.c
index 47ba8620c56..0b8b767f97c 100644
--- a/reflog.c
+++ b/reflog.c
@@ -310,16 +310,9 @@ static int push_tip_to_list(const char *refname, const struct object_id *oid,
 
 static int is_head(const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (parse_worktree_ref(refname, NULL, NULL, &refname))
-			BUG("not a worktree ref: %s", refname);
-		break;
-	default:
-		break;
-	}
-	return !strcmp(refname, "HEAD");
+	const char *stripped_refname;
+	parse_worktree_ref(refname, NULL, NULL, &stripped_refname);
+	return !strcmp(stripped_refname, "HEAD");
 }
 
 void reflog_expiry_prepare(const char *refname,
diff --git a/refs.c b/refs.c
index 1a964505f92..45d59a7ede2 100644
--- a/refs.c
+++ b/refs.c
@@ -722,7 +722,7 @@ int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 	return repo_dwim_log(the_repository, str, len, oid, log);
 }
 
-static int is_per_worktree_ref(const char *refname)
+int is_per_worktree_ref(const char *refname)
 {
 	return starts_with(refname, "refs/worktree/") ||
 	       starts_with(refname, "refs/bisect/") ||
@@ -738,37 +738,60 @@ static int is_pseudoref_syntax(const char *refname)
 			return 0;
 	}
 
+	/* HEAD is not a pseudoref, but it certainly uses the
+	 * pseudoref syntax. */
 	return 1;
 }
 
-static int is_main_pseudoref_syntax(const char *refname)
+enum ref_worktree_type parse_worktree_ref(const char *worktree_ref,
+					  const char **name, int *name_length,
+					  const char **ref)
 {
-	return skip_prefix(refname, "main-worktree/", &refname) &&
-		*refname &&
-		is_pseudoref_syntax(refname);
-}
+	const char *name_dummy;
+	int name_length_dummy;
+	const char *ref_dummy;
+	if (!name)
+		name = &name_dummy;
+	if (!name_length)
+		name_length = &name_length_dummy;
+	if (!ref)
+		ref = &ref_dummy;
 
-static int is_other_pseudoref_syntax(const char *refname)
-{
-	if (!skip_prefix(refname, "worktrees/", &refname))
-		return 0;
-	refname = strchr(refname, '/');
-	if (!refname || !refname[1])
-		return 0;
-	return is_pseudoref_syntax(refname + 1);
-}
+	*ref = worktree_ref;
+	if (is_pseudoref_syntax(worktree_ref)) {
+		return REF_WORKTREE_CURRENT;
+	}
 
-enum ref_type ref_type(const char *refname)
-{
-	if (is_per_worktree_ref(refname))
-		return REF_TYPE_PER_WORKTREE;
-	if (is_pseudoref_syntax(refname))
-		return REF_TYPE_PSEUDOREF;
-	if (is_main_pseudoref_syntax(refname))
-		return REF_TYPE_MAIN_PSEUDOREF;
-	if (is_other_pseudoref_syntax(refname))
-		return REF_TYPE_OTHER_PSEUDOREF;
-	return REF_TYPE_NORMAL;
+	if (is_per_worktree_ref(worktree_ref)) {
+		return REF_WORKTREE_CURRENT;
+	}
+
+	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
+		if (!*worktree_ref)
+			return -1;
+		*name = NULL;
+		*name_length = 0;
+		*ref = worktree_ref;
+
+		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
+		    REF_WORKTREE_CURRENT)
+			return REF_WORKTREE_MAIN;
+	}
+	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
+		const char *slash = strchr(worktree_ref, '/');
+
+		if (!slash || slash == worktree_ref || !slash[1])
+			return -1;
+		*name = worktree_ref;
+		*name_length = slash - worktree_ref;
+		*ref = slash + 1;
+
+		if (parse_worktree_ref(*ref, NULL, NULL, NULL) ==
+		    REF_WORKTREE_CURRENT)
+			return REF_WORKTREE_OTHER;
+	}
+
+	return REF_WORKTREE_SHARED;
 }
 
 long get_files_ref_lock_timeout_ms(void)
diff --git a/refs.h b/refs.h
index 23479c7ee09..9e40efc4787 100644
--- a/refs.h
+++ b/refs.h
@@ -825,15 +825,30 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  */
 int ref_is_hidden(const char *, const char *);
 
-enum ref_type {
-	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
-	REF_TYPE_PSEUDOREF,	  /* refs outside refs/ in current worktree */
-	REF_TYPE_MAIN_PSEUDOREF,  /* pseudo refs from the main worktree     */
-	REF_TYPE_OTHER_PSEUDOREF, /* pseudo refs from other worktrees       */
-	REF_TYPE_NORMAL,	  /* normal/shared refs inside refs/        */
+/* Is this a per-worktree ref living in the refs/ namespace? */
+int is_per_worktree_ref(const char *refname);
+
+/* Describes how a refname relates to worktrees */
+enum ref_worktree_type {
+	REF_WORKTREE_CURRENT, /* implicitly per worktree, eg. HEAD or
+				 refs/bisect/SOMETHING */
+	REF_WORKTREE_MAIN, /* explicitly in main worktree, eg.
+			      refs/main-worktree/HEAD */
+	REF_WORKTREE_OTHER, /* explicitly in named worktree, eg.
+			       refs/worktrees/bla/HEAD */
+	REF_WORKTREE_SHARED, /* the default, eg. refs/heads/main */
 };
 
-enum ref_type ref_type(const char *refname);
+/* Parse a ref that possibly explicitly refers to a worktree ref
+ * (ie. either REFNAME, main-worktree/REFNAME or
+ * worktree/WORKTREE/REFNAME). If the name references a worktree
+ * implicitly or explicitly, return what kind it was. The
+ * worktree_name, worktree_name_length and refname argument maybe NULL.
+ */
+enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
+					  const char **worktree_name,
+					  int *worktree_name_length,
+					  const char **refname);
 
 enum expire_reflog_flags {
 	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 95acab78eef..f230704229e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -138,44 +138,30 @@ static struct files_ref_store *files_downcast(struct ref_store *ref_store,
 	return refs;
 }
 
-static void files_reflog_path_other_worktrees(struct files_ref_store *refs,
-					      struct strbuf *sb,
-					      const char *refname)
-{
-	const char *real_ref;
-	const char *worktree_name;
-	int length;
-
-	if (parse_worktree_ref(refname, &worktree_name, &length, &real_ref))
-		BUG("refname %s is not a other-worktree ref", refname);
-
-	if (worktree_name)
-		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
-			    length, worktree_name, real_ref);
-	else
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir,
-			    real_ref);
-}
-
 static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PER_WORKTREE:
-	case REF_TYPE_PSEUDOREF:
+	const char *bare_refname;
+	const char *wtname;
+	int wtname_len;
+	enum ref_worktree_type wt_type = parse_worktree_ref(
+		refname, &wtname, &wtname_len, &bare_refname);
+
+	switch (wt_type) {
+	case REF_WORKTREE_CURRENT:
 		strbuf_addf(sb, "%s/logs/%s", refs->base.gitdir, refname);
 		break;
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_MAIN_PSEUDOREF:
-		files_reflog_path_other_worktrees(refs, sb, refname);
+	case REF_WORKTREE_SHARED:
+	case REF_WORKTREE_MAIN:
+		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, bare_refname);
 		break;
-	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
+	case REF_WORKTREE_OTHER:
+		strbuf_addf(sb, "%s/worktrees/%.*s/logs/%s", refs->gitcommondir,
+			    wtname_len, wtname, bare_refname);
 		break;
 	default:
-		BUG("unknown ref type %d of ref %s",
-		    ref_type(refname), refname);
+		BUG("unknown ref type %d of ref %s", wt_type, refname);
 	}
 }
 
@@ -183,22 +169,25 @@ static void files_ref_path(struct files_ref_store *refs,
 			   struct strbuf *sb,
 			   const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PER_WORKTREE:
-	case REF_TYPE_PSEUDOREF:
+	const char *bare_refname;
+	const char *wtname;
+	int wtname_len;
+	enum ref_worktree_type wt_type = parse_worktree_ref(
+		refname, &wtname, &wtname_len, &bare_refname);
+	switch (wt_type) {
+	case REF_WORKTREE_CURRENT:
 		strbuf_addf(sb, "%s/%s", refs->base.gitdir, refname);
 		break;
-	case REF_TYPE_MAIN_PSEUDOREF:
-		if (!skip_prefix(refname, "main-worktree/", &refname))
-			BUG("ref %s is not a main pseudoref", refname);
-		/* fallthrough */
-	case REF_TYPE_OTHER_PSEUDOREF:
-	case REF_TYPE_NORMAL:
-		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
+	case REF_WORKTREE_OTHER:
+		strbuf_addf(sb, "%s/worktrees/%.*s/%s", refs->gitcommondir,
+			    wtname_len, wtname, bare_refname);
+		break;
+	case REF_WORKTREE_SHARED:
+	case REF_WORKTREE_MAIN:
+		strbuf_addf(sb, "%s/%s", refs->gitcommondir, bare_refname);
 		break;
 	default:
-		BUG("unknown ref type %d of ref %s",
-		    ref_type(refname), refname);
+		BUG("unknown ref type %d of ref %s", wt_type, refname);
 	}
 }
 
@@ -771,7 +760,8 @@ static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    ref_type(iter->iter0->refname) != REF_TYPE_PER_WORKTREE)
+		    parse_worktree_ref(iter->iter0->refname, NULL, NULL,
+				       NULL) != REF_WORKTREE_CURRENT)
 			continue;
 
 		if ((iter->flags & DO_FOR_EACH_OMIT_DANGLING_SYMREFS) &&
@@ -1179,7 +1169,8 @@ static int should_pack_ref(const char *refname,
 			   unsigned int pack_flags)
 {
 	/* Do not pack per-worktree refs: */
-	if (ref_type(refname) != REF_TYPE_NORMAL)
+	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
+	    REF_WORKTREE_SHARED)
 		return 0;
 
 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
@@ -2277,7 +2268,8 @@ static enum iterator_selection reflog_iterator_select(
 		 */
 		return ITER_SELECT_0;
 	} else if (iter_common) {
-		if (ref_type(iter_common->refname) == REF_TYPE_NORMAL)
+		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
+				       NULL) == REF_WORKTREE_SHARED)
 			return ITER_SELECT_1;
 
 		/*
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 66c4574c99d..bf0e63ae70c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -862,7 +862,7 @@ static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
 
 	while ((ok = next_record(iter)) == ITER_OK) {
 		if (iter->flags & DO_FOR_EACH_PER_WORKTREE_ONLY &&
-		    ref_type(iter->base.refname) != REF_TYPE_PER_WORKTREE)
+		    !is_per_worktree_ref(iter->base.refname))
 			continue;
 
 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
diff --git a/worktree.c b/worktree.c
index 90fc085f76b..bb7873c72d1 100644
--- a/worktree.c
+++ b/worktree.c
@@ -489,62 +489,17 @@ int submodule_uses_worktrees(const char *path)
 	return ret;
 }
 
-int parse_worktree_ref(const char *worktree_ref, const char **name,
-		       int *name_length, const char **ref)
-{
-	if (skip_prefix(worktree_ref, "main-worktree/", &worktree_ref)) {
-		if (!*worktree_ref)
-			return -1;
-		if (name)
-			*name = NULL;
-		if (name_length)
-			*name_length = 0;
-		if (ref)
-			*ref = worktree_ref;
-		return 0;
-	}
-	if (skip_prefix(worktree_ref, "worktrees/", &worktree_ref)) {
-		const char *slash = strchr(worktree_ref, '/');
-
-		if (!slash || slash == worktree_ref || !slash[1])
-			return -1;
-		if (name)
-			*name = worktree_ref;
-		if (name_length)
-			*name_length = slash - worktree_ref;
-		if (ref)
-			*ref = slash + 1;
-		return 0;
-	}
-	return -1;
-}
-
 void strbuf_worktree_ref(const struct worktree *wt,
 			 struct strbuf *sb,
 			 const char *refname)
 {
-	switch (ref_type(refname)) {
-	case REF_TYPE_PSEUDOREF:
-	case REF_TYPE_PER_WORKTREE:
-		if (wt && !wt->is_current) {
-			if (is_main_worktree(wt))
-				strbuf_addstr(sb, "main-worktree/");
-			else
-				strbuf_addf(sb, "worktrees/%s/", wt->id);
-		}
-		break;
-
-	case REF_TYPE_MAIN_PSEUDOREF:
-	case REF_TYPE_OTHER_PSEUDOREF:
-		break;
-
-	case REF_TYPE_NORMAL:
-		/*
-		 * For shared refs, don't prefix worktrees/ or
-		 * main-worktree/. It's not necessary and
-		 * files-backend.c can't handle it anyway.
-		 */
-		break;
+	if (parse_worktree_ref(refname, NULL, NULL, NULL) ==
+		    REF_WORKTREE_CURRENT &&
+	    wt && !wt->is_current) {
+		if (is_main_worktree(wt))
+			strbuf_addstr(sb, "main-worktree/");
+		else
+			strbuf_addf(sb, "worktrees/%s/", wt->id);
 	}
 	strbuf_addstr(sb, refname);
 }
diff --git a/worktree.h b/worktree.h
index e9e839926b0..9dcea6fc8c1 100644
--- a/worktree.h
+++ b/worktree.h
@@ -166,16 +166,6 @@ const char *worktree_git_path(const struct worktree *wt,
 			      const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
-/*
- * Parse a worktree ref (i.e. with prefix main-worktree/ or
- * worktrees/) and return the position of the worktree's name and
- * length (or NULL and zero if it's main worktree), and ref.
- *
- * All name, name_length and ref arguments could be NULL.
- */
-int parse_worktree_ref(const char *worktree_ref, const char **name,
-		       int *name_length, const char **ref);
-
 /*
  * Return a refname suitable for access from the current ref store.
  */

base-commit: 805e0a68082a217f0112db9ee86a022227a9c81b
-- 
gitgitgadget
