Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03581C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 14:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjCOOX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbjCOOXx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 10:23:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8AB9475D
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:23:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cy23so76128832edb.12
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678890227;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrzzjIz8GpxjLoWilxQ9x+Sz+MioOOjw+hOyzEurOH4=;
        b=fGy+ZzvFdW1HjhRGfZIwPJGK3if3sgxAnnriiZXCOfB4viZGilu31gArZGEAP97Rw+
         XuaKxu3uZFh/UNwft+2d5MeemcKC+38GZQPNjlE97iDQgUlYCrzkLzflzWXcqQ5LAveU
         aaimgIJq8WvKKU9ZCp/MnIsEwH37Q9T5lNC0L4Y/3+SEMfwcJLQ802qFK8AqWE9Eq5Cm
         M8crckNaAZOJ9cGpejnR9S/JtcfAViCwe0Qlq4LdFJYhvEv0cvQ3zFueZyXxACDBaoVD
         gkYSWzDvBV5gMnQe/Vh91cWIfyw/98F/P4bLc9HPciAvlg8fEhVCP0V95U+GuGrBaRoz
         ZHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678890227;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrzzjIz8GpxjLoWilxQ9x+Sz+MioOOjw+hOyzEurOH4=;
        b=wm4obQ/m+OT2U0Ta32hzQMlt32vlyHqnPOCtmg7F5kIeT7ujob1Eb6U2pJ5aiQjpCw
         Ooqhcm+n3wByFErTfZyXKT3/kr79lrb1/p7cSE1bSE3629iP2xhWkpu2O5s8fY8sogq3
         5WfhRYq5LRFAbulA/xG4VXhBLwwM6TAHDmj9ZbMu1xvH6NhsTyRzXleHvS2REsg9XO+e
         6AJZh9mutAvZphQSrk60GXsUbtL62IYVkBfmuiQVmx2C+Cy38PdJisP27jrfyk6/NOPP
         Qa/KBvG5FsvrjB1gmMAaoXwviofbOoz9Ez/ZVIBWSwdnq4uQdcSU0gR8wQJDW5l3URxl
         ExrQ==
X-Gm-Message-State: AO0yUKULuggV7ow58DMx0Nb6A/LKQTRgjJQn35IgYcq4AyEhOMro7CcA
        rk2s0I5GZDDEilrtXFm/it4fUxCMRpw=
X-Google-Smtp-Source: AK7set/YWXX/8K9jSbeYpOYqao5guo7UgdnHuFg23ZvAdH1YGIc4yDoCmrj7z0H5rOruAUG7fbr2Ig==
X-Received: by 2002:a05:6402:68a:b0:4fd:2aac:d480 with SMTP id f10-20020a056402068a00b004fd2aacd480mr2995618edy.21.1678890227150;
        Wed, 15 Mar 2023 07:23:47 -0700 (PDT)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id u19-20020a50c053000000b004fc537aec3csm2550230edd.74.2023.03.15.07.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:23:46 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pcS2c-002yRq-0C;
        Wed, 15 Mar 2023 15:23:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 8/8] commit-reach: add tips_reachable_from_bases()
Date:   Wed, 15 Mar 2023 15:13:56 +0100
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <f3fb6833bd71d559a3076d9617a235614ad9a5f8.1678468864.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <f3fb6833bd71d559a3076d9617a235614ad9a5f8.1678468864.git.gitgitgadget@gmail.com>
Message-ID: <230315.864jqmxfd9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>

