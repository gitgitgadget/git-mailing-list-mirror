Return-Path: <SRS0=8Spe=7U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1849C433E0
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763762067B
	for <git@archiver.kernel.org>; Sun,  7 Jun 2020 20:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyEZiPGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgFGUd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Jun 2020 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgFGUd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Jun 2020 16:33:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F1C08C5C3
        for <git@vger.kernel.org>; Sun,  7 Jun 2020 13:33:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so15218331wrn.11
        for <git@vger.kernel.org>; Sun, 07 Jun 2020 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BVykrW13jGCsisRTIGsuWH589AEue8bvnQQUjRopGUQ=;
        b=nyEZiPGW9NBy8G1qDRLGmkooFSwc3w919ryUCgmphOi/KC7rYc/MpvrgR8o0uetcOS
         quLdYRHH0Ft6uWhVkZ3/Jfu2v8V7+lhgpzLzAPoMJ0ncA73ag9CqnNkE3abZ+tGgwRgS
         odPMfT2Dm4GODwgJAMqpZ6iQfORnVXMpy1OEoLA5Lv1BfPzIh7cotg9D9xobtN4YwqLH
         5dG3pc58wAvsjs6Mhokh/PEJaTw+sUOKDJyjSD7qpfaH7JIF3bEuMfAE07uwkhQUY4cn
         M7eYEfgVq6HiNWwFpUfn09SjyQfnlUOwbvU6hJeKIoRcKnA0tsU4A5AkNUuKfUrXllza
         SwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BVykrW13jGCsisRTIGsuWH589AEue8bvnQQUjRopGUQ=;
        b=RKbXnbgvFhWUr9kmRFpi7veBufvJUkyQZJzanBcGxVl7ZCOAmHq2fCddNRoPyg6Uj8
         T07C0ZWFiAnjlmcmbmvKWYuB9nKCyY7AL3Vw2zjOanAcWpSjJe3lO9aLyS/0RHZJ7X1w
         0cWLL31uZJPls+tRTA5Y87SWjSCkdkfgIneIH9YUOgSS8+YmcJKLyFvnnb8M51dBU33g
         5EmFzyu59PgFTKlnE1lYzdBg+oAlesNJdG7SWj60x7GVaChCxHDw9qB5vHrvImppEc6F
         xeDca416aPwqSoFxbUqXrEfq9eyz3yK9MNg/omihqka7NFtIum9Hgqn0c/RmuuQZ7r7a
         sY8Q==
X-Gm-Message-State: AOAM530++Ezt9LyPaamDL1CiG/XoW3+AZvkctXLAwADjSFRBfl9bfVV5
        2BNmGYQj0pcFNh09R/cCW77MQZfn
X-Google-Smtp-Source: ABdhPJx6kNX7c2eRvxWjFtEK3PVCrCsXUYWmsnlR/AbgBHHLnMOjdJhLn8GxbfFoLX20/unFSZZxuw==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr19822251wrr.405.1591562007362;
        Sun, 07 Jun 2020 13:33:27 -0700 (PDT)
Received: from szeder.dev (78-131-14-185.pool.digikabel.hu. [78.131.14.185])
        by smtp.gmail.com with ESMTPSA id f185sm10415048wmf.43.2020.06.07.13.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2020 13:33:26 -0700 (PDT)
Date:   Sun, 7 Jun 2020 22:33:23 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200607203323.GB11344@szeder.dev>
References: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
 <pull.609.v3.git.1587068044.gitgitgadget@gmail.com>
 <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1587068044.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adc03eee4ac8a0911bfd2a7ae03364ef0e744ef0.1587068044.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 08:14:02PM +0000, Derrick Stolee via GitGitGadget wrote:
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

Nit: spec->magic is the bitwise OR combination of all
spec->items[i].magic, so checking the latter below is unnecessary.

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
