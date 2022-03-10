Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFDC433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbiCJOzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbiCJOmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:42:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E051A19143B
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:37:16 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qa43so12410784ejc.12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YVJCjXy71dS/RUtnyEQqTACOQmh1f4UK7wNgIlgYVcw=;
        b=hOoSz+iQpZ7eGP06l+apuIxf2jfur/msTiNwMN+1nXKb9nURzxzsJnV9x1bKmD6xnH
         Yz0FH4kJ+L8TVkVywpeR/5oMhLqwiRA3j3NIUs0rIvh4SdZ/8JMhRz5VNFsS9bvePirv
         gjRQanfLSqV7oM4rFICAYI15CnAVkU3NiT6qwWxA0N+JLqbwEOnsQe++epLwRdXlTXmw
         wIoPShFqtHp2UdTyi73s93CMqX5U7nVVXlTecgsgSYTz4alRsP9Muy6Qok7Nl3oUayOD
         B1c8LEjYdJvZoSp6A3hxqNy2VF6zUYtKIN/x3jcs4j49GfUziFDzPW0UCRJvCn3ouMMZ
         oLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YVJCjXy71dS/RUtnyEQqTACOQmh1f4UK7wNgIlgYVcw=;
        b=3NHLt1EIJXz4KpCkoFgFYhynaKyIMwgw7Jdqd4kuU+dqXyemseF/rG9CA6JYMGhcFC
         FTXDUTFSmPJC3rMR6PIAmI6hmhKGRKfFVrNfLXPuafZSZS8+Ipnp5FZO/nm7Ek6WQ8nF
         jtQvRMhzOANNLe22dju2bMapvAkGly5POkTVLdSAla2yuo+4k/T85qBIKT1mA8VRC3I9
         iak1HQNA1041pflU0f92KrcRoMW8ydCUPs4YFRPLcWgKUhXtfvuG8zuTu5qh6flwohWY
         x7RupGgtALFjxc5xBzD2QDKIsQhw0T9hBfcI4Az82AhtxISbsjcRlGlghyhir5EGbaQk
         qv6g==
X-Gm-Message-State: AOAM531XoatQfV9sqhqCejhuGyooBFuI0KmQSHzqnRuoJFXzBmW6GvU4
        0I8ug3uhYB45aohJL2hVgl8=
X-Google-Smtp-Source: ABdhPJz42SJjBbdxzy1fTlR9/NXOFXLqKTGY/wVGRKu6ekKyyeLRkqOGGLSik+Y4oBuGgDardailwA==
X-Received: by 2002:a17:907:1c16:b0:6d7:622b:efea with SMTP id nc22-20020a1709071c1600b006d7622befeamr4536105ejc.110.1646923009721;
        Thu, 10 Mar 2022 06:36:49 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906078900b006dac5f336f8sm1851232ejc.124.2022.03.10.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:36:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSJuK-000Wqw-QA;
        Thu, 10 Mar 2022 15:36:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] trace2 docs: a couple of grammar fixes
Date:   Thu, 10 Mar 2022 15:35:43 +0100
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
 <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <07f7ee46232b4ccc53787fa2e08887b436ee11c3.1646919331.git.gitgitgadget@gmail.com>
Message-ID: <220310.86ilslkh6n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/technical/api-trace2.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index bb13ca3db8b..77216eff622 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -24,7 +24,7 @@ for example.
>  
>  Trace2 is controlled using `trace2.*` config values in the system and
>  global config files and `GIT_TRACE2*` environment variables.  Trace2 does
> -not read from repo local or worktree config files or respect `-c`
> +not read from repo local or worktree config files nor does it respect `-c`

Perhaps adding a comma before "nor" would also be a good addition.
