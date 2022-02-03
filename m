Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BCC433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbiBCTPy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344163AbiBCTPx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:15:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F8EC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:15:53 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k17so3059369plk.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zkd5ddIkn2myZwvhGRPqQ7tHRak0kt0pw/Id2at13yU=;
        b=no2DcB4O98pUQsm6Z0lJUVhq9BlFEoefJnp+6C1hM9rcczHet/kaTLvkTQsg3H39th
         F8peIX3B2Hv3xg6ld3HVr6K4poKzEvUKYuBZMC9+WvYnhF11nuo+pURrNr7mot4wwakJ
         vcLMbrHthxywmI2OFwCf2qNx7nZN43GIi8/xS4HdHNBk0Ypxro1joTW792t4g16eQp63
         yb7h2FkHWVFpVIMdbgA3g+zhlCVXt61R/ZdrCZipKbh6dHc1KCFnlmORcxExesScd8PT
         7WeBisTl7DokTBIZPIHtqP5ItHtIF0YsXmRTkzXoZwB1hvvRyxhvorfeoMe5M+YASOKQ
         okhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zkd5ddIkn2myZwvhGRPqQ7tHRak0kt0pw/Id2at13yU=;
        b=2+lZHfW+qT9aeodKunok3W9Nhvtody+9g+h8LvjHgmAxUAZky9QHZbPLKQV6zjLAHm
         /+iZCCdwDKYMrPbtLhsJUU7//Sm0m3SfPU70ABPWLupuCZ6A8w7J/ilG3C4qgGWoHF1b
         4hX+yyFJkrb6RF7z4QOYNqyCuWJv+xh3JBSNK/7XnbOVo/nTt2dpo2xTOcR88PXLha73
         5504U5uCk8/GOU6/Sk/B/ptE2p6l7WYseYOBakGWHCUMUQR8Lz4HK1gCeX7N51UMmGnF
         OYIvIsy5ZBzYhEnDxsqRJhAH0yPxVkTc/zD0A1FBOFresctWSaKbQSBrme/cEO37jg4K
         W0YQ==
X-Gm-Message-State: AOAM531JXNVet9wqxh+QVTbxtxKOiBrAhE+n6Gt7wiGvEN4S39nhzz2R
        CV+qP0KUodMoY7+Iz9j5rzc=
X-Google-Smtp-Source: ABdhPJzrGm0vV5cOfhnFWMDqWbk26X0HaKlmPK3n3trpwSTzFQqEeakfnY63aUrJqPyZN7fwB/5BLg==
X-Received: by 2002:a17:902:ab8e:: with SMTP id f14mr37235458plr.103.1643915752548;
        Thu, 03 Feb 2022 11:15:52 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id y21sm762274pfr.136.2022.02.03.11.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:15:52 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
        <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
        <220201.86ilty9vq2.gmgdl@evledraar.gmail.com>
        <xmqq8ruub35i.fsf@gitster.g>
        <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
        <220203.8635kz6d2o.gmgdl@evledraar.gmail.com>
        <xmqqo83nvm8w.fsf@gitster.g>
        <CAFQ2z_Mmfp4wrHNo92ke7i7UF2bDL9v4oddRC4UKN0R9h2C-6Q@mail.gmail.com>
Date:   Thu, 03 Feb 2022 11:15:51 -0800
In-Reply-To: <CAFQ2z_Mmfp4wrHNo92ke7i7UF2bDL9v4oddRC4UKN0R9h2C-6Q@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 3 Feb 2022 19:33:02 +0100")
Message-ID: <xmqqtudfu5g8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Thu, Feb 3, 2022 at 7:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Yes, enums or not, what I was also pointing out in
>> > https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com/
>> > is that changing just one logical set of flags at a time would make this
>> > much easier to review.
>>
>> Another thing to consider is how to make this play better with other
>> topics in flight.  Basing a huge single patch on top of 'seen' is a
>> way to ensure that the patch will never be useful.  There won't be a
>> good time when such a topic can graduate.  The topic will also have
>> a hard time keeping up with what new topics add while waiting for
>> what happen to be in 'seen' today (some of which may even go away
>> without graduating) all graduate.
>>
>> Limiting the scope to small and more stable subset of flags that are
>> in 'master' and does not conflict (e.g. no new bit defined to the
>> set of flags, no existing bit gets removed, no new callers that use
>> the bitset introduced) with other topics would incrementally improve
>> the code base, and makes progress in the sense that it reduces the
>> remaining work.
>
> OK. But do we agree we want to use enums? Me and AEvar are in favor,
> anyone against?

No strong preference either way from me.
