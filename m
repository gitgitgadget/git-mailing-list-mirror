Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3001F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 06:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJLOFB (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 10:05:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53846 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeJLOFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 10:05:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id y11-v6so11154016wma.3
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 23:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AEf8DIfZ9Ob+qpvu4G2n+6mqPcquBVEW4EOaJuz+PHs=;
        b=VoMV7fDbAjrKO3iVpXd0tAn6NypClktHtiRSLvYDbEV3lKXux+HIVN5kN9a88cLvdV
         Hxk0OSXmVIuppdnk87krLL2gdf7ZhuFYDK7XguwtFNrXLmAFoxawKlPPWLZzOVMvOi0r
         hTrW1szbqz2Ufq8gdgcIXi2vQsEv2WbeC6QWIFo0jPv1qcy7y+vAAugwULlpKuxUWChl
         E6h8ga0hsd0DWkD/5dL1BrgBY3gdAKeV9RdCba6dFrP/V9dKrPGNzb1TH4YU9B4fm93L
         xDQftp3zMe3gzZjpBG8+qv7+d581yRyt2XO6VsQJjSmAHFe3erwj8TqUEnpZPX9NjzQt
         UZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AEf8DIfZ9Ob+qpvu4G2n+6mqPcquBVEW4EOaJuz+PHs=;
        b=RmuSJyLtcZyi396w8GdwqVeMCdueoE76bGIotNFCRxkihKc9ce1PQ8Ja4RtmOmT0Ns
         MqP5gDpLQN8G9DuNOqdcYSS9QPSIfh5yAhWvx/kDVDrMP9243bC+hnjNLfRiSiv4AAZy
         h8dI+LxwgdLCpdRTE/5b9L8i7ZAaMMqKESp7yevvXjA3opc6wDjXOh8MVuTEtzuxdFl5
         /tXJX5E9VlBhn1gx5RRHlmSL6KxjIFinOw/T0Bc/tIhFgpoPjismik0nhUu2sZRotfPU
         mhirVrVxf5GwPAUkiMjAgef+W9MBBOVFS912VeZFm8g02zoHv/9t/kWyBFu1U7r58bPK
         5MvQ==
X-Gm-Message-State: ABuFfoj2seuZ7IfzymGHKGMn2Kyf1Z5KoxhFDF6RFdc7aUXb5/s8fI57
        gv61LAVPNGISm4RY4vs9AbM=
X-Google-Smtp-Source: ACcGV62o21aR944RPn5/12IdMGr9Ntpu6WPYq7eMdNefPmoDoSGu0lpGE5ulvLH0AetRAYBYX3Mqtg==
X-Received: by 2002:a1c:dc42:: with SMTP id t63-v6mr4116634wmg.17.1539326042331;
        Thu, 11 Oct 2018 23:34:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p1-v6sm152323wrs.40.2018.10.11.23.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 23:34:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 4/7] revision.c: begin refactoring --topo-order logic
References: <pull.25.v2.git.gitgitgadget@gmail.com>
        <pull.25.v3.git.gitgitgadget@gmail.com>
        <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
Date:   Fri, 12 Oct 2018 15:33:59 +0900
In-Reply-To: <fd1a0ab7cdaa06fd99f86fec51b483238f588296.1537551564.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 21 Sep 2018
        10:39:32 -0700 (PDT)")
Message-ID: <xmqqwoqnbrmw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> * revs->limited implies we run limit_list() to walk the entire
>   reachable set. There are some short-cuts here, such as if we
>   perform a range query like 'git rev-list COMPARE..HEAD' and we
>   can stop limit_list() when all queued commits are uninteresting.
>
> * revs->topo_order implies we run sort_in_topological_order(). See
>   the implementation of that method in commit.c. It implies that
>   the full set of commits to order is in the given commit_list.
>
> These two methods imply that a 'git rev-list --topo-order HEAD'
> command must walk the entire reachable set of commits _twice_ before
> returning a single result.

With or without "--topo-order", running rev-list without any
negative commit means we must dig down to the roots that can be
reached from the positive commits we have.

I am to sure if having to run the "sort" of order N counts as "walk
the entire reachable set once" (in addition to the enumeration that
must be done to prepare that N commits, performed in limit_list()).

> In v2.18.0, the commit-graph file contains zero-valued bytes in the
> positions where the generation number is stored in v2.19.0 and later.
> Thus, we use generation_numbers_enabled() to check if the commit-graph
> is available and has non-zero generation numbers.
>
> When setting revs->limited only because revs->topo_order is true,
> only do so if generation numbers are not available. There is no
> reason to use the new logic as it will behave similarly when all
> generation numbers are INFINITY or ZERO.

> In prepare_revision_walk(), if we have revs->topo_order but not
> revs->limited, then we trigger the new logic. It breaks the logic
> into three pieces, to fit with the existing framework:
>
> 1. init_topo_walk() fills a new struct topo_walk_info in the rev_info
>    struct. We use the presence of this struct as a signal to use the
>    new methods during our walk. In this patch, this method simply
>    calls limit_list() and sort_in_topological_order(). In the future,
>    this method will set up a new data structure to perform that logic
>    in-line.
>
> 2. next_topo_commit() provides get_revision_1() with the next topo-
>    ordered commit in the list. Currently, this simply pops the commit
>    from revs->commits.

... because everything is already done in #1 above.  Which makes sense.