> +{
> +	size_t i;

Ditto the decl suggestion in an earlier commit, i.e...

> +	struct commit_and_index *commits;
> +	unsigned int min_generation_index = 0;
> +	timestamp_t min_generation;
> +	struct commit_list *stack = NULL;
> +
> +	if (!bases || !tips || !tips_nr)
> +		return;
> +
> +	/*
> +	 * Do a depth-first search starting at 'bases' to search for the
> +	 * tips. Stop at the lowest (un-found) generation number. When
> +	 * finding the lowest commit, increase the minimum generation
> +	 * number to the next lowest (un-found) generation number.
> +	 */
> +
> +	CALLOC_ARRAY(commits, tips_nr);
> +
> +	for (i = 0; i < tips_nr; i++) {

...move this here?

> +		commits[i].commit = tips[i];
> +		commits[i].index = i;
> +		commits[i].generation = commit_graph_generation(tips[i]);
> +	}
> +
> +	/* Sort with generation number ascending. */
> +	QSORT(commits, tips_nr, compare_commit_and_index_by_generation);
> +	min_generation = commits[0].generation;
> +
> +	while (bases) {
> +		parse_commit(bases->item);
> +		commit_list_insert(bases->item, &stack);
> +		bases = bases->next;
> +	}
> +
> +	while (stack) {
> +		unsigned int j;

...ditto...

> +		int explored_all_parents = 1;
> +		struct commit_list *p;
> +		struct commit *c = stack->item;
> +		timestamp_t c_gen = commit_graph_generation(c);
> +
> +		/* Does it match any of our tips? */
> +		for (j = min_generation_index; j < tips_nr; j++) {

...to here...

> +			if (c_gen < commits[j].generation)
> +				break;
> +
> +			if (commits[j].commit == c) {
> +				tips[commits[j].index]->object.flags |= mark;
> +
> +				if (j == min_generation_index) {
> +					unsigned int k = j + 1;
> +					while (k < tips_nr &&
> +					       (tips[commits[k].index]->object.flags & mark))
> +						k++;
> +
> +					/* Terminate early if all found. */
> +					if (k >= tips_nr)
> +						goto done;
> +
> +					min_generation_index = k;
> +					min_generation = commits[k].generation;
> +				}
> +			}
> +		}
> +
> +		for (p = c->parents; p; p = p->next) {
> +			parse_commit(p->item);
> +
> +			/* Have we already explored this parent? */
> +			if (p->item->object.flags & SEEN)
> +				continue;
> +
> +			/* Is it below the current minimum generation? */
> +			if (commit_graph_generation(p->item) < min_generation)
> +				continue;
> +
> +			/* Ok, we will explore from here on. */
> +			p->item->object.flags |= SEEN;
> +			explored_all_parents = 0;
> +			commit_list_insert(p->item, &stack);
> +			break;
> +		}
> +
> +		if (explored_all_parents)
> +			pop_commit(&stack);
> +	}
> +
> +done:
> +	free(commits);
> +	repo_clear_commit_marks(the_repository, SEEN);

I didn't see this in my earlier suggestion for passing "struct
repository", but I think we should do the same here, i.e. have this
function take a "r" argument.

> [...]
> @@ -2390,33 +2390,21 @@ static void reach_filter(struct ref_array *array,
>  			 struct commit_list *check_reachable,
>  			 int include_reached)
>  {
> -	struct rev_info revs;
>  	int i, old_nr;
>  	struct commit **to_clear;
> -	struct commit_list *cr;
>  
>  	if (!check_reachable)
>  		return;
>  
>  	CALLOC_ARRAY(to_clear, array->nr);
> -
> -	repo_init_revisions(the_repository, &revs, NULL);
> -
>  	for (i = 0; i < array->nr; i++) {
>  		struct ref_array_item *item = array->items[i];
> -		add_pending_object(&revs, &item->commit->object, item->refname);
>  		to_clear[i] = item->commit;
>  	}
>  
> -	for (cr = check_reachable; cr; cr = cr->next) {
> -		struct commit *merge_commit = cr->item;
> -		merge_commit->object.flags |= UNINTERESTING;
> -		add_pending_object(&revs, &merge_commit->object, "");
> -	}
> -
> -	revs.limited = 1;
> -	if (prepare_revision_walk(&revs))
> -		die(_("revision walk setup failed"));
> +	tips_reachable_from_bases(check_reachable,
> +				  to_clear, array->nr,
> +				  UNINTERESTING);

I.e. it's not ideal, but we had a the_repository in this function before
(should probably have passed it from further up, but whatever), so we
could pass that to the new tips_reachable_from_bases() still.

> -test_perf 'ahead-behind counts: git rev-list' '
> -	for r in $(cat refs)
> -	do
> -		git rev-list --count "HEAD..$r" || return 1
> -	done

Why does this change require deleting the old perf test? Your commit 7/8
notes this test, but here we're deleting it, let's keep it and instead
note if the results changed, or stayed the same?

More generally, your commit message says:

> Add extra tests for this behavior in t6600-test-reach.sh as the
> interesting data shape of that repository can sometimes demonstrate
> corner case bugs.

And here for a supposed optimization commit you're adding new tests, but
when I try them with the C code at 7/8 they pass.

So it seems we should add them earlier, and this is a pure-optimization
commit, but one that's a bit confused about what goes where? :)
