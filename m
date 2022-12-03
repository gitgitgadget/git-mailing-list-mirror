Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A4C352A1
	for <git@archiver.kernel.org>; Sat,  3 Dec 2022 13:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiLCNLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Dec 2022 08:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLCNLN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2022 08:11:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF62B636
        for <git@vger.kernel.org>; Sat,  3 Dec 2022 05:11:13 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n20so17580823ejh.0
        for <git@vger.kernel.org>; Sat, 03 Dec 2022 05:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+QKP+UgyI/NtAJVrhQpv+ckzql5/+jmRiccogtMFynk=;
        b=LPloqtvmF0YcdnqY0h1Wa18Hcccfkp2/KT8ZxeQDny6qEJSvgvZ04bkFSbhQO/zQFI
         Rxtz/bBhFiQsu8dAw3VK1/yjbwcRWokczKML6Mao1MOINtgJqFT6qZX+FkK0hHBHdtrv
         L59gVXQ7m2OOa+jXmLzrlJWgYmN6NlXmJhA014xzL7wK2mmHBx31i5M/tVrJfBU7zbDf
         E9S5wCWa53Rbb20SBP1kqXlVbRwDBb0x65sI/RHm6E0QV0QMHTkHS5oc2UMw4z3SAYEv
         wtQJ2P2FQKB3nuUiCw4mlhdqipoMgcB1YQPUQWSVCj7e1RL+EzN9C9t5cXa1wkFvZJTS
         IE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+QKP+UgyI/NtAJVrhQpv+ckzql5/+jmRiccogtMFynk=;
        b=BIeD07RPyXdaRwkmhMXAUbpJ6n1xs/Pcvog5NnVhuiWbLndpB8YybGDlqhZfw49xD8
         uVnhmcaGwSTDbYszyiF8EmWlVXpjtncII5qd/39vyYNtbwZV1ZnEtPMh5bB7gufhCWKV
         bWUYEhu3vH6DoYBbW2Wwwcub9hxjs8JkWy6Vj21wJTzVjD1ZObkUBDpJMCjAPP0zRkXS
         enwFZJwG38LzOQnNuFi5nQBTjU1Xe7rYTs5XDTPVq8OHpic+2lyBZBowW085iT57Av67
         eFvbUefHxPP74ss6BcviJCFTJ3E2K87svrRyy//EIlYQujzM4L5xOUeTC9YgKrvXWIWU
         q98A==
X-Gm-Message-State: ANoB5pmLuS/nMcxdTHkB/itRorserE5WAk+Bi2TYRukrbYeNY39feJ0J
        NWMaqkZMmTmgEYZ5+3cLWIX3saDd9tY=
X-Google-Smtp-Source: AA0mqf7KMy1eEeVrU047FPOCYQb6oB0LKNwb/AeBF9o6gruYsUpjjHMGG3wwweUUk/GyAzEPtdri9Q==
X-Received: by 2002:a17:906:b34c:b0:7c0:a6d8:6a6b with SMTP id cd12-20020a170906b34c00b007c0a6d86a6bmr12398986ejb.194.1670073071161;
        Sat, 03 Dec 2022 05:11:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m16-20020a50ef10000000b0046bb7503d9asm4069829eds.24.2022.12.03.05.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 05:11:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p1SIO-003FMZ-2V;
        Sat, 03 Dec 2022 14:11:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <ericsunshine@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v5 11/15] cmake: support GIT_TEST_OPTS, abstract away
 WIN32 defaults
Date:   Sat, 03 Dec 2022 14:10:54 +0100
References: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>
 <cover-v5-00.15-00000000000-20221202T110947Z-avarab@gmail.com>
 <patch-v5-11.15-a5dd4fa1d00-20221202T110947Z-avarab@gmail.com>
 <CAPig+cTQu6E4-sLac_WEMJ6NMWCVDenOj1iNdfPib_WociXhXQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cTQu6E4-sLac_WEMJ6NMWCVDenOj1iNdfPib_WociXhXQ@mail.gmail.com>
Message-ID: <221203.86h6yceioj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 03 2022, Eric Sunshine wrote:

> On Fri, Dec 2, 2022 at 6:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> +       message(STATUS "Using Windowns-specific default test options: ${=
GIT_TEST_OPTS}")
>
> s/Windowns/Windows/

Thanks, the rest of this is just typos, but maybe this one's a Freudian sli=
p :)
