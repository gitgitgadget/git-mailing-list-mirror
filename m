Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE28C2BB85
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47622206C3
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 22:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="bufm24l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47622206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgDLWWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 18:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgDLWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 18:22:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A079C0A88B5
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 15:22:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r4so3688695pgg.4
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hI7pG1swT2TcQo44Oyf1o23sAU3aDPFN6o/rFOBUCsk=;
        b=bufm24l2qEiVG52LOOcEY9TP0ccYdi84ODYewv8szutzAi0I8D3ikYDXdYJZwVTV/r
         8iElf/aKNtUQ6cHzi+Mh00jJvZhYEAiU+KZaDJp8o/ADTQw44nGvIN8A960r6yy5maW1
         y35zt355+4RvYw1sNNWUOLjxbjIH7NwC8IWIoW6M6pOkpT3fux2H4n/CI/HcOwwtzzd3
         mvBmshV48sVDTRVduN0lQtP9Zz/oNJ5jxJiEQ8fuclAob0KZM+kN4SFsuwxpQkQzto2x
         IVBKuCChIgNEl9j3jrb+nyNPkeGw/LoybJcgmd+edyMAsBTk9u4YKDFQ2LD6i82eUnyj
         aK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hI7pG1swT2TcQo44Oyf1o23sAU3aDPFN6o/rFOBUCsk=;
        b=nEk8SRWXv+P2uKGPwAKQ2brJVUnhOH78O07OmMtLKX1m0mI8kiR/NsgKeaXfbvk8VS
         bsGta5kTVANSw27NkE618lQP83Wr9mkTSTmwboZNP1hBPFF3hMtYgyRauobOBGVOYMjI
         QfRUDitFiiFZ3PoUaH3NnO9Mc7EV7Tv3+T2rap+yJOIExybocGUUy9g9zSITzIrJ3QpU
         YhHd7NCClr+YniB+Bh4ntPZHNjABATGIO8XlKepMsg6AP+6bLJLpk8dkV8hIUBCKH4ou
         Vdnve6nfuQZ8PWbLFEr0+gAmbrFKjpB2FVqYp6JvwI9hfoMCG989oDWuC0U9OTAx235j
         2V/A==
X-Gm-Message-State: AGi0PuZTcaLpym9PO9rPqkieokH6A9dPT89FkF7RsLhiw/CBnUxtuiGn
        ZDwkaTcM+rAR3CcKO6ZnHoF5ew==
X-Google-Smtp-Source: APiQypJC7Mzlmvwhlx81I6cgWKxLBUJvGayTNh+ZJhZA7Ld7xIiHe3Wd0/f9u9KTM/uHgLdWly6mmg==
X-Received: by 2002:a63:29c1:: with SMTP id p184mr14837140pgp.37.1586730132763;
        Sun, 12 Apr 2020 15:22:12 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id l9sm7360220pjl.20.2020.04.12.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 15:22:12 -0700 (PDT)
Date:   Sun, 12 Apr 2020 16:22:10 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200412222210.GA53057@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Sat, Apr 11, 2020 at 01:02:59AM +0000, Derrick Stolee via GitGitGadget wrote:
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

All makes sense to me, and this seems like the only reasonable thing
*to* do in this situation. That's fine, since we're not regressing,
we're just not using Bloom filters.

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

Nicely done.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  revision.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 2b06ee739c8..e37b5b06108 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -661,6 +661,15 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  	if (!revs->commits)
>  	    return;
>

I certainly wouldn't complain about a comment here explaining these
three checks, but I suppose that the rationale is only a 'git blame'
away (and I guess that is faster now after this series ;-)).

> +	if (revs->prune_data.has_wildcard)
> +		return;
> +	if (revs->prune_data.nr > 1)
> +		return;
> +	if (revs->prune_data.magic ||
> +	    (revs->prune_data.nr &&
> +	     revs->prune_data.items[0].magic))
> +		return;
> +
>  	repo_parse_commit(revs->repo, revs->commits->item);
>
>  	if (!revs->repo->objects->commit_graph)
> --
> gitgitgadget

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
