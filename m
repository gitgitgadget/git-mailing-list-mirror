Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E9DC43334
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 08:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbiFGIvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiFGIvr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 04:51:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1928CBCF
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 01:51:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z7so22014805edm.13
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qSE8aBrLb0AcL1muyTTvRRhA10p2Au9pKKp4Jd4jerI=;
        b=KFu9e2mO7vCRS2Ao2iB70VQ9tLgrKzMNCcsjFEZQZxiTtLbAPXGtF5FGMyFwAAFeGX
         AGkdA4qHwAmD8d+j2JE+531GwZN5BlFVPMiYztRdUxC4gdFKBZObfb/gxejh3U25ct33
         zFGPcMtuyn8V/IXZMGTOb0G+P4oGuQMCFZLauP/SXdsYqka/Idy/CmBL/uSu/NCYbXAL
         VRBk5Gv2fBB0JzifkEItFAlw8Fs+0eqC/m/Q3IdMZhamGaKx4R9O7J54mTMml92Nmnw7
         MNBtRhg2t/6YZCmFOFBsKabcJlQeNEmwtfn/DyB782+RLOtnqxUMDp29J2Q5AEwDDzhw
         UUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qSE8aBrLb0AcL1muyTTvRRhA10p2Au9pKKp4Jd4jerI=;
        b=aDBUBZXV0ZeyhutoY3ROj2zFFkdJPTQ+TnwMMOc0xr9VS+0lTU1dFNuNYQcXUP6Ini
         7LcrjQEMHfUIMJup5yWULwLoICv43et9wqWQKUZZZ6n0UdimGTUjvvaJWOSrloMK787D
         JBylBtD3tdMFDHdsJFpbuKFdibQK70QFPn6y+Et16tW3OmLcl7vHGgmhA2qAoGnN/sUp
         BBtK+GEzLDdsuYgtODhkSvldhyGMhdFO/qc/Ss/jeiXOXsNYaNmsEwX/UQFs/10W4eig
         gBWC/XMpsYKc4wLof/0Jr91tDuFpferh0qC/5+iuOnNiSLXT+tTmFrvpsy50K0zzJAmD
         Ejcg==
X-Gm-Message-State: AOAM531HbiKN3K80fCYi03YD4Tb5zrrx+uPAZOehO7m571bnfMGaxK9L
        cPyXz2zVE3BHd2URLSI0RI8=
X-Google-Smtp-Source: ABdhPJxGIMuOGdmGI9YIY0+hH4mt8VW67y/2phrC5n+TCx4ZIRay9Lt9YMnmrU3igZnEmQP+Cc2OOQ==
X-Received: by 2002:a05:6402:3514:b0:431:7164:f1d9 with SMTP id b20-20020a056402351400b004317164f1d9mr6666347edd.99.1654591904509;
        Tue, 07 Jun 2022 01:51:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0042dd022787esm9917473edb.6.2022.06.07.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:51:43 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyUwB-002NYn-9G;
        Tue, 07 Jun 2022 10:51:43 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
Date:   Tue, 07 Jun 2022 10:49:01 +0200
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
 <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
 <6e98dfe9-5df2-caab-ed3a-81f07b0bb6bc@gmail.com>
 <220603.86o7zaxfhf.gmgdl@evledraar.gmail.com>
 <993aff66-01b7-4aa3-78ae-0027c9c04ea8@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <993aff66-01b7-4aa3-78ae-0027c9c04ea8@gmail.com>
Message-ID: <220607.86bkv4votc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 03/06/2022 10:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Jun 03 2022, Phillip Wood wrote:
>>=20
>>> Hi =C3=86var
>>>
>>> On 02/06/2022 15:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>> This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
>>>> reasons for why a regression needs this relatively large change to
>>>> move forward is discussed in past rounds, e.g. around [3]. CI at
>>>> https://github.com/avar/git/actions/runs/2428475773
>>>> Changes since v4, mainly to address comments by Johannes (thanks for
>>>> the review!):
>>>>    * First, some things like renaming "ungroup" to something else &
>>>>      rewriting the tests I didn't do because I thought keeping the
>>>>      inter/range-diff down in size outweighed re-arranging or changing
>>>>      the code at this late stage.
>>>>      In the case of the suggested shorter test in
>>>>      https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206011827300.349@t=
vgsbejvaqbjf.bet/
>>>>      the replacement wasn't testing the same thing. I.e. we don't see
>>>>      what's connected to a TTY if we redirect one of stdout or stderr
>>>>      anymore, which is important to get right.
>>>
>>> I'm a bit confused by this, the proposed test uses this hook script
>>>
>>> 	write_script .git/hooks/pre-commit <<-EOF
>>> 	test -t 1 && echo "stdout is a TTY" >out
>>> 	test -t 2 && echo "stderr is a TTY" >>out
>>> 	EOF
>>>
>>> if either of stderr or stdout is redirected then the corresponding
>>> "test -t" should fail and so we will detect that it is not a tty.
>> Yes, exactly, but the proposed test doesn't test that, in that case
>> both
>> of them are connected, the test in 2/2 does test that case.
>
> I think I must be missing something. As I understand it we want to
> check that the hook can see a tty on stdout and stderr. In the test
> above we'll get a line printed for each fd that is a tty. Your test
> always redirects one of stdout and stderr - why is it important to
> test that? - it feels like it is testing the shell's redirection code
> rather than git.

Yes, I think I'm the one who was missing something.

I looked at this again and I thought I'd been testing that e.g. one of
the two not returning true from isatty() wasn't making both "not TTY",
i.e. that run-command.c wasn't performing some shenanigans.

But that was probably too paranoid, and in any case I couldn't find a
good way to test it.

> I was concerned that we had also regressed the handling of stdin but
> looking at (the now deleted) run_hook_ve() it used to set .no_stdin =3D
> 1 so that is unchanged in the new code.

*nod*

I re-rolled a v6 just now which I think should address your comments
here:
https://lore.kernel.org/git/cover-v6-0.2-00000000000-20220606T170356Z-avara=
b@gmail.com/

I've still kept the "clean up after yourself" etc. behavior in the test,
and since it was easy we now test both "git hook run" and "git commit".

Thanks a lot for the careful review.
