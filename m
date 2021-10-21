Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 01:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD1360F39
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 01:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhJUBNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 21:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUBNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 21:13:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B3C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 18:11:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i20so951580edj.10
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 18:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=j0jUAgbR1SuexnngNFGiq9LqeKvjzYLDj7WRIgHCUUU=;
        b=knLRf6js/3rp/BvPEHJGn4+yHBqQfNm8lBkzI0N7RFiDKr/ObN/wXJqKET/eN3UMJD
         P87I5gqtx3/ZkendzBpQJb55hArOXedAg9nsDiL1sVARQIRLkbrMLwRQ5xJ4UfPinuG9
         LaXG8RuaEIx6UMXaP/q87ieirOPD03CdvIzjEOn1DoDybViKuVTb6dU8ox5fPX+emLHI
         YQyAn1+0kl1KulxfJQR3BRRhpEr1oSrAFzdKppStAs6Yrz9ZpaoZYaO9zMkrVojG97o4
         4nvYt/yMLUBwTGkJLebnLFBsIl3uBL2b3AN4IqFT2U3U2gCKi+aj1p86qWjof/yzluPi
         SoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=j0jUAgbR1SuexnngNFGiq9LqeKvjzYLDj7WRIgHCUUU=;
        b=LTjRftfD2IaNdwVyyjgZ6iF/Mv1+SjFzczec01qstm8vDVnVSrCGHC1Np1LqJOB4DZ
         HoENM7fAbdOHw1WwMuuG418rN9xYYDbZSSsXUEP9Mjfa/bzbmqhfFSS3I5b2liQbX7nk
         L2O/5RxBOYDIit6nrS/nT7PLtNMNzqQG+nyecjvLQ1xqLK7m3eLcTT0texnWEAG8RFPC
         IZGMhbF918NCs52YLZcbBNNMPZst9XAkwBuOFxPHB921DHwEqcKgzjmRSayOUno42rDS
         hef0Te8U++POSJp8DW5sYbgzFZDGBvOZMuCk5eITViXvWZ+9i+zjHRzDkqktqfm8u3hG
         eH0g==
X-Gm-Message-State: AOAM531LI5tTK00hywPi6kkwLAKLdKtJ36DCRVRqd6pycCdOCLWQCPWB
        XSVQKhhzv6Da5yCr1zc+Vxo=
X-Google-Smtp-Source: ABdhPJz3h5cZ3Juc2/LPLlyEeR7kKGzFpE35sV9KK9bASkXaGhWg01gCXNtnbnu+3lOyifrKquPlSg==
X-Received: by 2002:a05:6402:42ce:: with SMTP id i14mr3336956edc.5.1634778684833;
        Wed, 20 Oct 2021 18:11:24 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f7sm1915481edl.33.2021.10.20.18.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 18:11:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdMc6-000wI6-Sm;
        Thu, 21 Oct 2021 03:11:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Thu, 21 Oct 2021 02:48:24 +0200
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net> <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
 <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
Message-ID: <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Jeff King wrote:

> On Thu, Oct 21, 2021 at 01:14:37AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Jeff: Just in terms of error prone both of these implementations will
>> accept bad input that's being caught in 8/8 of this series.
>>=20
>> We accept a lot of bad input now, ending up with some combinations of
>> bad output or compile errors if you screw with the input *.txt files. I
>> think I've addressed all of those in this series.
>
> I don't mind more error-checking, though TBH I don't find a huge value
> in it. But what I did mean was:
>
>> If you mean the general concept of making a "foo.gen" from a "foo.txt"
>> as an intermediate with make as a way to get to "many-foo.h" I don't
>> really see how it's error prone conceptually. You get error checking
>> each step of the way, and it encourages logic that's simpler each step
>> of the way.
>
> Yes. It just seems like the Makefile gets more complicated, and
> sometimes that can lead to subtle dependency issues (e.g., the ".build"
> dependency in the earlier iteration of the series).

FWIW there wasn't an earlier version of the series, just a POC patch I
had as a comment in
https://lore.kernel.org/git/87r1gqxqxn.fsf@evledraar.gmail.com/

> And in general I'd much rather debug an awk script than a Makefile.
>
>> Per Eric's Sunshine's upthread comments an awk and Perl implementation
>> were both considered before[1].
>
> Ah sorry, I thought it was just a perl one that had been the
> show-stopper. I hadn't noticed the awk one. However, the point of my
> patch was to use perl if available, and fall back otherwise. Maybe
> that's too ugly, but it does address the concern with Eric's
> implementation.

I think carrying two implementations is worse than just having the one
slightly slower one.

>> I.e. I think if you e.g. touch Documentation/git-a*.txt with this series
>> with/without this awk version the difference in runtime is within the
>> error bars. I.e. making the loop faster isn't necessary. It's better to
>> get to a point where make can save you from doing all/most of the work
>> by checking modification times, rather than making an O(n) loop faster.
>
> FWIW, I don't agree with this paragraph at all. Parallelizing or reusing
> partial results is IMHO inferior to just making things faster.

I agree with you in the general case, but for something that's consumed
by a make dependency graph I find it easier to debug things if
e.g. changing git-add.txt results in a change to git-add.gen, which is
then cat'd together.

IOW if we had a sufficiently fast C compiler I think I'd still prefer
make's existing rules over some equivalent of:

    cat *.c | super-fast-cc

Since similar to how the *.sp files depend on the the *.o files now,
declaring the dependency graph allows you to easily add more built
things.

>> I'm also interested in (and have WIP patches for) simplifying things
>> more generally in the Makefile. Once we have a file exploded out has
>> just the synopsis line that can be used to replace what's now in
>> Documentation/cmd-list.perl, i.e. those summary blurbs also end up in
>> "man git".
>>=20
>> There's subtle dependency issues there as well, and just having a
>> one-off solution for the the command-list.h doesn't get us closer to
>> addressing that sibling implementation.
>
> So I don't know what "subtle dependency issues" you found here, but this
> is exactly the kind of complexity it was my goal to avoid.

But how? I don't see how narrowly making the loop in generate-cmdlist.sh
gets us closer to generating the "cmds_txt" in the
Documentation/Makefile.

Whereas after this series we're pretty much there in terms of generating
those files. i.e. try:

    cat Documentation/cmds-mainporcelain.txt

All of those synopsis blurbs are extracted, and reverse-attributable to
the corresponding files.

The dependencies there are (arguably) subtly broken because those files
aren't re-made if a "cmd-list.made" is more recent, so if you remove one
of the generated text files the Makefile logic will get stuck because
the graph is incomplete (which can happen e.g. if "make clean" is
interrupted, or you run a "git clean -dxf '*.txt'".

I did the latter and ran into that recently, because I was trying to
ad-hoc fix another more general dependency issue we tend to have, which
is using wildcards on potentially generated files, so if you checkout a
new verison, build, and then checkout an old version (or are adding one
of the files involved) a script like build-docdep.perl will "helpfully"
pick up bad dependencies.

I guess you could argue that those are all problems with the Makefile,
but I think they're ultimately best solved by driving the dependencies
from the Makefile.

I.e. all we need is the one list of built-ins in command-list.txt, pair
that up with the "category" and we can always generated everything down
to the manpages correctly without relying on FS wildcards.
