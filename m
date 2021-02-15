Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEAC433DB
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E40264E02
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 21:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOVkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 16:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhBOVkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 16:40:00 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD8DC061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:39:19 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n13so6959772ejx.12
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 13:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=8V3H/Pmnpw0vjjXoM+GW3/r8qCCCpnrzeTAc1/eaBQs=;
        b=QUdV9iVkIdrLcpM3g8kxe6o10eUh2xDcB0bCpoUboREAfuoIaCIzT22+vV9D+kN4Nx
         Buvne7kgNemAg17O2tByog0p6g3xUId8mP/2ulGlbRhM1qUV0ckhwlM8Vt+n8IFKptSR
         ECfW+4meAbx3bFkCZRXfmbH97UYUl09mnyINCiKryre0PxJkur7uUj6MxD6WRhvfvDiY
         Ywafe7BnJqJnSDu/sLqAI5BuAtEB6t9QNoL/t0+HBwv3KsZYk35zWF0/mfB7F9+rUohb
         NF4D+HTcrRfk9Kl8u/vqE7M3Dnck4OtqVhvIeoS4s3LKeE5o2v7WJ8U3OoORh6eklbuf
         Xzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=8V3H/Pmnpw0vjjXoM+GW3/r8qCCCpnrzeTAc1/eaBQs=;
        b=sEju6v70DnAsUsZ6q4YSpsCEU2a45l2FtWmo712NtBi5r9W9LI2ieFDytyD0tHR0co
         CyK+NTk9tAHKgs0x2V4ZjFHJM5oeDd9cgZnHeBrGmCZJ50yk7oQ9/CMwX1zvrsMP+8q5
         6Xx0eEwb+BMbxEL89uuj1+QrafuMTy+NBt8jmiMVCTFexfO94V5SkvIwhRrhKx7UMqXx
         s8h7iipGQ/BN5qusfD3Qc4QmwsQ6ICwNlJ25JaJXfSQiD4HWvVQ/UKNpvClYOKzeg03/
         4Sehmkesc2iC+3k7qbLxXuEHeBHnh7FkMbw/C1T6HoG878SSNmZ3tygnOa9PB7TwmeM7
         K1XA==
X-Gm-Message-State: AOAM530O0Tsfv63TSZJHIJKgk7WJIuNJRpFgEuXdCpxIfA2W0SdYwLgZ
        tG2H+QggZtLDBAc5x07D7tk=
X-Google-Smtp-Source: ABdhPJxC6aX/jkZ9+nU3oiEHozLHKjCRIKt5sZm3jaykdQMJ0GJtUhqyuLMCLPe7wuJLKIskwm6igQ==
X-Received: by 2002:a17:906:17c3:: with SMTP id u3mr17255235eje.304.1613425158271;
        Mon, 15 Feb 2021 13:39:18 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id g3sm11742224edk.75.2021.02.15.13.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 13:39:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] builtin/multi-pack-index.c: don't handle
 'progress' separately
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
 <abcc7fb7312b349562fe6d13e2250496e107c9ed.1613422804.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <abcc7fb7312b349562fe6d13e2250496e107c9ed.1613422804.git.me@ttaylorr.com>
Date:   Mon, 15 Feb 2021 22:39:16 +0100
Message-ID: <87a6s5au4b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Taylor Blau wrote:

> @@ -31,15 +30,14 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  
>  	git_config(git_default_config, NULL);
>  
> -	opts.progress = isatty(2);
> +	if (isatty(2))
> +		opts.flags |= MIDX_PROGRESS;
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_multi_pack_index_options,
>  			     builtin_multi_pack_index_usage, 0);
>  
>  	if (!opts.object_dir)
>  		opts.object_dir = get_object_directory();
> -	if (opts.progress)
> -		opts.flags |= MIDX_PROGRESS;


Funnily enough we could also just do:

    opts.flags = isatty(2);

Since there's a grand total of one flag it knows about, and
MIDX_PROGRESS is defined as 1.

Not the problem of this series really, just a nit: In efbc3aee08d (midx:
add MIDX_PROGRESS flag, 2019-10-21) we added this flag, and around the
same time the similar commit-graph code got refactored to have an enum
of flags in 5af80394521 (commit-graph: collapse parameters into flags,
2019-06-12).

I prefer the commit-graph way of having a clean boundary between the two
a bit more, and then just setting a flag based on an OPT_BOOL...
