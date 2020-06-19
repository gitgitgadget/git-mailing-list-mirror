Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645DFC433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D20214DB
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="K2nNcX5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbgFSRT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFSRTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 13:19:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88CC06174E
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 10:19:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so4703803pfe.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2020 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=q7q3tiESs7/QPgwNR+wUkJGzIjIQdlyxf56rJbIW+OA=;
        b=K2nNcX5iIbVkQtrChKg0+LazwHk9a9wsTdBqEQCPFRtutogtQe01QkaEo6dE7z5hHk
         IC2QYqayoWwrjJg7AAamrM/Uxw83X817v4Phro13HYtMpNbX+uldxvpDrHi2cnVouzJX
         lxjYK42VLl5Db/JmxYT8cqz3SC3qxeRe9U/faEsC6jXcMSDEMPFA+H/JzUXkVVxDZHI+
         bcHRv0ALSukiHlS/CpUT3D/GRwbsY4eOFLaYlnWZSsYJULQ6nL8MVeWn7z1Kk/UBKlWR
         89ucBokjoMY/ZGhRx77cO1Ip6QLtVt9hYlaUwJUq53Ibj/mpt5Fq2GUZzQAUpnAnjJRp
         Y8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=q7q3tiESs7/QPgwNR+wUkJGzIjIQdlyxf56rJbIW+OA=;
        b=ePZqOmMnm62JxUQ3U1Fq43sKQzWGwNCzQKn11PYfTt/qVUlMR6LqzcIjYf7kHcGVqY
         EQVpVyGxvoTJyiwscsV+vYTbc3zFCnsBdRU6nD5jeVeezcWEMLWSZYorg3q+JJUcHM0G
         6APd9yDv1V6vBD12m+l9EKrE58omHseIXUkRVM6VnWCEp/tjOlglE59owsDm436ZWfUJ
         fQsSHQMHJvwaG86QJYaBHA1oWXquEmV5bqoy8Euh9OvGUjtp0hHcnNORVDwwMzNodbR5
         C3roEUz/xp2MUVGJG32SdKWqmEjFT8Xpe5vCpWFExIo20mjNc468QZlh7bMeH3v5Z2Q4
         /ZDg==
X-Gm-Message-State: AOAM533yTUMLPNMzRJ1n1b6djQVfZbGIz+f5lffxeRhsq3g1JOuQ9Z6W
        SZfdKdWL6UWniVdI0jDdjWkX0A==
X-Google-Smtp-Source: ABdhPJx9KjnakGIwtMO4Eqx53RYdEs4kCbeSUdcOrY4NJy88dBfQpGVdw+Td372l6rViM00EGQTE4w==
X-Received: by 2002:a63:7844:: with SMTP id t65mr3930062pgc.382.1592587164760;
        Fri, 19 Jun 2020 10:19:24 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q65sm6499985pfc.155.2020.06.19.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 10:19:24 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:19:22 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 5/8] commit-graph: check all leading directories in
 changed path Bloom filters
Message-ID: <20200619171922.GA57283@syl.local>
References: <pull.659.git.1592252093.gitgitgadget@gmail.com>
 <9975fc96f1269b049ebdd54835a63480c3dcbe4e.1592252093.git.gitgitgadget@gmail.com>
 <20200619171717.GA55911@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619171717.GA55911@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 19, 2020 at 11:17:17AM -0600, Taylor Blau wrote:
> Hi Stolee,
>
> On Mon, Jun 15, 2020 at 08:14:50PM +0000, SZEDER Gábor via GitGitGadget wrote:
> > From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
> >
> > The file 'dir/subdir/file' can only be modified if its leading
> > directories 'dir' and 'dir/subdir' are modified as well.
> >
> > So when checking modified path Bloom filters looking for commits
> > modifying a path with multiple path components, then check not only
> > the full path in the Bloom filters, but all its leading directories as
> > well.  Take care to check these paths in "deepest first" order,
> > because it's the full path that is least likely to be modified, and
> > the Bloom filter queries can short circuit sooner.
> >
> > This can significantly reduce the average false positive rate, by
> > about an order of magnitude or three(!), and can further speed up
> > pathspec-limited revision walks.  The table below compares the average
> > false positive rate and runtime of
> >
> >   git rev-list HEAD -- "$path"
> >
> > before and after this change for 5000+ randomly* selected paths from
> > each repository:
> >
> >                     Average false           Average        Average
> >                     positive rate           runtime        runtime
> >                   before     after     before     after   difference
> >   ------------------------------------------------------------------
> >   git             3.220%   0.7853%     0.0558s   0.0387s   -30.6%
> >   linux           2.453%   0.0296%     0.1046s   0.0766s   -26.8%
> >   tensorflow      2.536%   0.6977%     0.0594s   0.0420s   -29.2%
> >
> > *Path selection was done with the following pipeline:
> >
> > 	git ls-tree -r --name-only HEAD | sort -R | head -n 5000
> >
> > The improvements in runtime are much smaller than the improvements in
> > average false positive rate, as we are clearly reaching diminishing
> > returns here.  However, all these timings depend on that accessing
> > tree objects is reasonably fast (warm caches).  If we had a partial
> > clone and the tree objects had to be fetched from a promisor remote,
> > e.g.:
> >
> >   $ git clone --filter=tree:0 --bare file://.../webkit.git webkit.notrees.git
> >   $ git -C webkit.git -c core.modifiedPathBloomFilters=1 \
> >         commit-graph write --reachable
> >   $ cp webkit.git/objects/info/commit-graph webkit.notrees.git/objects/info/
> >   $ git -C webkit.notrees.git -c core.modifiedPathBloomFilters=1 \
> >         rev-list HEAD -- "$path"
> >
> > then checking all leading path component can reduce the runtime from
> > over an hour to a few seconds (and this is with the clone and the
> > promisor on the same machine).
> >
> > This adjusts the tracing values in t4216-log-bloom.sh, which provides a
> > concrete way to notice the improvement.
> >
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  revision.c           | 35 ++++++++++++++++++++++++++---------
> >  revision.h           |  6 ++++--
> >  t/t4216-log-bloom.sh |  2 +-
> >  3 files changed, 31 insertions(+), 12 deletions(-)
> >
> > diff --git a/revision.c b/revision.c
> > index c644c660917..027ae3982b4 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -670,9 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
> >  {
> >  	struct pathspec_item *pi;
> >  	char *path_alloc = NULL;
> > -	const char *path;
> > +	const char *path, *p;
> >  	int last_index;
> > -	int len;
> > +	size_t len;
> > +	int path_component_nr = 0, j;
> >
> >  	if (!revs->commits)
> >  		return;
> > @@ -705,8 +706,22 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
> >
> >  	len = strlen(path);
> >
> > -	revs->bloom_key = xmalloc(sizeof(struct bloom_key));
> > -	fill_bloom_key(path, len, revs->bloom_key, revs->bloom_filter_settings);
> > +	p = path;
> > +	do {
> > +		p = strchrnul(p + 1, '/');
> > +		path_component_nr++;
> > +	} while (p - path < len);
> > +
> > +	revs->bloom_keys_nr = path_component_nr;
> > +	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
> > +
> > +	p = path;
> > +	for (j = 0; j < revs->bloom_keys_nr; j++) {
> > +		p = strchrnul(p + 1, '/');
> > +
> > +		fill_bloom_key(path, p - path, &revs->bloom_keys[j],
> > +			       revs->bloom_filter_settings);
> > +	}
> >
>
> Somewhat related to our off-list discussion yesterday, there is a bug in
> both 2.27 and this patch which produces incorrect results when (1)
> Bloom filters are enabled, and (2) we are doing a revision walk from
> root with the pathspec '.'.
>
> What appears to be going on is that our normalization takes '.' -> '',
> and then we form a Bloom key based on the empty string, which will
> return 'definitely not' when querying the Bloom filter some of the time,
> which should never happen. This is a consequence of never inserting the
> empty key into the Bloom filter upon generation.
>
> As a result, I have patched this in GitHub's fork (which is currently
> based on 2.27 and doesn't have these patches yet) by doing an early
> return when 'strlen(path) == 0'. Since it looks like these patches are
> going to land, here is some clean-up and a fix for the bug that you
> should feel free to test with and apply on top:
>
> --- >8 ---
>
> diff --git a/revision.c b/revision.c
> index 8bd383b1dd..123e72698d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -670,10 +670,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>         struct pathspec_item *pi;
>         char *path_alloc = NULL;
> -       const char *path, *p;
> +       char *path, *p;
>         int last_index;
>         size_t len;
> -       int path_component_nr = 0, j;
> +       int path_component_nr = 1, j;
>
>         if (!revs->commits)
>                 return;
> @@ -698,29 +698,33 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>
>         /* remove single trailing slash from path, if needed */
>         if (pi->match[last_index] == '/') {
> -           path_alloc = xstrdup(pi->match);
> -           path_alloc[last_index] = '\0';
> -           path = path_alloc;
> -       } else
> -           path = pi->match;
> +               path_alloc = xstrdup(pi->match);
> +               path_alloc[last_index] = '\0';
> +               path = path_alloc;
> +       } else {
> +               path = pi->match;
> +               len = pi->len;
> +       }
>
> -       len = strlen(path);
> +       if (!len)
> +               return;

