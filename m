Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D6C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 10:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656D3222BA
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/EU+8lW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKTKcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgKTKcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 05:32:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FF5C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 02:32:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w14so7452083pfd.7
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wB0wgRs8LVAvAxwVRHHv4D/89ckVOftT9wEqvDTgY9E=;
        b=g/EU+8lWTzTE/lkQaV4U/CTbjEFowctYtT49oywpkmuqPlB8xSH5jFCLvLCvE+05+J
         O9L/46txWD/SF1mmTqLs3kELaQXoYq/heWIh6mB1zoZVGwiMaeGXz8Lk5qy51BMzu49v
         TY1FeA9xc6jgHd47o5W96JctZHLkajMzmndvh8XDSiwwVj0PH96E1tOE68VtPI7nwLHK
         JkfBTp5jD+8GWeVz/svI3U3WXtVo9w7x2gOzsylX+oB9oZXho8YhM3Hj15OG3+C4wlhR
         SJ9soV/PS59vjSxg24aEC/ySvWlUi+9/TNvKO9NihdLA6stKolfTutZ5BhgH1CMzvJEB
         S6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=wB0wgRs8LVAvAxwVRHHv4D/89ckVOftT9wEqvDTgY9E=;
        b=qlYOz/cuvgEp4IOi2iXR57pGCG3d1ounCtgYerl4zOPHx1uv/svsi6ftVFNpIAhaIG
         PwjI5ThVs34RA1AVgcUJrA9oa7oOmShzZ2e1+tZxXbZZUYcYSFikzbMibn+bSOI7ZWH7
         D+8wS6tBZfC3T6RWxr6Op+5FiejoqVUg8vDr4c+pYZOabjCJJKgM8Zw3+A59z+vxbAiK
         hinqsoo1aKtJjuNinbupiMFU2RQCZd4b4y7tTp/acY72nsiXEdDEydLYBSTtPoKrvN0p
         pcivIYcvBflRWGenQXoWH5A/Hko/LCHQKYEGoEt6Wf7pNyOb3Ftog4RNCrDbukKMIEGS
         q0+A==
X-Gm-Message-State: AOAM533Nb8bNbBqlX6k7q2qOvANyerxdzh8jZApPJ5euORd5Xnvdvds5
        kYi3cp11s/rm0xxyUCnchfs=
X-Google-Smtp-Source: ABdhPJzF9ct/7/JJ8DalmXr/2Xrtmcej1kk0eLZuQlB31eryC+vHOBW2HSMXpeM0Q9ITc5zTJQtm/A==
X-Received: by 2002:a17:90a:588e:: with SMTP id j14mr9515931pji.30.1605868372961;
        Fri, 20 Nov 2020 02:32:52 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:41d:db53:c08:a078:319d:99fb])
        by smtp.gmail.com with ESMTPSA id v1sm3229429pjs.16.2020.11.20.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:32:52 -0800 (PST)
Date:   Fri, 20 Nov 2020 16:03:14 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH v4 09/10] commit-reach: use corrected commit dates in
 paint_down_to_common()
