Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F96C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EF0611C0
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhJDO5y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhJDO5x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:57:53 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830FC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:56:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id bd28so65747165edb.9
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=J/UOIJ0KsyPJomvMis4lJXLfSweToBi0Z56Ao0IFdyQ=;
        b=KZJbhnjE9k80WOx2Y+ij+itRBPAnOekVhxI15XvNkv1VKsuCdzNCmR1ZJXnnLjpbQw
         prEfNorZ3C0J5DSZD26N59uh7V4N9FMX+4MABbOu7gcLDiTUgSb3toJwZXexDjBMyoWG
         XTgESxGCimuH8X4uT1oxSRPIX8Hvq0edUbNCJgRAzJ4dqm4+fXcwZeU9KpSSQAnyB7ek
         +wNWf9KnZR7XJdMQQOPCXWKmXQ1eYAMGdqo2dLuVHqPiSA8YTUChUPKBgTrzshSHlMvB
         N1DxmPCNF3KKBCRsgS4dDIvcamk37jaN+1BeFzLVn8aFAYHt3p3ks0h9ABq45j6P5GXZ
         wqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=J/UOIJ0KsyPJomvMis4lJXLfSweToBi0Z56Ao0IFdyQ=;
        b=xLV6f3k/9iZXrJbaslvrt/hfYCiWM0IH1w/c0jiDbkRj0Fq8juI0Pfm1kEC8+3gHyQ
         ewy6jxSYe7v6DnLBmEz4RzFNze8ILEuI3uUQwlhpsrclqVO76Cks1+93vy4jdJ8ubz35
         O//7LqiSFplBiUHbmwijPVlu1yFObtEnu3Vu8aLtPAiK1kBpSo7wElSnXN5J2ZeQbY77
         1tkcDbTuQ8cYX2K+CvaArwYUmonhr69YrdpDTTKhE1SSYX9ZVHvyHpbcenOlCT4kGHku
         wgsbYCrBiRCYOt9dIMuNZF+JJakDxUVJf//sH2Vt0TKFqRAcn90Ht2F7Zl8SEp9bQ4to
         osUA==
X-Gm-Message-State: AOAM532+HSH8/VFNe/2/JllYjkR8MI3x3xeHV7RRP8nKX6dGI71johxX
        /nauGobsFk6EdKgjL/kfoTeWy5aaE0tTdg==
X-Google-Smtp-Source: ABdhPJy9+gQkHZe5S3QGAQQ8hOA2H8sInSooJtCLsjxV/CiRkWopg7/Pv1EhpdF8fxQ/cX6Tq83jqw==
X-Received: by 2002:a17:906:8d7:: with SMTP id o23mr18218419eje.193.1633359260689;
        Mon, 04 Oct 2021 07:54:20 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v13sm202293ede.79.2021.10.04.07.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:54:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/10] built-ins: plug memory leaks with
 unpack_trees_options_release()
Date:   Mon, 04 Oct 2021 16:54:08 +0200
References: <cover-00.10-00000000000-20211004T002226Z-avarab@gmail.com>
 <patch-10.10-06ad6baf566-20211004T002226Z-avarab@gmail.com>
 <CABPp-BFr7R_swdxswmoGRF3=uu0s8HgppfrnFEQ+NvS1oh+_og@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CABPp-BFr7R_swdxswmoGRF3=uu0s8HgppfrnFEQ+NvS1oh+_og@mail.gmail.com>
Message-ID: <87pmskn8mc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 04 2021, Elijah Newren wrote:

> On Sun, Oct 3, 2021 at 5:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>> Plug memory leaks in various built-ins that were missing
>> unpack_trees_options_release() calls. In an earlier commit these
>> functions were all made to use the "UNPACK_TREES_OPTIONS_INIT" macro,
>> now let's have the ones that didn't clean up their memory do so.
>
> This commit message doesn't say anything about what was leaking.  You
> should really bring up that it was the dir_clear() you added to
> unpack_trees_options_release() earlier in the series that is important
> here (or at least that's what I presume is the important fix).

*nod*, willdo.

> Looks good to me; thanks for catching and fixing these leaks.

