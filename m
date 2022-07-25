Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF78C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 20:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiGYUCt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 16:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiGYUCs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 16:02:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7078B20BE0
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:02:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sz17so22547603ejc.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 13:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7022sbVFatP65oz/9rIauVqzMrDSctfTyLcSSjiymCo=;
        b=Rz5il1idS9tnMWSX826zjMx4WiDQb/CDDnXMoVhbjltETE9xyHkOf99bEMvqFrgVsr
         OFph9G8ETTwEkiTH5J/T5PzuHdZhAmP0YsWQmpZ21GY56js0P09Q8tHLSKHyAhA6nTst
         DEX/CPwm4xgil3RzCYvRw3mhv01lxQm4wmD4hpqyoYY07e+F5GWj8OfQ2xbcgXbIfeXv
         tggyLF0CwNJh/Rip5GRa+6WA0g35QEVwOPEuvpVmGgB6I3bDnRFngQXBatG8+7/zLjEa
         hfB7BFD52ICc8rEyqjqs4ewsKg+mFrc/XzeqU+f/DWWk50wgvuWB0Ezk38eFbNhEIB56
         35mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7022sbVFatP65oz/9rIauVqzMrDSctfTyLcSSjiymCo=;
        b=Y2P48qA5Jyjtbg459XLhkbHoPzL+3zeSEY/wVyYJmFsjdECPRCgrPeThJwLcggHgJ+
         +csb8UJv673ckULcyIdBoyCNvXCvyC1/mYaVAgG16VwdRp+3Qv8deC3w2gvy7P3WWy4w
         Kp2ApN4aXjEI6ckJHkLKA5CgHjG50Hhfg0nGNsOTZvmeNEOnoT+zJaOzzhpm1NLmFUER
         3itAjVmZAyY7BQ28VKzYmXxx7oA1xtqD0PSF6UkM3EcmBmo0CzGchK1auVGbPvNHu4F1
         9l32ZSUny31ObRqxMvf66+vMzcJ8gBPNYqoQ8k0LAEM4/fq357Oafow1YQ6AqGAMy61S
         D4Gg==
X-Gm-Message-State: AJIora9LjZtSXnCLbFOPozY+XvVmlCzuDYMx7ZXIIvQyl/WMyrf2hhDE
        8VLW0c184nyT90OKjcJEVrQ=
X-Google-Smtp-Source: AGRyM1vc7+HOh66JhwFz4e/j7Rr/RYXJ5lEFMnFF5oNypv31MmzFMAbdir+kEIdNbLZw3MFPD0d3aQ==
X-Received: by 2002:a17:907:1c19:b0:72f:cc9e:3a7 with SMTP id nc25-20020a1709071c1900b0072fcc9e03a7mr7726378ejc.631.1658779366015;
        Mon, 25 Jul 2022 13:02:46 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0042de3d661d2sm7552915edb.1.2022.07.25.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 13:01:58 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oG4Gk-005tIO-5E;
        Mon, 25 Jul 2022 22:01:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(github): bring back the 'print test failures' step
Date:   Mon, 25 Jul 2022 22:00:52 +0200
References: <pull.1252.git.1654684998599.gitgitgadget@gmail.com>
 <220609.868rq6t0la.gmgdl@evledraar.gmail.com> <xmqqtu8sfp52.fsf@gitster.g>
 <220610.86edzws9q0.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220610.86edzws9q0.gmgdl@evledraar.gmail.com>
Message-ID: <220725.86sfmpneqp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 10 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jun 10 2022, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> When ci/print-test-failures.sh was last in this file before 08dccc8fc1f
>>> (ci: make it easier to find failed tests' logs in the GitHub workflow,
>>> 2022-05-21) there was no "name" field, that's an unrelated change that
>>> shouldn't be part of a narrow regression fix.
>>>
>>>> +      if: failure() && env.FAILED_TEST_ARTIFACTS !=3D ''
>>>
>>> We likewise just had "if failure()" then, is the distinction different
>>> in all these cases?
>>>
>>>> +      shell: bash
>>>
>>> ...and you've made every single one of them run with "bash" instead of
>>> the default shell, which is another "change while at it" that isn't
>>> discussed.
>>
>> If it is so important to support all the other shells in the GitHub
>> workflows environment, we can discuss fix-up patches on top or
>> replacement patches, but does that really matter?  If this were main
>> Makefile or ci/*.sh that are supposed to be usable by places other
>> than GitHub Actions environment we use for the CI there, of course
>> it would be worth to try being extra portable, but it may be even
>> beneficial to "fix" .github/workflows/* stuff, so that we won't have
>> to be affected by mistaken use of non-portable shell construct
>> written there, perhaps?
>
> It just looks like a mistake. The Windows sections need an explicit
> "bash" shell, but nothing else does, and the Windows sections had
> explicit names for somes stuff, but the other ones did not.
>
> So I think thas was just a case of copy/pasting the first section(s)
> rather than bringing back the pre-image. I think just bringing back the
> old behavior makes sense for a regression fix in a re-roll.
>
> Aside from that I think it's very useful to not rely on bash, for future
> directions of being able to use this tooling more portably, c.f. what I
> did in my series where you can run "like CI" locally, which I'd like to
> do on Solaris, AIX & whatever else without it being a portability
> hassle.

It turns out this is also a regression for our CI, if linux-musl fails
it'll emit:

    OCI runtime exec failed: exec failed: container_linux.go:380:
    starting container process caused: exec: "bash": executable file not
    found in $PATH: unknown

