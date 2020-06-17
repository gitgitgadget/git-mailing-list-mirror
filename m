Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEFDC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FBF20C09
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 09:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+B9LoRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQJUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQJUK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 05:20:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581BEC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:20:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so824931pfe.4
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 02:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tyyNc2082Rl/pW0h/4dnwNQ6zLKTEFMWJs6Y1W1klnI=;
        b=J+B9LoRgf2QNkUOLn9X3DNU9BDZUWHLxO20kMDWIVW2LsMPMt6d7BjLG5EfCXlYGQ/
         gtT/ad7hFjiJeEbHAPEJRXs78+CiyOkWnmIg6KixA9srYklgrj9vPYVnXPgKwNr1HPJP
         2DWuLhyXZsELyRVtPEKy/sgh1xnuBiUZrTKl73UWtCEhlW6QsK+ejKtaZtTZYefw1d8l
         6mj7WrymOh+wJ0D0riOd3OcQ6Sy5qbxoZToRcwawzj2v2BScZKdjuWlX8vE+IxVR9DTb
         1uF6pXIqMPYWcvZ2zqlRzHjhSPyjUV1sbAuDvLJYY5JC4G8CWASwX8EM7DrAlBao7C38
         e2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=tyyNc2082Rl/pW0h/4dnwNQ6zLKTEFMWJs6Y1W1klnI=;
        b=Dc9uxC4AidEH9kQ2ZdPUH68Y+eI9NAgEXxXEmUvgmt7z6iR+UEef/ZvTHszh8nQi+i
         xM+p6pXvC+GajUlE5Sfax8PTsKc+/YG0P3TJjz6owwWvLuZ4nWK7/Y4OdOb3PUBK8vs1
         H4FxCnEPFJjHCSWA/UutR2feMRDUG5e6FXwUCJLb65hh3wmlmLyLIV60CiPPhGVzzqhK
         XrGsqxFEd61ECa7sZNxc6/8sZ/q6QzFcn7bnjMgA9gdceq7wa5jriv6BEvSsxVUPlnc7
         WArXhxVTER9v8nzLxZWnWWwMnnsej3UMZ+5V2b7nkrd2SlF/ccizu35xOqVCckEJs8Nx
         O8UA==
X-Gm-Message-State: AOAM530ITQgm1QXmV0MQIrZ/36Tbe90RpbZRFX+a4gRkmMddselpQzbq
        mFurYV5SE0VsVV0moANbxQc=
X-Google-Smtp-Source: ABdhPJydJltOiIHxM90B2eRzfXoaHaqkwpbW4kdpatPLoUCEu8a6Yx62uhHmx/+GI7aaW2GFPRmNxA==
X-Received: by 2002:a63:d257:: with SMTP id t23mr5435808pgi.102.1592385609733;
        Wed, 17 Jun 2020 02:20:09 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:40b:ccca:8c2b:e6b:e670:4483])
        by smtp.gmail.com with ESMTPSA id e5sm4805414pjv.18.2020.06.17.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 02:20:08 -0700 (PDT)
Date:   Wed, 17 Jun 2020 14:48:22 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     jnareb@gmail.com, stolee@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] commit-graph: introduce commit_graph_data_slab
Message-ID: <20200617091822.GA26185@Abhishek-Arch>
Reply-To: 20200613065339.GC2898@szeder.dev
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
 <20200612184014.1226972-3-abhishekkumar8222@gmail.com>
 <20200613065339.GC2898@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200613065339.GC2898@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 13, 2020 at 08:53:39AM +0200, SZEDER Gábor wrote:
> On Sat, Jun 13, 2020 at 12:10:12AM +0530, Abhishek Kumar wrote:
> > diff --git a/commit-graph.c b/commit-graph.c
> > index 2ff042fbf4..91120ba3d3 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -87,6 +87,55 @@ static int commit_pos_cmp(const void *va, const void *vb)
> >  	       commit_pos_at(&commit_pos, b);
> >  }
> >  
> > +define_commit_slab(commit_graph_data_slab, struct commit_graph_data);
> > +static struct commit_graph_data_slab commit_graph_data_slab =
> > +	COMMIT_SLAB_INIT(1, commit_graph_data_slab);
> > +
> > +uint32_t commit_graph_position(const struct commit *c)
> > +{
> > +	struct commit_graph_data *data =
> > +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> > +
> > +	return data ? data->graph_pos : COMMIT_NOT_FROM_GRAPH;
> > +}
> > +
> > +uint32_t commit_graph_generation(const struct commit *c)
> > +{
> > +	struct commit_graph_data *data =
> > +		commit_graph_data_slab_peek(&commit_graph_data_slab, c);
> > +
> > +	if (!data)
> > +		return GENERATION_NUMBER_INFINITY;
> > +	else if (data->graph_pos == COMMIT_NOT_FROM_GRAPH)
> > +		return GENERATION_NUMBER_INFINITY;
> > +
> > +	return data->generation;
> > +}
> > +
> > +static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
> 
>   commit-graph.c: At top level:
>   commit-graph.c:115:34: error: ‘commit_graph_data_at’ defined but not used [-Werror=unused-function]
>    static struct commit_graph_data *commit_graph_data_at(const struct commit *c)
>                                     ^
> 
> Please make sure that each and every commit of your series can be
> built with DEVELOPER=1 and passes the test suite.
> 
> > +{
> > +	uint32_t i = commit_graph_data_slab.slab_count, j;
> > +	uint32_t slab_size = commit_graph_data_slab.slab_size;
> > +	struct commit_graph_data *data =
> > +		commit_graph_data_slab_at(&commit_graph_data_slab, c);
> > +
> > +	/*
> > +	 * commit-slab initializes elements with zero, overwrite this with
> > +	 * COMMIT_NOT_FROM_GRAPH for graph_pos.
> > +	 *
> > +	 * We avoid initializing generation with checking if graph position
> > +	 * is not COMMIT_NOT_FROM_GRAPH.
> > +	 */
> > +	for (; i < commit_graph_data_slab.slab_count; i++) {
> > +		for (j = 0; j < slab_size; j++) {
> > +			commit_graph_data_slab[i][j].graph_pos =
> 
>   commit-graph.c: In function ‘commit_graph_data_at’:
>   commit-graph.c:131:26: error: subscripted value is neither array nor pointer nor vector
>       commit_graph_data_slab[i][j].graph_pos =
>                             ^
> 
> Once the next patch is applied Git can be built again, but then:
> 
>   $ ~/src/git/git -C webkit.git commit-graph write
>   Finding commits for commit graph among packed objects: 100% (3984415/3984415), done.
>   Expanding reachable commits in commit graph: 219420, done.
>   Segmentation fault
> 
> Looking at it with a debugger:
> 
>   Program received signal SIGSEGV, Segmentation fault.
>   0x00000000005079b2 in commit_graph_data_at (c=0x1ad9aa0) at commit-graph.c:131
>   131                             commit_graph_data_slab.slab[i][j].graph_pos =
>   (gdb) bt
>   #0  0x00000000005079b2 in commit_graph_data_at (c=0x1ad9aa0)
>       at commit-graph.c:131
>   #1  0x000000000050a6a7 in compute_generation_numbers (ctx=0x9d61a0)
>       at commit-graph.c:1304
>   #2  0x000000000050d37d in write_commit_graph (odb=0x9d3d80, pack_indexes=0x0, 
>       commits=0x0, flags=COMMIT_GRAPH_WRITE_PROGRESS, 
>       split_opts=0x98e730 <split_opts>) at commit-graph.c:2178
>   #3  0x000000000042bb7e in graph_write (argc=0, argv=0x7fffffffe2f0)
>       at builtin/commit-graph.c:242
>   #4  0x000000000042bc8d in cmd_commit_graph (argc=1, argv=0x7fffffffe2f0, 
>       prefix=0x0) at builtin/commit-graph.c:278
>   #5  0x00000000004061d1 in run_builtin (p=0x97b950 <commands+528>, argc=2, 
>       argv=0x7fffffffe2f0) at git.c:448
>   #6  0x0000000000406521 in handle_builtin (argc=2, argv=0x7fffffffe2f0)
>       at git.c:673
>   #7  0x00000000004067c9 in run_argv (argcp=0x7fffffffe18c, argv=0x7fffffffe180)
>       at git.c:740
>   #8  0x0000000000406c3a in cmd_main (argc=2, argv=0x7fffffffe2f0) at git.c:871
>   #9  0x00000000004cfbda in main (argc=5, argv=0x7fffffffe2d8)
>       at common-main.c:52
>   (gdb) p commit_graph_data_slab
>   $1 = {
>     slab_size = 65532, 
>     stride = 1, 
>     slab_count = 4, 
>     slab = 0x4f68690
>   }
>   (gdb) p i
>   $2 = 0
>   (gdb) p commit_graph_data_slab.slab[i]
>   $3 = (struct commit_graph_data *) 0x0
>   (gdb) p c->index
>   $4 = 213506
>   (gdb) up
>   #1  0x000000000050a6a7 in compute_generation_numbers (ctx=0x9d61a0)
>       at commit-graph.c:1304
>   1304                    uint32_t generation = commit_graph_data_at(ctx->commits.list[i])->generation;
>   (gdb) p i
>   $5 = 0
> 
> 
> The way the loop variable 'i' is initialized and is used in the loop
> header suggests that you assume that all slabs with an index
> <slab_count are allocated.  That's not the case, only those slabs are
> allocated that contain data associated with a commit that has already
> been looked at.
> 

Wait, so assuming there are no slabs before and I call
`commit_graph_data_slab_at(&commit_graph_data_slab, c)` with an commit
index that would be in fourth slab, the slab would look like:

commit_graph_data_slab.slab[] = {NULL, NULL, NULL, <address>}

That's new to me! Thanks for sharing this.

Hopefully this is fixed in the v4 series here [1].

[1]: https://lore.kernel.org/git/20200617091411.14650-1-abhishekkumar8222@gmail.com/T/#u

> 
> > +				COMMIT_NOT_FROM_GRAPH;
> > +		}
> > +	}
> > +
> > +	return data;
> > +}
> > +
> >  static int commit_gen_cmp(const void *va, const void *vb)
> >  {
> >  	const struct commit *a = *(const struct commit **)va;
> > diff --git a/commit-graph.h b/commit-graph.h
> > index 3ba0da1e5f..cc76757007 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -135,4 +135,14 @@ void free_commit_graph(struct commit_graph *);
> >   */
> >  void disable_commit_graph(struct repository *r);
> >  
> > +struct commit_graph_data {
> > +	uint32_t graph_pos;
> > +	uint32_t generation;
> > +};
> > +
> > +/* 
> 
> This line adds a trailing space which is then removed in next patch.
> Please don't add it in the first place.
> 
> > + * Commits should be parsed before accessing generation, graph positions.
> > + */
> > +uint32_t commit_graph_generation(const struct commit *);
> > +uint32_t commit_graph_position(const struct commit *);
> >  #endif
> > -- 
> > 2.27.0
> > 

Regards
Abhishek
