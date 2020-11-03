Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8D7C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E2021D40
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 11:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8v9dS7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgKCLrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 06:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgKCLrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 06:47:25 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2811C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 03:47:24 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 133so13960913pfx.11
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P8uvWbpfAPq9/UubcvlaNfIk6UKDzKs0RwWd+9SH9B8=;
        b=Z8v9dS7hZwht8+P8UOYnspBASqPJ4tFaQ6+CYjmho6oMIlsid8ZJGOkFlOkCWODWZg
         HguQ5Fs92V0NpOhGVu1O/OZDjKrHbUg+9cTvtp8Pzqqs/oB2Fdv876V+Eg3sck4uqKlC
         YRKmIZLP28AOeg5aSs0JGHkpo/k5Vpsn2OR1q2UkebFBTRrV2SxmdTzn0PfVhrzKdzxc
         1zs33evAeaWO0ZepZsNMHT+pfkfoRV7hgz9E1YH5L4rqjCYqsn3Wn2B/ztPvt8bFJFGb
         T/nH+odnx0M4HVYqsQ+owXH1Vhyhp6tINOSvCGM3G+y2F3XH4M2f4T89rKqA3qHN0pd/
         g8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=P8uvWbpfAPq9/UubcvlaNfIk6UKDzKs0RwWd+9SH9B8=;
        b=mYvFXvc5I/BKiHIrRwXehTx7FHM9aLaZaVURqzj5trmJ27RbS0dOpLNvSPfVIxiOog
         fF2Ct9tq/xmAFl5Uo+nz90dM21qBUgpsRpx5UXXKzbvdxJHpzQ9SOvOa2Vy+ohkpYWuY
         Rs+TZWLBwbn3bqHlLVtdT50/FfWboy+d7knev4hPdSHwFIqwDlDEGB8AkPUxucaMwEAq
         cWBztuAqktIGt607HG8suh98ZA+PY+OEfetJHyXwFJCsEY1dND4XtN1caZ9b7SIYASzS
         DRq6k7eLVxo9sQkqF897V/+nsNUX3xY+mkj7+LedxnMcW0k13i6AXBEhwjOSwUJMMYdB
         fhng==
X-Gm-Message-State: AOAM530sIuZ87kshp7Q0HX98B/5Z2ZTyzweUz5p8prDAssMevdSjY5Xl
        hPEaQWcp72OrTfoJSVu8UEQ=
X-Google-Smtp-Source: ABdhPJxll46esEMrykf6cLzkxsfnNr4uFKtVP2MD7gEh+O3TtXISI+ITRIK7n0myzhnJZjR+8neCRw==
X-Received: by 2002:a63:ea0f:: with SMTP id c15mr16813392pgi.367.1604404044275;
        Tue, 03 Nov 2020 03:47:24 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:389:7e6:261e:fdbc:f280:46bb])
        by smtp.gmail.com with ESMTPSA id 15sm16788067pfj.179.2020.11.03.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 03:47:23 -0800 (PST)
Date:   Tue, 3 Nov 2020 17:14:32 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v4 06/10] commit-graph: implement corrected commit date
Message-ID: <20201103114432.GA3577@Abhishek-Arch>
Reply-To: 85r1pjzejg.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
 <85r1pjzejg.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85r1pjzejg.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 27, 2020 at 07:53:23PM +0100, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ...
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> Somewhere in the commit message we should also describe that this commit
> changes how commit-graph is verified: from checking that the generation
> number agrees with _topological level definition_, that is that for a
> given commit it is 1 more than maximum of its parents (with the caveat
> that we need to handle GENERATION_NUMBER_V1_MAX values correctly), to
> checking that slightly weaker condition fulfilled by both topological
> levels (generation number v1) and by corrected commit date (generation
> number v2) that for a given commit its generation number is 1 more than
> maximum of its parents or larger.

Sure, that makes sense. Will add.

> 
> But, as far as I understand it, current code does not handle correctly
> GENERATION_NUMBER_V1_MAX case (if we use generation number v1).
> 
> On the other hand we could have simpy use functional check, that
> generation number used (which can be v1 or v2, or any similar other)
> fulfills the reachability condition for each edge, which can be
> simplified to checking that generation(parents) <= generation(commit).
> If the reachability condition is true for each edge, then it is true for
> each path, and for each commit.
> 
> > ---
> >  commit-graph.c | 43 +++++++++++++++++++++++--------------------
> >  1 file changed, 23 insertions(+), 20 deletions(-)
> >
> > diff --git a/commit-graph.c b/commit-graph.c
> > index cedd311024..03948adfce 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -154,11 +154,6 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	else if (generation_a > generation_b)
> >  		return 1;
> >  
> > -	/* use date as a heuristic when generations are equal */
> > -	if (a->date < b->date)
> > -		return -1;
> > -	else if (a->date > b->date)
> > -		return 1;
> 
> Why this change?  It is not described in the commit message.
> 
> Note that while this tie-breaking fallback doesn't make much sense for
> corrected committer date generation number v2, this tie-breaking helps
> if we have to use topological levels (generation number v2).
> 

Right, I should have mentioned this change (and it's not something that
makes a difference either way).

We call commit_gen_cmp() only when we are sorting commits by generation
to speed up computation of Bloom filters i.e. while writing a commit
graph (either split commit-graph or a simple commit-graph).

Since we are always computing and storing corrected commit date when we
are writing (whether we write a GDAT chunk or not), using date as
heuristic is longer required.

> >  	return 0;
> >  }
> >  
> > @@ -1357,10 +1352,14 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> >  		timestamp_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> 
> Sidenote: I haven't noticed it earlier, but here 'uint32_t' might be
> enough; no need for 'timestamp_t' for 'level' variable.
> 
> > +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
> >

