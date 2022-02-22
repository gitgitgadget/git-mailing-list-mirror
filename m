Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CC9C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 11:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbiBVLhK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 06:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiBVLhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 06:37:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D28986D4
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:36:42 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm8so26576271edb.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 03:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ZruvFEdHXus31KGiqvc7Rv+WfhVT43rXxF+jn2Ac4Ws=;
        b=oE1cC9SL91k05jt7PY0XRl3Dkta+9E6iH9fNw2rQ2d0de3QjZAQXZrXNjUZRPvA19v
         agXZ6SalILPiMKgLQQzr+4QHvPd8X65GHb5wBGI+ltzIFxhd9DXY0RPT3iRaio5Q9mdK
         kHDwCKF0lp+FEcinLst+N7QN7Ta7EN22ujoG2Jlk11gGRcxi93ldKScA7hNd4tMUwjXW
         xP9qtbktV1M41ojNnMCs9F3Qg7WscxRevD9BCN1homTqHqp2Mb+nJM5aL/lXd68Tikhe
         X+UdHN1NAHix1b6tL4U2gGisU8kpPyCLKVzpe0nEKHGx7uAYPbbSXoOVoWH2zsVR+L45
         WFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ZruvFEdHXus31KGiqvc7Rv+WfhVT43rXxF+jn2Ac4Ws=;
        b=B2DK4CUoPLeN0OlCZjRUg3zQ46RBgHZGbzIV8C7kpLehMmxFZH+rmQtFPZp9AmzneE
         mKlgrOMeWDb380yqvN15twqAJ6q5nKGSUxHKssiZ6b7Xx1fdVldJybAWu4E4XCpW75Nm
         gDGtBKN7cxcMXODavvR0EHe7H7UUMybwR3Q0A4vVjs78Z+HBDhKQX5jr3vzewns+BMhH
         4I2DWy3dtAqdBqcnnBfozZEUxZlNBL2+1atw2wZZYmrAKaUTW6XlPedXZxNSxe41zpgT
         iFroV9Rcb/A4g5Cwm5Zk41x922P295x0r6uoF9JoJkymLVbJWvVT4XRstWgGKtHiBEMG
         5MnQ==
X-Gm-Message-State: AOAM530KiSqe8OUIXE0aSFeIUC10Lu8cqDIXW0FFPL0clZwwhUjuakia
        4EaEK5slXNXeugw+Or0FPu0=
X-Google-Smtp-Source: ABdhPJysTFA6XoZkMGyQ1IrkuknvbqYSwNq84DB2WTws117xKrzDhcNq+Ira+MlEBc84sHmj8GkGfg==
X-Received: by 2002:a05:6402:51ca:b0:412:d1b2:496d with SMTP id r10-20020a05640251ca00b00412d1b2496dmr18689064edd.18.1645529801258;
        Tue, 22 Feb 2022 03:36:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l8sm6097259ejp.198.2022.02.22.03.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 03:36:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMTTD-00604d-KA;
        Tue, 22 Feb 2022 12:36:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 4/8] Makefile: move ".SUFFIXES" rule to shared.mak
Date:   Tue, 22 Feb 2022 12:14:57 +0100
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
 <patch-v2-4.8-4c6d8089fff-20211224T173558Z-avarab@gmail.com>
 <YhQs3VfjacB+Ryvh@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YhQs3VfjacB+Ryvh@nand.local>
Message-ID: <220222.86bkyz875k.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Taylor Blau wrote:

