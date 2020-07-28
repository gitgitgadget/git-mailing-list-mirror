Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9DC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBCF2074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="E3ocQ5Ij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgG1QXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgG1QXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:23:19 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4183C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:23:18 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c12so6245741qtn.9
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hi8xqih1OvSQ2Zpzw6ndXuCEFBhR/Ys8kvrT9zxNk18=;
        b=E3ocQ5IjEF4pxXxaRSphIdCV8UaY1y9Fs+dfspeLE1o9s4/gWZzdAu4dhLl+ULIrxk
         JnQ1sPStIsW+pfNKGtFDr7tobqFZn5acNIzetrAjJVRsTIBLC6gGMhPS2314qG5c5JLc
         MpWXkyEYTTqcxw7P0Dwn6INnl0hbaa2dPUjWmqMyitEdGtJwUEULa2xeMOj2C4EnNJVZ
         zxnqIrP28i92fI475Djbd0MXWPXDJl4gk7zRwn6TQT2sn7Wu8YdMNbh7pDIP8Xplb1m0
         gfNba1rd9aRuM7vouZYuN8wDzmiJzcdnSxhXA47sXaDUAM76vihksYmlOMqpbXPTdbTB
         fnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hi8xqih1OvSQ2Zpzw6ndXuCEFBhR/Ys8kvrT9zxNk18=;
        b=dR1U1168P2HIi8/mwnJRKouOOMF/WbRU+hm9l25lq4RFkKPXTH54ce3HOUOWD5L8/2
         DXFdtB57wy9fX0ZS9Lu8e68UZR/ZSje3aCYd4jjT6x58WTMlcyQcM7CFm4quKeS0zDW4
         e4uQxvVefH4cTTaJd7R4CT4MaoB4wKIQPoItQ5wy46GX3/RAJvuK8g5cNi3ayrDttoB9
         2A4RZeCK9lfQlwY8iD5MRk4AfiwlN4DzQY3Kc8i5Ps25vy+iOuoTjeEoVrRqT3Ihfaq+
         uVTcfUFn8pq/1oCI7BPpCwu0B+H952dt15xOfIAf5PZWILGO+N2U48IxWCUz7ZaGiUTB
         aL9g==
X-Gm-Message-State: AOAM530xZhMJIFnowwJTsuGiVjPRJEGxSoU2xZHV9ip6hGUcL7UAJ2hv
        5VOiZFzXtNwFMyK80XtyUA2kPg==
X-Google-Smtp-Source: ABdhPJz90jIHhoS/G+OZ1JOs/jK49o+Q5FTMZV5QAyhu/Zy4yAFhe7VO+v0ksrvDLct0fr0/r+U8Xw==
X-Received: by 2002:ac8:24cf:: with SMTP id t15mr13746646qtt.270.1595953397826;
        Tue, 28 Jul 2020 09:23:17 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id v184sm24522084qki.12.2020.07.28.09.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 09:23:17 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:23:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 6/6] commit-graph: implement corrected commit date offset
Message-ID: <20200728162315.GG87373@syl.lan>
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <647290d0368e385227614dd1822aa9083b0dba5e.1595927632.git.gitgitgadget@gmail.com>
 <e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e8646aaa-667f-b7d8-f8f2-efbaaeb8877d@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 11:55:12AM -0400, Derrick Stolee wrote:
> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With preparations done,...
>
> I feel like this commit could have been made smaller by doing the
> uint32_t -> timestamp_t conversion in a separate patch. That would
> make it easier to focus on the changes to the generation number v2
> logic.

Yep, agreed.

