Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090B0C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 13:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiGUN72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiGUN70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 09:59:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8C2495F
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:59:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r6so2264711edd.7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Tqir4yuxkz876jISwRi5/nrGEXUn+g82m7NnH4LpxYM=;
        b=gs8X/IdTrvC6uFEcQMk37aeophnJLNeSl8pwzlLs9N0MbHOGUlqojy3ghOuEaF16a3
         Gy5meg1N6EdKtTy4yI02fA1TTieiiYPHa4bQngSd3kSm3t5rGxaws5yEkPL+UR9BsgAY
         cnmEB+IhrZ4BoDIxC0GzC9o9DhKTbbtbksq5cWGsoUExQUGay+JP01QymNTUgHebR2JX
         qnZiyERU+Em4Ykkf3dHI5wrVoDJv3eWgW2iUmaF+jkO4KH10oh4Ol9eAej/+qq29MobK
         u/eAo/PxgrMo5RtQXStAsdD8Z2ifdZapSDE7Py4Xalfa0U57z8j6QPviVGBwulCrJhu/
         Z/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Tqir4yuxkz876jISwRi5/nrGEXUn+g82m7NnH4LpxYM=;
        b=tZ7tDSbwusE5puYj4hWZhuPAssAIuzE9KSrD9WhlcDGbyhY/Yn/HLRjd6XzLTTqn36
         JcgcTH5u/pvKIfJmEjqNJqZY5lpG6Iv+NGlYSbZzoNRCwhINicar7ftXy5ydGi6HG5xa
         BzmwqeOgtH/dRMsaL/osOHBMIiuEQadRzWsAqaytB01X+bKvo6tn+pOk4XUq1eKPVLNs
         hOOT0mvDCT/C9f+EJUBOYxYBoF2QAd8ZeEcShQ8+qRh8v+YYW+P++Viwh6R2f8hT4hjb
         viWftBuQchb91aoWOVqh6L7mTfAX9RyBButDoZFw18OmyYDa4JZiApNwb/AFm8zbwmNm
         pSeg==
X-Gm-Message-State: AJIora/tUyYu7C6z8UmNcvUgMUAAls2261v1/hPD0lpGKkZylRcPH8ia
        M1gXFvrW4psG/izE46K0csk=
X-Google-Smtp-Source: AGRyM1sA0D/T56n6kHtqqwB/eliN10qZwW/yxBTKKrmhcUSO5u6g+CZOi4+6hcZT7E4doQNujjK7Pg==
X-Received: by 2002:a05:6402:354a:b0:43a:d32f:cc62 with SMTP id f10-20020a056402354a00b0043ad32fcc62mr55728799edd.48.1658411963282;
        Thu, 21 Jul 2022 06:59:23 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709063d2100b00722e0b1fa8esm861354ejf.164.2022.07.21.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 06:59:22 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEWi1-004bhU-PW;
        Thu, 21 Jul 2022 15:59:21 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Can I use CRoaring library in Git?
Date:   Thu, 21 Jul 2022 15:51:55 +0200
References: <CAPOJW5x4McofC5fxBvsRAzum28wmeDJCMTMRmY_0oy=32JjKqQ@mail.gmail.com>
 <CAPOJW5yJDq046nhq0V-syAg4ttoy++rBtq_RHSXPAKhtDDw6jQ@mail.gmail.com>
 <xmqq7d47m1t2.fsf@gitster.g>
 <304fd857-db62-7a1a-a9a9-cbfa93c2a00c@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <304fd857-db62-7a1a-a9a9-cbfa93c2a00c@github.com>
Message-ID: <220721.86r12etvly.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 21 2022, Derrick Stolee wrote:

> On 7/21/2022 2:12 AM, Junio C Hamano wrote:
>> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>>=20
>>> On Sat, Jul 16, 2022 at 7:20 PM Abhradeep Chakraborty
>>> <chakrabortyabhradeep79@gmail.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> I need the CRoaring[1] library to use roaring bitmaps. But it has
>>>> Apache license v2 which is not compatible with GPLv2[2].
>>>
>>> I have reached out to Daniel and he agreed to make CRoaring
>>> dual-licensed under MIT and Apachev2[1].
>>> Now, I can use CRoaring, right?
>>>
>>> [1] https://groups.google.com/g/roaring-bitmaps/c/0d7KoA79k3A
>>>
>>> Thanks :)
>>=20
>> Nice.
>
> Great news! Thanks for reaching out. I'm pleasantly surprised at
> the turnaround. Good luck integrating it into the Git codebase!

It's great that the primary author of the library wants to release it
under a compatible license.

But I feel like I'm missing something here, don't we still need the
other contributors to that code to sign off on such a license change,
and for us to be comfortable with integrating such code?

I tried a one-liner to see who has git-blame-able ranges[1] in the code,
which of course is just a rough approximation of "derived work" and
"copyright holder".

My understanding (again, not a lawyer and all that) is that such
transitions happen one of a few ways:

 A. One entity had been assigned copyright in the first place, and can
    re-license the work. E.g. the FSF requiring copyright assignments
    for anything non-trivial.

 B. The license itself has an "upgrade" clause (e.g. GPLv2 "or later"
    projects being GPLv3 compatible).

 C. All copyright holders (or near enough) agree to
    relicense. E.g. OpenStreetMap went through this process at some
    point.

Aren't we just at the beginning (but already past the most significant
step) of C?

1. $ git ls-files | xargs -P 8 -L 1 git -P blame --porcelain HEAD -- |grep =
-E '^author ' 2>/dev/null |sort|uniq -c|sort -nr
   2872 author Daniel Lemire
    131 author Owen Kaser
     87 author AE1020
     70 author Cerul Alain
     63 author Andrei Gudkov
     62 author Fran=C3=A7ois Saint-Jacques
     50 author Jacob Evans
     40 author Tom Cornebize
     37 author Mats Klepsland
     27 author Luca Deri
     17 author Mario Rugiero
     14 author DarrenJiang13
     11 author Wojciech Mu=C5=82a
     11 author GuillaumeHolley
     10 author Mario J. Rugiero
      9 author Paul Smith
      9 author Matt Olan
      6 author Salvatore Previti
      6 author Brian-Esch
      5 author tony eve
      5 author Chris O'Hara
      4 author Alexander Gallego
      3 author Zachary Dremann
      3 author Simon McVittie
      3 author Richard Odenweller
      3 author Hurricane Lee
      3 author daniel-j-h
      2 author stdpain
      2 author Shawn Cao
      2 author Murali Vemulapati
      2 author longqimin
      1 author Yuce Tekol
      1 author yperbasis
      1 author Saulius Grigaliunas
      1 author plantree
      1 author Nathan Kurz
      1 author Guillaume Holley
      1 author gssiyankai
      1 author Daniel Lem_equal(cm12, array_container_cardinality(AM));
      1 author Amos Bird
