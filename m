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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283DEC433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 05:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA6D2233FB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 05:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbhAHFvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 00:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbhAHFvy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 00:51:54 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511DC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 21:51:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id l23so5562216pjg.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 21:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V45eU3k4BYoe+XmG9Qh8lzOHQ8n10CM5Sd1QHWLVxUA=;
        b=FXy0XRDbQHOPWUnkxt6kPIMiZLRSmyqo0w3E1rxoEjD3wfYq51f/W3x5gEPlXpD7s9
         /1Oibo8iJN+nMtQFAM74wD4nFxpmPShZ0bB4GHJBLR1Vy+rns750tiVD5pvUaguIRB7c
         T48PiezFRWPc9uJdJfj8alu7VrBo10IRiWyEWEeIgYnU8nR08x0QoSRwyXrfx7MwS7fY
         OzsMzqM7UUwjFOLCQdXSFiVuHU9CU/A2UUdr912mwpG8Mbp7QZw76gbpDsgFuMU4Vkkb
         SaIZ5kzh1zmTLvu+rci8VMkiDzXg+nzga0v6/vElzsi62bSX9b00bHM5nph5yUKpAFHY
         D42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=V45eU3k4BYoe+XmG9Qh8lzOHQ8n10CM5Sd1QHWLVxUA=;
        b=nIQwqtYZ1acTfYL/sdDP5V2gpIIM6jZVFJ12tqMp8ADX9ud0KxAHj9U/t5/iF6fqLP
         IomOitOX6YanpazTpWLNq0bTocef+K4IGXM2XmhAyE5+R+2zNXqo5dlOIGsFrsQHRFej
         co/RlJzAycsS/SUyzC9UFlWszJ4ePEHS+dvzX9yaq0WlZyXfJ9+uUBPRyvSpMAI1dQbD
         ApbxXW+XIwGYPNJ3dBcYDt71VPrd/oMPr3yr5wo1IOTwbde6MCOH6UE3GuzoGnDiu0Bs
         2XFhPaKg01kiX24mktae/Qvfk0+wfEn5kWZh92ATIaKa3NsZzLodwKowKMue3Bkk5ozH
         4WCg==
X-Gm-Message-State: AOAM532K4uFdW4Nlystq9aNLo3zMqDORj46DkbjqJ2ncw3JHrcyjQAke
        MuGSLN6o18eqp7d1v3I7O7g=
X-Google-Smtp-Source: ABdhPJwW4dSeqdfICPmug2OgyxIVAX7gqUhAAQLQ8dxdOfUfz1QsJaVBvME5YJcLfZwJCN653olKeQ==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr2071828pjt.101.1610085073713;
        Thu, 07 Jan 2021 21:51:13 -0800 (PST)
Received: from Abhishek-Arch ([2409:4064:81c:cdaa:1c32:5945:1b72:d1f4])
        by smtp.gmail.com with ESMTPSA id h3sm8144949pgm.67.2021.01.07.21.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 21:51:13 -0800 (PST)
Date:   Fri, 8 Jan 2021 11:21:38 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com, me@ttaylor.com,
        stolee@gmail.com
Subject: Re: [PATCH v5 01/11] commit-graph: fix regression when computing
 Bloom filters
Message-ID: <X/fy6vWfCCVuApTE@Abhishek-Arch>
Reply-To: 20210105094535.GN8396@szeder.dev
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
 <20210105094535.GN8396@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210105094535.GN8396@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 05, 2021 at 10:45:35AM +0100, SZEDER Gábor wrote:
> On Mon, Dec 28, 2020 at 11:15:58AM +0000, Abhishek Kumar via GitGitGadget wrote:
> > Before computing Bloom fitlers, the commit-graph machinery uses
> > commit_gen_cmp to sort commits by generation order for improved diff
> > performance. 3d11275505 (commit-graph: examine commits by generation
> > number, 2020-03-30) claims that this sort can reduce the time spent to
> > compute Bloom filters by nearly half.
> 
> That's true, though there are repositories where it has basically no
> effect.  Alas we can't directly test it, because in 3d11275505 there
> is no '--changed-paths' option yet... one has to revert 3d11275505 on
> top of d38e07b8c4 (commit-graph: add --changed-paths option to write
> subcommand, 2020-04-06) to make any runtime comparisons ('git
> commit-graph write --reachable --changed-paths', best of five):
> 
>                    Sorting by
>                pack    | generation
>              position  |
>     -------------------+------------
>     gcc      114.821s  |    38.963s 
>     git        8.896s  |     5.620s
>     linux    209.984s  |   104.900s
>     webkit    35.193s  |    35.482s
> 
> Note the almost 3x speedup in the gcc repository, and the basically
> negligible slowdown in the webkit repo.
> 
> > But since c49c82aa4c (commit: move members graph_pos, generation to a
> > slab, 2020-06-17), this optimization is broken, since asking for a
> > 'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
> > while writing.
> 
> I wouldn't say that c49c82aa4c broke this optimisation, because:
> 
> did not break that optimization.  Though, sadly, it's not
> mentioned in 3d11275505's commit message, when commit_gen_cmp()
> compares two commits with identical generation numbers, then it
> doesn't leave them unsorted, but falls back to use their committer
> date as a tie-braker.  This means that after c49c82aa4c the commits
> are sorted by committer date, which appears to be so good a heuristic
> for Bloom filter computation that there is barely any slowdown
> compared to sorting by generation numbers:
> 
> > Not all hope is lost, though: 'commit_graph_generation()' falls back to
> 
> You mean commit_gen_cmp() here.
> 

Yes, fixed.

> > comparing commits by their date when they have equal generation number,
> > and so since c49c82aa4c is purely a date comparision function. This
> > heuristic is good enough that we don't seem to loose appreciable
> > performance while computing Bloom filters.
> 
> Indeed, c49c82aa4c barely caused any runtime difference in the
> repositories I usually use to test modified path Bloom filter
> performance:
> 
>                  c49c82aa4c^  c49c82aa4c
>   ---------------------------------------------
>   android-base     43.057s     43.091s   0.07%
>   cmssw            21.781s     21.856s   0.34%
>   cpython           9.626s      9.724s   1.01%
>   elasticsearch    18.049s     18.224s   0.96%
>   gcc              40.312s     40.255s  -0.14%
>   gecko-dev       104.515s    104.740s   0.21%
>   git               5.559s      5.570s   0.19%
>   glibc             4.455s      4.468s   0.29%
>   go                4.009s      4.016s   0.17%
>   homebrew-cask    30.759s     30.523s  -0.76%
>   homebrew-core    57.122s     56.553s  -0.99%
>   jdk              18.297s     18.364s   0.36%
>   linux           104.499s    105.302s   0.76%
>   llvm-project     34.074s     34.446s   1.09%
>   rails             6.472s      6.486s   0.21%
>   rust             14.943s     14.947s   0.02%
>   tensorflow       13.362s     13.477s   0.86%
>   webkit           34.583s     34.601s   0.05%
> 
> > Applying this patch (compared
> > with v2.29.1) speeds up computing Bloom filters by around ~4
> > seconds.
> 
> Without a baseline and knowing which repo, this "~4 seconds" is
> meaningless.
> 
> Here are my results comparing this fix to v2.30.0, best of five:
> 
>                               v2.30.0 +
>                    v2.30.0    this fix
>   ---------------------------------------------
>   android-base     42.786s     42.933s   0.34%
>   cmssw            20.229s     20.160s  -0.34%
>   cpython           9.616s      9.647s   0.32%
>   elasticsearch    16.859s     16.936s   0.45%
>   gcc              38.909s     36.889s  -5.19%
>   gecko-dev        99.417s     98.558s  -0.86%
>   git               5.620s      5.509s  -1.97%
>   glibc             4.307s      4.301s  -0.13%
>   go                3.971s      3.938s  -0.83%
>   homebrew-cask    31.262s     30.283s  -3.13%
>   homebrew-core    57.842s     55.663s  -3.76%
>   jdk              12.557s     12.251s  -2.43%
>   linux            94.335s     94.760s   0.45%
>   llvm-project     34.432s     33.988s  -1.28%
>   rails             6.481s      6.454s  -0.41%
>   rust             14.772s     14.601s  -1.15%
>   tensorflow       11.759s     11.711s  -0.40%
>   webkit           33.917s     33.759s  -0.46%
>

Thank you for the detailed performance benchmarking.

> 
> > So, avoid the useless 'commit_graph_generation()' while writing by
> > instead accessing the slab directly. This returns the newly-computed
> > generation numbers, and allows us to avoid the heuristic by directly
> > comparing generation numbers.
> > 
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 06f8dc1d896..caf823295f4 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
> >  	const struct commit *a = *(const struct commit **)va;
> >  	const struct commit *b = *(const struct commit **)vb;
> >  
> > -	uint32_t generation_a = commit_graph_generation(a);
> > -	uint32_t generation_b = commit_graph_generation(b);
> > +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> > +	uint32_t generation_b = commit_graph_data_at(b)->generation;
> >  	/* lower generation commits first */
> >  	if (generation_a < generation_b)
> >  		return -1;
> > -- 
> > gitgitgadget
> > 

Thanks
- Abhishek
