Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EECC433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 06:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF1120842
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 06:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePRqkSA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgG3GJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3GJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 02:09:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC3AC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 23:09:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so15948310pgb.6
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=X+tmPC688Ti/IHnGBUAnrfaslZZZ27Dq0rvduuiYgdw=;
        b=ePRqkSA3/9Q/MO96ue1/7pOJihH8r8m8IEVgblELI7cVY/3opMqNzdLPMPHCFwyntP
         +1ueJAsAlm13I27t3X6tbC5zdhCAOpyi4RLwDRKFavnuNaSxe8Gd1VvlmGtq+2Ne1hul
         9UdEDg0Kgxw4EG2G+cGegQDqVVCBFn9rbWyuHxJvQ/PVwteJpslXVtBvJNxrFzuxfclO
         lnTpWxLevMTYS0LhNPJIUDoYPEVE8pN/x92S2MAPPBCX3jvPI0N/5nZtIkUIr91Xzl3b
         dz8Fb9cyT7eiT1CjiQbSP+tcx6aeY4yOZCgC2F2PZAMPhdXXJsRpqKCoNbjZHz9kdJ9/
         CLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=X+tmPC688Ti/IHnGBUAnrfaslZZZ27Dq0rvduuiYgdw=;
        b=JmkdtA2bhsKCu/P74kGPofod+4J3OomOLpuOgBJruX91NqWhc+9tQD/Lgh69vDLOU4
         XRCwjPkZbgTSl9g4NosBSAh453qnSoIdgugQo7ZLiYsGOKigwmd6ywUk8TCP+GQqh8JF
         th2ahXbAjVsba/aqF7K72BMOyLowHVFQgDesvV7UC25m1ourNrJrq9EkySuJ3i9jeZrL
         mIjthonsiVyWLI2D4w3WFzLI6Bw4UD57E9ml5gqj9waqOEF0hzno5vUmRkhv8WRI1m6O
         07VxGGO5JnsICvkl4yCwlGxXadJm+IutgVGVBA6UJebQEnGgLdwXnWF2X6wwT+8vT9iL
         Fgtw==
X-Gm-Message-State: AOAM533vheYD6algwuPCHZR3kJU2hSpKffUpYznId1DpV1CdQPp0SyC5
        RKPbt245E8AHvW06ooHFjDg=
X-Google-Smtp-Source: ABdhPJzOUcAG2ClOZjWZYkPTGRNQktLSA3GTJLde2lj0ZljcUmUwyKTFYS/Idd18z9UZR3r5TZ9cyg==
X-Received: by 2002:a62:834c:: with SMTP id h73mr1726885pfe.221.1596089373840;
        Wed, 29 Jul 2020 23:09:33 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:208c:7cf0:d18:2f72:fb83:4831])
        by smtp.gmail.com with ESMTPSA id a13sm4769037pfn.171.2020.07.29.23.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 23:09:33 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:37:32 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH 3/6] commit-graph: consolidate fill_commit_graph_info
Message-ID: <20200730060732.GB50429@Abhishek-Arch>
Reply-To: a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
 <701f5912369c0fcc07cf604c3129cb5017a125ce.1595927632.git.gitgitgadget@gmail.com>
 <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d50995-566d-cad2-ff67-8b8604b52eed@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 28, 2020 at 09:14:42AM -0400, Derrick Stolee wrote:
> On 7/28/2020 5:13 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > 
> > Both fill_commit_graph_info() and fill_commit_in_graph() parse
> > information present in commit data chunk. Let's simplify the
> > implementation by calling fill_commit_graph_info() within
> > fill_commit_in_graph().
> > 
> > The test 'generate tar with future mtime' creates a commit with commit
> > time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
> > generation number and has undefined behavior. The test used to pass as
> > fill_commit_in_graph() did not read commit time from commit graph,
> > reading commit date from odb instead.
> 
> I was first confused as to why fill_commit_graph_info() did not
> load the timestamp, but the reason is that it is only used by
> two methods:
> 
> 1. fill_commit_in_graph(): this actually leaves the commit in a
>    "parsed" state, so the date must be correct. Thus, it parses
>    the date out of the commit-graph.
> 
> 2. load_commit_graph_info(): this only helps to guarantee we
>    know the graph_pos and generation number values.
> 
> Perhaps add this extra context: you will _need_ the commit date
> from the commit-graph in order to populate the generation number
> v2 in fill_commit_graph_info().

Thanks, that makes sense. I have revised the commit message to:

commit-graph: consolidate fill_commit_graph_info
    
    Both fill_commit_graph_info() and fill_commit_in_graph() parse
    information present in commit data chunk. Let's simplify the
    implementation by calling fill_commit_graph_info() within
    fill_commit_in_graph().
    
    The test 'generate tar with future mtime' creates a commit with commit
    time of (2 ^ 36 + 1) seconds since EPOCH. The commit time overflows into
    generation number (within CDAT chunk) and has undefined behavior.
    
    The test used to pass as fill_commit_in_graph() guarantees the values of
    graph position and generation number, and did not load timestamp.
    However, with corrected commit date we will need load the timestamp as
    well to populate the generation number.
