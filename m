Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6753DC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEAB206E6
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utmU8+G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgFDOgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFDOgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:36:52 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22988C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 07:36:52 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g7so2980791qvx.11
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dk04xzI7ZtCcPnqCSSKQmr2Dt+7ZkcAP9Omd49rbEx0=;
        b=utmU8+G6pfQAZKtrrhnozHG7DgNoM6It7bLrW+qAsgrSSuMHqTR4mK+iCp4KTBXANi
         u5CZMM+xaxXQnYWU+fek5XrBpeS4/4aoqT/9M4YB25CExqIjzphhv9T9fFW3uyzDz3M7
         v/WkRIxRTthTajeaMq9q1yYBaqjBnExxOydLqq6M6bNeNSwsUQ+jr0up3e9zcFsGfWJi
         DocMa6EybauB1CiN82cCIwd4SG6mWQrCYonhWHFf4nf3qX6oGnEB7KfgIbE93eNXiePr
         Eicve5dJsTCPInMnjZALrb/pJukIiBt2j3OE5pwHNAMjnLRoBbzundi2LlSkvUlsLVdj
         2omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dk04xzI7ZtCcPnqCSSKQmr2Dt+7ZkcAP9Omd49rbEx0=;
        b=PxgrCfZBsaHK9STII0+0fDDp3MbIKMv0mFJhaN7rtkHMYOarwKynpHnL9oRRnj81Iw
         LgEHg8+4tHkxqKIusYx2Eqlo+qBmV7/lS35qAX48JGGDSlQzDqcFiAtx92R0l420Gx6q
         1gmtsBVG/w+WdBMCXFx+ay6gDnCepBhPgrcqiG/Lok5jt5qb5pXWlbkNohgHfUzJfrEo
         I8M8GUPH3EG7L5ccSKPtQDtc7TgxVELbHNjZkOw9Fy1ObDvMjOvpsjldHLqFarpBRYLq
         QE8ogLulUG0/fXzxGOEf6xf+fBiyu2O6LMKX0MLxAuQIzlqUKYEsX7dI8xI7OpPL16ix
         U9OQ==
X-Gm-Message-State: AOAM533YcPO3ycJjKz2LFNHB1Uf7UiFyRHlEPVJ7l/asEX8griZut2uB
        ow43poQbaxkabE10URFJ9Ws=
X-Google-Smtp-Source: ABdhPJxhOGd8+ObuEOb4ABUa0kOMqROl0EMhb0K+ub5GjxYxWzz8yt1jJRUNq/q+19buIva/KI+R+w==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr5155639qvw.194.1591281411290;
        Thu, 04 Jun 2020 07:36:51 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 130sm4334905qko.113.2020.06.04.07.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 07:36:50 -0700 (PDT)
Subject: Re: [GSoC Patch 1/3] commit: introduce helpers for generation slab
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200604072759.19142-2-abhishekkumar8222@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <be28ab7b-0ae4-2cc5-7f2b-92075de3723a@gmail.com>
Date:   Thu, 4 Jun 2020 10:36:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200604072759.19142-2-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> The struct member generation refers to "generation number" (or more
> broadly, a reachablity index value) used by commit-graph to reduce time
> taken to walk commits. However, generation is not useful in other
> contexts and bloats the struct.
> 
> Let's move it to a commit-slab and shrink the struct by four bytes.
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 27 +++++++++++++++++++++++++++
>  commit-graph.h |  5 +++++
>  commit.h       |  3 ---
>  3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index e3420ddcbf..63f419048d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,33 @@ static int commit_pos_cmp(const void *va, const void *vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>  
> +define_commit_slab(generation_slab, uint32_t);
> +static struct generation_slab generation_slab = COMMIT_SLAB_INIT(1, generation_slab);
> +
> +uint32_t generation(const struct commit *c)
> +{
> +	uint32_t *gen = generation_slab_peek(&generation_slab, c);
> +
> +	return gen ? *gen : GENERATION_NUMBER_INFINITY;
> +}

This is good: if we don't have the value, then use INFINITY.
In the header file, perhaps include a warning comment that a
caller _must_ first parse the commit or else we have no guarantee
that the generation slab is populated. This matches the current
expectations before accessing the generation member.

> +static void set_generation(const struct commit *c, const uint32_t generation)
> +{
> +	unsigned int i = generation_slab.slab_count;
> +	uint32_t *gen = generation_slab_at(&generation_slab, c);
> +
> +	/*
> +	 * commit-slab initializes with zero, overwrite this with
> +	 * GENERATION_NUMBER_INFINITY
> +	 */
> +	for (; i < generation_slab.slab_count; ++i) {
> +		memset(generation_slab.slab[i], GENERATION_NUMBER_INFINITY,
> +		       generation_slab.slab_size * sizeof(uint32_t));
> +	}

Here is an example where combining the graph_pos and generation
slabs into one would be helpful. The only reason the generation
would be INFINITY is if graph_pos is COMMIT_NOT_FROM_GRAPH. If
the two values are side-by-side, we could just check graph_pos
first and return INFINITY instead of paying this initialization
cost as the slab grows.

I would also like to avoid initializing the slab if there is
no commit-graph present. I wonder if we can populate the slab
while parsing the commit-graph and check here if the slab is
NULL before doing any other logic? (I'm not sure if this is
possible, but it would be nice.)

> diff --git a/commit-graph.h b/commit-graph.h
> index 4212766a4f..653bd041ad 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,10 @@
>  #include "object-store.h"
>  #include "oidset.h"
>  
> +#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> +#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> +#define GENERATION_NUMBER_ZERO 0
> +
>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
>  #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
> @@ -137,4 +141,5 @@ void free_commit_graph(struct commit_graph *);
>   */
>  void disable_commit_graph(struct repository *r);
>  
> +uint32_t generation(const struct commit *c);
>  #endif
> diff --git a/commit.h b/commit.h
> index 1b2dea5d85..cc610400d5 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -11,9 +11,6 @@
>  #include "commit-slab.h"
>  
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> -#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> -#define GENERATION_NUMBER_ZERO 0

I appreciate that you are able to relocate these constants to
a more appropriate location.

Thanks,
-Stolee