I should note that _this_ is the critical fix, and it should fix the bug
if you only applied just this hunk.

Everything else is purely style clean-ups on top (ranging from the four
spaces used instead of a tab, to some string processing niceties that I
_think_ should address Rene's concern, although I'm not sure if an
actual bug is lurking there or not...)

> -       p = path;
>         do {
> -               p = strchrnul(p + 1, '/');
> -               path_component_nr++;
> -       } while (p - path < len);
> +               if (is_dir_sep(*p)) {
> +                       *p = '\0';
> +                       path_component_nr++;
> +               }
> +       } while (*p++);
>
>         revs->bloom_keys_nr = path_component_nr;
>         ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
>
>         p = path;
>         for (j = 0; j < revs->bloom_keys_nr; j++) {
> -               p = strchrnul(p + 1, '/');
> -
> -               fill_bloom_key(path, p - path, &revs->bloom_keys[j],
> +               size_t plen = strlen(p);
> +               fill_bloom_key(p, plen, &revs->bloom_keys[j],
>                                revs->bloom_filter_settings);
> +               p += plen;
>         }
>
>         if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
>
> >  	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
> >  		atexit(trace2_bloom_filter_statistics_atexit);
> > @@ -720,7 +735,7 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
> >  						 struct commit *commit)
> >  {
> >  	struct bloom_filter *filter;
> > -	int result;
> > +	int result = 1, j;
> >
> >  	if (!revs->repo->objects->commit_graph)
> >  		return -1;
> > @@ -740,9 +755,11 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
> >  		return -1;
> >  	}
> >
> > -	result = bloom_filter_contains(filter,
> > -				       revs->bloom_key,
> > -				       revs->bloom_filter_settings);
> > +	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
> > +		result = bloom_filter_contains(filter,
> > +					       &revs->bloom_keys[j],
> > +					       revs->bloom_filter_settings);
> > +	}
> >
> >  	if (result)
> >  		count_bloom_filter_maybe++;
> > @@ -782,7 +799,7 @@ static int rev_compare_tree(struct rev_info *revs,
> >  			return REV_TREE_SAME;
> >  	}
> >
> > -	if (revs->bloom_key && !nth_parent) {
> > +	if (revs->bloom_keys_nr && !nth_parent) {
> >  		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
> >
> >  		if (bloom_ret == 0)
> > diff --git a/revision.h b/revision.h
> > index 7c026fe41fc..abbfb4ab59a 100644
> > --- a/revision.h
> > +++ b/revision.h
> > @@ -295,8 +295,10 @@ struct rev_info {
> >  	struct topo_walk_info *topo_walk_info;
> >
> >  	/* Commit graph bloom filter fields */
> > -	/* The bloom filter key for the pathspec */
> > -	struct bloom_key *bloom_key;
> > +	/* The bloom filter key(s) for the pathspec */
> > +	struct bloom_key *bloom_keys;
> > +	int bloom_keys_nr;
> > +
> >  	/*
> >  	 * The bloom filter settings used to generate the key.
> >  	 * This is loaded from the commit-graph being used.
> > diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
> > index c7011f33e2c..c13b97d3bda 100755
> > --- a/t/t4216-log-bloom.sh
> > +++ b/t/t4216-log-bloom.sh
> > @@ -142,7 +142,7 @@ test_expect_success 'setup - add commit-graph to the chain with Bloom filters' '
> >
> >  test_bloom_filters_used_when_some_filters_are_missing () {
> >  	log_args=$1
> > -	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":8,\"definitely_not\":6"
> > +	bloom_trace_prefix="statistics:{\"filter_not_present\":3,\"zero_length_filter\":0,\"maybe\":6,\"definitely_not\":8"
> >  	setup "$log_args" &&
> >  	grep -q "$bloom_trace_prefix" "$TRASH_DIRECTORY/trace.perf" &&
> >  	test_cmp log_wo_bloom log_w_bloom
> > --
> > gitgitgadget
> >
> Thanks,
> Taylor
Thanks,
Taylor
