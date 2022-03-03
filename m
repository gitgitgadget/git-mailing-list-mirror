Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D9C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 10:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiCCKND (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiCCKNC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 05:13:02 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FAF1768C0
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 02:12:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qa43so9453518ejc.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=u25e7tevOyof9hTyRePsORsbvVdJirp7PedqPNtqfL8=;
        b=MhnmQqsENraCjpxsf1798Bc0UEboZf5K3CVvBHcQxd/kYTuSLjlq8hwVRrBK1tUO0S
         QuNofTKRKQSiBf+IB3nl3RkBX4sIeYsn/dIhz4wNosm8f54pt/6jFSxYahXI2ZrfCepX
         q7cgKaQuVmBFh6eWy3wU6XEiL2HX0nf65SqAutRRvwbJnNdgWZZMuyByQ0scNiERE2DT
         vvZYImY43hibW/CH1QVH95PJ/peOCa+sZbM6g2Sk2rBHuZeTyJGUZA8P/Cee0VG9woxz
         mscMm+rAGK3i1tVwrrnrnMOSSp6H1u0VcebUad6HOlLDLevU018pEpAc1iquJpaWm9R2
         v/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=u25e7tevOyof9hTyRePsORsbvVdJirp7PedqPNtqfL8=;
        b=UEcvh1caqLCJiN6FCulggd68EhkdHghEeJGqTuRkL+c2mHpXzoSW4BoJBmju9H+6QY
         FSR3TGJHO3EU5nKOrmegBl6FHLk9SV/WKXNT/dI3BIIT/sYRQ8ywjRNLNmaumrn6JeXe
         LewBajGIJEkDUDR/GHBxGP/lr0qNF4URQU4TyWmCt0M5kQHjNlLumC8JHM8MsQv36FzH
         l9Fr21SXMBjImrptsz5P04eQeNx7Ge/S0aAXnMf4hdxNWuBXZSKW+4edXMfcidk/mY4h
         mZrqcz7oxJAS7XSR97ZaIG83rzkH1M5dX0pD5WRafYKKvra+zitcEsn6aWhM5A/CVeYZ
         A+eA==
X-Gm-Message-State: AOAM530hE2v6VmEg3jDihR7RiowsQvogVbskO4IYmPXJV5IBNG5vLz04
        9sYQ7rpWnBKSypjaLCcxv/Mqp/NAInCGmg==
X-Google-Smtp-Source: ABdhPJzdq6L3YgNHzQNPjCTSO4rVGJ2E3aoVN32EgKfxmnpbRpB/DbBgSjJufGjtX+sqbgTsTozGiA==
X-Received: by 2002:a17:907:60cf:b0:6da:95de:3920 with SMTP id hv15-20020a17090760cf00b006da95de3920mr1023479ejc.95.1646302335473;
        Thu, 03 Mar 2022 02:12:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c487000000b00413a99bf3a3sm677648edq.56.2022.03.03.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:12:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPiRR-000PO4-Jx;
        Thu, 03 Mar 2022 11:12:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 11/15] rev-list tests: don't hide abort() in
 "test_expect_failure"
Date:   Thu, 03 Mar 2022 11:10:11 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <patch-11.15-26c838f0560-20220302T171755Z-avarab@gmail.com>
 <xmqqa6e8gd24.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqa6e8gd24.fsf@gitster.g>
Message-ID: <220303.86k0db5oqq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change a couple of uses of "test_expect_failure" to use a
>> "test_expect_success" to positively assert the current behavior, and
>> replace the intent of "test_expect_failure" with a "TODO" comment int
>> the description.
>>
>> As noted in [1] the "test_expect_failure" feature is overly eager to
>
> And noted in [2], it is not a good idea to abuse "test_expect_success"
> for this purpose, either, though.
>
> [2] https://lore.kernel.org/git/xmqq4k9kj15p.fsf@gitster.g/

As noted I do have a "test_todo" (or "test_expect_todo") replacement for
"test_expect_failure" which I think I think will address your concern
there.

But do you mind if this is left like this for now? Due to the semantics
of "test_expect_failure" we can't use it in conjunction with
"test_must_fail" currently and not hide segfaults or abort().

So having it marked as "ok ... # TODO" v.s. "not ok ... # TODO" isn't
ideal, but certainly better than silently hiding abort() and segfaults.

