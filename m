Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA4DC433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1F204EC
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7Yc7hPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbgHQTPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbgHQPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE70C061343
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so14266625wmi.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2i3qUwPJDAmy4lYfuNBK8v1B1C+CYmST/yp8s9bmrTI=;
        b=n7Yc7hPp+Ah7RogCjmUzzoRsKkyUVCzi55/34cRxzQ54lG2NSL5oa011prPKlO9aq6
         N8O/qDx6LlcNAsDpm76osOJnhjnw+KcoT8DnNKMjpjU2DbysNEVS4FG+jwm3ctLYhdWe
         2XuKkvcqKQ7zut9Nn2B7reGfa80wlkiljkaKL7J3jq5UDzP1qiWM6ujkvjkwVDj2IG89
         i0loycDfAj1weU8fGQz+IjSKqsgVM+LXe70RzH//IbCAFSkrc9qcl3zNkitl0rk/5tNS
         nT6ttvZU93pexxs9fO+WuSJ/HHkLxGPx+wtg44EnBtm6ZITw2KQSOjyCAWPYmuPBGIk6
         vFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2i3qUwPJDAmy4lYfuNBK8v1B1C+CYmST/yp8s9bmrTI=;
        b=EZTwg/6wKXja7XKZMttLxUUY3hG4/xdrUaMAB/x0E4uS9QXeCeqlum097m3RtfHwTw
         aa+QgCJmjrq9Inel33jkl0ZP5SUFdlV3OyV4mFyw1w4nT/HTfxcapvVuObilDl6Yum7a
         TPExak5mXEwEv7yWl4V/HeA7/L24bAaIBPOYzZ5GY1p3M9r47b6sNY2XiJGl2nytB1pH
         6YYaPK8P4o8CClFRf6ILnVosWV9HByH0HUl2pXzbJ2SvrR+faOOU/4BbkCe00YteUaxL
         1k+ye6XDgCDsFDtdPpUXBjBkppU04ksFw8eAheIGgycpoVhJlRAK1wsUjQyHS6F4PyXj
         qvsA==
X-Gm-Message-State: AOAM533JInfDfHtCDflFa4ANuL5WvO09NasSkA7QRqGrQvZ079J/Vp98
        luyQyRFnMg20OzfHUiWc7wGMPr6GY6w=
X-Google-Smtp-Source: ABdhPJymAiefXNOj5sGj8VejSqN/4F61fSm4gZ0mPwtQvAL9ZObbjL4IxkLyr5cbTxt+nrAtb4qFvQ==
X-Received: by 2002:a1c:61d5:: with SMTP id v204mr15672804wmb.102.1597678800706;
        Mon, 17 Aug 2020 08:40:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o124sm29380746wmb.2.2020.08.17.08.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:40:00 -0700 (PDT)
Message-Id: <c624e17dc62dec2748e74d9c84dce56f959cc2d1.1597678796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 15:39:55 +0000
Subject: [PATCH 3/4] refs: move gitdir into base ref_store
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

