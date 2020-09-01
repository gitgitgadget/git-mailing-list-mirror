Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A891DC433E7
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C56206EB
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 10:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lq93i4Oj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgIAKLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIAKLA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 06:11:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6538C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 03:10:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nv17so382839pjb.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 03:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bjN1dYq5ZCHNgoDcpG4fSou+EhRtTyNpVLhHloBUgJ4=;
        b=lq93i4Oj+j9d22QLfxcQazE2sp4zYbH129HOtoxOXr0tO8auBjKVRwBzVKotAAcGe8
         TfvNhKRECDLZw2g9bL9yM0/HqecSk4UC4m+XFKDVSzlkazwrfi+KwcYqtC6usTEJprhP
         5EEbFS1ss4S3JQ5fQLwOe8StgcEMG+7fEO2EkIMn8XJsA1Mk6BK6ZP43DfzwUX5ndHxF
         YQ3c2DoD/wFTqreWs/vStLj1FRn2pteAzv5ABSZY7kPref6lzZdc8VSrlVbAi6X+CTl/
         cLkFW3sbCCaxpDtzuooCVFRcp9izyioL47zvboOt3NM+qGmoWtmj0yg3/rq2F5R9cT8A
         oWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bjN1dYq5ZCHNgoDcpG4fSou+EhRtTyNpVLhHloBUgJ4=;
        b=DJkRFbaQzdFCambLxmGm38GeeLA32SrIMa9WtOKkuKnz8ZY/MiDh01WvoKJynA8ULz
         WljdbiOD4g/+lEa6N5OwLd6Cz0xuq6Xz8Y0+8trAtslI04/3zilKYtiCR9qzg/qiToof
         vcrBxAwl0er86y6EMKkrNkt7UhjVgzMKOYrvXVoOXZw5L0oUqC1ESrnIgNYz7p/XRQa1
         hrJ6ugxPt8fiR2KyUkeRlSWLN0yfDIpga5rqtoeuXP6Y/H+yawqrTV1Sn6PLb3FluDiR
         wxIx2Qo2bA26qI1Vlhoh8+hZ2Rzl1m8u9c/0SHeHPANPDARRaneRw3+wy8qBL/C726AI
         3vqQ==
X-Gm-Message-State: AOAM530p6zdNeeRMQysut3dRFsdBRPuzxaAktG3C3uB31qm9i9BWzhmA
        68LkV6yx7V7lc/sAQ7Y6Yfk=
X-Google-Smtp-Source: ABdhPJwdTCoOyKwTDwPlJIGXlYbynF+lJzQLoYdIxlu/IJeeTpW5M8ExaHVKzH4bTdq8Jrbwy+Q3Ew==
X-Received: by 2002:a17:902:ff07:: with SMTP id f7mr779347plj.52.1598955058966;
        Tue, 01 Sep 2020 03:10:58 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id i7sm1504819pgh.58.2020.09.01.03.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:10:57 -0700 (PDT)
Date:   Tue, 1 Sep 2020 15:38:28 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, stolee@gmail.com
Subject: Re: [PATCH v3 10/11] commit-reach: use corrected commit dates in
 paint_down_to_common()
Message-ID: <20200901100828.GA10388@Abhishek-Arch>
Reply-To: 85imdah50e.fsf@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <439adc1718d6cc37f18c1eaeafd605f5c2961733.1597509583.git.gitgitgadget@gmail.com>
 <85imdah50e.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85imdah50e.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 09:09:21PM +0200, Jakub Narębski wrote:
> Hello Abhishek,
> 
> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> >
> > With corrected commit dates implemented, we no longer have to rely on
> > commit date as a heuristic in paint_down_to_common().
> 
> All right, but it would be nice to have some benchmark data: what were
> performance when using topological levels, what was performance when
> using commit date heuristics (before this patch), what is performace now
> when using corrected commit date.
> 
> >
> > t6024-recursive-merge setups a unique repository where all commits have
> > the same committer date without well-defined merge-base. As this has
> > already caused problems (as noted in 859fdc0 (commit-graph: define
> > GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph within the
> > test script.
> 
> OK?

In hindsight, that is a terrible explanation. Here's what I have revised
this to:

  With corrected commit dates implemented, we no longer have to rely on
  commit date as a heuristic in paint_down_to_common().

  While using corrected commit dates Git walks nearly the same number of
  commits as commit date, the process is slower as for each comparision we
  have to access the commit-slab (for corrected committer date) instead of
  accessing struct member (for committer date).

  For example, the command `git merge-base v4.8 v4.9` on the linux
  repository walks 167468 commits, taking 0.135s for committer date and
  167496 commits, taking 0.157s for corrected committer date respectively.

  t6404-recursive-merge setups a unique repository where all commits have
  the same committer date without well-defined merge-base. As this has
  already caused problems (as noted in 859fdc0 (commit-graph: define
  GIT_TEST_COMMIT_GRAPH, 2018-08-29)).

  While running tests with GIT_TEST_COMMIT_GRAPH unset, we use committer
  date as a heuristic in paint_down_to_common(). 6404.1 'combined merge
  conflicts' merges commits in the order:
  - Merge C with B to form a intermediate commit.
  - Merge the intermediate commit with A.

  With GIT_TEST_COMMIT_GRAPH=1, we write a commit-graph and subsequently
  use the corrected committer date, which changes the order in which
  commits are merged:
  - Merge A with B to form a intermediate commit.
  - Merge the intermediate commit with C.

  While resulting repositories are equivalent, 6404.4 'virtual trees were
  processed' fails with GIT_TEST_COMMIT_GRAPH=1 as we are selecting
  different merge-bases and thus have different object ids for the
  intermediate commits.

  As this has already causes problems (as noted in 859fdc0 (commit-graph:
  define GIT_TEST_COMMIT_GRAPH, 2018-08-29)), we disable commit graph
  within t6404-recursive-merge.
> 
> >
> > Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> > ---
> >  commit-graph.c             | 14 ++++++++++++++
> >  commit-graph.h             |  6 ++++++
> >  commit-reach.c             |  2 +-
> >  t/t6024-recursive-merge.sh |  4 +++-
> >  4 files changed, 24 insertions(+), 2 deletions(-)
> >
> 
> I have reorderd files for easier review.
> 
> > diff --git a/commit-graph.h b/commit-graph.h
> > index 3cf89d895d..e22ec1e626 100644
> > --- a/commit-graph.h
> > +++ b/commit-graph.h
> > @@ -91,6 +91,12 @@ struct commit_graph *parse_commit_graph(void *graph_map, size_t graph_size);
> >   */
> >  int generation_numbers_enabled(struct repository *r);
> >
> > +/*
> > + * Return 1 if and only if the repository has a commit-graph
> > + * file and generation data chunk has been written for the file.
> > + */
> > +int corrected_commit_dates_enabled(struct repository *r);
> > +
> >  enum commit_graph_write_flags {
> >  	COMMIT_GRAPH_WRITE_APPEND     = (1 << 0),
> >  	COMMIT_GRAPH_WRITE_PROGRESS   = (1 << 1),
> 
> All right.
> 
> > diff --git a/commit-graph.c b/commit-graph.c
> > index c1292f8e08..6411068411 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -703,6 +703,20 @@ int generation_numbers_enabled(struct repository *r)
> >  	return !!first_generation;
> >  }
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
> > +	return !!g->chunk_generation_data;
> > +}
> 
> The previous commit introduced validate_mixed_generation_chain(), which
> walked whole split commit-graph chain, and set `read_generation_data`
> field in `struct commit_graph` for all layers in the chain.
> 
> This function examines only the top layer, so it follows the assumption
> that Git would behave in such way that oly topmost layers in the chai
> can be GDAT-less.
> 
> Why the difference?  Couldn't validate_mixed_generation_chain() simply
> call corrected_commit_dates_enabled()?

The previous commit didn't need to walk the whole split commit-graph
chain. Because of how we are handling writing in a mixed generation data
chunk, if a layer has generation data chunk, all layers below it have a
generation data chunk as well.

So, there are two cases at hand:

- Topmost layer has generation data chunk, so we know all layers below
  it has generation data chunk and we can read values from it.
- Topmost layer does not have generation data chunk, so we know we can't
  read from generation data chunk.

Just checking the topmost layer suffices - modified the previous commit.

Then, this function is more or less the same as
`g->read_generation_data` that is, if we are reading from generation
data chunk, we are using corrected commit dates.

> 
> > +
> >  static void close_commit_graph_one(struct commit_graph *g)
> >  {
> >  	if (!g)
> > diff --git a/commit-reach.c b/commit-reach.c
> > index 470bc80139..3a1b925274 100644
> > --- a/commit-reach.c
> > +++ b/commit-reach.c
> > @@ -39,7 +39,7 @@ static struct commit_list *paint_down_to_common(struct repository *r,
> >  	int i;
> >  	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
> >
> > -	if (!min_generation)
> 
> This check was added in 091f4cf (commit: don't use generation numbers if
> not needed, 2018-08-30) by Derrick Stolee, and its commit message
> includes benchmark results for running 'git merge-base v4.8 v4.9' in
> Linux kernel repository:
> 
>       v2.18.0: 0.122s    167,468 walked
>   v2.19.0-rc1: 0.547s    635,579 walked
>          HEAD: 0.127s
> 
> > +	if (!min_generation && !corrected_commit_dates_enabled(r))
> >  		queue.compare = compare_commits_by_commit_date;
> 
> It would be nice to have similar benchmark for this change... unless of
> course there is no change in performance, but I think then it needs to
> be stated explicitly.  I think.
> 

Mentioned in the commit message - we walk (nearly) the same number of
commits but take somewhat longer.

> >
> >  	one->object.flags |= PARENT1;
> > diff --git a/t/t6024-recursive-merge.sh b/t/t6024-recursive-merge.sh
> > index 332cfc53fd..d3def66e7d 100755
> > --- a/t/t6024-recursive-merge.sh
> > +++ b/t/t6024-recursive-merge.sh
> > @@ -15,6 +15,8 @@ GIT_COMMITTER_DATE="2006-12-12 23:28:00 +0100"
> >  export GIT_COMMITTER_DATE
> >
> >  test_expect_success 'setup tests' '
> > +	GIT_TEST_COMMIT_GRAPH=0 &&
> > +	export GIT_TEST_COMMIT_GRAPH &&
> >  	echo 1 >a1 &&
> >  	git add a1 &&
> >  	GIT_AUTHOR_DATE="2006-12-12 23:00:00" git commit -m 1 a1 &&
> > @@ -66,7 +68,7 @@ test_expect_success 'setup tests' '
> >  '
> >
> >  test_expect_success 'combined merge conflicts' '
> > -	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git merge -m final G
> > +	test_must_fail git merge -m final G
> >  '
> >
> >  test_expect_success 'result contains a conflict' '
> 
> OK, so instead of disabling commit-graph for this test, now we disable
> it for the whole script.
> 
> Maybe this change should be in a separate patch?

With the explanation in commit message, it's clear to see how using
corrected commit dates leads to an (incorrectly) failing test. Does it
still make sense to seperate them?

> 
> Best,
> -- 
> Jakub Narębski

Thanks
- Abhishek
