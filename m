Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852AC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiLFTwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 14:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLFTw2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 14:52:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120BE2FFF0
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 11:52:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id b2so8923451eja.7
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgaCQixnAQgfcr7Ca7Bam6HfOMDuTuSUVXVhg1Fd5jw=;
        b=lUn759/uEqIQ6BKwGyXed3b+McUCvHbXPT+77mSoUu6CAQe1ayhdsWoZQyX8skoVjI
         rLv7Ris7M3jOmYKb+jevXM8IAulmkDk0z+sBf96fd+kADvPlXHUGMXz98G5UmrDWCsUk
         +37MaNFBGJhjKaukYtSfW/BIPMxb+FKgbAkIHJFns3saVMDWIjV/mtfF2KxG/GYu5xC1
         UD+Qpoea2Gp/Vvm6cAmKKBpGic7fPCi0NY1zZHeqcq9a9YiAwbVOIFpJSL5YiZiejrB/
         YLtSfHj2rZpKgJnSLH+4Y/tVWFtTGP+EvzBbWBFlY8qjny+5PxRDW6RRI/bVy4B8aEaB
         rG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgaCQixnAQgfcr7Ca7Bam6HfOMDuTuSUVXVhg1Fd5jw=;
        b=EZ4QXapKusEl/WCegDwmICnWzUrqt7R2fK+aE6zptboAJ4nuori66XcpB5mE9p6ACw
         tzKsD2L1CYCjYSilxKozUsC2QlurRG4nKm2VNRWveMI7cggw/Rt5g7oMVmB5NjbOjaQQ
         qJCwujK4FIaYfGufx3KupskGaFAzqjWgA5O0PvyyUcWSmpxJtUq3X/faJR16gB48VT/+
         w/7QzwRDUmQ59jvKe5UnJiTSDuhyDz3WOJL5UmxcLd8JDp8fHz4iJm7VcIM5s+nqcqqi
         /ak5lYj3BpE840ONwqr6WV6YthzhSUlNhijA3T806hTD4x89XPVZb3pRokeW6WG5iShS
         QFbQ==
X-Gm-Message-State: ANoB5pkY2Le4EfkaJIOKc7snJfAXktztO8ABl5GBjhcwy+90CNfIZuAz
        n6+jpMIA60Y+RFf0dqEmEOIY5C+yrvC3wQ==
X-Google-Smtp-Source: AA0mqf6IwrSikHL2xBAghN8XOtLqTkTy1hgc+dK4SuryR7BvAJBK2p6P1bfTe4f7vPCC0/7mlZLNCQ==
X-Received: by 2002:a17:907:9951:b0:7b2:7e7a:11c1 with SMTP id kl17-20020a170907995100b007b27e7a11c1mr57580248ejc.684.1670356344222;
        Tue, 06 Dec 2022 11:52:24 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ky16-20020a170907779000b007c08091ad7esm7672698ejc.208.2022.12.06.11.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 11:52:23 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2dzL-0044XB-19;
        Tue, 06 Dec 2022 20:52:23 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Seija <doremylover123@gmail.com>
Subject: Re: [PATCH v5] revision: use calloc instead of malloc where possible
Date:   Tue, 06 Dec 2022 20:44:11 +0100
References: <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com>
 <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1390.v5.git.git.1670348301601.gitgitgadget@gmail.com>
Message-ID: <221206.86k034b98o.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Rose via GitGitGadget wrote:

