Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB24C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D033E64F4F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 13:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhCQNfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhCQNfK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 09:35:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A62C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:35:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y6so2310963eds.1
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=L5gg9/PeMQWRRNGlL5ziaq1gOqAW7hUXT0OmZcofcyM=;
        b=lY7PkMPQgBjrGvnm01qTOW/Ci835xUoyvPPkgitNEmVo09gMfQJseOZir/avJxiTfF
         T4hST/OFsKSTmxC685Uk86HS35yXJeuj1lknZn+ur+VJIcKRd5q4uGCODe/Jw4jnVNsF
         r0yArRxuLWDA3ha9I8km3UypopX7eZLwSAbLtEeYbzj1xcJHG1MYrm9HR30yKGx9/TpI
         70yGuJ8GlIaw9puFDxZMmXF8ePI14IfCekkCp0dJGdR85PlQFeDpg01S53iKQ6oO8kTf
         srEzgF1JlazIWTf4u4IKcbyg3Cz3l5rHnbedIRAS+nggOCm6EXf2IUiG35i/V9DNGk+H
         FFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=L5gg9/PeMQWRRNGlL5ziaq1gOqAW7hUXT0OmZcofcyM=;
        b=nvDtFoYyywikGzOyXatx4Zs5PgqizmXOnmkOYh2i/p9nazX/2pUtvl/656sw1oqERI
         HwXB5Xv5jvLaybP6Y1XCti0mreiYJbyvCj7RZ+wCK/wZy6W4RqMtULBTWDttwy7tDIrS
         IG/Nhq673MnMDAl9Su87+97rC0RjjOoMBVXkQuR30ShG8mnySSvTfOT7oI7/QUTFEzra
         FKQdA3lvmUs0j3AnYzotXeon/5/I1xlyiSK0vC1e+iuPluS8Gt5UojSHEOphk5Lz45lR
         QXleLfo5sa/absRUIXYOV1GYkgjR3qjxvgmib0LyfMZcam4qRh0DFWAfcidx6wHLCHHX
         rbkA==
X-Gm-Message-State: AOAM533LcDuC8bKmUuq6ouiCNolDunl/p1Wtu8sHSZPiT0RBmy5RgbwV
        dtrtkfF8PE6maMBYGPjFdUaPLw+Wn7b3cQ==
X-Google-Smtp-Source: ABdhPJxLkXEuHtJZsP2LJh9Aj98D77rWaD/vpz4xrgrhGNBiK95fC4AQ70itttT48qgbMfIMTRP4OQ==
X-Received: by 2002:aa7:c6da:: with SMTP id b26mr42460051eds.254.1615988108592;
        Wed, 17 Mar 2021 06:35:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u24sm11715808ejr.34.2021.03.17.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:35:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 13/20] unpack-trees: allow sparse directories
References: <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <4000c5cdd4cf6008358a02d1b0244b24e61b3e3e.1615912983.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <4000c5cdd4cf6008358a02d1b0244b24e61b3e3e.1615912983.git.gitgitgadget@gmail.com>
Date:   Wed, 17 Mar 2021 14:35:07 +0100
Message-ID: <87zgz1zywk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The index_pos_by_traverse_info() currently throws a BUG() when a
> directory entry exists exactly in the index. We need to consider that it
> is possible to have a directory in a sparse index as long as that entry
> is itself marked with the skip-worktree bit.
>
> The 'pos' variable is assigned a negative value if an exact match is not
> found. Since a directory name can be an exact match, it is no longer an
> error to have a nonnegative 'pos' value.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 2da3e5ec77a1..e81d82d72d89 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -749,9 +749,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
>  	strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
>  	strbuf_addch(&name, '/');
>  	pos = index_name_pos(o->src_index, name.buf, name.len);
> -	if (pos >= 0)
> -		BUG("This is a directory and should not exist in index");
> -	pos = -pos - 1;
> +	if (pos >= 0) {
> +		if (!o->src_index->sparse_index ||
> +		    !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
> +			BUG("This is a directory and should not exist in index");
> +	} else
> +		pos = -pos - 1;

Style nit: add {}'s to the "else" once the "if" gets one.

>  	if (pos >= o->src_index->cache_nr ||
>  	    !starts_with(o->src_index->cache[pos]->name, name.buf) ||
>  	    (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))