> 3. expand_topo_walk() provides get_revision_1() with a way to signal
>    walking beyond the latest commit. Currently, this calls
>    add_parents_to_list() exactly like the old logic.

"latest"?  We dig down the history from newer to older, so at some
point we hit an old commit and need to find the parents to keep
walking towards even older parts of the history.  Did you mean
"earliest" instead?

> While this commit presents method redirection for performing the
> exact same logic as before, it allows the next commit to focus only
> on the new logic.

OK.

> diff --git a/revision.c b/revision.c
> index e18bd530e4..2dcde8a8ac 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -25,6 +25,7 @@
>  #include "worktree.h"
>  #include "argv-array.h"
>  #include "commit-reach.h"
> +#include "commit-graph.h"
>  
>  volatile show_early_output_fn_t show_early_output;
>  
> @@ -2454,7 +2455,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	if (revs->diffopt.objfind)
>  		revs->simplify_history = 0;
>  
> -	if (revs->topo_order)
> +	if (revs->topo_order && !generation_numbers_enabled(the_repository))
>  		revs->limited = 1;

Are we expecting that this is always a bool?  Can there be new
commits for which generation numbers are not computed and stored
while all the old, stable and packed commits have generation
numbers?

> @@ -2892,6 +2893,33 @@ static int mark_uninteresting(const struct object_id *oid,
>  	return 0;
>  }
>  
> +struct topo_walk_info {};
> +
> +static void init_topo_walk(struct rev_info *revs)
> +{
> +	struct topo_walk_info *info;
> +	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
> +	info = revs->topo_walk_info;
> +	memset(info, 0, sizeof(struct topo_walk_info));

There is no member in the struct at this point.  Are we sure this is
safe?  Just being curious.  I know xmalloc() gives us at least one
byte and info won't be NULL.  I just do not know offhand if we have
a guarantee that memset() acts sensibly to fill the first 0 bytes.

> +	limit_list(revs);
> +	sort_in_topological_order(&revs->commits, revs->sort_order);
> +}
> +
> +static struct commit *next_topo_commit(struct rev_info *revs)
> +{
> +	return pop_commit(&revs->commits);
> +}
> +
> +static void expand_topo_walk(struct rev_info *revs, struct commit *commit)
> +{
> +	if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
> +		if (!revs->ignore_missing_links)
> +			die("Failed to traverse parents of commit %s",
> +			    oid_to_hex(&commit->object.oid));
> +	}
> +}
> +
>  int prepare_revision_walk(struct rev_info *revs)
>  {
>  	int i;
> @@ -2928,11 +2956,13 @@ int prepare_revision_walk(struct rev_info *revs)
>  		commit_list_sort_by_date(&revs->commits);
>  	if (revs->no_walk)
>  		return 0;
> -	if (revs->limited)
> +	if (revs->limited) {
>  		if (limit_list(revs) < 0)
>  			return -1;
> -	if (revs->topo_order)
> -		sort_in_topological_order(&revs->commits, revs->sort_order);
> +		if (revs->topo_order)
> +			sort_in_topological_order(&revs->commits, revs->sort_order);
> +	} else if (revs->topo_order)
> +		init_topo_walk(revs);
>  	if (revs->line_level_traverse)
>  		line_log_filter(revs);
>  	if (revs->simplify_merges)

The diff is a bit hard to grok around here, but 

 - when limited *and* topo_order, we do the sort here, as we know we
   already have called limit_list(), i.e. we behave identically as
   the code before this patch in that case.

 - when not limited but topo_order, then we do init_topo_walk();
   currently we do limit_list() and sort_in_topological_order(),
   which means we do the same as above.

As long as limit_list() and sort_in_topological_order() does not
look at revs->limited bit, this patch cannot cause any regression.

> @@ -3257,6 +3287,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  		if (revs->reflog_info)
>  			commit = next_reflog_entry(revs->reflog_info);
> +		else if (revs->topo_walk_info)
> +			commit = next_topo_commit(revs);
>  		else
>  			commit = pop_commit(&revs->commits);

So this get_revision_1() always grabs the commit from next_topo_commit()
when topo-order is in effect.

> @@ -3278,6 +3310,8 @@ static struct commit *get_revision_1(struct rev_info *revs)
>  
>  			if (revs->reflog_info)
>  				try_to_simplify_commit(revs, commit);
> +			else if (revs->topo_walk_info)
> +				expand_topo_walk(revs, commit);
>  			else if (add_parents_to_list(revs, commit, &revs->commits, NULL) < 0) {
>  				if (!revs->ignore_missing_links)
>  					die("Failed to traverse parents of commit %s",

And this add-parents-or-barf is replicated in expand_topo_walk() at
this step, so there is no change in behaviour.

Looks like a cleanly done preparation that is a no-op.

> diff --git a/revision.h b/revision.h
> index 2b30ac270d..fd4154ff75 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -56,6 +56,8 @@ struct rev_cmdline_info {
>  #define REVISION_WALK_NO_WALK_SORTED 1
>  #define REVISION_WALK_NO_WALK_UNSORTED 2
>  
> +struct topo_walk_info;
> +
>  struct rev_info {
>  	/* Starting list */
>  	struct commit_list *commits;
> @@ -245,6 +247,8 @@ struct rev_info {
>  	const char *break_bar;
>  
>  	struct revision_sources *sources;
> +
> +	struct topo_walk_info *topo_walk_info;
>  };
>  
>  int ref_excluded(struct string_list *, const char *path);
