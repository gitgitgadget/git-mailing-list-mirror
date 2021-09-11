Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6002C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D36761213
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 07:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhIKHV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 03:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhIKHV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 03:21:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326DBC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 00:20:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qq21so3103702ejb.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=NY9WX37LamEAR4312LZBOK26IMvMV+QmyWqgmBtdrgc=;
        b=j6Fb3+OjkqdK+7NFTSCa9VztB24lMJVJNWi723UAKLCIFbKsnAjqYnN8qb6BGNXMPY
         H31ipkBhpgK/aTzRzCAq2qA3StmN6/cMm5g5nANPcD2KgQ1kA6sIv7ldAHkwRfAFjU6T
         QNBdYya6zzyYlenf7F7T2mG1c1pkn40EiUKaN7ufs+Obk6LAsa0CVkk9yKaUan8c8WwJ
         1ztzgM91sxTCgTRnjLsgqliNtNx0Vm8CM00eYZlfUYYE2yy9fDwFqkpOqpgc+EKxVZMz
         IBfAyPo1vro3HhDt9+EsdjvMWlGyLm4VDt/ghruk4YkQwx/AICkHn6hNNoz5bvXYL1Em
         OCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=NY9WX37LamEAR4312LZBOK26IMvMV+QmyWqgmBtdrgc=;
        b=Nfsr4Z1LDU6U9Q1omhHpDNpeV1vVS9N7JqRDl0kAViyjYRFrmEV+tpEZPy4mr+ed+B
         XtcKd1xrD02Gx4pLQbyRF5l4jwEEEU0bV6h+KpUmIoWq8M3aO28Vs+b3eksngWmNla4n
         R1lY2CGiyMNpUpbn7OMhlzaCEs9QkoEKye63JyTA/tUtcMjmfUje67NoJT8u/+ME8vYa
         UR8oMuxti7GAqGKe289VOOGu1XdTzEFWWoSZRlpFMLjZL1VkCdLDo1rbz2iWPg5p1Rtu
         I2MYU8W25BDSr84b3t/v+ZV0IdVCyUVZsNV5z7y9lr4rL0HN3ray+7mPG2hBval/mQMF
         oVKg==
X-Gm-Message-State: AOAM530QsraY8s6Ld5vius3DLaVeDHlViTiZEIwkd9PYvOL8nRSdfNLw
        kJIx9qq/cYhIhd5g8RnEjSg=
X-Google-Smtp-Source: ABdhPJwBW6xHDTQtFcSGC71mkm587N8095QIZrQIfVGLcB8OpL1u+RPwSxdLFryxDDVGNSaXDz2TCw==
X-Received: by 2002:a17:906:c416:: with SMTP id u22mr1580549ejz.543.1631344842736;
        Sat, 11 Sep 2021 00:20:42 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m10sm386764ejx.76.2021.09.11.00.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 00:20:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/6] git.c: add a NEED_UNIX_SOCKETS option for built-ins
Date:   Sat, 11 Sep 2021 09:16:56 +0200
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
 <cover-v2-0.6-00000000000-20210910T153146Z-avarab@gmail.com>
 <patch-v2-2.6-d6c44402715-20210910T153147Z-avarab@gmail.com>
 <xmqqr1dwotmn.fsf@gitster.g> <87mtojaklj.fsf@evledraar.gmail.com>
 <YTwm57pp/cvfR5rg@carlos-mbp.lan>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTwm57pp/cvfR5rg@carlos-mbp.lan>
Message-ID: <87ilz7a88o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Sorry, if this is silly, but why is this not better (at least as a starti=
ng
> point, since it obviously will need more work?
>
> Undefined symbols for architecture x86_64:
>   "_cmd_credential_cache", referenced from:
>       _commands in git.o
>   "_cmd_credential_cache_daemon", referenced from:
>       _commands in git.o

I'm fine with it. I'm just trying to get to the end-goal of fixing the
formatting issue in "-h" output in the simplest way possible.

What you're suggesting would be effectively a revert of various parts of
b5dd96b70ac (make credential helpers builtins, 2020-08-13), which is
behavior I assumed we'd like to retain.

But yes, if changing that behavior is OK then this is simpler.

Anyway, all of this in v2 was in response to feedback on v1 to make the
v1 function in parse_options() easier, see summary at
https://lore.kernel.org/git/cover-0.2-00000000000-20210901T110917Z-avarab@g=
mail.com/

But it does look like Junio would like to keep the only "real" in-tree
user of the current API in builtin/blame.c, so at that point removing
these by any method becomes a moot point, so I think I'l try some
alternate approach based on v1 that doesn't touch these at all again.
