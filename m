Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E8C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF49B64E44
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 19:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhBKTn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 14:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhBKTn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 14:43:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8DC061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:43:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l25so11851248eja.9
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iz+8R60MktJWGxW1PtNT+qumTWCx1YwGxhghskr7nMU=;
        b=OYQ5KYIdx+B0vIPucytqU/L705rYB1SMZxRNamftTyL12AjGs+BdZMhnChe2yOseep
         5Zvv72exk9qLaJyb0MU+2tlF+zl4PeA4iY0Py8XXqWKAoBGzGMSXXmOZqTDej3jqn9uT
         zsTrAzKBmaLwk0bDucKEhzPQx15mNVpuMvXQ+KxrZSxxfrnmXGn07IRvgOuAArL22+J3
         sQ4Sz7ZuPQD3b3Zvf000U5o/NhmmLhiX/j7pnbnkf8DiBkklkO1brjbhT/14Yqrr2ie0
         kYXDMybE8QFhBsjPUm+LzpvdDcs+vRIHRYirh4OUQJ8utXjtfwm2HtZ6T1CVmlmSOQkJ
         kaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iz+8R60MktJWGxW1PtNT+qumTWCx1YwGxhghskr7nMU=;
        b=iqO00LcfNyesayAxGJmRcWFLe/0Ie8KTVWHCT7po2pza7HvPonQhQvp5JXod8a2xfF
         INRVP++/sP8lEDkHowPJ1MVzBoKdwvmO35DQgZ3F0S0sRqHHsr4YGhtAdsSKvbYv39U3
         hK1gA7509nY8AsGHoGpz6SJSBTpHWvKh2N0tven5fAtUzOsJ6P3E6gfSUkTqwQ5pYE+H
         5pr6psDLUclCX0QpLbaMedCb9jA1hr/RiHyKD5gFIX4KMQixJAiFD/62rSrYi3fIPYyj
         BuHoFZtBweD645eWH59gINsVse3H3BXGDZJASabj7+g2Ivz9SskbvteBQ3N9h9vlfZjT
         yHng==
X-Gm-Message-State: AOAM530aGtdmhcAdoY55j+7HhbPalFQh6s5IGQHjvFRthp0w4M4YuxG0
        u8nW1P6YJGj5E0C1e4gDzns=
X-Google-Smtp-Source: ABdhPJxxMS0D3B9DaIlwfo8TwOLFjv5jilvBnZJ+U6FKNDHXSmuPlIq3YiCTvxpZsisiTj7g8/O/MQ==
X-Received: by 2002:a17:906:5d15:: with SMTP id g21mr10338095ejt.373.1613072594953;
        Thu, 11 Feb 2021 11:43:14 -0800 (PST)
Received: from szeder.dev (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id er1sm5334773ejc.69.2021.02.11.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 11:43:14 -0800 (PST)
Date:   Thu, 11 Feb 2021 20:43:12 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        l.s.r@web.de, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 02/17] chunk-format: create chunk format write API
Message-ID: <20210211194312.GI1015009@szeder.dev>
References: <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <pull.848.v3.git.1612535452.gitgitgadget@gmail.com>
 <16c37d2370cf4fd5fc309ac6dc8aa6443ffcf3d7.1612535453.git.gitgitgadget@gmail.com>
 <20210207211359.GD1015009@szeder.dev>
 <96d4f87d-eb6e-faec-1d22-5f6ae307b624@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96d4f87d-eb6e-faec-1d22-5f6ae307b624@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 08, 2021 at 08:44:06AM -0500, Derrick Stolee wrote:
