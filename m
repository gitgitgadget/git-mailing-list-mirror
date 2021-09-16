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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88909C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F90861108
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 05:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbhIPFkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 01:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhIPFkl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 01:40:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA6C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:39:21 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j13so12213381edv.13
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 22:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=W/MOwc7nXvQIVFbndWug3LR8xW/fcqJCV4X1ExKQ3qw=;
        b=kIoQrKgR2FfpQXrOMYSjwgptgnreva7UzaRGqj2vTOz0GR72yPcYrcZ7S+rvQ4j64Q
         FC4+nuWr/8KWV1sjIVkXwh9OX++F96uqp1A7tQq/7ZsgyDydeqL9i4JKfj3tixZ236ey
         TaV4km7WgU0tl3ZBhUIax78X82CqxvIbc3emi/49RJRn+kHZ4gm+4iRB0/zeLIuFZnt2
         gT5UJCfxfps6RxpL6b59B9ATnJdPYMrAqecV2vHyM/KIp0E3mxljEfHHykEpGquA5K12
         uDtIjQY+u5CywbUV1wl4FY1qjj+ku+kPqiJ56K8nBPopMIOKezPfU/cVPM812WgoztXM
         Vp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=W/MOwc7nXvQIVFbndWug3LR8xW/fcqJCV4X1ExKQ3qw=;
        b=r+fhh6LAnl9NSuMiq3hnt30p2sS1pLKq7SK6lOwq3Ej64/qxJgGAab2jysy5vhz4yw
         /Qjp2e6o3mZ2mlgyBaYrWCGPkY4W/1jUENg0cDUlG+0CT0XPumeu/laSxe0dGBMTDmm/
         QhZSeZlv8sBDnu4MsM9kLORByZeSRDIpxAxi0lsJsGm0knMekb0AMvUKOCg50fPlqHx1
         ChTIqUbOVT2ld5RDbTXlkOAdnNfcpv/fYFLEFYsDFOqaRhM8UsQM76WHKJZBrmUTr5pY
         kVSuXSaTBbLi/DjwcFrG4ZcYP6wZ8iVqXxlQEAlMNWQTtyGOmp0WNlUxJ5eX6iGRKyqt
         7oFg==
X-Gm-Message-State: AOAM532ZMIcFwXHkLJ1pXEO4PegLclkptr6Kw9YJTgJYCKXMgX3o4E7n
        oSQz2JwuhBgPy8ijdQafYSt412iT4QE=
X-Google-Smtp-Source: ABdhPJy7bRsdUwyrPKVfZIiD5kWDpYzIdde3BDFZ6Ai7m5WPXkJQ2xDOX2CMVAjV42T+jr3WVqyKmg==
X-Received: by 2002:a17:906:f11:: with SMTP id z17mr4366424eji.385.1631770759671;
        Wed, 15 Sep 2021 22:39:19 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i13sm856524edc.48.2021.09.15.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 22:39:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
Date:   Thu, 16 Sep 2021 07:35:59 +0200
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
Message-ID: <87fsu5m649.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Sep 15 2021, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Do not leak the thread name (contained within the thread context) when
> a thread terminates.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tls.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 067c23755fb..7da94aba522 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
>  
>  	pthread_setspecific(tr2tls_key, NULL);
>  
> +	strbuf_release(&ctx->thread_name);
>  	free(ctx->array_us_start);
>  	free(ctx);
>  }

As noted in your cover letter:

 * A fix for a memory leak in the Trace2 code. (This was independently
   reported in last week in "ab/tr2-leaks-and-fixes".)

So I think this patch can be dropped from this series, since it's exact
duplicate of my 48f68715b14 (tr2: stop leaking "thread_name" memory,
2021-08-27) in ab/tr2-leaks-and-fixes, currently in "next" and marked
for a merge with master.

When submitting a series that depends on another one it's best to rebase
it on top of it & indicate it as such in the cover letter, Junio can
queue such a series on top of another one.

In this case I'm still not sure why this fix is here, i.e. surely
nothing later in the series absolutely needs this stray memory leak
fix...
