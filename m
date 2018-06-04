Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E9C1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeFDDTb (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:19:31 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36072 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFDDTb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:19:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so26248503wrm.3
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NAqNpC7YntIYusll4KdY3VqDFnIJrsyF9USM44DE7tY=;
        b=I5XigvlZrqk43AFPTlP7DbTproi6HoZCbDc54s42oXN7NxrDBhh+ckcpneSO5PxqQb
         w37PALlKaTht59NNxvoo6koGN6WRxw2s+z/sdXwpZNrbiq+X8wvUkaGx1ne+4wZsj0Re
         cHWCEmfKt7/3L6ae9dmIsoQCCl4SgEIXBMkpU+wMNwzP7s57Ko9zAj4vTlnu4214GD1+
         Mffiq1JxuORt33UcnJk+WPWs9HlxWwQAC/o1G2PYEF0eEoGB/IPTK/wkqZ15EQyEfCxi
         YH9tmCBeb3E9ejvwD4uXlFh0+mcDWpEgbIHVg6JBczIeYzGZEGvgmfusfvxJgg6fTv5W
         MFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NAqNpC7YntIYusll4KdY3VqDFnIJrsyF9USM44DE7tY=;
        b=HCLQqwTqX7nxiQDnjlQKvrzD+8/lzlz1hRLkUIodRZGUdXgQ8XdVMpMmQOZwprwBPX
         BVRcCARpZu3wXW1v5uu0Nsa+7g7H4S5AKhbDHfo1qjMa0VkznWQ11llsEZyolPVcjTb7
         WOSwHXyNudSL+zXm+E30nfjuwsRgdIaOC4POMC9CSbyNDRq6Sb5FY7Ly5UAN8Eif6SLI
         WAaCUB70z7ztT825+DAKaqC9TuxAJlmyoK1pe4ASRMEFZcKSyMGohaI4cyrPNajgxmKX
         K4su4r/m1Rt9SrsQ28ld9GWkbvNdH1Sn2aqcHjpSCjzpct0oGqNmr/ac4FZsapttbUL3
         qgNQ==
X-Gm-Message-State: ALKqPwdgiTTr/R/NJ9x031hNPWzETikgJH1Ab6ona35pJ1r1T2mETXKZ
        Lo1xLuVtyuwqdpHMCMFbMfBq6L3T
X-Google-Smtp-Source: ADUXVKJBmG9+5wf51g9NtZfXfS+tdpogcez3NBvJSD0ga70adHQPw9ql5Z1r1GXSYm3j/b1zN/HnPg==
X-Received: by 2002:adf:8bdb:: with SMTP id w27-v6mr15120636wra.169.1528082369476;
        Sun, 03 Jun 2018 20:19:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 141-v6sm10744237wmf.35.2018.06.03.20.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 20:19:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree being merged is HEAD
References: <20180603065810.23841-1-newren@gmail.com>
        <20180603065810.23841-5-newren@gmail.com>
Date:   Mon, 04 Jun 2018 12:19:28 +0900
In-Reply-To: <20180603065810.23841-5-newren@gmail.com> (Elijah Newren's
        message of "Sat, 2 Jun 2018 23:58:07 -0700")
Message-ID: <xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> `git merge-recursive` does a three-way merge between user-specified trees
> base, head, and remote.  Since the user is allowed to specify head, we can
> not necesarily assume that head == HEAD.
>
> We modify index_has_changes() to take an extra argument specifying the
> tree to compare the index to.  If NULL, it will compare to HEAD.  We then
> use this from merge-recursive to make sure we compare to the
> user-specified head.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>
> I'm really unsure where the index_has_changes() declaration should go;
> I stuck it in tree.h, but is there a better spot?

I think I saw you tried to lift an assumption that we're always
working on the_index in a separate patch recently.  Should that
logic apply also to this part of the codebase?  IOW, shouldn't
index_has_changes() take a pointer to istate (as opposed to a
function that uses the implicit the_index that should be named as
"cache_has_changes()" or something?)

I tend to think this function as part of the larger read-cache.c
family whose definitions are in cache.h and accompanied by macros
that are protected by NO_THE_INDEX_COMPATIBILITY_MACROS so if we
were to move it elsewhere, I'd keep the header part as-is and
implementation to read-cache.c to keep it together with the family,
but I do not see a huge issue with the current placement, either.

> diff --git a/cache.h b/cache.h
> index 89a107a7f7..439b9d9f6e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -634,14 +634,6 @@ extern int discard_index(struct index_state *);
>  extern void move_index_extensions(struct index_state *dst, struct index_state *src);
>  extern int unmerged_index(const struct index_state *);
>  
> -/**
> - * Returns 1 if the index differs from HEAD, 0 otherwise. When on an unborn
> - * branch, returns 1 if there are entries in the index, 0 otherwise. If an
> - * strbuf is provided, the space-separated list of files that differ will be
> - * appended to it.
> - */
> -extern int index_has_changes(struct strbuf *sb);
> -
>  extern int verify_path(const char *path, unsigned mode);
>  extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
> diff --git a/merge-recursive.c b/merge-recursive.c
> index b3deb7b182..762aa087d0 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3263,7 +3263,7 @@ int merge_trees(struct merge_options *o,
>  	if (oid_eq(&common->object.oid, &merge->object.oid)) {
>  		struct strbuf sb = STRBUF_INIT;
>  
> -		if (!o->call_depth && index_has_changes(&sb)) {
> +		if (!o->call_depth && index_has_changes(&sb, head)) {
>  			err(o, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
>  			    sb.buf);
>  			return -1;
> diff --git a/merge.c b/merge.c
> index 0783858739..965d287646 100644
> --- a/merge.c
> +++ b/merge.c
> @@ -14,19 +14,21 @@ static const char *merge_argument(struct commit *commit)
>  	return oid_to_hex(commit ? &commit->object.oid : the_hash_algo->empty_tree);
>  }
>  
> -int index_has_changes(struct strbuf *sb)
> +int index_has_changes(struct strbuf *sb, struct tree *tree)
>  {
> -	struct object_id head;
> +	struct object_id cmp;
>  	int i;
>  
> -	if (!get_oid_tree("HEAD", &head)) {
> +	if (tree)
> +		cmp = tree->object.oid;
> +	if (tree || !get_oid_tree("HEAD", &cmp)) {
>  		struct diff_options opt;
>  
>  		diff_setup(&opt);
>  		opt.flags.exit_with_status = 1;
>  		if (!sb)
>  			opt.flags.quick = 1;
> -		do_diff_cache(&head, &opt);
> +		do_diff_cache(&cmp, &opt);
>  		diffcore_std(&opt);
>  		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
>  			if (i)
> diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
> index 3876cfa4fa..1d43712c52 100755
> --- a/t/t6044-merge-unrelated-index-changes.sh
> +++ b/t/t6044-merge-unrelated-index-changes.sh
> @@ -126,7 +126,7 @@ test_expect_success 'recursive, when merge branch matches merge base' '
>  	test_path_is_missing .git/MERGE_HEAD
>  '
>  
> -test_expect_failure 'merge-recursive, when index==head but head!=HEAD' '
> +test_expect_success 'merge-recursive, when index==head but head!=HEAD' '
>  	git reset --hard &&
>  	git checkout C^0 &&
>  
> diff --git a/tree.h b/tree.h
> index e2a80be4ef..2e1d8ea720 100644
> --- a/tree.h
> +++ b/tree.h
> @@ -37,4 +37,12 @@ extern int read_tree_recursive(struct tree *tree,
>  extern int read_tree(struct tree *tree, int stage, struct pathspec *pathspec,
>  		     struct index_state *istate);
>  
> +/**
> + * Returns 1 if the index differs from tree, 0 otherwise.  If tree is NULL,
> + * compares to HEAD.  If tree is NULL and on an unborn branch, returns 1 if
> + * there are entries in the index, 0 otherwise. If an strbuf is provided,
> + * the space-separated list of files that differ will be appended to it.
> + */
> +extern int index_has_changes(struct strbuf *sb, struct tree *tree);
> +
>  #endif /* TREE_H */
