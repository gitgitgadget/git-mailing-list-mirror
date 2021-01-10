Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3D4C433E0
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C9DB20735
	for <git@archiver.kernel.org>; Sun, 10 Jan 2021 12:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbhAJMV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jan 2021 07:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbhAJMVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jan 2021 07:21:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82778C061786
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 04:20:45 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id t6so8059922plq.1
        for <git@vger.kernel.org>; Sun, 10 Jan 2021 04:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=MGf1yyv3xFRhXu2fhqGFbupew86SsA6c/QIiXrcp+kg=;
        b=ACW/Htl8relF327/knq7/Cjm+psRFumrIJdUKe/B1DqnoT2DhKl09U0jEWdHUj+UZw
         Vs8Mhftq3Z9uKiSFUPChV9RoM5ZuHLgq26DQrTeonGiZdhbRAgCs0KJtr8iFs1MxzT6v
         QFnx/veEbFDZpkZDxB0plR0jmn01S58y4K0YPd0rEDWwqNyN0wg/0xvkzkMRO4BR9QeZ
         1g7foNo+XCN5/hWxs61mxNwyXlczlbW6VvSzzj0WVRBNr9iMldbby1Qtuml678A+yGVg
         kFUDXkzaE604ClqiXBHbb/r87l/p2TtuU6aC19cePrrdzzYIxtQw+8Q+pmJVTEMF4LC8
         p4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=MGf1yyv3xFRhXu2fhqGFbupew86SsA6c/QIiXrcp+kg=;
        b=um3VUR28CMVIxNGyicbNcFVMPpovMhenTQKCh07ccXD8Krumnmlt7F9k1RLRHF4HnH
         euxltCP9DQu7muyjc5nGE920VKBJLIH/zippjaE/+Zg4xzxqkqGP8mXqWIPQTqERUFJQ
         gT+XbTEzDF23MszPtsPi/k6qxYfwXyk/+ULGonPll4ms1ChFbRcd1qJMHDxtrt+PO4rc
         lMC6I+0kbRKkcDvvXSg5xfeE04CBBqFQlQEX3xzfSPfNOifzC20hAIr9+omf7T4b00pr
         KIohByrQ7YdtaV/sXIZPtfTAAcMRfi+uAUZUZDLLM133gKeqJdE52y8XYupafTEI4Pbk
         NZYA==
X-Gm-Message-State: AOAM5319/7DU8u8TwkuG4ccEiUy5KkLF8+ttnj2WI0FXSkSVp0qcKvhK
        rcc1BPVsZZOCTi6NLVDnAdk=
X-Google-Smtp-Source: ABdhPJxFmnEKSI2SpmQj2aq+/u3iJWKKUx/OCUGcKwXmcmmc8EoGXM+cZJVMp78vNybVz7EkPD3HNQ==
X-Received: by 2002:a17:90a:5303:: with SMTP id x3mr13088859pjh.54.1610281244890;
        Sun, 10 Jan 2021 04:20:44 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:2e96:3919:aaca:74e3:b7c2:671e])
        by smtp.gmail.com with ESMTPSA id y5sm10975415pjt.42.2021.01.10.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 04:20:44 -0800 (PST)
Date:   Sun, 10 Jan 2021 17:51:03 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylor.com
Subject: Re: [PATCH v5 07/11] commit-graph: implement corrected commit date
Message-ID: <X/rxL+ofMI4LNSYw@Abhishek-Arch>
Reply-To: 7a0eaa06-131f-ce2d-a335-b624d64ec7e4@gmail.com
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <859c39eff52e32ad322969d024184971acec82e7.1609154168.git.gitgitgadget@gmail.com>
 <7a0eaa06-131f-ce2d-a335-b624d64ec7e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a0eaa06-131f-ce2d-a335-b624d64ec7e4@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 29, 2020 at 08:53:11PM -0500, Derrick Stolee wrote:
> On 12/28/2020 6:16 AM, Abhishek Kumar via GitGitGadget wrote:
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > 
> > With most of preparations done, let's implement corrected commit date.
> > 
> > The corrected commit date for a commit is defined as:
> > 
> > * A commit with no parents (a root commit) has corrected commit date
> >   equal to its committer date.
> > * A commit with at least one parent has corrected commit date equal to
> >   the maximum of its commit date and one more than the largest corrected
> >   commit date among its parents.
> > 
> > As a special case, a root commit with timestamp of zero (01.01.1970
> > 00:00:00Z) has corrected commit date of one, to be able to distinguish
> > from GENERATION_NUMBER_ZERO (that is, an uncomputed corrected commit
> > date).
> > 
> > To minimize the space required to store corrected commit date, Git
> > stores corrected commit date offsets into the commit-graph file. The
> > corrected commit date offset for a commit is defined as the difference
> > between its corrected commit date and actual commit date.
> > 
> > Storing corrected commit date requires sizeof(timestamp_t) bytes, which
> > in most cases is 64 bits (uintmax_t). However, corrected commit date
> > offsets can be safely stored using only 32-bits. This halves the size
> > of GDAT chunk, which is a reduction of around 6% in the size of
> > commit-graph file.
> > 
> > However, using offsets be problematic if one of commits is malformed but
> 
> However, using 32-bit offsets is problematic if a commit is malformed...
> 
> > valid and has committerdate of 0 Unix time, as the offset would be the
> 
> s/committerdate/committer date/
> 
> > same as corrected commit date and thus require 64-bits to be stored
> > properly.
> > 
> > While Git does not write out offsets at this stage, Git stores the
> > corrected commit dates in member generation of struct commit_graph_data.
> > It will begin writing commit date offsets with the introduction of
> > generation data chunk.
> > 
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 1b2a015f92f..bfc3aae5f93 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -1339,9 +1339,11 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  					ctx->commits.nr);
> >  	for (i = 0; i < ctx->commits.nr; i++) {
> >  		uint32_t level = *topo_level_slab_at(ctx->topo_levels, ctx->commits.list[i]);
> > +		timestamp_t corrected_commit_date = commit_graph_data_at(ctx->commits.list[i])->generation;
> >  
> >  		display_progress(ctx->progress, i + 1);
> > -		if (level != GENERATION_NUMBER_ZERO)
> > +		if (level != GENERATION_NUMBER_ZERO &&
> > +		    corrected_commit_date != GENERATION_NUMBER_ZERO)
> >  			continue;
> >  
> >  		commit_list_insert(ctx->commits.list[i], &list);
> > @@ -1350,16 +1352,23 @@ static void compute_generation_numbers(struct write_commit_graph_context *ctx)
> >  			struct commit_list *parent;
> >  			int all_parents_computed = 1;
> >  			uint32_t max_level = 0;
> > +			timestamp_t max_corrected_commit_date = 0;
> >  
> >  			for (parent = current->parents; parent; parent = parent->next) {
> >  				level = *topo_level_slab_at(ctx->topo_levels, parent->item);
> > +				corrected_commit_date = commit_graph_data_at(parent->item)->generation;
> >  
> > -				if (level == GENERATION_NUMBER_ZERO) {
> > +				if (level == GENERATION_NUMBER_ZERO ||
> > +				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
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
> 
> nit: the "break" in the first case makes it so this large else block
> is unnecessary. 

Thanks, removed.

> 
> -				if (level == GENERATION_NUMBER_ZERO) {
> +				if (level == GENERATION_NUMBER_ZERO ||
> +				    corrected_commit_date == GENERATION_NUMBER_ZERO) {
>  					all_parents_computed = 0;
>  					commit_list_insert(parent->item, &list);
>  					break;
> -				} else if (level > max_level) {
> -					max_level = level;
> +				
> +				if (level > max_level)
> +					max_level = level;
> +
> +				if (corrected_commit_date > max_corrected_commit_date)
> +					max_corrected_commit_date = corrected_commit_date;
> -				}
>  			}
> 
> Thanks,
> -Stolee
> 

Thanks
- Abhishek
