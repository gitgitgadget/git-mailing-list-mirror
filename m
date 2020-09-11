Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF98C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0A222208
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 21:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sp5CWilY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgIKVrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 17:47:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57549 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgIKVrH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 17:47:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE1BB79106;
        Fri, 11 Sep 2020 17:47:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mFgwMD44AFTEWNfDb3WMCgjKCNA=; b=Sp5CWi
        lYBe95RpWkJ+y/7uQWZONt8XJq1kQB8kVhK3o9W5fK4ou/Y7clGpuyS4IondLIkb
        NHWUmo1HAmxMy18yY+jFbOrPWnzqC2394+Of7Z2k8kq+HlHZpXL9n8/T/JRbcAhY
        Qa4NkxVgeYRjjeZcAMt2t6xOqnLU8/ZRhBgiY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fqO+cre6YkHQs8Yol4iEkfZFyvaWrOOL
        OtB4kdtViSsmLtvDngnmrmrYt+yjj6FjwWEK9xRHIl28mTjbefZp/I4A6CeWbow7
        Fg37pXQebBwZifdcDSszD0VxmYtB29DLupGGaxX5/kHHWlgoOrkj/Zl8z/TdIhSr
        7Vas571Kkd4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B567C79105;
        Fri, 11 Sep 2020 17:47:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4CDE79102;
        Fri, 11 Sep 2020 17:47:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ref-filter: allow merged and no-merged filters
References: <20200908153759.36504-1-alipman88@gmail.com>
        <20200911185754.64173-1-alipman88@gmail.com>
        <20200911185754.64173-3-alipman88@gmail.com>
Date:   Fri, 11 Sep 2020 14:47:00 -0700
In-Reply-To: <20200911185754.64173-3-alipman88@gmail.com> (Aaron Lipman's
        message of "Fri, 11 Sep 2020 14:57:54 -0400")
Message-ID: <xmqqlfhgm1ez.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52CC8B06-F478-11EA-B442-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> If passed more than one merged (or more than one no-merged) filter, refs
> must be reachable from any one of the merged commits, and reachable from
> none of the no-merged commits.

This mirrors how the "contains" behaves, which is good.

>  Documentation/git-branch.txt       |  6 +--
>  Documentation/git-for-each-ref.txt |  6 +--
>  Documentation/git-tag.txt          |  4 +-

It is a bit sad that this only removes from documentation without
adding (the removal is because merged and no-merged are no longer
mutually exclusive).  There should be a new description on how it
behaves when both of them are given---the combination were impossible
so it was sufficient to say "they are incompatible", but now the user
needs to know how they interact with each other.

Perhaps --contains side can already be combined so they have
description we can borrow here?  I didn't look too carefully.

> diff --git a/ref-filter.c b/ref-filter.c
> index 110bcd741a..c04dca47d1 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2231,11 +2231,17 @@ void ref_array_clear(struct ref_array *array)
>  	}
>  }
>  
> -static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
> +static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata, int reachable)
>  {
> +	struct commit_list *check_reachable_list = reachable ?
> +		ref_cbdata->filter->reachable_from :
> +		ref_cbdata->filter->unreachable_from;
> +
> +	if (!check_reachable_list)
> +		return;
> +

We do not allow decl-after-statement.

>  	struct rev_info revs;
>  	int i, old_nr;
> -	struct ref_filter *filter = ref_cbdata->filter;
>  	struct ref_array *array = ref_cbdata->array;
>  	struct commit **to_clear = xcalloc(sizeof(struct commit *), array->nr);
>  
> @@ -2247,12 +2253,15 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>  		to_clear[i] = item->commit;
>  	}
>  
> -	filter->merge_commit->object.flags |= UNINTERESTING;
> -	add_pending_object(&revs, &filter->merge_commit->object, "");
> +	for (struct commit_list *rl = check_reachable_list; rl; rl = rl->next) {
> +		struct commit *merge_commit = rl->item;
> +		merge_commit->object.flags |= UNINTERESTING;
> +		add_pending_object(&revs, &merge_commit->object, "");
> -	revs.limited = 1;
> -	if (prepare_revision_walk(&revs))
> -		die(_("revision walk setup failed"));
> +		revs.limited = 1;
> +		if (prepare_revision_walk(&revs))
> +			die(_("revision walk setup failed"));
> +	}

This looks wrong.  I would have expected, instead of placing the
single object to the pending queue, the loop places all the filter
objects in a queue, and then makes a limited revision walk just
once.  In general, each time after the code makes a call to
prepare_revision_walk() to perform a revision walk, before doing so
again, the object flags used for the walking must be cleared.  You
can tell that the original code structure follows the pattern.
Calling it inside a loop breaks the pattern a big time.

In any case, we mark the named commits as UNINTERESTING and walk
from them and the tips of (surviving) refs to see which refs are
reachable from _any_ of the named commits.  The original code is a
degenerated case of having only one named commit.

The idea of the original is when checking for "--merged", any ref
whose tip is reachable from the named commit is merged and should be
shown.  That extends naturally to multiple commits given to
"--merged"; any ref whose tip is reachable from one of the named
commits is selected.

For "--no-merged", any ref whose tip is reachable from the named
commit is merged and should be excluded.  That also extends to
multiple commits.  Any ref whose tip is reachable from one of the
"--no-merged" commit is rejected.

> @@ -2263,14 +2272,19 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>  
>  		int is_merged = !!(commit->object.flags & UNINTERESTING);
>  
> -		if (is_merged == (filter->merge == REF_FILTER_MERGED_INCLUDE))
> +		if (is_merged == reachable)
>  			array->items[array->nr++] = array->items[i];
>  		else
>  			free_array_item(item);

So, in the original code, if the tip of the ref is reachable from
the given commit (i.e. painted UNINTERESTING), we keep it in the
array when looking for "--merged".  That corresponds to the case 
where reachable is true.  Similarly for the --no-merged case.

So the overall logic seems sound.  It's just the callsite of
prepare_revision_walk() which does the actual painting of the graph
looks wrong.

> @@ -2541,31 +2555,22 @@ int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset)
>  {
>  	struct ref_filter *rf = opt->value;
>  	struct object_id oid;
> -	int no_merged = starts_with(opt->long_name, "no");
>  
>  	BUG_ON_OPT_NEG(unset);
>  
> -	if (rf->merge) {
> -		if (no_merged) {
> -			return error(_("option `%s' is incompatible with --merged"),
> -				     opt->long_name);
> -		} else {
> -			return error(_("option `%s' is incompatible with --no-merged"),
> -				     opt->long_name);
> -		}
> -	}
> -
> -	rf->merge = no_merged
> -		? REF_FILTER_MERGED_OMIT
> -		: REF_FILTER_MERGED_INCLUDE;
> -
>  	if (get_oid(arg, &oid))
>  		die(_("malformed object name %s"), arg);
>  
> -	rf->merge_commit = lookup_commit_reference_gently(the_repository,
> -							  &oid, 0);
> -	if (!rf->merge_commit)
> +	struct commit *merge_commit = lookup_commit_reference_gently(the_repository,
> +								     &oid, 0);

decl-after-statement here, too.

> +	if (!merge_commit)
>  		return error(_("option `%s' must point to a commit"), opt->long_name);
>  
> +	if (starts_with(opt->long_name, "no"))
> +		commit_list_insert(merge_commit, &rf->unreachable_from);
> +	else
> +		commit_list_insert(merge_commit, &rf->reachable_from);
> +
>  	return 0;
>  }

Thanks.
