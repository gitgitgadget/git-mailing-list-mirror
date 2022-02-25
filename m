Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C01C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243079AbiBYQgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243069AbiBYQgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 11:36:43 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F89246354
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:36:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk11so11994978ejb.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=IwVzK3kw9gPzoeRpG403QF3M30obGGlZMg9wAqnRMrg=;
        b=CF7Q4lBwK6ltnggCK73MSS7nLsRp6McaFuQ0T8n3X4AgG86hPunSSduo1A1mGAK08r
         CT8eK66XsqH4kJmXdk8spgJQGHeSx5UnEIWbS+ajo4OkmjY8eGXj2OL0P4BSgKdRWSpw
         IIQmGuGEA5MmrN8hDgacgUrmDDdMVB/mRlhtQW18KK7jpwyfAKAhZcY0ByOyuhohP6n/
         sKmPoY2SZx5FbIsH7y8qXy8RF1i/RxcvPWSuUkKDKC1stvx42WHimOB13keiYM6Nb9t4
         O7ReQOSpagGzBcpOloAEgWuBb6Z7se0Qzq02Xkynipz64ZQMAlqfFsnsPUWvR0szxlSo
         y6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=IwVzK3kw9gPzoeRpG403QF3M30obGGlZMg9wAqnRMrg=;
        b=aO9MKRNMPp45dAa2iqhmZG3zVgSTuZZnIDojMf3sr9xSJW1oc3SuTDNmqRGSuinrzw
         XTawj5ZlJ4vcOz69ln1W58ewxXTNdebJzhhSI1vZnaIJrCU9xrjV1D/Zy0reG8z0qwe4
         9LuIFUNDU48Z83aRzmuQQEnkUgqcnWS8Iwj3B5Ni3sbWULRmzonBWpautctPFNytNEgX
         Pil8xEa54pPfbt+S4vqOpcEDfuWbpG8ZJzKggGvLQLFqUOQF1McFNc3TiDBlKxs9uzIC
         PP1lBZhO57+G2KEVR+Lp8WvKxSvJUXq+cpyIGS/Ye4Fx5S/9NTk9OpVXP8rcLcSC6Jtd
         PHtg==
X-Gm-Message-State: AOAM530WC/X7AH5xLxjbKWgfae0Rq1M2TbsaGrsVgbCWiVorAQ7BJPlC
        Co1G5qYf3Se2KoLLkL9CpnU=
X-Google-Smtp-Source: ABdhPJxcOA9TI5VVAoudqwcVizNk+3dhL5d6pUejwV5jATFpmBq2gvcebsfW61a8EEhPAvYwkhuXpw==
X-Received: by 2002:a17:906:cd17:b0:6ce:3727:65f2 with SMTP id oz23-20020a170906cd1700b006ce372765f2mr6837468ejb.720.1645806969535;
        Fri, 25 Feb 2022 08:36:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bx1-20020a0564020b4100b00410f01a91f0sm1582441edb.73.2022.02.25.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:36:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNdZg-000eNT-Hw;
        Fri, 25 Feb 2022 17:36:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, cocci@inria.fr
Subject: Re: [cocci] [PATCH] add usage-strings ci check and amend remaining
 usage strings
Date:   Fri, 25 Feb 2022 17:28:13 +0100
References: <220221.86tucsb4oy.gmgdl@evledraar.gmail.com>
 <20220221173357.8622-1-chakrabortyabhradeep79@gmail.com>
 <nycvar.QRO.7.76.6.2202221152230.11118@tvgsbejvaqbjf.bet>
 <220222.867d9n83ir.gmgdl@evledraar.gmail.com>
 <alpine.DEB.2.22.394.2202221436320.2556@hadrien>
 <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202251601040.11118@tvgsbejvaqbjf.bet>
Message-ID: <220225.86v8x27vk7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Feb 25 2022, Johannes Schindelin wrote:

> Hi Julia,
>
> On Tue, 22 Feb 2022, Julia Lawall wrote:
>
>> [I]f there are some cases that are useful to do statically, with only
>> local information, then using Coccinelle could be useful to get the
>> problem out of the way once and for all.  Coccinelle doesn't support
>> much processing of strings directly, but you can always write some
>> python code to test the contents of a string and to create a new one.
>>
>> Let me know if you want to try this.  You can also check, eg the demo
>> demos/pythontococci.cocci to see how to create code in a python script a=
nd
>> then use it in a normal SmPL rule.
>>
>> If some context has to be taken into account and the context in the same
>> function, then that can also be done with Coccinelle, eg
>>
>> A
>> ...
>> B
>>
>> matches the case where after an A there is a B on all execution paths
>> (except perhaps those that end in an error exit) and
>>
>> A
>> ... when exists
>> B
>>
>> matches the case where there is a B sometime after executing A, even if
>> that does not always occur.
>>
>> If the context that you are interested in is in a called function or is =
in
>> the calling context, then Coccinelle might not be the ideal choice.
>> Coccinelle works on one function at a time, so to do anything
>> interprocedural, you have to do some hacks.
>
> Right. The code in question is not actually calling a function, but a
> macro, and passes a literal string to the macro that we would want to
> check statically.
>
> I did have my doubts that it would be easy with Coccinelle, but since =C3=
=86var
> seemed so confident, I tried it, struggled, and decided to follow up with
> you.
>
> Thank you for confirming my suspicion!
> Johannes

In case it's not clear from the upthread (and I thought my [1] explained
it well enough) I never thought it would be easy or even possible to do
this particular thing with coccinelle.

I.e. I mentioned in [1]:

    Aside: if we did want to do the "parse C" method the right way to do it
    would be to have a coccinelle script do it

So it's intended as a side-note to explain to a new contributor that
*if* we do end up wanting to parse or transform C we have coccinelle,
and it's a great tool for those cases where such static transformations
are easy. I and others have added some in-tree in the past where
appropriate.

But I then went on to say (and elaborated on later in [2]) that in this
case the right thing to do is runtime checking.

So, I'm sorry if you wasted time on it. In either case it seems we've
ended up in agreement in this case about appropriate uses of coccinelle.

I.e. it's a fantastic tool as a semantic patch engine, but it
understandably has limitations where you'd effectively need it to
execute your program to decide what to do, as is the case with the
parse_options() API and the eventual parse_options_check() etc. doing
assertions depending on flags that got passed down.

1. https://lore.kernel.org/git/220221.86tucsb4oy.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/220222.867d9n83ir.gmgdl@evledraar.gmail.com/
