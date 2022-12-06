Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ABC3A5A7
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 05:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiLFFD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 00:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiLFFDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 00:03:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999BBC74F
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 21:03:18 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so12373172pgl.11
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 21:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8j7hwkFLJySaOi93UvOIc0DH0ik18Ci/+gAK8moryo=;
        b=ADTrqHTKVcgb7Klka7SZNGvAhhBiJw+5ZSwVr7oudqtwDvdYpi1n1CV6S9amcabpBz
         xqKO8xqXGgTRs524ssfPSfaolGnbEtTXbHzOFeW6EcLO5eE0bs46Uc0f7GxIowsnYiDw
         FTEZzfk8L1T3yleOuF2cOXpZtMSbSczMqr8SzjENXzrY4Zgi5G+u9+HfT8IIw4gA1nCz
         brTGiEjxrriasRKZ7Ob8b4GRU+0DYuQOLf6BZnWF3sPXFnxpeqWvAb9y1e/C4EPXZrmw
         ApEhtDMcqmM/XbauO7iIFRWZFyEfUH5+qerCU2AkgJXdMVFLoGFXXleAcdj1MgffmQYT
         C+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D8j7hwkFLJySaOi93UvOIc0DH0ik18Ci/+gAK8moryo=;
        b=diM63HRrWv6J4xqh6+X+cLqlCNzUNq0QWhBo1lSwwdhSvY2egvgs4mstvaiJuSc8zw
         yQxuVE9CAAMtRLjnj187JIspkUNbla9mBPttH043VG3XLZXucmzei4yFAp6drn6gQVgr
         5gJxF0TY7GNtzibwTKvs3qdgyRvasAcFKea89MMb0PVYqMyA3lRz5g3OcAQKNqEVJwlz
         W1F8jDH+z35BKKKtD1gbI3uA2Bo2BZre3pcpTHaC/+azHkTsJnLIOHsv6FW8zt9/LyZd
         25RT/4nm0FB1MIZw2kBDiturW8Z9JCto56EoVXUeO6Si4wZz8T+65ye02tg7oWkGqUPa
         2EjA==
X-Gm-Message-State: ANoB5pkwmxNP/MzClIKOHtVT7r0FpTnGJgERfZ2X2U6/523HUjpc3pVi
        1aWrOs0GSBZBdvFC8DDWN7c=
X-Google-Smtp-Source: AA0mqf7cFt1qSP2LrcSLZQ5Do43sQK5UqAmMB4hO+dcBLbA1vsPFdwfR6KSrGRirbt8jG1gum70oFw==
X-Received: by 2002:a63:f152:0:b0:476:a612:abd7 with SMTP id o18-20020a63f152000000b00476a612abd7mr66830278pgk.241.1670302997842;
        Mon, 05 Dec 2022 21:03:17 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b00575ecd1d301sm10712217pfj.177.2022.12.05.21.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 21:03:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Seija <doremylover123@gmail.com>
Subject: Re: [PATCH v4] maintenance: use calloc instead of malloc where
 possible
References: <pull.1390.v3.git.git.1670256084172.gitgitgadget@gmail.com>
        <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com>
Date:   Mon, 05 Dec 2022 21:03:16 -0800
In-Reply-To: <pull.1390.v4.git.git.1670256724311.gitgitgadget@gmail.com> (Rose
        via GitGitGadget's message of "Mon, 05 Dec 2022 16:12:04 +0000")
Message-ID: <xmqqpmcxqg2z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Rose via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija <doremylover123@gmail.com>
>
> We can avoid having to call memset by calling calloc directly

What is not explained here is how that makes the code better in what
way.  Reduced line count?  Reduced cycle count?  Reduced line count?

The reason I ask is because the patch touches codepaths that do not
call memset() after malloc(), which the above may explain.

Also, the patch does not use calloc() directly, but uses
CALLOC_ARRAY() doesn't it?

>      +    maintenance: use calloc instead of malloc where possible

This is not about "git maintenance", is it?  Why is that subsystem
specifically named here?

This is not about the patch, because Signed-off-by: line has a legal
meaning (also see SubmittingPatches[[real-name]]), would you mind
explaining what is going on with your name?  The e-mailed patches
come from "Rose", but the patch author identifies themselves as
"Seija".

> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index ecd49ca268f..0e184bb5212 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -51,7 +51,7 @@ static inline struct llist_item *llist_item_get(void)
>  		new_item = free_nodes;
>  		free_nodes = free_nodes->next;
>  	} else {
> -		int i = 1;
> +		size_t i = 1;
>  		ALLOC_ARRAY(new_item, BLKSIZE);
>  		for (; i < BLKSIZE; i++)
>  			llist_item_put(&new_item[i]);

This is unrelated change, isn't it?

> @@ -61,9 +61,7 @@ static inline struct llist_item *llist_item_get(void)
>  
>  static inline void llist_init(struct llist **list)
>  {
> -	*list = xmalloc(sizeof(struct llist));
> -	(*list)->front = (*list)->back = NULL;
> -	(*list)->size = 0;
> +	CALLOC_ARRAY(*list, 1);
>  }

I am somewhat torn on this one.

The original makes it crystal clear that the initial state of the
llist data structure is that the .front and the .back pointers that
point at the head and the tail of a linearly linked list point at
NULL and the .size member indicates there is zero elements on the
list.  IOW, unlike a mindless "memset()" in a

	x = malloc(sizeof(...));
	memset(x, '\0', sizeof(...));

sequence, the way members are cleared was meaningful in the
original.

Using CALLOC_ARRAY() makes it as bad as use of memset() that blindly
fills the memory reason with NUL bytes.  Surely a NULL pointer may
have the same bit representation as a region of memory filled with
NUL, and a size_t integer whose value is zero may also share the
same bit representation, but it lost clarity of the original.

On the other hand, if we are willing to accept the conciseness, and
accept the "\0 filled memory region is the naturally initialized
state for this structure" convention, then I do not see the value of
having a separate llist_init() helper function.  It is used only in
a handful places in this single file, so getting rid of the helper
and writing CALLOC_ARRAY(x, 1) to clear each instance of the structure
it is used to clear may not be a bad thing.

And the presented solution is neither.  Again, I'd prefer to keep
the original, but if we must use CALLOC_ARRAY() to replace it, then
I'd prefer to see that the helper function to be removed.

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

This IS an improvement.  We do the mindless clearing either way, it
is just shorter and easier to follow.

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

Ditto.

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

Ditto.

> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> index 9e36f24875d..c19bc441a96 100644
> --- a/xdiff/xutils.c
> +++ b/xdiff/xutils.c
> @@ -98,12 +98,10 @@ void *xdl_cha_alloc(chastore_t *cha) {
>  	void *data;
>  
>  	if (!(ancur = cha->ancur) || ancur->icurr == cha->nsize) {
> -		if (!(ancur = (chanode_t *) xdl_malloc(sizeof(chanode_t) + cha->nsize))) {
> +		if (!(ancur = (chanode_t *) xdl_calloc(1, sizeof(chanode_t) + cha->nsize))) {
>  
>  			return NULL;
>  		}
> -		ancur->icurr = 0;
> -		ancur->next = NULL;

I am somewhat negative on this for the same reason why I'd prefer to
keep the llist thing intact.  Also xdiff code is a borrowed code and
I'd rather see us not to touch it unnecessarily.

>  		if (cha->tail)
>  			cha->tail->next = ancur;
>  		if (!cha->head)
>
> base-commit: 805265fcf7a737664a8321aaf4a0587b78435184

Thanks.
