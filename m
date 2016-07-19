Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0D62018B
	for <e@80x24.org>; Tue, 19 Jul 2016 05:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbcGSF22 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 01:28:28 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35724 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbcGSF20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 01:28:26 -0400
Received: by mail-io0-f178.google.com with SMTP id m101so9805536ioi.2
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 22:28:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GOfY3TaQ1wRr0IhFlCqtUYoaPhRe4JsxwmnKoZ5Y2Xk=;
        b=ExkLAdK7iDLBg7fcnMpW+Yy+kKtJcIcU4BvfTgBHhkO3CO39FDdPkcmS/UusDS6pAq
         qCWsarg5q9WuY4KX5ExS98akxraIklWJ1ZraBOdJuEXeYRg6XdjHA3HDeGICWAyyfonN
         SZPZONkMs3OCJFTAafNRpZxEqEdP5jyV/KLTHp03WsMZu+/ygxfKQwNMb/K3bgtBP5QT
         Bxdj/gGVG37uKNy/J5h3NjQy356X5WcCDMCTGyNoQ42z4KWIZIlew95UuOwg5Xqfre3Y
         ODzVoJRSqebJqjzPV2EoWwJFQ4E3QaiZA21Htcqp0ZvlLoN65lNCpau5QoXzpbiFDv/2
         fktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GOfY3TaQ1wRr0IhFlCqtUYoaPhRe4JsxwmnKoZ5Y2Xk=;
        b=WB0yux4Q5jcoAEw4bT8F4o46f7BGbMvbfhqd/D3t6q+n9SCBONJxURdleHSaDGynq+
         ZFhcGeF+2Q+L4bNGbBlMnMle7gvHJec7W2viTiVw7U926IenClejDTjxp8OWIHhzmsLB
         tI3SnAEGgGCxPReAMTpHEXmHbveHD8tJJ1mlbP4Q6KMCcmisAlmGZdRCzqubhPbW3eHG
         EcULgXSWUjnIxXYfR4ZNyJaii9fswHJ34SHGSBpwqMeSn2tlAi+ts0YhMbEasQNxQLbw
         cne3+GZZ0hFg8DNKUbVF/Zwzd5xqJ8U2f2kkU8/5m/QRCLIOuj1XKTygsHQbRNIkeM5E
         IWLA==
X-Gm-Message-State: ALyK8tKMi9sH9DbaIHrGL6sEWev3+HGosKdnhBKF3t6G8Wrz7AcLTt5KHcgxn+JtDEZghmY14eApn2BCQZ46xoRP
X-Received: by 10.107.144.10 with SMTP id s10mr35623591iod.165.1468906105751;
 Mon, 18 Jul 2016 22:28:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Mon, 18 Jul 2016 22:28:25 -0700 (PDT)
In-Reply-To: <20160716075621.GA10275@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net> <20160715104347.GL19271@sigill.intra.peff.net>
 <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com> <20160716075621.GA10275@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 18 Jul 2016 22:28:25 -0700
Message-ID: <CAGZ79kZPbSTAv6zjJ01PdqBOZrsfhRAte_v-mbBzXuOAWNK+Tg@mail.gmail.com>
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 16, 2016 at 12:56 AM, Jeff King <peff@peff.net> wrote:
>> > +               if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
>> > +                       const char *p = memchr(data, '\0', sz);
>> > +                       if (p) {
>> > +                               /*
>> > +                                * The NUL tells us to start sending keepalives. Make
>> > +                                * sure we send any other data we read along
>> > +                                * with it.
>> > +                                */
>> > +                               keepalive_active = 1;
>> > +                               send_sideband(1, 2, data, p - data, use_sideband);
>> > +                               send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
>> > +                               continue;
>>
>> Oh, I see why the turn_on_keepalive_on_NUL doesn't work as well as I thought.
>> I wonder if we can use a better read function, that would stop reading at a NUL,
>> and return early instead?
>
> How would you do that, if not by read()ing a byte at a time (which is
> inefficient)? Otherwise you have to deal with the leftovers (after the
> NUL) in your buffer. It's one of the reasons I went with a single-byte
> signal, because otherwise it gets rather complicated to do robustly.

I do not question the concept of a single NUL byte, but rather the
implementation,
i.e. if we had an xread_until_nul you would not need to have a double
send_sideband
here?

>
> -Peff
