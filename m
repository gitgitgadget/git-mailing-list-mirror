Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D43C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 09:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiFCJ3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 05:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbiFCJ3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 05:29:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2113A5D0
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 02:29:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gl15so924063ejb.4
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=i4+bElpolsJ0GHepQpFg/tQgCcioHKXuT9MN/GIWKrc=;
        b=AIW4GfQ0USfuRu6sLaINCkNaH29UcLmpcTRUj12IkhTU48kdH79DMabTBLmqNpd7dy
         W/uzFjO3dAMmZLi8/3Nm6/fzbrdLYWO4y0KnCixSuOOq4ryBEFgpYlwseFozNKwXyOFa
         PZCC9MhuozosNPCDr4B8nOZQkUEln42vLZ218GEE6/Io+wDNoMNdj3f+o8oLTmT7+h6p
         eKiisJ9/ir17tGTKmC1/b22DEiBrhzXd0azdxgeygRWJfsvmBGHfdS3jJxsIK6kLazOK
         /apEhZ01sm192uob7vaaO8L6gvYNbXSjiX47YcRhjsY9jHQcnJ0d+DczR+St+nxkVFrn
         EJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=i4+bElpolsJ0GHepQpFg/tQgCcioHKXuT9MN/GIWKrc=;
        b=3zTBPWjf6uvciAMM1axlHryCA21ISL7eB9oNW6NbHQPlwUueSXXzTr/7gTohU2aehO
         9BDLGtiJ95q/suvHPySCNcCeUfbE4LjePHKSsi+Lb4THY2Z0R1mme2Ubw21CwEB3smth
         F8x0W//ksuixw8m/PONkpCSwLNfMklygd4W3a4B7oChAY7MSVvhvvHrgjjSFDIhiUBzN
         jQXgjVX49VP7JAYm/nJz9EDC4iZaF2JXKM24dnimdneMeOU5yQcu/osIaddETPx5M9El
         rvciQwEEHBOw3SWYuDxAHx+UUr03/FeUBpCNeGSmtkMFIDCW6K7Uh4CK6/u59Vfhhfk3
         7jyQ==
X-Gm-Message-State: AOAM532frK6RoxxcQjSaGRC70Jm9Q47SN0JlnBw55WYFVR9XnaS0sk6o
        D7KjZBLuPAXX7Qg9SgvTrZc=
X-Google-Smtp-Source: ABdhPJyXAOgaWY6wyvePGMalzMp9NwFBV/dHzGL5g+4iJFFvVEmUt9BDv29d1dXbs78IPo06ioGQ8Q==
X-Received: by 2002:a17:907:ea6:b0:708:1282:cbe8 with SMTP id ho38-20020a1709070ea600b007081282cbe8mr8026798ejc.520.1654248542130;
        Fri, 03 Jun 2022 02:29:02 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g15-20020aa7dc4f000000b0042defe37a42sm3629492edu.16.2022.06.03.02.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:29:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nx3c4-001a2E-BH;
        Fri, 03 Jun 2022 11:29:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anthony Sottile <asottile@umich.edu>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/2] hook API: connect hooks to the TTY again, fixes
 a v2.36.0 regression
Date:   Fri, 03 Jun 2022 11:20:02 +0200
References: <cover-v4-0.2-00000000000-20220531T173005Z-avarab@gmail.com>
 <cover-v5-0.2-00000000000-20220602T131858Z-avarab@gmail.com>
 <6e98dfe9-5df2-caab-ed3a-81f07b0bb6bc@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6e98dfe9-5df2-caab-ed3a-81f07b0bb6bc@gmail.com>
Message-ID: <220603.86o7zaxfhf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 03 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 02/06/2022 15:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This series fixes a v2.36.0 regression[1]. See [2] for the v4. The
>> reasons for why a regression needs this relatively large change to
>> move forward is discussed in past rounds, e.g. around [3]. CI at
>> https://github.com/avar/git/actions/runs/2428475773
>> Changes since v4, mainly to address comments by Johannes (thanks for
>> the review!):
>>   * First, some things like renaming "ungroup" to something else &
>>     rewriting the tests I didn't do because I thought keeping the
>>     inter/range-diff down in size outweighed re-arranging or changing
>>     the code at this late stage.
>>     In the case of the suggested shorter test in
>>     https://lore.kernel.org/git/nycvar.QRO.7.76.6.2206011827300.349@tvgs=
bejvaqbjf.bet/
>>     the replacement wasn't testing the same thing. I.e. we don't see
>>     what's connected to a TTY if we redirect one of stdout or stderr
>>     anymore, which is important to get right.
>
> I'm a bit confused by this, the proposed test uses this hook script
>
> 	write_script .git/hooks/pre-commit <<-EOF
> 	test -t 1 && echo "stdout is a TTY" >out
> 	test -t 2 && echo "stderr is a TTY" >>out
> 	EOF
>
> if either of stderr or stdout is redirected then the corresponding
> "test -t" should fail and so we will detect that it is not a tty.

Yes, exactly, but the proposed test doesn't test that, in that case both
of them are connected, the test in 2/2 does test that case.

Can that snippet bebe made to work? Sure, but I know the test I have
works, and that proposed replacement didn't even pass chainlint
(i.e. hasn't been run even once in our test suite). So I didn't think
that trying to micro-optimize the test length was worth it in this case.

It's also getting much of that length reduction e.g. by not cleaning up
after itself, which the test in 2/2 does.

