Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF25BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B4360527
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJVMxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJVMxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 08:53:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBDFC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:50:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r4so6456802edi.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=zae6CUaDljge9zSruW45JJSaKwvdswm8r9c7Sd+q0jQ=;
        b=gw83Qqu7Jszzx4BMr9FzRD1rvOfNm7XpbOmhlG7wP9JAXAEaAEpDQGPqrky/X8b3vd
         MnFSme8bXI3ZRNA/pSkgJCBrqsajKPJSGbaMG510zjt/6gF3cPLiqMcOhOGuobLcgl/z
         0QWUpKP9b4/kcmAXgKr+4MS8fHUXUkgyrXhqLeTGshI75OrWVdfP44AyVoIcUz6TTQ5j
         WV6PPZYiRlFclPMreZVWgNXdR8mNOhmU6Zk7lSjEqLEoz153Vq0rMPRHC8ut80Rc1Xtu
         4bEAuWhzCTbFfoJKBJUqAtvfeEwyYrw9em4zx/mX4+NCYrIgDvGtxy3Enah8Sddb64ml
         67ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=zae6CUaDljge9zSruW45JJSaKwvdswm8r9c7Sd+q0jQ=;
        b=uh920dAkKIFaW0uxEuX9eEDZnCpnJbb5N05G36+/PAxuu3wtR6EDjSZRzTzFSR4tMn
         wvJJtz3fGKjwOY9IT5kNi8h9y4BKFEh2ZTXXuIcawmf3pPwmz7mBmXVqbcpir86PheUR
         khvVrdujDU0YyWwCWYbKO7ZUkN9Dokv/nsjjfX0JEYnhBfN3D1nSwK5q1pYbg007dk1I
         8B57aqduELj0t4l0iSOwNztPsw60LxXBp0or+3qU/rCM5g3DEoDIs2cAZD1OtKww0aDm
         fVQWHTXhNcJRoznUQ53q36D44yZ4Zfj/IgitPfrXdlpMu0kvXwTnyjJ3gJPGFmqkScXD
         6fiA==
X-Gm-Message-State: AOAM531+T6LolsEx/RYKzbcl2LkRTXgmnbXuO0rTtvHzuxCeXW3JDzs1
        GzhgSL3kjhx5ntqamsyvYSqxF2P0XyPWSA==
X-Google-Smtp-Source: ABdhPJy202DgYCZzppTfvZI/RE/Y8wj4Szxmk49ekQ8cw2N2MOUgb51vQp4PmOG+RjqSWkCAczGHcg==
X-Received: by 2002:a17:906:3d32:: with SMTP id l18mr15912768ejf.393.1634907045450;
        Fri, 22 Oct 2021 05:50:45 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id c8sm4055569edt.55.2021.10.22.05.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 05:50:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdu0S-001CXW-EA;
        Fri, 22 Oct 2021 14:50:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH 0/8] Makefile: make command-list.h 2-5x as fast with -jN
Date:   Fri, 22 Oct 2021 14:37:18 +0200
References: <YNqBtrXzUlJiuc7y@coredump.intra.peff.net>
 <cover-0.8-00000000000-20211020T183533Z-avarab@gmail.com>
 <YXB9moNHRj+nrnX9@coredump.intra.peff.net> <YXCKqAEwtwFozWk6@nand.local>
 <211021.86v91rmftn.gmgdl@evledraar.gmail.com>
 <YXCqO7WFET6J7gGf@coredump.intra.peff.net>
 <211021.86ilxrmbb9.gmgdl@evledraar.gmail.com>
 <YXDOaNsu8CaytBbr@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXDOaNsu8CaytBbr@nand.local>
Message-ID: <211022.86cznxkyu3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 20 2021, Taylor Blau wrote:

> On Thu, Oct 21, 2021 at 02:48:24AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> >> Per Eric's Sunshine's upthread comments an awk and Perl implementation
>> >> were both considered before[1].
>> >
>> > Ah sorry, I thought it was just a perl one that had been the
>> > show-stopper. I hadn't noticed the awk one. However, the point of my
>> > patch was to use perl if available, and fall back otherwise. Maybe
>> > that's too ugly, but it does address the concern with Eric's
>> > implementation.
>>
>> I think carrying two implementations is worse than just having the one
>> slightly slower one.
>
> I have no opinion on whether or not assuming that awk or Perl exists and
> can be relied upon during the build is reasonable or not. It seems like
> the former might be a slightly safer assumption than the latter, but in
> all honesty it seems like both are always likely to be around.
>
> In any case, I think the point was that we could improve upon Peff's
> patch by just having a single implementation done in awk. And when I
> wrote that I definitely was in the mindset of being able to rely on awk
> during compilation.
>
>> >> I.e. I think if you e.g. touch Documentation/git-a*.txt with this ser=
ies
>> >> with/without this awk version the difference in runtime is within the
>> >> error bars. I.e. making the loop faster isn't necessary. It's better =
to
>> >> get to a point where make can save you from doing all/most of the work
>> >> by checking modification times, rather than making an O(n) loop faste=
r.
>> >
>> > FWIW, I don't agree with this paragraph at all. Parallelizing or reusi=
ng
>> > partial results is IMHO inferior to just making things faster.
>>
>> I agree with you in the general case, but for something that's consumed
>> by a make dependency graph I find it easier to debug things if
>> e.g. changing git-add.txt results in a change to git-add.gen, which is
>> then cat'd together.
>>
>> IOW if we had a sufficiently fast C compiler I think I'd still prefer
>> make's existing rules over some equivalent of:
>>
>>     cat *.c | super-fast-cc
>>
>> Since similar to how the *.sp files depend on the the *.o files now,
>> declaring the dependency graph allows you to easily add more built
>> things.
>
> This seems like an unfair comparison to me. I might be more sympathetic
> if we were generating a more complicated artifact by running
> generate-cmdlist.sh, but its inputs and outputs seem very well defined
> (and non-complicated) to me.

They are? a foo.o to foo.o input is relatively uncomplicated, and you
can discover the exact dependencies with 3rd party tools, like the GCC
and Clang switches we use generate the .depends dirs[1].

Whereas with the custom shellscripts that have for-loops of their own
like generate-cmdlist.sh what it depends on exactly is relatively opaque
to you until you read the shellscript.

I guess it's a matter of taste, but if you run this with/without this
series:

    touch Documentation/git-a*.txt; time make -j1 command-list.h --debug=3D=
b V=3D1

You'll see that before we'd spot that e.g. git-add.txt changed, but
we'll run one target in response to that at the end.

So it's just like what you'd get when you make %.o from %.c to produce a
"program" that links all those %.o together at the end.

So I do think it's a fair comparison, if anything it's unfair to this
series, because as noted you can discover these dependency independently
with GCC etc. for C code. But for a custom *.txt format with an ad-hoc
*.sh to parse it there's no such aid available.

1. $ cat .depend/help.o.d=20
help.o: help.c cache.h git-compat-util.h compat/bswap.h wildmatch.h \
 banned.h strbuf.h hashmap.h hash.h repository.h path.h sha1dc_git.h \
 sha1collisiondetection/lib/sha1.h sha256/block/sha256.h list.h advice.h \
 gettext.h convert.h string-list.h trace.h trace2.h pack-revindex.h \
 oid-array.h mem-pool.h config.h builtin.h commit.h object.h tree.h \
 decorate.h gpg-interface.h pretty.h commit-slab.h commit-slab-decl.h \
 commit-slab-impl.h exec-cmd.h run-command.h thread-utils.h strvec.h \
 levenshtein.h help.h command-list.h column.h version.h refs.h \
 parse-options.h prompt.h
[...]
