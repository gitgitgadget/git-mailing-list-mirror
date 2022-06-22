Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D902C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 17:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbiFVRPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376884AbiFVRO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 13:14:59 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F042D8
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:14:58 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id y14so20789891qvs.10
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 10:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2QnYJAxJX7kQusqmkdBs6+DDvJ+pcgSqlQgNk3MkdBk=;
        b=R7ygrV3BujGHNSpWT/fWOxsbKPdCYN+5w66ijpfo3OTFsxGZsApZzR6/qfRbe2nHGG
         yHlpgCefXz0HjdqSz5XTxDEOEWf/8q9nxlHf6xOSyvhFMPW8hmMMOGTrWPeOebrQrcn7
         1BA6/s9umtauDSjeeIVqiXzQuDCgdS1cVsUY5Sd67jr0255Zku9CloluhJQQNfxwwXax
         J4EGUUqLXg551f345kJ0pzC0kWLNjA30s0h9sZkmTFuf5Uu+H/8xYY+lMgFhPJEkuFLX
         nbaNDL9WPuLnazInDIS9gWC9nuAT2219V0B1HhYZIIIFQBkgOxRPqdzaxnzruIoFvXcV
         je7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2QnYJAxJX7kQusqmkdBs6+DDvJ+pcgSqlQgNk3MkdBk=;
        b=BPVMVqgxLyiKUsjGwoFBUUXb+9RuzrneQ9x20LMrDRPEj30ePC4tU6a/GwA/y/iU+Z
         PcxN308ty0EXqQW/a+0bXlDQutouirLtp/TWx6qmCncf2InwxXtnWhDOluu6P9ZbUWEO
         6v+KGSxJ+2NhT8hquwh3p0F7ll9nEcjG3lR4JSUke1zqeVBwz4RO61UwtdfRhudN4TjF
         3xmZ3+Ej/P8Nfg6Yg88vBUkpIdNQ0nnC7+7AyM0pnDO1BGAwgM8++OwHfVvCEfjoA/mR
         jl18kikAptfA1mVK32pi96jMUKJEv0PUVB3ZjLBixxTm7O/cmpcT2Cp1zSQygyFKVU9F
         5THQ==
X-Gm-Message-State: AJIora+SfJznp8HIsLctsC2Fzb8yfaKb/78E5Mdrp6KaBqWojd+zGHUH
        hoHbZJB+8rF9PI2WgZfz4PCi5Q==
X-Google-Smtp-Source: AGRyM1sr30K/JuCdBjJOzdJwLNvqrbRV5d6sCbl6Sziy7ElP0PxLDvisn0O7FyJI8J4s2Q1Bkd5Zmw==
X-Received: by 2002:ac8:5ac9:0:b0:306:6da0:5858 with SMTP id d9-20020ac85ac9000000b003066da05858mr4002620qtd.20.1655918096100;
        Wed, 22 Jun 2022 10:14:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ef8-20020a05620a808800b006a71398f06fsm16632237qkb.32.2022.06.22.10.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:14:55 -0700 (PDT)
Date:   Wed, 22 Jun 2022 13:14:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 6/6] bitmap-lookup-table: add performance tests
Message-ID: <YrNODmtvF6/Vlwv2@nand.local>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <f5f725a3fe2ac0c93088c48ac520303a3df2c83d.1655728395.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5f725a3fe2ac0c93088c48ac520303a3df2c83d.1655728395.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 20, 2022 at 12:33:14PM +0000, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Add performance tests for bitmap lookup table extension.

These tests look good, though I left a few notes below which boil down
to recommending a separate commit to set pack.writeReverseIndex=true,
and some suggestions for how to clean up the diff in the two performance
scripts you modified.

I would be interested to see the relevant results from running these
perf scripts on a reasonably large-sized repository, e.g. the kernel or
similar.

For the next version of this series, would you mind running these
scripts and including the results in this commit message?

> Mentored-by: Taylor Blau <ttaylorr@github.com>
> Co-mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  t/perf/p5310-pack-bitmaps.sh       | 60 +++++++++++++++++++-----------
>  t/perf/p5326-multi-pack-bitmaps.sh | 55 +++++++++++++++++----------
>  2 files changed, 73 insertions(+), 42 deletions(-)
>
> diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
> index 7ad4f237bc3..a8d9414de92 100755
> --- a/t/perf/p5310-pack-bitmaps.sh
> +++ b/t/perf/p5310-pack-bitmaps.sh
> @@ -10,10 +10,11 @@ test_perf_large_repo
>  # since we want to be able to compare bitmap-aware
>  # git versus non-bitmap git
>  #
> -# We intentionally use the deprecated pack.writebitmaps
> +# We intentionally use the deprecated pack.writeBitmaps
>  # config so that we can test against older versions of git.
>  test_expect_success 'setup bitmap config' '
> -	git config pack.writebitmaps true
> +	git config pack.writeBitmaps true &&
> +	git config pack.writeReverseIndex true

