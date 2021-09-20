Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0951C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 01:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9932260FC0
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 01:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhITBbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 21:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhITBbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 21:31:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73835C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 18:29:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n10so53933382eda.10
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 18:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aZKGo/WUSUIsqJ/FK7N5GOjcj/wfBiAtawb0xyQLfI8=;
        b=AWMlbmaPE0v5Qgw1HVSCQaZAjn14crw5a2ydueL+0REkEt/7/G2MvQX7trTfu2S7oC
         cmuf9UjBNs4wISYBccD4wFo5ectiVhAYF5egd3QEiR6c48izaboIo49yu6m4uFmV+DAC
         JIfRL+FwOZ1QGYshKr/QeYLT1NSBUUv9QQmFL49s1ibF2Z5zPBVqJE/VSxkxt9O6Eq3g
         +H1s08g2K0Xa/XFTNgYBbgc5OHWCsFIN7CBRcF5iYkfJ0zCRoP4GU+FmBD/CGXN3MuHf
         wMdIwLlQxkUydfK1SU1Ud3RHcjd1/Wr17OtNZ7PmEffOnfneZb6NqlTQaKnI65J6o6+R
         tc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aZKGo/WUSUIsqJ/FK7N5GOjcj/wfBiAtawb0xyQLfI8=;
        b=siMME4833hQZ4x+O3NOUzzKgtQSdMTRDqfnU2L8zVz900wb3MwsXAakhozBeJYWnjY
         P/29XMyLtCkjQtRjtg6mE16kBBu/59knlqG22LSvp4Xc384zGfrmJ4qTGiZMZxu5Qa5Z
         ORFxvnVPtLxyrvh3+/VRjT2Z+dZm+3IWQXQx2IBCZN5dKxDuGHzns9fmfA/BnyhOMntX
         5aTnc8Wpn2zWmQiKWfHOKsrXDhvc6cAjIVWKmtRiNqelIU2m+bL02QI+oYs7KJWsDAdt
         W/i5fQjbdhMlY0fbzRTx1prHtJuadtTH/ANWQFoAUHq/li6v9+yeWF4QP/K6EDNBBR8A
         AjFQ==
X-Gm-Message-State: AOAM533YcvEpcVkJ0PR8H8WOd/ey1hXSIpe+mFgR6PV3GXXtinzCk+L9
        3uGu2SBFLNfY9wX6lKboIUo=
X-Google-Smtp-Source: ABdhPJxTHaTaZw7BmxGs03qCgK8fEx9pYSa2TDI7W0iWRuaoLnzPsRy81DWF5XahyQqBuNNF1j+kHA==
X-Received: by 2002:a17:906:1510:: with SMTP id b16mr26914248ejd.332.1632101381945;
        Sun, 19 Sep 2021 18:29:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 90sm6280741edc.36.2021.09.19.18.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 18:29:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
Date:   Mon, 20 Sep 2021 03:22:20 +0200
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
 <xmqq8rzsdqlq.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq8rzsdqlq.fsf@gitster.g>
Message-ID: <87fsu0avaz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Sep 19 2021, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/repo-settings.c b/repo-settings.c
>> index 309577f6bc..d00b675687 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -2,6 +2,8 @@
>>  #include "config.h"
>>  #include "repository.h"
>>  
>> +#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
>> +
>>  void prepare_repo_settings(struct repository *r)
>>  {
>>  	int value;
>> @@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
>>  		r->settings.core_commit_graph = value;
>>  	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
>>  		r->settings.gc_write_commit_graph = value;
>> +	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
>> +	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
>
>
> This is a "review comment" that is more than 2 years late X-<, but I
> noticed that this is used to muck with a structure that was
> initialized by filling it with \0377 bytes.
>
> +           /* Defaults */
> +           memset(&r->settings, -1, sizeof(r->settings));
>
> but the structure is is full of "int" and "enum", so apparently this
> works only on 2's complement architecture.
>
>         struct repo_settings {
>                 int initialized;
>
>                 int core_commit_graph;
>                 int commit_graph_read_changed_paths;
>                 int gc_write_commit_graph;
>                 int fetch_write_commit_graph;
>
>                 int index_version;
>                 enum untracked_cache_setting core_untracked_cache;
>
>                 int pack_use_sparse;
>                 enum fetch_negotiation_setting fetch_negotiation_algorithm;
>
>                 int core_multi_pack_index;
>
>                 unsigned command_requires_full_index:1,
>                          sparse_index:1;
>         };
>
> I see that the earliest iteration of this series [*1*] set the
> default explicitly using assignments of the correct types, like
> this:
>
>
> +void prepare_repo_settings(struct repository *r)
> +{
> +       if (r->settings)
> +          return;
> +
> +       r->settings = xmalloc(sizeof(*r->settings));
> +
> +       /* Defaults */
> +       r->settings->core_commit_graph = -1;
> +       r->settings->gc_write_commit_graph = -1;
> +       r->settings->pack_use_sparse = -1;
> +       r->settings->index_version = -1;
> + ...
>
> which I think should be a reasonable starting point to fix the
> current code.
>
> Another thing I noticed is that while it may have been only for
> setting the default value for a boolean variable initially, other
> changes abuse the macro to set an arbitrary integer values to
> integer members of the structure, e.g. c6cc4c5a (repo-settings:
> create feature.manyFiles setting, 2019-08-13) sets 4 to the
> index_version (naturally, the choice between 0 and 1 does not make
> much sense for the member), and ad0fb659 (repo-settings: parse
> core.untrackedCache, 2019-08-13) stuffs UNTRACKED_CACHE_* enum to
> core_untracked_cache.  The UPDATE_DEFAULT_BOOL() macro should be
> renamed to UPDATE_DEFAULT_INT() at least, I would think, to save
> readers from confusion.

Yes this is all a bit weird and/or broken, but I'm a bit perplexed at
this reply to a 2+ year old E-Mail given my outstanding series to fix
all these issues you've noted here[1] posted in the last few days, and
you having read (at least part of) it[1].

But then again, the last patch you left a comment on was 3/5. It's 4/5
that fixes all the issues you note above[2] :)

The macro is gone, so is the memset to -1 and other weird emergent
behavior. We can rely on repo_init() having zero'd the structure for us,
and we just proceed to set sensible defaults in a way that doesn't stomp
over the types in the struct.

1. https://lore.kernel.org/git/cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v3-4.5-28286a61162-20210919T084703Z-avarab@gmail.com/

> [Reference]
>
> *1* https://lore.kernel.org/git/72f652b89c71526cc423e7812de66f41a079f181.1563818059.git.gitgitgadget@gmail.com/

