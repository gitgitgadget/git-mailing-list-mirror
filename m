Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA88C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBBQkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBBQkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:40:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31621716B
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:40:05 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so1763801pjp.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UzVhng8reb/gomPCenQoNjGyXQHeJdKO24Td76WPQlE=;
        b=RA2sKBl7xuyoihKkuHs+rTMtMVSKASM+YYVXNDJyM4SIMxGRRau9KjOP/Gh7yr1Go4
         aWIQrkqS0R0fsvJCSCN1M2s/J7SxIU5WSBPQeGNPGrKy5Ku7QUjCBj4hlFUd6rwEfgHt
         09SkQN70EwwrqG0FBMsaJNYe1l2ZFXF/HGMElCx7xDtzjiZ3Qq4UdF5UtvFRkS1Y+kF1
         I8IEQja4vvJXDNgrlAsWVbFWbihoRUxRLlWoh9rfFNf2w9diCaHqOiIXKZItaR2E4+hB
         nD6aLPrXgEHBB79bcGqirrYIlUadBsEcbWUPC1Tm3/iw4nyu9NCLPvOIlLBRbDIybkLe
         Fx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UzVhng8reb/gomPCenQoNjGyXQHeJdKO24Td76WPQlE=;
        b=scT9XtNCcF4nljEeqfEd2zb5fY77PegfRPnQwKDJot9iNXNi+f5nLCL7oANKjZweRj
         8PFnGAwBm3MVgcABn1UnfiryZGW3OHR1yPqK++CKCxFnGBmnQk8T4yrqh2j4nukVAiMo
         KmDOxIAbVVd6JISJiGF+fcICxpeL1jVPsh0o6dyGEipRo7ZLPoicbOg1wfYlF6v0mxka
         ItaLBglT8IZXK7g1ViphixjkrxSJc3+cbNozOk93VlnIg3flL/yEK1OelPxYasKlTfV6
         /bx5hfbUStUmR4FZOnNN/uc5EaomUDVzasCgGYHPLbH1AtDNEY94Nd4+7MLM+UejhI/F
         4HKA==
X-Gm-Message-State: AO0yUKUel6RC9ZphlVigrRYskATIcaWtuMTFbeoEqeYN6EoJseEMLxzI
        rUlaQHWUh8zUomncDRbHoM0=
X-Google-Smtp-Source: AK7set8Y4pNenU+cH/GM4ydA0jpMqv9dMs6+OMUtAy1Y42Grx8yBVKAobZzoN68c70CZWir7uYxScQ==
X-Received: by 2002:a17:90a:1982:b0:22b:f009:2e6 with SMTP id 2-20020a17090a198200b0022bf00902e6mr7070483pji.18.1675356005161;
        Thu, 02 Feb 2023 08:40:05 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id gg14-20020a17090b0a0e00b00225a8024b8bsm47905pjb.55.2023.02.02.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:40:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
        <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
        <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
Date:   Thu, 02 Feb 2023 08:40:04 -0800
In-Reply-To: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 2 Feb 2023 16:17:09 +0000")
Message-ID: <xmqqwn50uil7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... Reverting the change
> gives the misleading impression that we're making a commitment to
> keeping the output stable. The focus of this thread seems to be the
> problems relating to github which they have already addressed.
>
> I think there is general agreement that it is not practical to promise
> that the compressed output of "git archive" is stable so maybe it is
> better to make that clear now while users can work around it in the
> short term with a config setting rather than waiting until we're faced
> with some security or other issue that forces a change to the output
> which users cannot work around so easily.

I love to see somebody else play the devil's advocate role.  Thanks
for all of the above.