> From: Seija <doremylover123@gmail.com>
>
> We can avoid having to call memset by calling calloc directly
>
> Signed-off-by: Seija doremylover123@gmail.com
> ---
>     revision: use calloc instead of malloc where possible
>     
>     We can avoid having to call memset by calling calloc directly
>     
>     Signed-off-by: Seija doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1390%2FAtariDreams%2Fcalloc-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1390/AtariDreams/calloc-v5
> Pull-Request: https://github.com/git/git/pull/1390
>
> Range-diff vs v4:
>
>  1:  3cd6b1eab13 ! 1:  8072fa30e4f maintenance: use calloc instead of malloc where possible
>      @@ Metadata
>       Author: Seija <doremylover123@gmail.com>
>       
>        ## Commit message ##
>      -    maintenance: use calloc instead of malloc where possible
>      +    revision: use calloc instead of malloc where possible
>       
>           We can avoid having to call memset by calling calloc directly
>       
>      @@ Commit message
>       
>        ## builtin/pack-redundant.c ##
>       @@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
>      - 		new_item = free_nodes;
>      - 		free_nodes = free_nodes->next;
>      - 	} else {
>      --		int i = 1;
>      -+		size_t i = 1;
>      - 		ALLOC_ARRAY(new_item, BLKSIZE);
>      - 		for (; i < BLKSIZE; i++)
>      - 			llist_item_put(&new_item[i]);
>      -@@ builtin/pack-redundant.c: static inline struct llist_item *llist_item_get(void)
>      + 	return new_item;
>      + }
>        
>      - static inline void llist_init(struct llist **list)
>      - {
>      +-static inline void llist_init(struct llist **list)
>      +-{
>       -	*list = xmalloc(sizeof(struct llist));
>       -	(*list)->front = (*list)->back = NULL;
>       -	(*list)->size = 0;
>      -+	CALLOC_ARRAY(*list, 1);
>      - }
>      - 
>      +-}
>      +-
>        static struct llist * llist_copy(struct llist *list)
>      + {
>      + 	struct llist *ret;
>      + 	struct llist_item *new_item, *old_item, *prev;
>      + 
>      +-	llist_init(&ret);
>      ++	CALLOC_ARRAY(ret, 1);
>      + 
>      + 	if ((ret->size = list->size) == 0)
>      + 		return ret;
>      +@@ builtin/pack-redundant.c: static void load_all_objects(void)
>      + 	struct pack_list *pl = local_packs;
>      + 	struct llist_item *hint, *l;
>      + 
>      +-	llist_init(&all_objects);
>      ++	CALLOC_ARRAY(all_objects, 1);
>      + 
>      + 	while (pl) {
>      + 		hint = NULL;
>      +@@ builtin/pack-redundant.c: static void cmp_local_packs(void)
>      + 
>      + 	/* only one packfile */
>      + 	if (!pl->next) {
>      +-		llist_init(&pl->unique_objects);
>      ++		CALLOC_ARRAY(pl->unique_objects, 1);
>      + 		return;
>      + 	}
>      + 
>      +@@ builtin/pack-redundant.c: static struct pack_list * add_pack(struct packed_git *p)
>      + 		return NULL;
>      + 
>      + 	l.pack = p;
>      +-	llist_init(&l.remaining_objects);
>      ++	CALLOC_ARRAY(l.remaining_objects, 1);
>      + 
>      + 	if (open_pack_index(p))
>      + 		return NULL;
>      +@@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
>      + 		scan_alt_odb_packs();
>      + 
>      + 	/* ignore objects given on stdin */
>      +-	llist_init(&ignore);
>      ++	CALLOC_ARRAY(ignore, 1);
>      + 	if (!isatty(0)) {
>      + 		while (fgets(buf, sizeof(buf), stdin)) {
>      + 			oid = xmalloc(sizeof(*oid));
>       
>        ## remote.c ##
>       @@ remote.c: void apply_push_cas(struct push_cas_option *cas,
>      @@ submodule.c: static struct fetch_task *fetch_task_create(struct submodule_parall
>        
>        	task->sub = submodule_from_path(spf->r, treeish_name, path);
>        
>      -
>      - ## xdiff/xutils.c ##
>      -@@ xdiff/xutils.c: void *xdl_cha_alloc(chastore_t *cha) {
>      - 	void *data;
>      - 
>      - 	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
>      --		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
>      -+		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
>      - 
>      - 			return NULL;
>      - 		}
>      --		ancur->icurr = 0;
>      --		ancur->next = NULL;
>      - 		if (cha->tail)
>      - 			cha->tail->next = ancur;
>      - 		if (!cha->head)
>
>
>  builtin/pack-redundant.c | 17 +++++------------
>  remote.c                 |  4 ++--
>  submodule.c              | 10 +++++-----
>  3 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index ecd49ca268f..ce5be807cf0 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -59,19 +59,12 @@ static inline struct llist_item *llist_item_get(void)
>  	return new_item;
>  }
>  
> -static inline void llist_init(struct llist **list)
> -{
> -	*list = xmalloc(sizeof(struct llist));
> -	(*list)->front = (*list)->back = NULL;
> -	(*list)->size = 0;
> -}
> -
>  static struct llist * llist_copy(struct llist *list)
>  {
>  	struct llist *ret;
>  	struct llist_item *new_item, *old_item, *prev;
>  
> -	llist_init(&ret);
> +	CALLOC_ARRAY(ret, 1);
>  
>  	if ((ret->size = list->size) == 0)
>  		return ret;
> @@ -448,7 +441,7 @@ static void load_all_objects(void)
>  	struct pack_list *pl = local_packs;
>  	struct llist_item *hint, *l;
>  
> -	llist_init(&all_objects);
> +	CALLOC_ARRAY(all_objects, 1);
>  
>  	while (pl) {
>  		hint = NULL;
> @@ -475,7 +468,7 @@ static void cmp_local_packs(void)
>  
>  	/* only one packfile */
>  	if (!pl->next) {
> -		llist_init(&pl->unique_objects);
> +		CALLOC_ARRAY(pl->unique_objects, 1);
>  		return;
>  	}
>  
> @@ -512,7 +505,7 @@ static struct pack_list * add_pack(struct packed_git *p)
>  		return NULL;
>  
>  	l.pack = p;
> -	llist_init(&l.remaining_objects);
> +	CALLOC_ARRAY(l.remaining_objects, 1);
>  
>  	if (open_pack_index(p))
>  		return NULL;
> @@ -620,7 +613,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
>  		scan_alt_odb_packs();
>  
>  	/* ignore objects given on stdin */
> -	llist_init(&ignore);
> +	CALLOC_ARRAY(ignore, 1);
>  	if (!isatty(0)) {
>  		while (fgets(buf, sizeof(buf), stdin)) {
>  			oid = xmalloc(sizeof(*oid));
> diff --git a/remote.c b/remote.c
> index 60869beebe7..475a1d18af0 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2741,9 +2741,9 @@ void apply_push_cas(struct push_cas_option *cas,
>  
>  struct remote_state *remote_state_new(void)
>  {
> -	struct remote_state *r = xmalloc(sizeof(*r));
> +	struct remote_state *r;
>  
> -	memset(r, 0, sizeof(*r));
> +	CALLOC_ARRAY(r, 1);
>  
>  	hashmap_init(&r->remotes_hash, remotes_hash_cmp, NULL, 0);
>  	hashmap_init(&r->branches_hash, branches_hash_cmp, NULL, 0);
> diff --git a/submodule.c b/submodule.c
> index 8ac2fca855d..015102a83d6 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1458,14 +1458,13 @@ struct fetch_task {
>   */
>  static const struct submodule *get_non_gitmodules_submodule(const char *path)
>  {
> -	struct submodule *ret = NULL;
> +	struct submodule *ret;
>  	const char *name = default_name_or_path(path);
>  
>  	if (!name)
>  		return NULL;
>  
> -	ret = xmalloc(sizeof(*ret));
> -	memset(ret, 0, sizeof(*ret));
> +	CALLOC_ARRAY(ret, 1);
>  	ret->path = name;
>  	ret->name = name;
>  
> @@ -1504,8 +1503,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
>  					    const char *path,
>  					    const struct object_id *treeish_name)
>  {
> -	struct fetch_task *task = xmalloc(sizeof(*task));
> -	memset(task, 0, sizeof(*task));
> +	struct fetch_task *task;
> +
> +	CALLOC_ARRAY(task, 1);
>  
>  	task->sub = submodule_from_path(spf->r, treeish_name, path);
>  
>
> base-commit: 2e71cbbddd64695d43383c25c7a054ac4ff86882

This is partially some of the sentiments Junio did in the v4 review
(although I looked at this before reading that).

I think calloc-ing or memset-ing a struct is going in the opposite
direction of where we've been trending, which is to have explicit
initializers. Sometimes it's justified, but in the "pack-redundant.c"
case I think it's probably better & more future-proof to keep it, and
get rid of the odd patter nof passing in a ** to an init function to
have it alloc for us.

I.e. this (there's some stray new free() in there from testing, sorry,
but those are also bugs we should fix...):

	diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
	index ecd49ca268f..af91d643dd2 100644
	--- a/builtin/pack-redundant.c
	+++ b/builtin/pack-redundant.c
	@@ -27,6 +27,7 @@ static struct llist {
	 	struct llist_item *back;
	 	size_t size;
	 } *all_objects; /* all objects which must be present in local packfiles */
	+#define LLIST_INIT { 0 }
	 
	 static struct pack_list {
	 	struct pack_list *next;
	@@ -59,19 +60,18 @@ static inline struct llist_item *llist_item_get(void)
	 	return new_item;
	 }
	 
	-static inline void llist_init(struct llist **list)
	+static inline void llist_init(struct llist *list)
	 {
	-	*list = xmalloc(sizeof(struct llist));
	-	(*list)->front = (*list)->back = NULL;
	-	(*list)->size = 0;
	+	struct llist blank = LLIST_INIT;
	+	memcpy(list, &blank, sizeof(*list));
	 }
	 
	 static struct llist * llist_copy(struct llist *list)
	 {
	-	struct llist *ret;
	+	struct llist *ret = xmalloc(sizeof(struct llist));
	 	struct llist_item *new_item, *old_item, *prev;
	 
	-	llist_init(&ret);
	+	llist_init(ret);
	 
	 	if ((ret->size = list->size) == 0)
	 		return ret;
	@@ -420,6 +420,7 @@ static void minimize(struct pack_list **min)
	 
	 	unique_pack_objects = llist_copy(all_objects);
	 	llist_sorted_difference_inplace(unique_pack_objects, missing);
	+	free(missing);
	 
	 	/* remove unique pack objects from the non_unique packs */
	 	pl = non_unique;
	@@ -447,8 +448,9 @@ static void load_all_objects(void)
	 {
	 	struct pack_list *pl = local_packs;
	 	struct llist_item *hint, *l;
	+	all_objects = xmalloc(sizeof(struct llist));
	 
	-	llist_init(&all_objects);
	+	llist_init(all_objects);
	 
	 	while (pl) {
	 		hint = NULL;
	@@ -475,7 +477,8 @@ static void cmp_local_packs(void)
	 
	 	/* only one packfile */
	 	if (!pl->next) {
	-		llist_init(&pl->unique_objects);
	+		pl->unique_objects = xmalloc(sizeof(struct llist));
	+		llist_init(pl->unique_objects);
	 		return;
	 	}
	 
	@@ -512,7 +515,8 @@ static struct pack_list * add_pack(struct packed_git *p)
	 		return NULL;
	 
	 	l.pack = p;
	-	llist_init(&l.remaining_objects);
	+	l.remaining_objects = xmalloc(sizeof(struct llist));
	+	llist_init(l.remaining_objects);
	 
	 	if (open_pack_index(p))
	 		return NULL;
	@@ -562,7 +566,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
	 	int i;
	 	int i_still_use_this = 0;
	 	struct pack_list *min = NULL, *red, *pl;
	-	struct llist *ignore;
	+	struct llist *ignore = xmalloc(sizeof(struct llist));
	 	struct object_id *oid;
	 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
	 
	@@ -620,7 +624,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
	 		scan_alt_odb_packs();
	 
	 	/* ignore objects given on stdin */
	-	llist_init(&ignore);
	+	llist_init(ignore);
	 	if (!isatty(0)) {
	 		while (fgets(buf, sizeof(buf), stdin)) {
	 			oid = xmalloc(sizeof(*oid));
	@@ -635,6 +639,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
	 		llist_sorted_difference_inplace(pl->remaining_objects, ignore);
	 		pl = pl->next;
	 	}
	+	free(ignore);
	 
	 	cmp_local_packs();

Now, for:

> @@ -1504,8 +1503,9 @@ static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf
>  					    const char *path,
>  					    const struct object_id *treeish_name)
>  {
> -	struct fetch_task *task = xmalloc(sizeof(*task));
> -	memset(task, 0, sizeof(*task));
> +	struct fetch_task *task;
> +
> +	CALLOC_ARRAY(task, 1);
>  
>  	task->sub = submodule_from_path(spf->r, treeish_name, path);

This is no worse than before, but I think we're just converting here
from one bad pattern to another.

The "struct fetch_task" contains a "struct strvec", for many of our
structs we play it fast and loose with whether you can calloc() it, but
for "struct strbuf", "struct strvec" etc. we have an "empty_strvec" (or
"slopbuf" etc.), so we *really* want those to be properly init'd.

AFAICT we're just lucky that it happens to work with the strvec API in
this case, but if this was a strbuf it could easily segfault etc.

So the better fix here since we're spending review time on it isn't to
move from one memset() equivalent pattern to another, but actually to
start properly initializing this.

Finally, this commit just seems to be all over the place in what it's
changing. We have a bunch of:

	x = xmalloc(...);
	memset(x, 0, ...);

In our tree, it's not clear why these are being picked out in
particular, or what they have to do with each other.

I think that if we're proposing to refactor these doing so with
coccinelle is a much better thing to do. There's a parallel thread about
that over at:
https://lore.kernel.org/git/6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com/
