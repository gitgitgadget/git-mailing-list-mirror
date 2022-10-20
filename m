Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E9AC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJTS66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJTS65 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:58:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2DA20DB69
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:58:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u21so909828edi.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsqh07U1hO2PdTh7DllwwmeHTcXdtVFCIpbqqR1SJmc=;
        b=eznncy9QTx9M1mZZWaSyp+g1uWCSpjsq+IhtNrSSVTuBXyTKF066ZK4cPRaHVeSJkC
         9tUI8X6SSdE4hrZiQIRdRXSd+LDe5FK1CVfnfcfFiMkkQdSKtqdv9rd30EhwjuM5nf7y
         ERuWNEadj5byTlnGO5mRpRGQruTBS8fp9LFCwQ/I4zBbRU2KUJObnESB8u1/DwIjIPfA
         2z25rAK4NvPiym42blPLQ6YA15xnR3aa47ouXsBCjp2Yt/39nPF8OC3c2J2nPI8mncTw
         y1laObR0oDDhWjg6Iw8jv67wZi2kYcaVR8JQhw1kHOeDzUGhaqame62KEYfLVlaSqyqi
         wivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hsqh07U1hO2PdTh7DllwwmeHTcXdtVFCIpbqqR1SJmc=;
        b=y0um1UtAYuBqgHtde+hS8pw9vOXb0NG/OizXeAAAtA5i5Xo8Q1U2t2PWz9vbPNXmY6
         y1gAsUPIA/dvOzgST3qYVkd5j+M92I58ClAWn6dgONhGlbWRs/h4XDW1mtJJRu30A0BH
         f0nIq2rpxNKXkhgogxxJEU94zRNttboccaMvrxPC6FnXEVVEkSRw8TzEsbOFxiSbEXXf
         V1A0TRBTe4iIw3Pl7UtK1PMcGBPIYBvGIHwMa0OB6BmoQ+xbG7FG8f1b9DofuA7jQYYi
         OFsTm8Tm7I3kRVt2XXpQkTHZJU/wyudSx8yhJshMQf5G6thzSU3KfP5gzIspetbqQ6k1
         a6mA==
X-Gm-Message-State: ACrzQf3XruC/I/01yxPY44uBAzXE4vEfjDS4SomowrRHUKbmu7WXI0d1
        YTNGaGFyF/P82ss12oKCq6s=
X-Google-Smtp-Source: AMsMyM7Yza6DBCj6FoNEXFJ9DOzHAKNaSdFS0vWPSIj2PzsDv5/xetotYbvdjX11JDaxsHmS/Mkzcw==
X-Received: by 2002:a05:6402:360d:b0:459:5f40:5b0a with SMTP id el13-20020a056402360d00b004595f405b0amr13096946edb.168.1666292333992;
        Thu, 20 Oct 2022 11:58:53 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sz15-20020a1709078b0f00b0078d9b967962sm10466106ejc.65.2022.10.20.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:58:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1olakl-006VM1-23;
        Thu, 20 Oct 2022 20:58:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 5/8] trace2: improve thread-name documentation in the
 thread-context
Date:   Thu, 20 Oct 2022 20:57:39 +0200
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
 <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
 <8cb206b76323e14d8e07f6cfb5aa482a47eb54c5.1666290489.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <8cb206b76323e14d8e07f6cfb5aa482a47eb54c5.1666290489.git.gitgitgadget@gmail.com>
Message-ID: <221020.86y1tafhjo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 20 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Improve the documentation of the tr2tls_thread_ctx.thread_name field
> and its relation to the tr2tls_thread_ctx.thread_id field.

Good to see this split off, thanks!

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tls.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index d4e725f430b..7d1f03a2ea6 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -25,12 +25,15 @@ struct tr2tls_thread_ctx {
>  /*
>   * Create thread-local storage for the current thread.
>   *
> - * We assume the first thread is "main".  Other threads are given
> - * non-zero thread-ids to help distinguish messages from concurrent
> - * threads.
> - *
> - * Truncate the thread name if necessary to help with column alignment
> - * in printf-style messages.
> + * The first thread in the process will have:
> + *     { .thread_id=0, .thread_name="main" }
> + * Subsequent threads are given a non-zero thread_id and a thread_name
> + * constructed from the id and a thread base name (which is usually just
> + * the name of the thread-proc function).  For example:
> + *     { .thread_id=10, .thread_name="th10fsm-listen" }

I think the example is missing a ":" after the "th10", i.e. it should be
"th10:fsm-listen" per the code in 6/8:

	strbuf_addf(&buf, "th%02d:", ctx->thread_id);
        [...]
