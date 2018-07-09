Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5851F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933506AbeGIQmm (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:42:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37318 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:42:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so21461182wmh.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=//QE9oAZlOtonJ8ApTBZZeTWXC2xU5TUrB7BinZFaeQ=;
        b=IOhNxvxNAzVR58eEpfVZesn/yfGSB6r8SFoRlS39D8+YCH8NEslACTH+795Tl/fAYH
         taymPYRx7NrQGUvq78Egwn46G3EjoeYpJ2XQGFUHB7B1ZL8YcyrXJ7ElWTdUlk2OB9sF
         Z5wb3i9J3xItPEQFoiVdCi8xV8OktsaWy0UnFOdz1nJFfvO6WJ3uznMHpxMp7OkrGUE0
         kF0kcK+oWqMutMbTTZ9wDeaQkC2n5XwrnguAvsJpU+FPhtyWvC/lFJ/3h+BRYJRAqUPL
         hNuTEW/tO4KEkaMFaW9odi4gv12IhgnB7f8UB6YKYqd+Ng8vfykbah841b9hm/d9FkyA
         kMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=//QE9oAZlOtonJ8ApTBZZeTWXC2xU5TUrB7BinZFaeQ=;
        b=Vy2pLC5my9n7ieWmzFswXaOqVyP7WAfYytc7w3ktPq4SRi2JrvYEdbnUuqBkrqj/VG
         b56t81g+7SWff/nlCLx0pzhsGWAbjJ0+Y15GILtmR9BiBcgd7fynxs7GDCwzIwdJ8LAk
         09giVUV/gS2mDNQMQVb5BgV26JU4lvBiwYr9NR0Hp46XGfi3hstd9HYnpJ5qdAQ90Q2d
         yzUxGD9RvlJcBjLIA8NB9GnlblOUQWF9nH/lYqIVY+U0jKXluTGqcuO8qoA73gB/z+Pa
         Pa9w0OmeZ3upQsKqqhnyzsUKspPeqXRoKodvmCr2wqnJPgSnofhXuVysUdsJqobDWpzt
         PEXg==
X-Gm-Message-State: APt69E2JXN/v9ygc83A6DB6ejmmS5Zp3hXOsgL/26lezdqk00WT7CTvD
        646LlM5gLFqj4i/UZXw/JnE=
X-Google-Smtp-Source: AAOMgpe7Pva3XNUMnEcE4WSX18lOlZALw4TTzax+W46q3D89xZ/vs1yA7NrI3WlYcXHOkLTvPTDcyQ==
X-Received: by 2002:a1c:1414:: with SMTP id 20-v6mr11046773wmu.61.1531154556607;
        Mon, 09 Jul 2018 09:42:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g10-v6sm4890147wru.43.2018.07.09.09.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:42:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v4 3/4] sequencer: refactor the code to detach HEAD to checkout.c
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180708180104.17921-1-predatoramigo@gmail.com>
        <20180708180104.17921-4-predatoramigo@gmail.com>
Date:   Mon, 09 Jul 2018 09:42:35 -0700
In-Reply-To: <20180708180104.17921-4-predatoramigo@gmail.com> (Pratik Karki's
        message of "Sun, 8 Jul 2018 23:46:03 +0545")
Message-ID: <xmqq8t6kfjic.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> In the upcoming builtin rebase, we will have to start by detaching
> the HEAD, just like shell script version does. Essentially, we have
> to do the same thing as `git checkout -q <revision>^0 --`, in pure C.
>
> The aforementioned functionality was already present in `sequencer.c`
> in `do_reset()` function. But `do_reset()` performs more than detaching
> the HEAD, and performs action specific to `sequencer.c`.
>
> So this commit refactors out that part from `do_reset()`, and moves it
> to a new function called `detach_head_to()`. As this function has
> nothing to do with the sequencer, and everything to do with what `git
> checkout -q <revision>^0 --` does, we move that function to checkout.c.
>
> This refactoring actually introduces a slight change in behavior:
> previously, the index was locked before parsing the argument to the
> todo command `reset`, while it now gets locked *after* that, in the
> `detach_head_to()` function.
>
> It does not make a huge difference, and the upside is that this closes
> a few (unlikely) code paths where the index would not be unlocked upon
> error.
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> ---

Here is a place to say "unchanged since v3" for a change like this
one that changes neither the proposed log message above nor the
patch below to help reviewers who have seen the previous round (they
can stop reading here).  Hopefully there are more reviewers than you
who write new code, so spending a bit more time to help them spend
less would be an overall win for the project.

Thanks.