> > let's implement corrected commit date offset.
> > We add a new commit-slab to store topological levels while writing
>
> It's important to add: we store topological levels to ensure that older
> versions of Git will still have the performance benefits from generation
> number v1.
>
> > commit graph and upgrade number of struct commit_graph_data to 64-bits.
>
> Do you mean "update the generation member in struct commit_graph_data
> to a 64-bit timestamp"? The struct itself also has the 32-bit graph_pos
> member.
>
> > We have to touch many files, upgrading generation number from uint32_t
> > to timestamp_t.
>
> Yes, that's why I recommend doing that in a different step.
>
> > We drop 'detect incorrect generation number' from t5318-commit-graph.sh,
> > which tests if verify can detect if a commit graph have
> > GENERATION_NUMBER_ZERO for a commit, followed by a non-zero generation.
> > With corrected commit dates, GENERATION_NUMBER_ZERO is possible only if
> > one of dates is Unix epoch zero.
>
> What about the topological levels? Are we caring about verifying the data
> that we start to ignore in this new version? I'm hesitant to drop this
> right now, but I'm open to it if we really don't see it as a valuable test.
>
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  blame.c                 |   2 +-
> >  commit-graph.c          | 109 ++++++++++++++++++++++------------------
> >  commit-graph.h          |   4 +-
> >  commit-reach.c          |  32 ++++++------
> >  commit-reach.h          |   2 +-
> >  commit.h                |   3 ++
> >  revision.c              |  14 +++---
> >  t/t5318-commit-graph.sh |   2 +-
> >  upload-pack.c           |   2 +-
> >  9 files changed, 93 insertions(+), 77 deletions(-)
> >
> > diff --git a/blame.c b/blame.c
> > index 82fa16d658..48aa632461 100644
> > --- a/blame.c
> > +++ b/blame.c
> > @@ -1272,7 +1272,7 @@ static int maybe_changed_path(struct repository *r,
> >  	if (!bd)
> >  		return 1;
> >
> > -	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_INFINITY)
> > +	if (commit_graph_generation(origin->commit) == GENERATION_NUMBER_V2_INFINITY)
> >  		return 1;
>
> I don't see value in changing the name of this macro. It
> is only used as the default value for a commit not in the
> commit-graph. Changing its value to 0xFFFFFFFF works for
> both versions when the type is updated to timestamp_t.
>
> The actually-important change in this patch (not just the
> type change) is here:
>
> > -static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> > +static void compute_corrected_commit_date_offsets(struct write_commit_graph_context *ctx)
> >  {
> >  	int i;
> >  	struct commit_list *list = NULL;
> > @@ -1326,11 +1334,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					_("Computing commit graph generation numbers"),
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> > -		uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
> > +		uint32_t topo_level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> >
> >  		display_progress(ctx->progress, i + 1);
> > -		if (generation != GENERATION_NUMBER_INFINITY &&
> > -		    generation != GENERATION_NUMBER_ZERO)
> > +		if (topo_level != GENERATION_NUMBER_INFINITY &&
> > +		    topo_level != GENERATION_NUMBER_ZERO)
> >  			continue;
>
> Here, our "skip" condition is that the topo_level has been computed.
> This should be fine, as we are never reading that out of the commit-graph.
> We will never be in a mode where topo_level is computed but corrected
> commit-date is not.
>
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1338,29 +1346,38 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			struct commit *current = list->item;
> >  			struct commit_list *parent;
> >  			int all_parents_computed = 1;
> > -			uint32_t max_generation = 0;
> > +			uint32_t max_level = 0;
> > +			timestamp_t max_corrected_commit_date = current->date;
>
> Later you assign data->generation to be "max_corrected_commit_date + 1",
> which made me think this should be "current->date - 1". Is that so? Or,
> do we want most offsets to be one instead of zero? Is there value there?
>
> >
> >  			for (parent = current->parents; parent; parent = parent->next) {
> > -				generation = commit_graph_data_at(parent->item)->generation;
> > +				topo_level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> >
> > -				if (generation == GENERATION_NUMBER_INFINITY ||
> > -				    generation == GENERATION_NUMBER_ZERO) {
> > +				if (topo_level == GENERATION_NUMBER_INFINITY ||
> > +				    topo_level == GENERATION_NUMBER_ZERO) {
> >  					all_parents_computed = 0;
> >  					commit_list_insert(parent->item, &list);
> >  					break;
> > -				} else if (generation > max_generation) {
> > -					max_generation = generation;
> > +				} else {
> > +					struct commit_graph_data *data = commit_graph_data_at(parent->item);
> > +
> > +					if (topo_level > max_level)
> > +						max_level = topo_level;
> > +
> > +					if (data->generation > max_corrected_commit_date)
> > +						max_corrected_commit_date = data->generation;
> >  				}
> >  			}
> >
> >  			if (all_parents_computed) {
> >  				struct commit_graph_data *data = commit_graph_data_at(current);
> >
> > -				data->generation = max_generation + 1;
> > -				pop_commit(&list);
> > +				if (max_level > GENERATION_NUMBER_MAX - 1)
> > +					max_level = GENERATION_NUMBER_MAX - 1;
> > +
> > +				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> > +				data->generation = max_corrected_commit_date + 1;
> >
> > -				if (data->generation > GENERATION_NUMBER_MAX)
> > -					data->generation = GENERATION_NUMBER_MAX;
> > +				pop_commit(&list);
> >  			}
> >  		}
> >  	}
>
> This looks correct, and I've done a tiny bit of perf tests locally.
>
> > @@ -2085,6 +2102,7 @@ int write_commit_graph(struct object_directory *odb,
> >  	uint32_t i, count_distinct = 0;
> >  	int res = 0;
> >  	int replace = 0;
> > +	struct topo_level_slab topo_levels;
> >
> >  	if (!commit_graph_compatible(the_repository))
> >  		return 0;
> > @@ -2099,6 +2117,9 @@ int write_commit_graph(struct object_directory *odb,
> >  	ctx->changed_paths = flags & COMMIT_GRAPH_WRITE_BLOOM_FILTERS ? 1 : 0;
> >  	ctx->total_bloom_filter_data_size = 0;
> >
> > +	init_topo_level_slab(&topo_levels);
> > +	ctx->topo_levels = &topo_levels;
> > +
> >  	if (ctx->split) {
> >  		struct commit_graph *g;
> >  		prepare_commit_graph(ctx->r);
> > @@ -2197,7 +2218,7 @@ int write_commit_graph(struct object_directory *odb,
> >  	} else
> >  		ctx->num_commit_graphs_after = 1;
> >
> > -	compute_generation_numbers(ctx);
> > +	compute_corrected_commit_date_offsets(ctx);
>
> This rename might not be necessary. You are computing both
> versions (v1 and v2) so the name change is actually less
> accurate than the old name.
>
> Thanks,
> -Stolee

I don't have anything to add that Stolee hasn't already pointed out.
Thanks for your work on this series, and I'm looking forward to another
reroll.

Thanks,
Taylor
