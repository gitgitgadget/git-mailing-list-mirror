Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35125C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 16:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiLEQML (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 11:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiLEQMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 11:12:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177C1CFC6
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 08:12:07 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o5so19372576wrm.1
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 08:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXC8YYbv5uDlXxnJx3sfu66R/vTiAwdc1ig+spuACFU=;
        b=N2EG81TCJeNyLzlM5V68nHPW1OfbkTQiDguyNortS7PYFAGDdgiy/XCqfTxOLJhdtL
         LINj4knpnq8Iwz6rjA7IuhSWe4jOmCx3jDRPo+sSnWRT7EjaXIVHaJDZMQVGmQxR+eqa
         211xW3aaBAGeTluCsdHvCLKK94IiaW95OjIrlwL+wv70etdcrII/Fy3W6Y7rlVxWLUYM
         XzucUg/32hyHCI5B3uxfAbltb3V56qJTNN50Ogxp2RPZokNJUUihRmMW3rPv1tfXW9nc
         PHq75vbHlcbML91v+okZFuErL1J4T5k8FSpTQ8RP7NejNUNWkeoiPROfrs3t4hTwa0MN
         N6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXC8YYbv5uDlXxnJx3sfu66R/vTiAwdc1ig+spuACFU=;
        b=49rsKRmTaF95fb4rv8zh8AQODRd0p6JPTCjhZiSQFnMowr/uF/Oday9WlBU7ghjbt2
         6pgrqAYx1H3rijBfTYKfe0lwjfJR2zsSQCjVDUjSw2JFiAS9hW/IRi3z1bWXQ7Z7d21A
         S8HovNgsMDreQ4lk/u0dSjXQ56+YsdNwo3HyZcto+uwD6jkyvjns9xLO5ZFLjCx5dbBC
         lmqVJOl62prGwFUzv68yT7PWlN5TnFCrw1oGfsEcmI7eZrn7kEfQcDGUyC+bgkZDAwoR
         +p1gIzd/9oPHu6H8ThJpaTysUKwP0PO5KBKOeXkpMDZPXg4X5A1qb9vytgrAM7TXfTtz
         R0Ag==
X-Gm-Message-State: ANoB5pmd3EbvbH8qybXWVcipML9NQpesHiE5rBrLl+zogde6iU95R2UE
        BpLN+jI7JGaFp8ji1ZDbu6NNfPIWJxg=
X-Google-Smtp-Source: AA0mqf7eTQUMAvXyo3jwZjwwzcFxrjrQDH5850/S6cAxABWwkguLfFVR/Flnsy6XMAaYOmydK3OMyQ==
X-Received: by 2002:adf:fcc9:0:b0:242:3a48:1757 with SMTP id f9-20020adffcc9000000b002423a481757mr11337200wrs.528.1670256725734;
        Mon, 05 Dec 2022 08:12:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u16-20020adff890000000b0024165454262sm14690168wrp.11.2022.12.05.08.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 08:12:05 -0800 (PST)
Message-Id: <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.v3.git.git.1670256084172.gitgitgadget@gmail.com>
References: <pull.1390.v3.git.git.1670256084172.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 16:12:04 +0000
Subject: [PATCH v4] maintenance: use calloc instead of malloc where possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija <doremylover123@gmail.com>

We can avoid having to call memset by calling calloc directly

Signed-off-by: Seija doremylover123@gmail.com
---
    maintenance: use calloc instead of malloc where possible
    
    We can avoid having to call memset by calling calloc directly
    
    Signed-off-by: Seija doremylover123@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v4
Pull-Request: https://github.com/git/git/pull/1390

Range-diff vs v3:

 1:  b5cfec60048 ! 1:  3cd6b1eab13 maintenance: use xcalloc instead of xmalloc where possible
     @@ Metadata
      Author: Seija <doremylover123@gmail.com>
      
       ## Commit message ##
     -    maintenance: use xcalloc instead of xmalloc where possible
     +    maintenance: use calloc instead of malloc where possible
      
     -    We can avoid having to call memset by calling xcalloc directly
     +    We can avoid having to call memset by calling calloc directly
      
          Signed-off-by: Seija doremylover123@gmail.com
      


 builtin/pack-redundant.c |  6 ++----
 remote.c                 |  4 ++--
 submodule.c              | 10 +++++-----
 xdiff/xutils.c           |  4 +---
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..0e184bb5212 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -51,7 +51,7 @@ static inline struct llist_item *llist_item_get(void)
 		new_item = free_nodes;
 		free_nodes = free_nodes->next;
 	} else {
-		int i = 1;
+		size_t i = 1;
 		ALLOC_ARRAY(new_item, BLKSIZE);
 		for (; i < BLKSIZE; i++)
 			llist_item_put(&new_item[i]);
@@ -61,9 +61,7 @@ static inline struct llist_item *llist_item_get(void)
 
 static inline void llist_init(struct llist **list)
 {
-	*list = xmalloc(sizeof(struct llist));
-	(*list)->front = (*list)->back = NULL;
-	(*list)->size = 0;
+	CALLOC_ARRAY(*list, 1);
 }
 
 static struct llist * llist_copy(struct llist *list)
diff --git a/remote.c b/remote.c
index 60869beebe7..475a1d18af0 100644
--- a/remote.c
+++ b/remote.c
@@ -2741,9 +2741,9 @@ void apply_push_cas(struct push_cas_option *cas,
 
 struct remote_state *remote_state_new(void)
 {
-	struct remote_state *r = xmalloc(sizeof(*r));
+	struct remote_state *r;
 
-	memset(r, 0, sizeof(*r));
+	CALLOC_ARRAY(r, 1);
 
 	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
 	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
diff --git a/submodule.c b/submodule.c
index 8ac2fca855d..015102a83d6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1458,14 +1458,13 @@ struct fetch_task {
  */
 static const struct submodule *get_non_gitmodules_submodule(const char *path)
 {
-	struct submodule *ret = NULL;
+	struct submodule *ret;
 	const char *name = default_name_or_path(path);
 
 	if (!name)
 		return NULL;
 
-	ret = xmalloc(sizeof(*ret));
-	memset(ret, 0, sizeof(*ret));
+	CALLOC_ARRAY(ret, 1);
 	ret->path = name;
 	ret->name = name;
 
@@ -1504,8 +1503,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
 					    const char *path,
 					    const struct object_id *treeish_name)
 {
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
+	struct fetch_task *task;
+
+	CALLOC_ARRAY(task, 1);
 
 	task->sub = submodule_from_path(spf->r, treeish_name, path);
 
diff --git a/xdiff/xutils.c b/xdiff/xutils.c
index 9e36f24875d..c19bc441a96 100644
--- a/xdiff/xutils.c
+++ b/xdiff/xutils.c
@@ -98,12 +98,10 @@ void *xdl_cha_alloc(chastore_t *cha) {
 	void *data;
 
 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
-		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
+		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
 
 			return NULL;
 		}
-		ancur->icurr = 0;
-		ancur->next = NULL;
 		if (cha->tail)
 			cha->tail->next = ancur;
 		if (!cha->head)

base-commit: 805265fcf7a737664a8321aaf4a0587b78435184
-- 
gitgitgadget