>  checkout.c  | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  checkout.h  |  3 +++
>  sequencer.c | 58 +++++-------------------------------------------
>  3 files changed, 72 insertions(+), 53 deletions(-)
>
> diff --git a/checkout.c b/checkout.c
> index bdefc888ba..da68915fd7 100644
> --- a/checkout.c
> +++ b/checkout.c
> @@ -2,6 +2,11 @@
>  #include "remote.h"
>  #include "refspec.h"
>  #include "checkout.h"
> +#include "unpack-trees.h"
> +#include "lockfile.h"
> +#include "refs.h"
> +#include "tree.h"
> +#include "cache-tree.h"
>  
>  struct tracking_name_data {
>  	/* const */ char *src_ref;
> @@ -42,3 +47,62 @@ const char *unique_tracking_name(const char *name, struct object_id *oid)
>  	free(cb_data.dst_ref);
>  	return NULL;
>  }
> +
> +int detach_head_to(struct object_id *oid, const char *action,
> +		   const char *reflog_message)
> +{
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct tree_desc desc;
> +	struct lock_file lock = LOCK_INIT;
> +	struct unpack_trees_options unpack_tree_opts;
> +	struct tree *tree;
> +	int ret = 0;
> +
> +	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +		return -1;
> +
> +	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> +	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> +	unpack_tree_opts.head_idx = 1;
> +	unpack_tree_opts.src_index = &the_index;
> +	unpack_tree_opts.dst_index = &the_index;
> +	unpack_tree_opts.fn = oneway_merge;
> +	unpack_tree_opts.merge = 1;
> +	unpack_tree_opts.update = 1;
> +
> +	if (read_cache_unmerged()) {
> +		rollback_lock_file(&lock);
> +		strbuf_release(&ref_name);
> +		return error_resolve_conflict(_(action));
> +	}
> +
> +	if (!fill_tree_descriptor(&desc, oid)) {
> +		error(_("failed to find tree of %s"), oid_to_hex(oid));
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> +		rollback_lock_file(&lock);
> +		free((void *)desc.buffer);
> +		strbuf_release(&ref_name);
> +		return -1;
> +	}
> +
> +	tree = parse_tree_indirect(oid);
> +	prime_cache_tree(&the_index, tree);
> +
> +	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> +		ret = error(_("could not write index"));
> +	free((void *)desc.buffer);
> +
> +	if (!ret)
> +		ret = update_ref(reflog_message, "HEAD", oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +
> +	strbuf_release(&ref_name);
> +	return ret;
> +
> +}
> diff --git a/checkout.h b/checkout.h
> index 9980711179..6ce46cf4e8 100644
> --- a/checkout.h
> +++ b/checkout.h
> @@ -10,4 +10,7 @@
>   */
>  extern const char *unique_tracking_name(const char *name, struct object_id *oid);
>  
> +int detach_head_to(struct object_id *oid, const char *action,
> +		   const char *reflog_message);
> +
>  #endif /* CHECKOUT_H */
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..106d518f4d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -29,6 +29,7 @@
>  #include "oidset.h"
>  #include "commit-slab.h"
>  #include "alias.h"
> +#include "checkout.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -2756,14 +2757,7 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>  {
>  	struct strbuf ref_name = STRBUF_INIT;
>  	struct object_id oid;
> -	struct lock_file lock = LOCK_INIT;
> -	struct tree_desc desc;
> -	struct tree *tree;
> -	struct unpack_trees_options unpack_tree_opts;
> -	int ret = 0, i;
> -
> -	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> -		return -1;
> +	int i;
>  
>  	if (len == 10 && !strncmp("[new root]", name, len)) {
>  		if (!opts->have_squash_onto) {
> @@ -2789,56 +2783,14 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
>  		if (get_oid(ref_name.buf, &oid) &&
>  		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
>  			error(_("could not read '%s'"), ref_name.buf);
> -			rollback_lock_file(&lock);
>  			strbuf_release(&ref_name);
>  			return -1;
>  		}
>  	}
>  
> -	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
> -	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
> -	unpack_tree_opts.head_idx = 1;
> -	unpack_tree_opts.src_index = &the_index;
> -	unpack_tree_opts.dst_index = &the_index;
> -	unpack_tree_opts.fn = oneway_merge;
> -	unpack_tree_opts.merge = 1;
> -	unpack_tree_opts.update = 1;
> -
> -	if (read_cache_unmerged()) {
> -		rollback_lock_file(&lock);
> -		strbuf_release(&ref_name);
> -		return error_resolve_conflict(_(action_name(opts)));
> -	}
> -
> -	if (!fill_tree_descriptor(&desc, &oid)) {
> -		error(_("failed to find tree of %s"), oid_to_hex(&oid));
> -		rollback_lock_file(&lock);
> -		free((void *)desc.buffer);
> -		strbuf_release(&ref_name);
> -		return -1;
> -	}
> -
> -	if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> -		rollback_lock_file(&lock);
> -		free((void *)desc.buffer);
> -		strbuf_release(&ref_name);
> -		return -1;
> -	}
> -
> -	tree = parse_tree_indirect(&oid);
> -	prime_cache_tree(&the_index, tree);
> -
> -	if (write_locked_index(&the_index, &lock, COMMIT_LOCK) < 0)
> -		ret = error(_("could not write index"));
> -	free((void *)desc.buffer);
> -
> -	if (!ret)
> -		ret = update_ref(reflog_message(opts, "reset", "'%.*s'",
> -						len, name), "HEAD", &oid,
> -				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> -
> -	strbuf_release(&ref_name);
> -	return ret;
> +	return detach_head_to(&oid, action_name(opts),
> +			      reflog_message(opts, "reset", "'%.*s'",
> +					     len, name));
>  }
>  
>  static int do_merge(struct commit *commit, const char *arg, int arg_len,
