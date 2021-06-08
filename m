Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A4C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9A1613FF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 10:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFJKZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 06:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKZG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 06:25:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83820C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:22:56 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a11so42598129ejf.3
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 03:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=LplCrgPU9rsywAysQZ2aAWfuRAup59MnXSX+lCs8SDs=;
        b=c/C0RsVKCM+h0CxDO0ZvpFG/7dxOARx57BT3NYwM4kQddU7luTPDR1Fp5Ck9lVdyoM
         0sd1ITleWAKuTbXQFAYRKmW0pwrFELcqmdyNOxVC/zhig6G3LFRrJIO0eKAXAgK9NdBR
         jZhr/cmutWiiYxivQ7TeCuRlWVst5bsjhI16YzHdsyFSPrXyM/H+gw64rn72bKTcjzH6
         ZmxqniBg+YyZ5qFwa3y39W4PicqZ8QA39OefABt5dU2lqVrkmWuJYCcrG/ZRdPVfJ/9y
         EdYNL0fSRkunW3wY2rBpN8zKgl8N6m6cIEsAszXtIS9R+SQeuDCeTzbhd887XuIJUUdu
         zvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=LplCrgPU9rsywAysQZ2aAWfuRAup59MnXSX+lCs8SDs=;
        b=Zk8nyUvOHHLcDnf17slqGrB6Lse3FmyIlL9/3yIA2LOLegk8/dVX9K2nTaFAPQUGX/
         NZ/jFAxq6W+ol6UP3VVV73eoUnqY3iZN8A9zWOgWbJ1jOCGOYrgmuow78I86NFOwc1C1
         HgiNwY8mWi3e6mXZsIdZnqsxE545drfjQJ8L32LNM93SmoCdERseG9ZEI2cQ7SlQmGiw
         d8sI05o880Ql3CWYRTEMndo/TspW1+4Vp4T5AgDKYHL+YC3xswF9/zTW+anlqRj5Ochb
         aaqeXqnjpkYH55UB3b0EW1L/OwKq+RWGYNmz6+1DVFoCPgekwQ7qxfRZyRou2B2Gm0J6
         T+8g==
X-Gm-Message-State: AOAM532YHKl2AqU1KMJPGzvAIqTx0JqvPWNa6TSgt18SbWkP8yaQ48qK
        g4MbkvrT042l01ZWEr4sw7k=
X-Google-Smtp-Source: ABdhPJzUZr+d84htGvR5toXZF4a2/4EpYcF8c3FK5lZyGpUtvXVkjp7OwEN7vsqIJD44q2Fxt8iPKQ==
X-Received: by 2002:a17:906:4109:: with SMTP id j9mr3903170ejk.250.1623320574882;
        Thu, 10 Jun 2021 03:22:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id q9sm1117351edw.51.2021.06.10.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 03:22:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <ttaylorr@github.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: use user-specific utf-8 locale for testing
Date:   Tue, 08 Jun 2021 12:49:21 +0200
References: <20210602114646.17463-1-congdanhqx@gmail.com>
 <YLfiYXxQqXL7RyHC@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLfiYXxQqXL7RyHC@nand.local>
Message-ID: <874ke62f41.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 02 2021, Taylor Blau wrote:

> On Wed, Jun 02, 2021 at 06:46:46PM +0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=
=C3=B4ng Danh wrote:
>> Despite being required by POSIX, locale(1) is unavailable in some
>> systems, e.g. Linux with musl libc.  Some of those systems support
>> utf-8 locale out of the box.
>
> Hmmph. I would have imagined that locale was available everywhere, but
> unfortunately not.

Small and unsolicited history lesson from a person with funny characters
in their name & language :)

Today it seems like *nix systems have always had UTF-8, but this was a
relatively late development.=20=20

It's Plan9 that had UTF-8 from the start, on *nix systems it was
US-ASCII, and anything else was tacked on top later on.

When I started using *nix systems I belive it was quite common to have
default configurations with only ISO-8859-1 locales installed, and
certainly that's what a lot of or most users who had the need for
locales in European languages not covered by US-ASCII used by default.

This is from hazy memory, but I think it was even actively recommended
against having or using UTF-8 locales on the system. If you
e.g. connected to an IRC channel, or copy/pasted from your text editor
into an E-Mail you could easily send the other end misencodedgibberish.

Later on things like IRC channels in these languages had a "switch day",
it was a complete mess. Nowadays mostly nobody really notices or
remembers anymore these encoding issues since we've mostly got UTF-8
everywhere as a result.

I mean, at least in the case of European languages, I understand
e.g. Japanese and Chinese still have their own persistent encoding
issues related to competing standards.

Even today you can't rely on UTF-8 even on Linux systems, and I think
this has become even more true of late with minimal CI systems or other
chroot-like test environments.
