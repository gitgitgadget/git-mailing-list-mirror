Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D6C43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2870208B8
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 22:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1fG3Wjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIQWNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQWNH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 18:13:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44235C06174A
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 15:13:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so5402074ejf.6
        for <git@vger.kernel.org>; Thu, 17 Sep 2020 15:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yy4CEOk3qe/S4EL0uPXLG6WpUtQy/R/7uEAW4C/GKo8=;
        b=f1fG3Wjy8N39eAfnGf1vMqpzDEdMfRlVRTisCW08wW2QvsHxIZCyq6wVesv6eL6gDO
         phSr++5+rr7AqpZzXHeMGgM7G3xkWAzcRS3pUR28SlyQD4ZBPfi6Goh9KUNZc7EplwD/
         clI5mk+LI6P2M8Yz2b7oSajUZjYRahYEgVLPVEYLksrjKVmICg9tqzbPBt0u6uOYsl94
         eeMMCg1n+mel3s/ot4fZBq7iUYJMtnzQm59XNfct1WL/PZm5/GOWgJiXusF/gbYBR3YD
         aAgbN0tVkbWuVrMJWZ7P88POC35Vg9ZFgToxKjijxVCNONPC+QuJ8cKYleW2WRsFjkFF
         Yl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy4CEOk3qe/S4EL0uPXLG6WpUtQy/R/7uEAW4C/GKo8=;
        b=jXzHp4Dr4+kjzYlij2dZtUjjVUpyN5xziZcCEzvgNHgP4KkNPMUl5/PW1HLfgVO/wA
         Cn8NMt7odFixfS3CitAKkMHOLZDbyBm7HsOBxPd4wF9atCW+fMDX1vjbPRKpERCvnV8N
         FUTgCJoon3rN2pdO0LgnYEtUzAvrdqWgMXSvYdFy+MXdud1msIH0RK8aYL52j1cMjqCZ
         5Kst8J2Vg8SQVgvt7WRVM/+RfDbvSarPzlMXrk6eCFZLHrwrh1oxq4z7SsujwWqaI9Fp
         FbqRhV0SD0DztJwo2Pc9be2hNSwJnYUnugaAoo5HXj4dIzBwpwWqbY1kELCpB9nHs0b0
         1g7g==
X-Gm-Message-State: AOAM531pGLktP2f/2PeWfTxQxaH/uf7JjPR2axPRzL3L0Nh8JbSzzdTS
        YdZSGJJ/v9PwZN4cwokpUlVV30kIdM8=
X-Google-Smtp-Source: ABdhPJw2VZ80LE/5rvnF+32RRWIaNxM6UafVQr1VuDNQ7urTZuyv1qZoygTb4A9qtbeaI4flJgZgBw==
X-Received: by 2002:a17:906:819:: with SMTP id e25mr33836799ejd.211.1600380785751;
        Thu, 17 Sep 2020 15:13:05 -0700 (PDT)
Received: from szeder.dev (84-236-109-2.pool.digikabel.hu. [84.236.109.2])
        by smtp.gmail.com with ESMTPSA id g11sm693549edt.88.2020.09.17.15.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 15:13:05 -0700 (PDT)
Date:   Fri, 18 Sep 2020 00:13:02 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v2 10/13] bloom: encode out-of-bounds filters as non-empty
Message-ID: <20200917221302.GC23146@szeder.dev>
References: <cover.1599664389.git.me@ttaylorr.com>
 <cover.1600279373.git.me@ttaylorr.com>
 <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4653b5b4bcd254a3791797214b46722b4062dc18.1600279373.git.me@ttaylorr.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 02:07:59PM -0400, Taylor Blau wrote:
