Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D62D2018D
	for <e@80x24.org>; Wed, 10 May 2017 04:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751624AbdEJE5n (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:57:43 -0400
Received: from mail-ua0-f173.google.com ([209.85.217.173]:35934 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdEJE5m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:57:42 -0400
Received: by mail-ua0-f173.google.com with SMTP id j17so22849278uag.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B1bYrqMhnxRohhTNwDUF60BF3WlHZwLDxnEHc453FZk=;
        b=UQM51wXZq0ibNTLlFYCnKhas2lp6va7YZsj+3bm6WeOPZG81VCxmFrFK3uH99+es79
         DaWSXISo+xUPRKwdSM2p/0QshPE5NmqD5l9YQYP97XBo7SuC+ZYH0h30/fR4sRKV+QKB
         a6eSghxQKiFeewxiKLHb/4o8dNTVTLdVXKTfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B1bYrqMhnxRohhTNwDUF60BF3WlHZwLDxnEHc453FZk=;
        b=kVJDjfnYjQBo5/GXFaNTlVL5YYavS+B/IiqsE0BtTSQnA549nRfgRFZFcbgd3X38dt
         FgpUtjl/+N1PLCjbjl3OPrIjkJodDTf1LP1izF37OGT2by6vBbjd2vWVEwkHEVL+X8Yp
         LPdDlOcUAiyLI6Nav0qCvk7ot1JPvx2rW/rvqNBBo+bXHDXHrCMkTKxq4QUfjaZNiAt3
         RZxpd/LouMVYAw9uyaUhnXp6jg/HpeKqR/aauwWsCu/3RyibIfU2hmSGOW7ZT5c6dHAh
         xPlApZrZb6xR67IXQzOJPMK5kgyOPk/zWwLKuGg6ztVs0krjOjebtSQtyff8ELiJS3aw
         Pelw==
X-Gm-Message-State: AODbwcAJ3/bPGGjXToVpFrooGFfXTAQk/vaHj4PpV16c/LA7ZeWOY9Lc
        ixsJH4u67hb/lvocuJZdiApb1uM9TQ==
X-Received: by 10.176.94.133 with SMTP id y5mr1979135uag.150.1494392261441;
 Tue, 09 May 2017 21:57:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.71.89 with HTTP; Tue, 9 May 2017 21:57:20 -0700 (PDT)
In-Reply-To: <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net> <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Tue, 9 May 2017 21:57:20 -0700
Message-ID: <CAJo=hJuaPhxQwD+DdMcP_21j61KR_GY=P+tHrYScgzZFrtemEA@mail.gmail.com>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 9, 2017 at 9:33 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 09, 2017 at 09:22:11PM -0700, Shawn Pearce wrote:
>
>> > Hmm. That makes sense generally, as the request should succeed. But it
>> > seems like we're creating a client that will sometimes succeed and
>> > sometimes fail, and the reasoning will be somewhat opaque to the user.
>> > I have a feeling I'm missing some context on when you'd expect this to
>> > kick in.
>>
>> Specifically, someone I know was looking at building an application
>> that is passed only a SHA-1 for the tip of a ref on a popular hosting
>> site[1]. They wanted to run `git fetch URL SHA1`, but this failed
>> because the site doesn't have upload.allowtipsha1inwant enabled.
>> However the SHA1 was clearly in the output of git ls-remote.
>
> OK. So this is basically a case where we expect that the user knows what
> they're doing.
>
>> For various reasons they expected this to work, because it works
>> against other sites that do have upload.allowtipsha1inwant enabled.
>> And I personally just expected it to work because the fetch client
>> accepts SHA-1s, and the wire protocol uses "want SHA1" not "want ref",
>> and the SHA-1 passed on the command line was currently in the
>> advertisement when the connection opened, so its certainly something
>> the server is currently willing to serve.
>
> Right, makes sense.  I wondered if GitHub should be turning on
> allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
> some internal refs[1], and they're things that users wouldn't want to
> fetch. The problem for your case really is just on the client side, and
> this patch fixes it.
>
> Some of this context might be useful in the commit message.
>
> -Peff
>
> [1] The reachability checks from upload-pack don't actually do much on
>     GitHub, because you can generally access the objects via the API or
>     the web site anyway. So I'm not really opposed to turning on
>     allowTipSHA1InWant if it would be useful for users, but after
>     Jonathan's patch I don't see how it would be.

Right, I agree. That is why we proposed this patch to the client,
rather than a support request with GitHub to change server
configuration. :)
