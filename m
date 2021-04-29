Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394A0C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15576142A
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhD2TYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhD2TIV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 15:08:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90268C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:07:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id o16so77757568ljp.3
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 12:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WVmRUhWsjO8tzjrLR0JAUSFg/ml07rlxxNjGc/HSDU0=;
        b=iHMuRX9EnAPoYe6PiSm4Roumn2P6lJIpZTR6xvszONvxlXfSscTfZbDPVD104W4cvx
         OdunsUkbExEo/Q0Uku5dX+yUjYIVZ4/fwvvzSsByVXiq+rXDd57jCFNFV3F91uEcPVVH
         ldBNHRgjq5HANmclKdN/lQWzQOS8KBll0HtllFruZvMDuaC/9atsyZQWn9ptG1P5YHQ/
         sX+7wd41UvZXGZOfhiuAM/0pNdoXeLCyJodQVCswOUgwLtlQM1Lc7Rx23xFCSjt1577I
         ZGUcYKlbgVk6SzCaauUra+fnHHzvywBMEgTrX0oIjaMg19V0nMU0Hhul48E8KWjx4rG8
         Ek5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WVmRUhWsjO8tzjrLR0JAUSFg/ml07rlxxNjGc/HSDU0=;
        b=Q6KeEI3iqp2tepoCNuzOSInunhLJtDyMBTLp1H7Hd58kU9IIejYhW7mSGaf21Cs99i
         rWHlKrmB+0Ck+Q+hidBom9QDXBXVC0gGEYfP/Y2I4fD7GHAbuAYjBhyyeBQkm7fDdm1Q
         Ud66t0N/stmhvV2qhn/KA0kEi8Zsjp8BhdlnWUMLP72YrHStn7wtQRgyJcxvUezpKTco
         TUsAIIYiloCT/t10/nsDGgMgyfRpvVBEzzNrWsqDBonkQhh1wggCYjZkWVGjtaPa66ZJ
         RIl/x9LcGN5vqq+4+2p1WgE3r3r7gcThjZTyFe71ZXGOa1TpQ1CM1XCXkDzKwmw3jjK+
         l86w==
X-Gm-Message-State: AOAM532UImzGdZ/NAItS5/LQPB+t5vMES/e9CgzBuBRkqoih6byNrKzT
        jJfsnhaSNhb10nSnholSFzudzhDwrB0=
X-Google-Smtp-Source: ABdhPJyf5VetGpe0e4eT6/wKNcAMkolvKA1TrtBr3KPkDDZrsBZX0NwULOtHyhtQp2cQ/gYauEHN8Q==
X-Received: by 2002:a05:651c:105a:: with SMTP id x26mr887967ljm.158.1619723252822;
        Thu, 29 Apr 2021 12:07:32 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id i15sm59704lfg.232.2021.04.29.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:07:32 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
        <87eeet9hhl.fsf@osv.gnss.ru>
        <CAMMLpeQE5zY2KAu7rA=kGBGh5xeNUK8CRMf4FxKd-BoMjZzLJA@mail.gmail.com>
Date:   Thu, 29 Apr 2021 22:07:31 +0300
In-Reply-To: <CAMMLpeQE5zY2KAu7rA=kGBGh5xeNUK8CRMf4FxKd-BoMjZzLJA@mail.gmail.com>
        (Alex Henrie's message of "Thu, 29 Apr 2021 11:24:22 -0600")
Message-ID: <87a6pgaozw.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> On Thu, Apr 29, 2021 at 10:35 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > On Thu, Apr 29, 2021 at 6:38 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> As the final purpose of all this is to have -m as user-friendly short
>> >> option, I'd incline to finally let it imply -p, as --diff-merges=m now
>> >> covers another side of the coin.
>> >>
>> >> What do you think?
>> >
>> > I am 100% in favor of that proposal, and I can work on the code this
>> > weekend.
>>
>> No need to bother. If we agree, I'll send a patch atop of my recent
>> changes that make -m format configurable.
>
> Great, thank you!
>
>> Alternatively, we can add a configuration option, or let -m imply -p
>> only when -m format is explicitly configured by the user.
>
> Since the goal here is simple, easily understandable, and
> user-friendly behavior, I think -m should imply -p all the time, or at
> least imply -p by default. The less I have to explain to new Git
> users, the better.

Yep, but OTOH -m never implied -p before, and it'll take time for the
change get to release and then to reach distributions... So the actual
question here is if anybody cares enough about backward compatibility in
this particular case to complicate transition?

-- Sergey Organov