We need the 'timestamp_t' as we are comparing level with the now 64-bits
GENERATION_NUMBER_INFINITY. I thought uint32_t would be promoted to
timestamp_t. I have a hunch that since we are explicitly using a fixed
width data type, compiler is unwilling to type coerce into broader data
types.

Advice on this appreciated.

> 
> All right, we compute both generation numbers: topological levels and
> corrected commit date.
> 
> I guess we use 'corrected_commit_date' instead of simply 'generation' to
> make it asier to remember which is which.
> 
> >  		display_progress(ctx->progress, i + 1);
> >  		if (level != GENERATION_NUMBER_INFINITY &&
> > -		    level != GENERATION_NUMBER_ZERO)
> > +		    level != GENERATION_NUMBER_ZERO &&
> > +		    corrected_commit_date != GENERATION_NUMBER_INFINITY &&
> > +		    corrected_commit_date != GENERATION_NUMBER_ZERO
> 
> Straightforward addition.
> 
> > +		    )
> 
> Why this closing parenthesis is now in separated line?
> 
> >  			continue;
> >  
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1369,17 +1368,25 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			struct commit_list *parent;
> >  			int all_parents_computed = 1;
> >  			uint32_t max_level = 0;
> > +			timestamp_t max_corrected_commit_date = 0;
> 
> All right, straightforward addition.
> 
> >  
> >  			for (parent = current->parents; parent; parent = parent->next) {
> >  				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> > -
> 
> Why we have removed this empty line?
> 
> > +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
> 
> All right.
> 
> >  				if (level == GENERATION_NUMBER_INFINITY ||
> > -				    level == GENERATION_NUMBER_ZERO) {
> > +				    level == GENERATION_NUMBER_ZERO ||
> > +				    corrected_commit_date == GENERATION_NUMBER_INFINITY ||
> > +				    corrected_commit_date == GENERATION_NUMBER_ZERO
> > +				    ) {
> 
> All right, same as above.
> 
> >  					all_parents_computed = 0;
> >  					commit_list_insert(parent->item, &list);
> >  					break;
> > -				} else if (level > max_level) {
> > -					max_level = level;
> > +				} else {
> > +					if (level > max_level)
> > +						max_level = level;
> > +
> > +					if (corrected_commit_date > max_corrected_commit_date)
> > +						max_corrected_commit_date = corrected_commit_date;
> >  				}
> 
> All right, reasonable and straightforward.
> 
> >  			}
> >  
> > @@ -1389,6 +1396,10 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  				if (max_level > GENERATION_NUMBER_V1_MAX - 1)
> >  					max_level = GENERATION_NUMBER_V1_MAX - 1;
> >  				*topo_level_slab_at(ctx->topo_levels, current) = max_level + 1;
> > +
> > +				if (current->date && current->date > max_corrected_commit_date)
> > +					max_corrected_commit_date = current->date - 1;
> > +				commit_graph_data_at(current)->generation = max_corrected_commit_date + 1;
> 
> All right.
> 
> Here we use the same trick as in previous commit (and as above) to avoid
> any possible overflow, to minimize number of conditionals.  The fact
> that max_corrected_commit_date might store incorrect value doesn't
> matter, as it is reset at beginning of this loop.
> 
> >  			}
> >  		}
> >  	}
> > @@ -2485,17 +2496,9 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
> >  		if (generation_zero == GENERATION_ZERO_EXISTS)
> >  			continue;
> >  
> > -		/*
> > -		 * If one of our parents has generation GENERATION_NUMBER_V1_MAX, then
> > -		 * our generation is also GENERATION_NUMBER_V1_MAX. Decrement to avoid
> > -		 * extra logic in the following condition.
> > -		 */
> > -		if (max_generation == GENERATION_NUMBER_V1_MAX)
> > -			max_generation--;
> > -
> 
> Perhaps in the future we should check that both topological levels, and
> also corrected committer date (if it exists) for correctness according
> to their definition.  Then the above removed part would be restored (but
> with s/max_generation/max_level/).
> 
> >  		generation = commit_graph_generation(graph_commit);
> > -		if (generation != max_generation + 1)
> > -			graph_report(_("commit-graph generation for commit %s is %u != %u"),
> > +		if (generation < max_generation + 1)
> > +			graph_report(_("commit-graph generation for commit %s is %"PRItime" < %"PRItime),
> 
> All right, so we relaxed the check so that it will be fulfilled by
> generation number v2 (and also by generation number v1, as it implies
> the more strict check for v1).
> 
> What would happen however if generation holds topological levels, and it
> is GENERATION_NUMBER_V1_MAX for at least one parent, which means it is
> GENERATION_NUMBER_V1_MAX for a commit?  As you can check, the condition
> would be true: GENERATION_NUMBER_V1_MAX < GENERATION_NUMBER_V1_MAX + 1,
> so the `git commit-graph verify` would incorrectly say that there is
> a problem with generation number, while there isn't one (false positive
> detection of error).

Alright, so the above block still makes sense if we are working with
topological levels but not with corrected commit dates. Instead of
removing it, I will modify the condition to check that one of our parents
has GENERATION_NUMBER_V1_MAX and the graph uses topological levels.

Suprised that no test breaks by this change.

I have also moved changes in the verify function to the next patch, as
we cannot write or read corrected commit dates yet - so little sense in
modifying verify.

> 
> Sidenote: I think we don't have to worry about having to introduce
> GENERATION_NUMBER_V2_MAX, as the in-memory size (of reconstructed from
> disck representation) corrected commiter date is the same as of commiter
> date itself, plus some, and I don't see us coming close to 64-bit limit
> of timestamp_t for commit dates.
> 
> >  				     oid_to_hex(&cur_oid),
> >  				     generation,
> >  				     max_generation + 1);
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