> 
> > Let's fix that by setting commit time of (2 ^ 34 - 1) seconds.
> 
> The timestamp limit placed in the commit-graph is more restrictive
> than 64-bit timestamps, but as your test points out, the maximum
> timestamp allowed takes place in the year 2514. That is far enough
> away for all real data.
> 
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c      | 31 ++++++++++++-------------------
> >  t/t5000-tar-tree.sh |  4 ++--
> >  2 files changed, 14 insertions(+), 21 deletions(-)
> > 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 5d3c9bd23c..204eb454b2 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -735,15 +735,24 @@ static void fill_commit_graph_info(struct commit *item, struct commit_graph *g,
> >  	const unsigned char *commit_data;
> >  	struct commit_graph_data *graph_data;
> >  	uint32_t lex_index;
> > +	uint64_t date_high, date_low;
> >  
> >  	while (pos < g->num_commits_in_base)
> >  		g = g->base_graph;
> >  
> > +	if (pos >= g->num_commits + g->num_commits_in_base)
> > +		die(_("invalid commit position. commit-graph is likely corrupt"));
> > +
> >  	lex_index = pos - g->num_commits_in_base;
> >  	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
> >  
> >  	graph_data = commit_graph_data_at(item);
> >  	graph_data->graph_pos = pos;
> > +
> > +	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> > +	date_low = get_be32(commit_data + g->hash_len + 12);
> > +	item->date = (timestamp_t)((date_high << 32) | date_low);
> > +
> >  	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> >  }
> >  
> > @@ -758,38 +767,22 @@ static int fill_commit_in_graph(struct repository *r,
> >  {
> >  	uint32_t edge_value;
> >  	uint32_t *parent_data_ptr;
> > -	uint64_t date_low, date_high;
> >  	struct commit_list **pptr;
> > -	struct commit_graph_data *graph_data;
> >  	const unsigned char *commit_data;
> >  	uint32_t lex_index;
> >  
> > +	fill_commit_graph_info(item, g, pos);
> > +
> >  	while (pos < g->num_commits_in_base)
> >  		g = g->base_graph;
> 
> This 'while' loop happens in both implementations, so you could
> save a miniscule amount of time by placing the call to
> fill_commit_graph_info() after the while loop.
> 
> > -	if (pos >= g->num_commits + g->num_commits_in_base)
> > -		die(_("invalid commit position. commit-graph is likely corrupt"));
> 
> > -	/*
> > -	 * Store the "full" position, but then use the
> > -	 * "local" position for the rest of the calculation.
> > -	 */
> > -	graph_data = commit_graph_data_at(item);
> > -	graph_data->graph_pos = pos;
> >  	lex_index = pos - g->num_commits_in_base;
> > -
> > -	commit_data = g->chunk_commit_data + (g->hash_len + 16) * lex_index;
> > +	commit_data = g->chunk_commit_data + GRAPH_DATA_WIDTH * lex_index;
> 
> I was about to complain about this change, but GRAPH_DATA_WIDTH
> is a macro that does an equivalent thing (except the_hash_algo->rawsz
> instead of g->hash_len).
> 
> >  
> >  	item->object.parsed = 1;
> >  
> >  	set_commit_tree(item, NULL);
> >  
> > -	date_high = get_be32(commit_data + g->hash_len + 8) & 0x3;
> > -	date_low = get_be32(commit_data + g->hash_len + 12);
> > -	item->date = (timestamp_t)((date_high << 32) | date_low);
> > -
> > -	graph_data->generation = get_be32(commit_data + g->hash_len + 8) >> 2;
> > -
> >  	pptr = &item->parents;
> >  
> >  	edge_value = get_be32(commit_data + g->hash_len);
> > diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
> > index 37655a237c..1986354fc3 100755
> > --- a/t/t5000-tar-tree.sh
> > +++ b/t/t5000-tar-tree.sh
> > @@ -406,7 +406,7 @@ test_expect_success TIME_IS_64BIT 'set up repository with far-future commit' '
> >  	rm -f .git/index &&
> >  	echo content >file &&
> >  	git add file &&
> > -	GIT_COMMITTER_DATE="@68719476737 +0000" \
> > +	GIT_COMMITTER_DATE="@17179869183 +0000" \
> >  		git commit -m "tempori parendum"
> >  '
> >  
> > @@ -415,7 +415,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
> >  '
> >  
> >  test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
> > -	echo 4147 >expect &&
> > +	echo 2514 >expect &&
> >  	tar_info future.tar | cut -d" " -f2 >actual &&
> >  	test_cmp expect actual
> >  '
> > 
> 
> Thanks,
> -Stolee
