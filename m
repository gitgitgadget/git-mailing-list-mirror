Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC420C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6487921734
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 14:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mutual.io header.i=@mutual.io header.b="g39zjRND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgKDOHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgKDOG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 09:06:59 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374D1C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 06:06:58 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id w13so16451973eju.13
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mutual.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLmCRr6SAigSJzMh1qaU1rto+e/kOylTzQ1yEqtkMkI=;
        b=g39zjRNDZpvn2Osx2Rw+aI0oL4v+pRtk7I8GL0XjNRn6Ct3zqfQW0VdETgvMGlHQIR
         hjUE5Qjqy9rBhQQCukr5oFBYi5v6fnzVXftRryJP2qAeNMnC+4XVqoHKH0gyjEyva2KJ
         ZhmMeyU4mDfnbsMV0MtUxcWp4r/H9EPWaFKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLmCRr6SAigSJzMh1qaU1rto+e/kOylTzQ1yEqtkMkI=;
        b=TFt7eMLMbhGORg9tom8qDdwxoXKCPYUwAwNS4O7lfYPJkxjN45qB1qw5INn0tyZ/tX
         49gcdPNMmfFkBMFeO3IdQGyVtTL1uczGpLpv3hHutUVJk6zxjCGsIUK3Z4c1ooBiD/oF
         5Twji/+8b3ADBpRP/TG3N5o8ubBq3mIGUVkmPagu7IglIdX+c10YDMKTioR+vL2uJi6L
         3/HqoM5CtgRuUmeWfvzQItU6tzEn8rcnu9ULcAi8vHy2eg++TBdB8I1hwQn8PUt1OKxV
         bnFxt9rvEVOovap5+7e8MZZ0uKAHLjWbfVeGsWxrxSmGueVO1255zKI2kM67+/PxOdMw
         7+xA==
X-Gm-Message-State: AOAM5315wn8yrN9KhbUqU33+Mz1atT3bTr5QqQDF3m9E/Ivw1oBN+Gcm
        V0el+2Xnfy56LpqFKwqRqcmosAvllXlT3m7rFzjrlw==
X-Google-Smtp-Source: ABdhPJwpBKAAelYGuN2Olxjx6OpjknDytT3vvFCo2a/zSXaMs8vqt0OeWNAviU0/Dry40P+zB1udBuw1DfVC88XpJlQ=
X-Received: by 2002:a17:906:5fd9:: with SMTP id k25mr6955909ejv.166.1604498816922;
 Wed, 04 Nov 2020 06:06:56 -0800 (PST)
MIME-Version: 1.0
References: <1604022059-18527-1-git-send-email-dan@mutual.io>
 <20201030044012.GA3259692@coredump.intra.peff.net> <CANo+1gv0otfjRexAVW6E+yPEvGLo55_tQWN-81mQMm4U0seCJQ@mail.gmail.com>
 <20201030090902.GA3268509@coredump.intra.peff.net> <xmqqeelaqh7m.fsf@gitster.c.googlers.com>
 <20201104133342.GB3030480@coredump.intra.peff.net>
In-Reply-To: <20201104133342.GB3030480@coredump.intra.peff.net>
From:   Daniel Duvall <dan@mutual.io>
Date:   Wed, 4 Nov 2020 06:06:44 -0800
Message-ID: <CANo+1gu2pi+JXV6a3fBFA+w_zCfQb80fJze2T3Ed1ri7+=KZGA@mail.gmail.com>
Subject: Re: [PATCH] upload-pack: allow stateless client EOF just prior to haves
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 4, 2020 at 5:33 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Nov 03, 2020 at 01:10:53PM -0800, Junio C Hamano wrote:
>
> > Yeah, I'd agree that punting on v0 and making sure the current
> > version would work well is good enough.
> >
> > I lost track and am not sure what's the current status of the topic
> > is.  Is v3 [*1*] the latest and satisfactory one?
>
> Yeah, I just read over v3 again and it looks good to me. Thanks, Daniel!
>
> -Peff

Contributing this tiny patch was a rewarding experience, getting to
know Git more intimately and collaborating with you all. Thanks so
much!

Kindly,
Daniel
