Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F171BC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAFC42076E
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeX+TAdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHSO2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgHSO2F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:28:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CF8C061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a14so21754579wra.5
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2i3qUwPJDAmy4lYfuNBK8v1B1C+CYmST/yp8s9bmrTI=;
        b=BeX+TAdyOffiveir8zSavUvFy6yg/RXJ3NORZFlNMZaD1xN19mOrUTuS92jk8IGuAy
         +2q8zT9LJk6gVtTf3GYs1FFWTOkKNT31VniM1PYBvPi1LNkQLFuMnoi3J0b+qBXACtxe
         Ft59hKErRAvZcIUiJwqVNZTyx3Bd6EJSs4kSMLK6MSHzARMQ2TkGhB5PrhNmh6hPbFxu
         KwNvmkypdNELOeSuScqnn3oTlHfC6FlADMvtxjo9lvMsva4lu0THpP+Dm8l1yBdO2m6Y
         GDaKSkxzXsLogw0cP5tZU41JGOJ7tIoblI1bN2nLmrvNRPEoiulXzlo+DXqUy7p8aoub
         2ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2i3qUwPJDAmy4lYfuNBK8v1B1C+CYmST/yp8s9bmrTI=;
        b=scvIXZQjSGXz5Cv63GRidWUTqOBKa9aqjH9dfIiRhhPCIkLzQNmr8Jb2f4hGWARAbW
         6c0ZRu4VvXUFBz7ltzXs+cRKmYk8PrZMdn/lgsb1StZ/Kx/oeP8dEtK640m3W1z0eodX
         vzsm9rf790IFv7cF2/CSvtlYATFjNBd495xHnR4A/SIYd1rI6bfUMIjeJYgak8wM3WgZ
         U9tk0e8njX1WxMjngDM7pOAZeXflxTlR9nRLhqrFNUzO1hHk8mTxG45ilYl7FCnEbm39
         UtwXl+3koUMLyRkfYLIk6zjBsMELh2omCdPvz7oVeC2oJM7mtrb8aQ0tJyB1VGSB9W4H
         kL/A==
X-Gm-Message-State: AOAM530gSetIIuXLnd32wiWOmGlI9Od7Uf8HLAtjKyUkGCYumdxjrBT0
        53/hy7i4uf+k4YFusVRwiqLGlXb8qB0=
X-Google-Smtp-Source: ABdhPJySxrk9Y/OSA7ICExqTWVWA5Kb6ETrpNBP/B8min3Dn0CuSDaX46OvflyjxCCN1JTx6i3xOiQ==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr25345433wrv.331.1597847282968;
        Wed, 19 Aug 2020 07:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 188sm11609593wmz.2.2020.08.19.07.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:28:02 -0700 (PDT)
Message-Id: <6263b4b3f2dd2f0e77235f5f09daed7c0bd69099.1597847278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
        <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:27:57 +0000
Subject: [PATCH v2 3/4] refs: move gitdir into base ref_store
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 15 ++++++---------
 refs/packed-backend.c |  1 +
 refs/refs-internal.h  |  3 +++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3a3573986f..dd712e47f4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -67,7 +67,6 @@ struct files_ref_store {
 	struct ref_store base;
 	unsigned int store_flags;
 
-	char *gitdir;
 	char *gitcommondir;
 
 	struct ref_cache *loose;
@@ -94,18 +93,17 @@ static struct ref_store *files_ref_store_create(const char *gitdir,
 	struct ref_store *ref_store = (struct ref_store *)refs;
 	struct strbuf sb = STRBUF_INIT;
 
+	ref_store->gitdir = xstrdup(gitdir);
 	base_ref_store_init(ref_store, &refs_be_files);
 	refs->store_flags = flags;
 
-	refs->gitdir = xstrdup(gitdir);
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
 	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
 	refs->packed_ref_store = packed_ref_store_create(sb.buf, flags);
 	strbuf_release(&sb);
 
-	chdir_notify_reparent("files-backend $GIT_DIR",
-			      &refs->gitdir);
+	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
 			      &refs->gitcommondir);
 
@@ -176,7 +174,7 @@ static void files_reflog_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/logs/%s", refs->base.gitdir, refname);
 		break;
 	case REF_TYPE_OTHER_PSEUDOREF:
 	case REF_TYPE_MAIN_PSEUDOREF:
@@ -198,7 +196,7 @@ static void files_ref_path(struct files_ref_store *refs,
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
-		strbuf_addf(sb, "%s/%s", refs->gitdir, refname);
+		strbuf_addf(sb, "%s/%s", refs->base.gitdir, refname);
 		break;
 	case REF_TYPE_MAIN_PSEUDOREF:
 		if (!skip_prefix(refname, "main-worktree/", &refname))
@@ -2203,12 +2201,11 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 		files_downcast(ref_store, REF_STORE_READ,
 			       "reflog_iterator_begin");
 
-	if (!strcmp(refs->gitdir, refs->gitcommondir)) {
+	if (!strcmp(refs->base.gitdir, refs->gitcommondir)) {
 		return reflog_iterator_begin(ref_store, refs->gitcommondir);
 	} else {
 		return merge_ref_iterator_begin(
-			0,
-			reflog_iterator_begin(ref_store, refs->gitdir),
+			0, reflog_iterator_begin(ref_store, refs->base.gitdir),
 			reflog_iterator_begin(ref_store, refs->gitcommondir),
 			reflog_iterator_select, refs);
 	}
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4458a0f69c..b912f2505f 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -200,6 +200,7 @@ struct ref_store *packed_ref_store_create(const char *path,
 	struct ref_store *ref_store = (struct ref_store *)refs;
 
 	base_ref_store_init(ref_store, &refs_be_packed);
+	ref_store->gitdir = xstrdup(path);
 	refs->store_flags = store_flags;
 
 	refs->path = xstrdup(path);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 9188ddbec2..527b0a6e2e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -672,6 +672,9 @@ extern struct ref_storage_be refs_be_packed;
 struct ref_store {
 	/* The backend describing this ref_store's storage scheme: */
 	const struct ref_storage_be *be;
+
+	/* The gitdir that this ref_store applies to: */
+	char *gitdir;
 };
 
 /*
-- 
gitgitgadget

