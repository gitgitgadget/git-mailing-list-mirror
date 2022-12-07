Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE12C47089
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 04:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGEnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 23:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLGEnG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 23:43:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C256EC1
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 20:43:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n21so11172739ejb.9
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 20:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oO+yLkOIqkWCSWPnm1ciAeqtoJ8tvHDwe2lbRCXll+k=;
        b=AumddIsSEMp2F898pId3sZ0jZ7kswsqy4c83z1MJt1EFdjOsTr5gw93d7krV3UR32i
         Tzy/LyuiopVk/IvpsB2QtKucO7SCizwavqgXWG1qeiYW5peqSp/w1X4R5kqInvoNCfUy
         bax+S/1PRwKU4a/udyRWTmMapYy6s9kzFEbTmB4vF+NzhJBs11DaRXDz034XtJAN7+yY
         2RWA+6DdtlmPkhUpBaxO9nqFLJKJnysYhnsmU/PXeCPaVbfV/+OxvOcgN4Fb59I4z1Cq
         HkEBkq62yvJFTyKCqdueHgwGZRO9BjOkI7lcHIWQUIKdaA/nmVXmP+GdatEyzfUX0UhW
         gP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oO+yLkOIqkWCSWPnm1ciAeqtoJ8tvHDwe2lbRCXll+k=;
        b=2LGsB9nqvUue54aA9+WMZS2wpThwqPKoU8/HHDBNvdamhe0V/QeismpA8tkubB/QeI
         +UovyjNMzcwzPtetzh38mCgR5BKQ0DCZeIlf8dPtVDkB8CtYBXrNp0vNtva6YOpue0nR
         0287tApOSq7HD9hAOctAvlBK0x1P/gBi3ld10QnfDY6GeIPHI+JaPYxKYlqiwAZA3WHI
         Blju1Sf2UvR6ZhastDVKU8tqIsH8AEVsPqlFDsKtgXJK0aGC//u+ZwrNwyhkRjstJKge
         gmzM510w9KU65OehqQWGr1KY4dEajw0Ln4eVClac817JlMoJ79x3qAmweg8jFu0E+wMN
         6aWw==
X-Gm-Message-State: ANoB5pnStjGGISI5aDaPMwSGuj5Q2DilOSuN3rK1s+RrwW1KMQQcK5w2
        cyAepe4CjK4OK/kg58UdXk/nDZGpYH2+lA==
X-Google-Smtp-Source: AA0mqf7wXywioWrHqpyZc5vFqc1c5t3eiGq04+7+hkxomFBeA04h+s9AaTEDmmDL69Utab+mabtD1Q==
X-Received: by 2002:a17:906:811:b0:7c1:98e:b910 with SMTP id e17-20020a170906081100b007c1098eb910mr5568599ejd.81.1670388184072;
        Tue, 06 Dec 2022 20:43:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id i16-20020a170906251000b007c10fe64c5dsm1239607ejb.86.2022.12.06.20.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 20:43:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2mGt-004Knl-0g;
        Wed, 07 Dec 2022 05:43:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     David Caro <dcaro@wikimedia.org>, git@vger.kernel.org
Subject: Re: Skipping adding Signed-off-by even if it's not the last on git
 commit
Date:   Wed, 07 Dec 2022 05:31:18 +0100
References: <20221206170646.6lnpr6h7oprziy5b@vulcanus>
 <Y4/xSObs9QXvE+xR@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y4/xSObs9QXvE+xR@nand.local>
Message-ID: <221207.86y1rjako8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 06 2022, Taylor Blau wrote:

> Hi David,
>
> On Tue, Dec 06, 2022 at 06:06:46PM +0100, David Caro wrote:
>> I have noticed that when requesting git commit to add the
>> Signed-off-by header, it will add it even if it already exists as long
>> as it's not the last in the footer.
>>
>> It seems that the functionality to do so has been there for a while
>> (see [1]) and it's being used effectively on format-patch, but it was
>> never enabled for the rest of commands.
>
> Right; bab4d1097c (sequencer.c: teach append_signoff how to detect
> duplicate s-o-b, 2013-02-12) introduced the APPEND_SIGNOFF_DEDUP flag,
> which instructs append_signoff() to avoid adding a Signed-off-by
> trailer if one already exists anywhere in the trailers section of the
> target commit.
>
> As bab4d1097c hints, this is desirable in some situations. However,
> adding duplicated S-o-b trailers is useful in other situations. For
> example, if you and I exchange a patch back and forth on this list, it
> might go something like:
>
>   1. I write up an initial patch, add my Singed-off-by, and send it to
>      the list.
>
>   2. You notice that some aspects can be improved, so you apply and
>      modify the commit locally, adding your own Signed-off-by.
>
>   3. I pick up your changes as part of a new version of the patch
>      series, and resubmit it to the list, adding my own Signed-off-by
>      again.
>
> There are a couple of small things worth noting there. First, in (2),
> the changes that you introduced were large enough to be worth crediting
> (e.g., you didn't suggest a typofix or to modify the amount of spacing
> on a line or similar), but not large enough to change the author of the
> patch.
>
> Likewise, in (3), the second instance of my Signed-off-by indicates that
> I am OK with the changes that you wrote, and I certify the new version
> of the patch as my own work.
>
> One such instance is in 0ca6ead81e (alias.c: reject too-long cmdline
> strings in split_cmdline(), 2022-09-28). Another is in b3c5f5cb04
> (submodule: move core cmd_update() logic to C, 2022-03-15).
>
> If you're curious to dig up more in your own project, here's a little
> shell snippet I wrote up to find some examples:
>
>     git rev-list --no-merges HEAD |
>     while read rev
>     do
>       git -P show -s -1 --format=3D'%(trailers:key=3DSigned-off-by,unfold=
=3Dtrue)' "$rev" |
>       grep -v '^$' | sort | uniq -c | grep -vq "^      1 " && echo "$rev"
>     done

This is pretty much what I would have said, i.e. that it is intentional,
as the SOB has do do with the DCO chronology of events.

The SOB is a proxy for passing the copyrightable work around, and to
certify that you have permission to license the work per the DCO etc.

But it's also interesting in that context that we choose to omit this
for re-rolls. I.e.:

 1. I write a patch, that has 10 lines of original work, add a SOB
 2. You pick it up, add another 10 lines, add your SOB
 3. I pick it up again, add another 10 lines, add my SOB

So at the end we have a SOB sequence of: =C3=86var, Taylor, =C3=86var, and =
30
copyrightable lines of code.

But if I submit three versions of my own patch with the same growth
pattern over those three iterations shouldn't I have 3 of my own SOB
lines: =C3=86var, =C3=86var, =C3=86var?

I'm not suggesting that's a sane idea, but at the same time I can't
really square the internal logic of why we'd do one, but not the
other.

If we assume that an earlier SOB from a v1 is carried forward to my own
v2 and v3 re-rolls, shouldn't the same convention apply for my v1 SOB if
you the v2 re-roll was yours?