> On 2/7/2021 4:13 PM, SZEDER Gábor wrote:
> >> +#define CHUNK_LOOKUP_WIDTH 12
> > 
> > As this macro is defined in 'chunk-format.c' it's not part of the
> > chunkfile API.  However, at the end of this patch series
> > 'commit-graph.c' still contains:
> > 
> >   #define GRAPH_CHUNKLOOKUP_WIDTH 12
> > 
> > and uses it in a couple of safety checks (that didn't became part of
> > the common chunkfile module; why?),
> 
> Chunk-based files don't have a minimum size unless we know the header
> size and a minimum number of required chunks. I suppose that we could
> add this in the future to further simplify consumers of the API.
> 
> > while 'midx.c' contains:
> > 
> >   #define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
> > 
> > though it's not used anymore.
> > 
> > I think we should have only one such constant as part of the chunkfile
> > API; and preferably use the definition from 'midx.c' as it is more
> > informative than yet another magic number.
> > 
> > Furthermore, being called 'CHUNK_LOOKUP_WIDTH', I had to look up the
> > places where this constant is used to make sure that it indeed means
> > what I suspect it means.  Perhaps CHUNK_TOC_ENTRY_SIZE would be a more
> > descriptive name for this constant.
> 
> More descriptive, for sure.
> 
> > On a somewhat related note: 'commit-graph.c' and 'midx.c' still
> > contains the constants MAX_NUM_CHUNKS and MIDX_MAX_CHUNKS,
> > respecticely, but neither of them is used anymore.
> 
> Thanks. The following patch can be added on top of this series
> to clean up these dangling macros.

It would be better to squash this into the patches that removed the
last uses of each of those constants.

And it still leaves the magic number '12' duplicated in
'commit-graph.c' and 'chunk-format.c'.

> Thanks,
> -Stolee
> 
> --- >8 ---
> 
> From 839b880ccee65eac63e8b77b12fab6531acc55b0 Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <dstolee@microsoft.com>
> Date: Mon, 8 Feb 2021 08:38:47 -0500
> Subject: [PATCH] chunk-format: remove outdated macro constants
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The following macros were needed by midx.c and commit-graph.c to handle
> their independent implementations of the chunk-based file format, but
> now the chunk-format API makes them obsolete:
> 
> * MAX_NUM_CHUNKS
> * MIDX_MAX_CHUNKS
> * MIX_CHUNKLOOKUP_WIDTH
> 
> Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 1 -
>  midx.c         | 2 --
>  2 files changed, 3 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 32cf5091d2f..3b5a8767269 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -45,7 +45,6 @@ void git_test_write_commit_graph_or_die(void)
>  #define GRAPH_CHUNKID_BLOOMINDEXES 0x42494458 /* "BIDX" */
>  #define GRAPH_CHUNKID_BLOOMDATA 0x42444154 /* "BDAT" */
>  #define GRAPH_CHUNKID_BASE 0x42415345 /* "BASE" */
> -#define MAX_NUM_CHUNKS 9
>  
>  #define GRAPH_DATA_WIDTH (the_hash_algo->rawsz + 16)
>  
> diff --git a/midx.c b/midx.c
> index 95648a1f368..5c7f2ed2333 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -22,14 +22,12 @@
>  #define MIDX_HEADER_SIZE 12
>  #define MIDX_MIN_SIZE (MIDX_HEADER_SIZE + the_hash_algo->rawsz)
>  
> -#define MIDX_MAX_CHUNKS 5
>  #define MIDX_CHUNK_ALIGNMENT 4
>  #define MIDX_CHUNKID_PACKNAMES 0x504e414d /* "PNAM" */
>  #define MIDX_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
>  #define MIDX_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
>  #define MIDX_CHUNKID_OBJECTOFFSETS 0x4f4f4646 /* "OOFF" */
>  #define MIDX_CHUNKID_LARGEOFFSETS 0x4c4f4646 /* "LOFF" */
> -#define MIDX_CHUNKLOOKUP_WIDTH (sizeof(uint32_t) + sizeof(uint64_t))
>  #define MIDX_CHUNK_FANOUT_SIZE (sizeof(uint32_t) * 256)
>  #define MIDX_CHUNK_OFFSET_WIDTH (2 * sizeof(uint32_t))
>  #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
> -- 
> 2.30.0.vfs.0.0.exp
> 
