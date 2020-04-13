Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102FEC2BA19
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1B42063A
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="zFp1Xekm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgDMQJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgDMQJL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 12:09:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283C2C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:09:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k18so3534834pll.6
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sNnLYNFX7xVLpuDsSHege/R5XzztvpGZnD7d4D6QGLE=;
        b=zFp1Xekmppa5Bcg7exmFVM1VhNITkxgCci6aZDdSQSFAK5jZUSER9du3Otv7lbdPOh
         21y2QDWNpNYkq+iaOGUPitNpCI/OqVgSrG7DSV/1HMto1+O9ZUreIyTUccrRnAsjlV04
         NKcgtd305eK50cn0E/VX17/OiFgczC2r+Grjcwr18Jlcr9S+ZWDZ0vrAYiOGVNhaeHVh
         k9e8g7xUAMwwTxqcTrx7HtFjBRVSCa66FxCIQPZH9oAjtWdWlAQMVsyHt1mL7XTMHQYc
         /l07p1FNHBssY3IgnvOJbtI0VUGNksmRxyYqN1YXCwRu8tbs0xLCJa9pYIXn5IEarm1q
         xG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNnLYNFX7xVLpuDsSHege/R5XzztvpGZnD7d4D6QGLE=;
        b=AQCqkDpq8N+M7RiVyQRslVHX9e6zgLFNjSPZuh9z6V894uxpEqZmmtd0sDwSTRK23Y
         O8QbKQWhBKDdiPOemT9FnWwXXbLLxwY7uFHFCFQnQgnolbhwKjruf0sNayboJG55H7IY
         lVZyzX91VNagnSte7y6kJ8R1evGHFTvp1muoIdT9CZa9Hp/kuq5s1EWVYCABSsTdEAzA
         7mPVbYY8D7S0eGgo21a29GTmlOcQS/H9p1ZfMP5a67IzxV3e5BH083fQwlIEEs87zJPb
         VNri4k+C6Z5KXH9VwDuQ35iGpAcaRHMjsSZipxEIbToBT0gYjJs63vba/MYtidLIyxWQ
         U7Rg==
X-Gm-Message-State: AGi0PubUGMQqvpDquqBY9ML1/c7ODTTJdSm2luUXGT/ZNZ14Q9yQpR0K
        b7Bqs2RQ3WBP7RyBXBOi7cqOcA==
X-Google-Smtp-Source: APiQypLgzy59Rq/RWK0bbfccKZE4Y4BkjgCXyUlOU3qNBLhQhsB/KD12KRc5fPgJ5vS22dGigMscAw==
X-Received: by 2002:a17:902:347:: with SMTP id 65mr18031328pld.21.1586794150477;
        Mon, 13 Apr 2020 09:09:10 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id o125sm8154560pgo.74.2020.04.13.09.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:09:09 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:09:08 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/4] revision: complicated pathspecs disable filters
Message-ID: <20200413160908.GD59601@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1586789126.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1586789126.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 02:45:23PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The changed-path Bloom filters work only when we can compute an
> explicit Bloom filter key in advance. When a pathspec is given
> that allows case-insensitive checks or wildcard matching, we
> must disable the Bloom filter performance checks.
>
> By checking the pathspec in prepare_to_use_bloom_filters(), we
> avoid setting up the Bloom filter data and thus revert to the
> usual logic.
>
> Before this change, the following tests would fail*:
>
> 	t6004-rev-list-path-optim.sh (Tests 6-7)
> 	t6130-pathspec-noglob.sh (Tests 3-6)
> 	t6131-pathspec-icase.sh (Tests 3-5)
>
> *These tests would fail when using GIT_TEST_COMMIT_GRAPH and
> GIT_TEST_COMMIT_GRAPH_BLOOM_FILTERS except that the latter
> environment variable was not set up correctly to write the changed-
> path Bloom filters in the test suite. That will be fixed in the
> next change.
>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 2b06ee739c8..f78c636e4d0 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -650,6 +650,20 @@ static void trace2_bloom_filter_statistics_atexit(void)
>  	jw_release(&jw);
>  }
>
> +static int forbid_bloom_filters(struct pathspec *spec)
> +{
> +	if (spec->has_wildcard)
> +		return 1;
> +	if (spec->nr > 1)
> +		return 1;
> +	if (spec->magic & ~PATHSPEC_LITERAL)
> +		return 1;
> +	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
> +		return 1;
> +
> +	return 0;
> +}
> +
>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>  	struct pathspec_item *pi;
> @@ -659,7 +673,10 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	int len;
>
>  	if (!revs->commits)
> -	    return;
> +		return;
> +
> +	if (forbid_bloom_filters(&revs->prune_data))
> +		return;
>
>  	repo_parse_commit(revs->repo, revs->commits->item);
>
> --
> gitgitgadget
>

Nicely done, this looks good to me. Thanks.

Thanks,
Taylor
