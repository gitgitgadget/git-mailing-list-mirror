Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE856C4743D
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DDB611ED
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 21:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFDVi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 17:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFDVi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 17:38:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF5C061767
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 14:36:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o5so12746823edc.5
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0Zr+HvLv3vu0naGAJv4z2/OjB/ISoR1EIx08pVDfz/I=;
        b=UBcEkNoLb/rRGRGStUkYch1Yjr4Tqyf4FtmBomfbWU+rEc8tDcbhfE1goPZRNoAdAV
         BL7h44SkDQy6LJDtMG162TMXXBgzOwhF673ZAuFam+b9vFRm1r9Hh16LMm/jGnHoKDSC
         XMh+WAfw9InFNPgdo/isRbVb7f0hA0pTGblMY73waeUxIvnPr8VyTDOF6dZKApU5eSHU
         5nxTVDKePRD7Qmfh/Cncb3ptmDhdQNaom3xJSll0HbHE8Ih4PEoE6vn1ksrECWSY/qYb
         leNFcMKotCJukErw0WUWFyVtqoge6CiS7966fRquHEHcl02JWsoLYOiT766xZj+3f5lw
         U8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0Zr+HvLv3vu0naGAJv4z2/OjB/ISoR1EIx08pVDfz/I=;
        b=d3tAf61ZD64Yl1DlonUiBgbZG3fGxgA03k4Aw5D3gF+ik+Q90JuNjfT00cCLMFAZ+O
         UTaJw8sFI2PpCX1k3P0citAtUATKKpsNUsjIqg2TsdtbQQ6KmGFbF/Vk/1Arx11D9JJB
         NGYHkOO/fcUHJ0gMsoUEXxpIXL+kUpiKlIiQp/mGKHJegStqtKXEZC4DRof+wTXKNqVQ
         3Lm7hga9P6Ia3eu7/fTzC+Drl4kdpyza8ICkUv0ekK1zvEEWSc2xInMqC/b/vPmfNgau
         MeZ68cY8RKu2Mco+Wbou7aGC0PRwu7gC4YU4kBuBJ7pvPstN29lR9oI50gFk8rTcsfc2
         YBlQ==
X-Gm-Message-State: AOAM5314ZwsWI8ej6nIHVi1Y/I3RRUoy5aj+nX+Uy7hk3vtMZ8S3TRvo
        APmDwWfZuaqGj426X5l3Jkk=
X-Google-Smtp-Source: ABdhPJyoQVtNVYGhNvQ4N83lEQU2X1+P8rXj2sEjk4QB8BmHaBsEeKriL38Kyizz3vu9Szqrn3gOQw==
X-Received: by 2002:a05:6402:342:: with SMTP id r2mr7022602edw.69.1622842595737;
        Fri, 04 Jun 2021 14:36:35 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id m4sm3214315eje.8.2021.06.04.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:36:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Felt <aixtools@gmail.com>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Date:   Fri, 04 Jun 2021 23:12:06 +0200
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
 <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
Message-ID: <87o8cl5n31.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 03 2021, Jeff King wrote:

> On Mon, May 31, 2021 at 04:18:46PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>>=20
>> On Wed, Jul 26 2017, Michael Haggerty wrote:
>>=20
>> > [...]
>> > +test_expect_success 'pack symlinked packed-refs' '
>> > +	# First make sure that symlinking works when reading:
>> > +	git update-ref refs/heads/loosy refs/heads/master &&
>> > +	git for-each-ref >all-refs-before &&
>> > +	mv .git/packed-refs .git/my-deviant-packed-refs &&
>> > +	ln -s my-deviant-packed-refs .git/packed-refs &&
>> > +	git for-each-ref >all-refs-linked &&
>> > +	test_cmp all-refs-before all-refs-linked &&
>> > +	git pack-refs --all --prune &&
>> > +	git for-each-ref >all-refs-packed &&
>> > +	test_cmp all-refs-before all-refs-packed &&
>> > +	test -h .git/packed-refs &&
>> > +	test "$(readlink .git/packed-refs)" =3D "my-deviant-packed-refs"
>> > +'
>>=20
>> FWIW this broke tests on AIX because we can't assume readlink(1) exists
>> at all. See d2addc3b96 (t7800: readlink may not be available,
>> 2016-05-31) for a workaround.
>
> Hmm. So obviously we can use a fix similar to the one in t7800 (though
> it's sufficiently complicated that I'd be tempted to wrap it in a helper
> function). There are a few other calls that could be changed, too.
>
> But it's interesting to me that it sounds like the tests have been
> broken on AIX for 4 years, and nobody noticed. I assume you ran into
> this on the gcc build-farm machines. Our traditional approach for
> portability has been: if somebody is using the platform and cares enough
> to submit patches, then we'll support it. But testing on the build-farm
> means preemptively finding these problems, whether anyone actually cares
> about AIX or not. :)
>
> I'm not really arguing either way here, just thinking out loud.
>
> Preemptively finding portability problems may save work in the long
> term. And people may even be using Git on AIX and just ignoring test
> failures, or they have GNU coreutils installed anyway, etc. But it would
> also save work if we can ignore platforms that nobody uses.

I believe that the main packager for AIX is Michael Felt (CC'd). He's
occasionally posted here on-list, e.g. at [1], the package is at [2].

I think in the grand scheme of things if we break things completely for
IBM xlc and/or Oracle's C compiler git won't be that much worse
off. Plenty of third party packages for those platforms simply use the
full GNU toolchain.

From memory the most commonly used package for Solaris is built with the
full GNU toolchain, so in that sense portability to that platform isn't
a practical issue.

I just send patches for these as part of doing rc-phase testing on the
GCC farm to see if anything's broken since the last release. Issues we
have on OSX, Linux, Windows etc. tend to be resolved already, which
leaves more obscure issues on these platforms.

I've said before that I do think that porting to "obscure" platforms
like those has some value in itself, even now there's e.g. C compiler
warnings on those proprietary compilers that cover blind spots that
neither gcc nor clang have. Often they're false alarms, but there's the
occasional gold nuggets in there.

E.g. I have some post-release patches queued up for fixing various cmd_*
functions of ours to use "return" instead of "exit(code)". Even though
they return "int" neither GCC nor Clang complain about the early exit,
but SunCC does. As a result we don't run the usual teardown in git.c for
some built-ins.

I was trying to get AIX in particular to the point of passing 100% a
while ago, but sort of lost steam with Junio not wanting to take my
patches at [3].

Without those re-running the tests usually takes manual intervention on
the box, so and since my usual test setup is more of a fire-and-forget
affair I mostly stopped bothering with the AIX box as a result...

1. https://lore.kernel.org/git/1200106e-b75d-5b15-0608-427cd923578a@felt.de=
mon.nl/
2. http://www.aixtools.net/index.php/git
3. https://lore.kernel.org/git/patch-1.6-3330cdbccc0-20210329T161723Z-avara=
b@gmail.com/