Message-ID: <X7ebaubi/FhLMtVO@Abhishek-Arch>
Reply-To: 85y2jiqq3c.fsf@gmail.com
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <bb9b02af32d028fc0c26d372aa490e260c74e74d.1602079786.git.gitgitgadget@gmail.com>
 <85y2jiqq3c.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85y2jiqq3c.fsf@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 03, 2020 at 06:59:03PM +0100, Jakub Narębski wrote:
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With corrected commit dates implemented, we no longer have to rely on
> > commit date as a heuristic in paint_down_to_common().
> >
> > While using corrected commit dates Git walks nearly the same number of
> > commits as commit date, the process is slower as for each comparision we
> > have to access a commit-slab (for corrected committer date) instead of
> > accessing struct member (for committer date).
> 
> Something for the future: I wonder if it would be worth it to bring back
> generation number from the commit-slab into `struct commit`.
> 
> >
> > For example, the command `git merge-base v4.8 v4.9` on the linux
> > repository walks 167468 commits, taking 0.135s for committer date and
> > 167496 commits, taking 0.157s for corrected committer date respectively.
> 
> I think it would be good idea to explicitly refer to the commit that
> changed paint_down_to_common() to *not* use generation numbers v1
> (topological levels) in the cases such as this, namely 091f4cf3 (commit:
> don't use generation numbers if not needed).  In this commit we have the
> following:
> ...
>

I have re-arranged the first half of commit message: 

  091f4cf3 (commit: don't use generation numbers if not needed,
  2018-08-30) changed paint_down_to_common() to use commit dates instead
  of generation numbers v1 (topological levels) as the performance
  regressed on certain topologies. With generation number v2 (corrected
  commit dates) implemented, we no longer have to rely on commit dates and
  can use generation numbers.
  
  For example, the command `git merge-base v4.8 v4.9` on the Linux
  repository walks 167468 commits, taking 0.135s for committer date and
  167496 commits, taking 0.157s for corrected committer date respectively.
  
  While using corrected commit dates Git walks nearly the same number of
  commits as commit date, the process is slower as for each comparision we
  have to access a commit-slab (for corrected committer date) instead of
  accessing struct member (for committer date).

> 
> The times you report (0.135s and 0.157s) are close to 0.122s / 0.127s
> reported in 091f4cf3 - that is most probably because of the differences
> in the system performance (hardware, operating system, load, etc.).
> Numbers of commits walked for the committed date heuristics, that is
> 167,468 agrees with your results; 167,496 (+28) for corrected commit
> date (generation number v2) is significantly smaller (-468,083) than
> 635,579 reported for topological levels (generation number v1).
> 
> I suspect that there are cases (with date skew) where corrected commit
> date gives better performance than committer date heuristics, and I am
> quite sure that generation number v2 can give better performance in case
> where paint_down_to_common() uses generation numbers.
> 
> .................................................................
> 
> Here begins separate second change, which is not put into separate
> commit because it is fairly tightly connected to the change described
> above.  It would be good idea, in my opinion, to add a sentence that
> explicitely marks this switch, for example:
> 
>   This change accidentally broke fragile t6404-recursive-merge test.
>   t6404-recursive-merge setups a unique repository...
> 
> Maybe with s/accidentaly/incidentally/.
> 

Thanks, will add.

> Or add some other way of connection those two parts of the commit
> messages.
> ...
> >  
> > +int corrected_commit_dates_enabled(struct repository *r)
> > +{
> > +	struct commit_graph *g;
> > +	if (!prepare_commit_graph(r))
> > +		return 0;
> > +
> > +	g = r->objects->commit_graph;
> > +
> > +	if (!g->num_commits)
> > +		return 0;
> > +
> > +	return g->read_generation_data;
> > +}
> 
> Very nice abstraction.
> 
> Minor issue: I wonder if it would be better to use _available() or
> "_present()" rather than _enabled() suffix.
> 

We could, but that breaks conformity with `generation_numbers_enabled()`.

I see both functions to be similar in nature, to answer whether the
commit-graph has X? X could be topological levels or corrected commit
dates.

> > +
> >  struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r)
> >  {
> >  	struct commit_graph *g = r->objects->commit_graph;
> > diff --git a/commit-graph.h b/commit-graph.h
> > index ad52130883..d2c048dc64 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -89,13 +89,19 @@ struct commit_graph *read_commit_graph_one(struct repository *r,
> >  struct commit_graph *parse_commit_graph(struct repository *r,
> >  					void *graph_map, size_t graph_size);
> >  
> > +struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
> > +
> >  /*
> >   * Return 1 if and only if the repository has a commit-graph
> >   * file and generation numbers are computed in that file.
> >   */
> >  int generation_numbers_enabled(struct repository *r);
> >  
> > -struct bloom_filter_settings *get_bloom_filter_settings(struct repository *r);
> 
> This moving get_bloom_filter_settings() before generation_numbers_enabled() 
> looks like accidental change.  If not, why it is here?

Right, that's an accidental change. I wanted to group
generation_numbers_enabled() and corrected_commit_dates_enabled()
together.

> 
> ...
> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