I suspect that eliminating the overhead of generating the reverse index
in memory is important to see the effect of this test. We should make
sure that this is done in a separate step so when we compare two commits
that both have a reverse index written.

That being said, we should probably make reverse indexes be the default
anyways, since they help significantly with all kinds of things (really,
any operation which has to generate a reverse index in memory, like
preparing a pack to push, the '%(objectsize:disk)' cat-file formatting
atom, and so on.

So at a minimum I would suggest extracting a separate commit here which
sets pack.writeReverseIndex to true for this test. That way the commit
prior to this has reverse indexes written, and comparing "this commit"
to "the previous one" is isolating the effect of just the lookup table.

But as a useful sideproject, it would be worthwhile to investigate
setting this to true by default everywhere, perhaps after this series
has settled a little more (or if you are blocked / want something else
to do).

>  '
>
>  # we need to create the tag up front such that it is covered by the repack and
> @@ -28,27 +29,42 @@ test_perf 'repack to disk' '
>
>  test_full_bitmap
>
> -test_expect_success 'create partial bitmap state' '
> -	# pick a commit to represent the repo tip in the past
> -	cutoff=$(git rev-list HEAD~100 -1) &&
> -	orig_tip=$(git rev-parse HEAD) &&
> -
> -	# now kill off all of the refs and pretend we had
> -	# just the one tip
> -	rm -rf .git/logs .git/refs/* .git/packed-refs &&
> -	git update-ref HEAD $cutoff &&
> -
> -	# and then repack, which will leave us with a nice
> -	# big bitmap pack of the "old" history, and all of
> -	# the new history will be loose, as if it had been pushed
> -	# up incrementally and exploded via unpack-objects
> -	git repack -Ad &&
> -
> -	# and now restore our original tip, as if the pushes
> -	# had happened
> -	git update-ref HEAD $orig_tip
> +test_perf 'use lookup table' '
> +    git config pack.writeBitmapLookupTable true
>  '

This part doesn't need to use 'test_perf', since we don't care about the
performance of running "git config". Instead, using
`test_expect_success` is more appropriate here.

> -test_partial_bitmap
> +test_perf 'repack to disk (lookup table)' '
> +    git repack -adb
> +'
> +
> +test_full_bitmap
> +
> +for i in false true
> +do
> +	$i && lookup=" (lookup table)"
> +	test_expect_success "create partial bitmap state$lookup" '
> +		git config pack.writeBitmapLookupTable '"$i"' &&
> +		# pick a commit to represent the repo tip in the past
> +		cutoff=$(git rev-list HEAD~100 -1) &&
> +		orig_tip=$(git rev-parse HEAD) &&
> +
> +		# now kill off all of the refs and pretend we had
> +		# just the one tip
> +		rm -rf .git/logs .git/refs/* .git/packed-refs &&
> +		git update-ref HEAD $cutoff &&
> +
> +		# and then repack, which will leave us with a nice
> +		# big bitmap pack of the "old" history, and all of
> +		# the new history will be loose, as if it had been pushed
> +		# up incrementally and exploded via unpack-objects
> +		git repack -Ad &&
> +
> +		# and now restore our original tip, as if the pushes
> +		# had happened
> +		git update-ref HEAD $orig_tip
> +	'
> +
> +	test_partial_bitmap
> +done

Could we extract the body of this loop into a function whose first
argument is either true/false? I think that would improve readability
here, and potentially clean up the diff a little bit.

For what it's worth, I don't think we need to do anything fancier for
the test name other than:


    test_partial_bitmap () {
      local enabled="$1"
      test_expect_success "create partial bitmap state (lookup=$enabled)" '
        git config pack.writeBitmapLookupTable "$enabled" &&
        [...]
      '
    }

    test_partial_bitmap false
    test_partial_bitmap true

or something.

> +for i in false true
> +do
> +	$i && lookup=" (lookup table)"
> +	test_expect_success "create partial bitmap state$lookup" '
> +		git config pack.writeBitmapLookupTable '"$i"' &&
> +		# pick a commit to represent the repo tip in the past
> +		cutoff=$(git rev-list HEAD~100 -1) &&
> +		orig_tip=$(git rev-parse HEAD) &&
> +
> +		# now pretend we have just one tip
> +		rm -rf .git/logs .git/refs/* .git/packed-refs &&
> +		git update-ref HEAD $cutoff &&
> +
> +		# and then repack, which will leave us with a nice
> +		# big bitmap pack of the "old" history, and all of
> +		# the new history will be loose, as if it had been pushed
> +		# up incrementally and exploded via unpack-objects
> +		git repack -Ad &&
> +		git multi-pack-index write --bitmap &&
> +
> +		# and now restore our original tip, as if the pushes
> +		# had happened
> +		git update-ref HEAD $orig_tip
> +	'
> +
> +	test_partial_bitmap
> +done

Same note here.

Thanks,
Taylor
