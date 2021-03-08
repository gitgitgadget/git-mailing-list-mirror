Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0ABC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3C6565121
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCHMu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCHMt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 07:49:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939DC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 04:49:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p1so14581427edy.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 04:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=I0tJJUesjee305HKburvgruUZ1LE9pyHZyTLn4CyWsU=;
        b=SeQHl9c5Wd5GnVh/zzYPc9iy3BHCaVLJ5xZcWTzr/zURzorfI9rCBSylt0asN0SA/z
         TiiFyzxlWRFldhJFUi9QFt9qkThvHUi6C01JCc+xwkaoWr7UQK/LtMX+Ml793jd3Qtvj
         MTH3FBWNSBeI4kBtN/suF/5OV+JMCJZG4IPH27/3Ok207P9ZVc1VMu8xiqH1yydM+yWh
         5ckX2RPN38l2/UwYbcXUR2Dbv3kjv57m/xtlqpSrUwT2xljASu9u9jqH6gmIUHmjdc0s
         r0QOHiW2PKKD9f5MCb0UYgavrQdjLnZVPtwsQ0dUtg5gP/aNrErCOG5xlwYljq8ZnzKQ
         Uacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=I0tJJUesjee305HKburvgruUZ1LE9pyHZyTLn4CyWsU=;
        b=ocTNY+ECDm+zUw9Bb1x6RngZiydRstN0crUVxpGQjBgd8cDew3GBi/Pjhw8bRj7QSU
         WKIM2A/PmbJCOS02lMoRZBhufnjGSQ1gP7M3l8vUHhmpyCcovNukweCcGjsbYnYtNmkd
         wLJPbVIbcuAvDTOTw3TXs20IXef+wNC7e1SZaEDPq9EvL2uTyzgUSmUQ+bfkVtYA/Wo0
         4qwc6D0tSHJU+NEMokze4ktcttvKtpbFbf84dzOP38nFYdwxcZ2FK4hROjPu0Q5dodav
         s9vZ+gclvHj6Y61FFz01swKba8SdSJuMUR7oxyjde1rbnqKxus5r80b352kbcZM6MBlq
         BDUA==
X-Gm-Message-State: AOAM5338EM68k0VJv7vM+buhIl8Zd0jfcDrLU4Sp/GkED1fz/bDZPurt
        x/D5gn534RYnZ5qXUGJGXsWH6jFPUeP3lA==
X-Google-Smtp-Source: ABdhPJyzSZoaQog0kKWMXtimnTvHS0zVjHV9O63ZGTLTQsK4PQasnKo9mng7jpYczX0zCNZBBQX2Ag==
X-Received: by 2002:a50:9dc9:: with SMTP id l9mr21754047edk.377.1615207794130;
        Mon, 08 Mar 2021 04:49:54 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d6sm6663769eje.20.2021.03.08.04.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:49:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 04/11] merge-ort: have ll_merge() calls use the
 attr_index for renormalization
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <cb035ac5fe4ab18b697eff42afedcab62880ceec.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <cb035ac5fe4ab18b697eff42afedcab62880ceec.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 13:49:53 +0100
Message-ID: <87a6rdkdxq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> ll_merge() needs an index when renormalization is requested.  Give it
> the special one we created exactly for that purpose.  This fixes t6418.4
> and t6418.5 under GIT_TEST_MERGE_ALGORITHM=ort.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 028d1adcd2c9..87c553c0882c 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -360,7 +360,7 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
>  	string_list_clear(&opti->paths_to_free, 0);
>  	opti->paths_to_free.strdup_strings = 0;
>  
> -	if (opti->attr_index.cache_nr)
> +	if (opti->attr_index.cache_nr) /* true iff opt->renormalize */
>  		discard_index(&opti->attr_index);

Perhaps instead of a comment, in that "if":

    assert(opt->renormalize);

>  	/* Free memory used by various renames maps */
> @@ -988,7 +988,6 @@ static int merge_submodule(struct merge_options *opt,
>  	return 0;
>  }
>  
> -MAYBE_UNUSED
>  static void initialize_attr_index(struct merge_options *opt)
>  {
>  	/*
> @@ -1063,6 +1062,8 @@ static int merge_3way(struct merge_options *opt,
>  	char *base, *name1, *name2;
>  	int merge_status;
>  
> +	initialize_attr_index(opt);

Subjective, but I think it's more readable to move the "initialized"
check in initialize_attr_index() here, so:

    if (!attr_index->initialized)
        initialize_attr_index(opt);

Saves the reader a trip to the function to see that it doesn't do
anything except exit early on that flag.

>  	ll_opts.renormalize = opt->renormalize;
>  	ll_opts.extra_marker_size = extra_marker_size;
>  	ll_opts.xdl_opts = opt->xdl_opts;
> @@ -1101,7 +1102,7 @@ static int merge_3way(struct merge_options *opt,
>  
>  	merge_status = ll_merge(result_buf, path, &orig, base,
>  				&src1, name1, &src2, name2,
> -				opt->repo->index, &ll_opts);
> +				&opt->priv->attr_index, &ll_opts);
>  
>  	free(base);
>  	free(name1);