> On Fri, Dec 24, 2021 at 06:37:43PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>     $ git -c hyperfine.hook.setup=3D hyperfine -L rev HEAD~1,HEAD~0 -s '=
make -C Documentation man' 'make -C Documentation -j1 man'
>>     Benchmark 1: make -C Documentation -j1 man' in 'HEAD~1
>>       Time (mean =C2=B1 =CF=83):     121.7 ms =C2=B1   8.8 ms    [User: =
105.8 ms, System: 18.6 ms]
>>       Range (min =E2=80=A6 max):   112.8 ms =E2=80=A6 148.4 ms    26 runs
>>
>>     Benchmark 2: make -C Documentation -j1 man' in 'HEAD~0
>>       Time (mean =C2=B1 =CF=83):      97.5 ms =C2=B1   8.0 ms    [User: =
80.1 ms, System: 20.1 ms]
>>       Range (min =E2=80=A6 max):    89.8 ms =E2=80=A6 111.8 ms    32 runs
>>
>>     Summary
>>       'make -C Documentation -j1 man' in 'HEAD~0' ran
>>         1.25 =C2=B1 0.14 times faster than 'make -C Documentation -j1 ma=
n' in 'HEAD~1'
>
> Nice speed-up. Though I am not sure I totally understand where it comes
> from ;). Reading 30248886ce8 and the documentation on .SUFFIXES from
> [1], I am still unclear. I guess removing the obsolete built-in suffix
> rules gives make less work to do in general?

I'll update the commit message, but basically the same applies as for
2/8 here (<patch-v2-2.8-b0c9be581a6-20211224T173558Z-avarab@gmail.com>),
or if you run "make" with "--debug=3Da". I.e. if before/after this change y=
ou do:

    git clean -dxf; make -C Documentation/ --debug=3Da git-status.1 >/tmp/b=
 2>&1
    git clean -dxf; make -C Documentation/ --debug=3Da git-status.1 >/tmp/a=
 2>&1

You'll get:
=20=20=20=20
    $ wc -l /tmp/[ba]
       6515 /tmp/a
     144051 /tmp/b
     150566 total

Which e.g. for "git-status.txt" starts with (I cut a lot out, there's
way more than this just for that file):
=20=20=20=20
          Considering target file 'git-status.txt'.
           Looking for an implicit rule for 'git-status.txt'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.o'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.c'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.cc'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.C'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.cpp'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.p'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.f'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.F'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.m'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.r'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.s'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.S'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.mod'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.sh'.
    -      Trying pattern rule with stem 'git-status.txt'.
    -      Trying implicit prerequisite 'git-status.txt.o'.
    [...]

I.e. given a foo.txt "make" by default will exhaustively consider foo
foo.txt.c, foo.txt.cpp etc. etc.

This is all ultimately a part of make's implicit rule
mechanism. I.e. even if you have no Makefile at all you can run "make
main" if you have a main.c in your directory, and it'll discover it and
compile it with implicit rules, unless you explicitl disable them,
e.g. with "-r":
=20=20=20=20
    $ rm Makefile hello; make hello
    rm: cannot remove 'Makefile': No such file or directory
    rm: cannot remove 'hello': No such file or directory
    cc   hello.o   -o hello
    $ rm Makefile hello; make -r hello
    rm: cannot remove 'Makefile': No such file or directory
    make: *** No rule to make target 'hello'.  Stop.

> So long as we're not depending on any of these, this seems like a nice
> little boost to me.

Yes, definitely!

>> diff --git a/shared.mak b/shared.mak
>> index 29f0e69ecb9..155ac84f867 100644
>> --- a/shared.mak
>> +++ b/shared.mak
>> @@ -9,6 +9,11 @@
>>  %:: s.%
>>  %:: SCCS/s.%
>>
>> +## Likewise delete default $(SUFFIXES). See:
>> +##
>> +##     info make --index-search=3D.DELETE_ON_ERROR
>> +.SUFFIXES:
>
> Hmm. s/DELETE_ON_ERROR/SUFFIXES? Or perhaps I'm holding this whole thing
> incorrectly:
>
>     ~/s/git [nand] (ab/make-noop) $ info make --index-search=3D.DELETE_ON=
_ERROR
>     no index entries found for '.DELETE_ON_ERROR'
>     ~/s/git [nand] (ab/make-noop) $ info make --index-search=3D.SUFFIXES
>     no index entries found for '.SUFFIXES'

Yes that's a copy/paste error, it should be .SUFFIXES.

But both commands should work, or emit an error like:

    $ info doesnotexist --index-search=3D.DELETE_ON_ERROR
    info: No menu item 'doesnotexist' in node '(dir)Top'

A broken OS package? Self-built "make"?

In any case I could also link to
https://www.gnu.org/software/make/manual/html_node/Suffix-Rules.html;
which is the same information online (but may not match your local
"make" version)>
