Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A8BC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F2C206DC
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 21:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="yDLckhEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHKVDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgHKVDk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 17:03:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5389BC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:03:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so213307qka.3
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0WLVwVOtIujTHTF1VZpe9QShZUKGenG026FckdQbEo=;
        b=yDLckhEQ8rtTwEz91k6rDOWUwQJ4lI0MpYEoE+ioui+Js9Sy7xAQ27wkWsu6an3ZOW
         J2j/mfd/avIfGM3gWgOZnhcTver69jjsQmstFRsGminXJLrC4mo1MG5Oq7zOedui+qot
         POjGO/VkF4mJlBhtgsXFQnZmy6mt7L6TNTqSjC1JWrgAX/U7j6ssOYb8wJ19LapihSN3
         vseipqZjT3RRm+gDSboBLb+ucyYvT3rQvx3P7CaAXFLlmyw/z7JY2VAomdI5agfJNsSj
         2nX8VHsdhwLFot8bg40gpRephPXMX/9zOAF6t3yX1l9XOLVVx1PRSRr4NdEeWUbMMgSm
         GD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0WLVwVOtIujTHTF1VZpe9QShZUKGenG026FckdQbEo=;
        b=EhW710QNeTkP8Tm/dJbJ9YiUhFvPfYg+q6DNOaS2vblObWO5Fmor8ekBqpcO4KyXl2
         T3G1oQZ7hbWFFkTSZgG+huREV2dTdkBFLEunS8t+xbTWw62BP3shnxAGTLxYOz46KS8J
         y7MxHceR0Gzj/3gTZ0ESuoj4zqagv+Im1sS2icD7mUvsMuZq9N5IbDPZ9bmG9FZ8ZK/i
         y+iZ2JnbI/lxk15gPFLe5fSrFCDRY/ke84rN8rA2vSxDgCSXc06NgoxagbJoF3ocWjKM
         ftITOtmCmMhcUzMCthMX9FvhcNSZDid5q9qu7a2r/rVSYGSkJGTAzCLcoMWQT2fVZLZ1
         OKKg==
X-Gm-Message-State: AOAM531DotAwA7wpWoIVDJkTEC1vumSueudr86TyON2dP3otHMymp3Ap
        UFtkRiO4LaMGuFiqOVZB+LrHJg==
X-Google-Smtp-Source: ABdhPJx2itb6Xk8Pl8NBTQzAsmwJMz7JZqBshIr/JOsZ0NkMPeeQ9ZTxOMNMvRszTiTQ5tsoFlGzFA==
X-Received: by 2002:a05:620a:22b4:: with SMTP id p20mr2885613qkh.340.1597179819465;
        Tue, 11 Aug 2020 14:03:39 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id o72sm15276qka.113.2020.08.11.14.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:03:38 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:03:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
Message-ID: <20200811210337.GA34786@syl.lan>
References: <20200809060810.31370-1-sunshine@sunshineco.com>
 <20200809174209.15466-1-sunshine@sunshineco.com>
 <20200811183258.GB33865@syl.lan>
 <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSroWZEoOL78COmPS4rkvKLE-yCiqh6Part+5gUgVon+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 03:25:03PM -0400, Eric Sunshine wrote:
> On Tue, Aug 11, 2020 at 2:33 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Sun, Aug 09, 2020 at 01:42:09PM -0400, Eric Sunshine wrote:
> > > +             test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
> >
> > Not related to your patch, but I've seen this style of "x$1" in a few
> > places in test-lib-functions.sh. Why can't this be written as 'test "$1"
> > = -'?
>
> Short answer: To prevent 'test' from thinking that the argument is a switch.

Makes sense. Now I feel silly for asking :).

> Longer answer:
>
> 'test' can accept both switches (i.e. "-e") and non-switch arguments.
> Keep in mind, too, that all the quoting is stripped by the shell
> _before_ 'test' ever sees its arguments. Let's say that the caller has
> a filename whose name actually is "-e" and passes that in as $1. So,
> what does 'test' see?
>
>     test -e = -
>
> Rather than comparing literal string "-e" to literal string "-", it's
> instead (almost) asking if the file named "=" exists; I say "almost"
> because it's actually an error since switch -e only accepts one
> argument, but it's being given two arguments, "=" and "-".
>
> You might say that having a file named "-e" (or similar) is unlikely,
> however, what is not unlikely is a caller passing "-" for
> standard-input as $1. In this case, 'test' sees:
>
>     test - = -
>
> which may or may not be an error in a particular implementation of
> 'test'. Some implementations may understand that "-" is not a valid
> switch, thus infer that you're actually asking for an equality
> comparison between arguments, but other implementations may complain
> either that there is no switch named "-" or that those arguments
> simply make no sense.
>
> This is why it's a very common idiom in shell programming with 'test'
> to see "x" prepended, thus ensuring that the argument can't be
> confused with a switch.

Thanks for a careful and helpful explanation, as always :-). Makes sense
to me.

Thanks,
Taylor