> When a changed-path Bloom filter has either zero, or more than a
> certain number (commonly 512) of entries, the commit-graph machinery
> encodes it as "missing". More specifically, it sets the indices adjacent
> in the BIDX chunk as equal to each other to indicate a "length 0"
> filter; that is, that the filter occupies zero bytes on disk.
> 
> This has heretofore been fine, since the commit-graph machinery has no
> need to care about these filters with too few or too many changed paths.
> Both cases act like no filter has been generated at all, and so there is
> no need to store them.
> 
> In a subsequent commit, however, the commit-graph machinery will learn
> to only compute Bloom filters for some commits in the current
> commit-graph layer. This is a change from the current implementation
> which computes Bloom filters for all commits that are in the layer being
> written. Critically for this patch, only computing some of the Bloom
> filters means adding a third state for length 0 Bloom filters: zero
> entries, too many entries, or "hasn't been computed".
> 
> It will be important for that future patch to distinguish between "not
> representable" (i.e., zero or too-many changed paths), and "hasn't been
> computed". In particular, we don't want to waste time recomputing
> filters that have already been computed.
> 
> To that end, change how we store Bloom filters in the "computed but not
> representable" category:
> 
>   - Bloom filters with no entries are stored as a single byte with all
>     bits low (i.e., all queries to that Bloom filter will return
>     "definitely not")
> 
>   - Bloom filters with too many entries are stored as a single byte with
>     all bits set high (i.e., all queries to that Bloom filter will
>     return "maybe").
> 
> These rules are sufficient to not incur a behavior change by changing
> the on-disk representation of these two classes. Likewise, no
> specification changes are necessary for the commit-graph format, either:
> 
>   - Filters that were previously empty will be recomputed and stored
>     according to the new rules, and
> 
>   - old clients reading filters generated by new clients will interpret
>     the filters correctly and be none the wiser to how they were
>     generated.
> 
> Clients will invoke the Bloom machinery in more cases than before, but
> this can be addressed by returning a NULL filter when all bits are set
> high. This can be addressed in a future patch.

OTOH, clients will invoke the tree-diff machinery in fewer cases than
before, because querying the Bloom filter of commits not modifying any
files will now return "definitely not".

> Finally, note that this does increase the size of on-disk commit-graphs,
> but far less than other proposals. In particular, this is generally more
> efficient than storing a bitmap for which commits haven't computed their
> Bloom filters. Storing a bitmap incurs a penalty of one bit per commit,
> whereas storing explicit filters as above incurs a penalty of one byte
> per too-large or too-small commit.

s/too-small/empty/

> In practice, these boundary commits likely occupy a small proportion of
> the overall number of commits, and so the size penalty is likely smaller
> than storing a bitmap for all commits.

                 |      Percentage of
                 |    commits modifying
                 |   0 path   |  >= 512 paths
  ---------------+------------+----------------
  android-base   |   13.20%   |   0.13%
  cmssw          |    0.15%   |   0.23%
  cpython        |    3.07%   |   0.01%
  elasticsearch  |    0.70%   |   1.00%
  gcc            |    0.00%   |   0.08%
  gecko-dev      |    0.14%   |   0.64%
  git            |    0.11%   |   0.02%
  glibc          |    0.02%   |   0.10%
  go             |    0.00%   |   0.07%
  homebrew-cask  |    0.40%   |   0.02%
  homebrew-core  |    0.01%   |   0.01%
  jdk            |    0.26%   |   5.64%
  linux          |    0.01%   |   0.51%
  llvm-project   |    0.12%   |   0.03%
  rails          |    0.10%   |   0.10%
  rust           |    0.07%   |   0.17%
  tensorflow     |    0.09%   |   1.02%
  webkit         |    0.05%   |   0.31%


> A test to exercise filters which contain too many changed path entries
> will be introduced in a subsequent patch.


> diff --git a/bloom.h b/bloom.h
> index c6d77e8393..70a8840896 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -93,6 +93,7 @@ enum bloom_filter_computed {
>  	BLOOM_NOT_COMPUTED = (1 << 0),
>  	BLOOM_COMPUTED     = (1 << 1),
>  	BLOOM_TRUNC_LARGE  = (1 << 2),
> +	BLOOM_TRUNC_SMALL  = (1 << 3),

s/SMALL/EMPTY/

This "small" suffix in the constant, variable, and trace2 key names is
misleading, because we only mean empty commits.

>  };
>  
>  struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
> diff --git a/commit-graph.c b/commit-graph.c
> index 1ca754f19c..bd4247bca5 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -974,6 +974,7 @@ struct write_commit_graph_context {
>  
>  	int count_bloom_filter_computed;
>  	int count_bloom_filter_not_computed;
> +	int count_bloom_filter_trunc_small;
>  	int count_bloom_filter_trunc_large;
>  };
>  
