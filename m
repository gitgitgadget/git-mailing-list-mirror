Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42049C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C51F6113E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhIPEVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 00:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbhIPEVd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 00:21:33 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE00C0613D9
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:19:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b8so5290169ilh.12
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJQRlT1A3ApEfBfo0jXsLAh5lyR++1J/hmkHDI4j/2Q=;
        b=SKvlufvjKr9Jme4w8THCSdRqKQFrLc2zSul1iu1XRfZ2q5IsuMkWZTP+9mIFJk+DoQ
         1jP7Msuia7TlXbB6svVBfwQXtJdtRSqkE0+SqTASC47u8vlQ2ZKkczLYJPNQRvuwjFeu
         5ElpcYC4HqzTeTKz01qSrLYvRnSIVEb4jPZn6sLr7cD2UMhwKExfvbrh2V4MqMXjKRf7
         v1d3Ra1vbUfPkLZOXrTUglhM/X7eVHNowAoRkjjGnKd/0534QkwbeTwMzpOOjQ50jqzQ
         7ZrQTl8Nef1WZVwdpFcjfhLXGhkYm8UttegrH3b7DqkQZ4Ld94N4sLeK44xert4txYTj
         Aj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJQRlT1A3ApEfBfo0jXsLAh5lyR++1J/hmkHDI4j/2Q=;
        b=lv96VceFF2pcKaKFU0dCiRZOaYDDWHYmMeypXCx99wlIWhUvTStYoxe2Nlj0At5yay
         8UWDakySyJMvr2nPlFyLPXnR83E4qJOA23IDoQ6ExIp0E+/gudpslw/oALV6xWfrviTq
         205ERDRJLT/5LxE7ZWQEWVnNPQQmL2/Ot4ZypeKtag22/6XzncRlzwopGEcF7Hlf+G1E
         i6N+BBJ55UH6yzL0+cpYQG8NnGTcWIzEj23ES68BOLpKRSBOJO8Ac55+aHsUpt5tdjVy
         DpE/0X3bRHvSXlDXRukrrp6SneZfqo8lt+EBnDhPnxuOvgFHB/bdUINLY9HvFgCY2bWh
         0BDQ==
X-Gm-Message-State: AOAM530vc0T0NGeMuLgR9sxeOOXZ9DW2sC1O51aSUfoi1FgNTXWY3REw
        vZg8UVVt3fxaJuQsVg2SckNxrg==
X-Google-Smtp-Source: ABdhPJw6NKkKDeshvQYZuxuXZDdXFZMb+mYz94sLYfHKdRfHh+08qa/PjyDIyJRPKjrqzwB6ArS1pQ==
X-Received: by 2002:a92:c744:: with SMTP id y4mr2436557ilp.288.1631765988416;
        Wed, 15 Sep 2021 21:19:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15sm1036196iop.15.2021.09.15.21.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 21:19:47 -0700 (PDT)
Date:   Thu, 16 Sep 2021 00:19:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
Message-ID: <YULF3hoaDxA9ENdO@nand.local>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
 <xmqqa6kdwo24.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6kdwo24.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 02:01:39PM -0700, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Jeff Hostetler <jeffhost@microsoft.com>
> >
> > Do not leak the thread name (contained within the thread context) when
> > a thread terminates.
> >
> > Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> > ---
> >  trace2/tr2_tls.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> > index 067c23755fb..7da94aba522 100644
> > --- a/trace2/tr2_tls.c
> > +++ b/trace2/tr2_tls.c
> > @@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
> >
> >  	pthread_setspecific(tr2tls_key, NULL);
> >
> > +	strbuf_release(&ctx->thread_name);
> >  	free(ctx->array_us_start);
> >  	free(ctx);
> >  }
>
> So the idea is create allocates a new instance, and unset is to
> release the resource held by it?
>
> This is not a problem in _this_ patch but more about the base code
> that is being fixed here, but using strbuf as thread_name member
> sends a strong signal that it is designed to be inexpensive to
> change thread_name after a context is created by create_self.  If
> it is not the case, the member should be "const char *", which may
> be computed using a temporary strbuf in create_self() and taken from
> the strbuf with strbuf_detach(), I would think.

It looks like we do not change the contents of the thread_name buffer
anywhere. I assume that we store the strbuf in struct tr2tls_thread_ctx
because we do some string formatting in tr2tls_create_self().

But there we could easily say ctx->thread_name = strbuf_release(&buf).

More concerning to me is that we use signed integers to keep track of nr
and alloc of array_us_start. But both of these are separate issues and
don't need to be dealt with here.

Thanks,
Taylor
