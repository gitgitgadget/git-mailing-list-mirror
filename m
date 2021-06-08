Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A0FC4743E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D3ED61008
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 11:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhFHLT0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 07:19:26 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36603 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFHLTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 07:19:25 -0400
Received: by mail-ed1-f41.google.com with SMTP id w21so23967718edv.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=K1Eqp1O6yTBDD0dV/ToP2FOEX0sa/qmV1GY6LMr4IbY=;
        b=bIdt9SMBbhAMsvSiXrnb8+Ss2BY268yQvYoEnSwPniL+TRiWgqdDSzI2Q7Pjhdug5f
         C9l5chDcWu/5mgGtkFjNa0TdTAxsk6vyezC6bz9FGlWRqiM6Xf42XZOS2yXdTSE/C/We
         j8AhAUmvZpXcPV1b0iEykxcJCHg4b4rjn87hpRxqr1Ql+uQFU2CCudWWagN5XiKTP+Hy
         hzz18iWAUK9HCXXGTlJOyfYqMG7l0g/Eil9EEmuCrrtUwmVZ7N0eeHM/ddAi1PjfXJ/N
         A7LKiw3B+YMLcp8kpUM0jEhOBewtNwDBUp2ayHN3hsykitYH3pAInGREOLeIpDOV9gkk
         URpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=K1Eqp1O6yTBDD0dV/ToP2FOEX0sa/qmV1GY6LMr4IbY=;
        b=lUIi8YQvfj1ClQYGTjgXYUiAeRxw2zwQjU2pV39Dwa/eL6HWpbyoz6xp4jkJhJPYSC
         Tjonf8/ytEMeFDMHp0dBVp/4C8h9xpR0nMfecBar6TprAfgzSjMyYhTWawYQvUmLQxC2
         IVERq4h5RemFD43dPulZfOIedZWsRJzEjriR/QoN5T4t4Daq4qFelOxjvlqCnJu0qqxs
         KzWCF22zir7FL5cxPOQbPkDi0iLpO0oT8kTL01ssHF+1gtQYoIt9oVWwQz+Fu//JWHis
         B24lKbb7C3eDmYBsQpiwOQWglFI/7YHXAqJpE1sBpxahQ+ZQ8Y02A4rxTUVsxuKbvFiy
         BL3A==
X-Gm-Message-State: AOAM533m//AvIz8iycZQa1R0j8coiWAK3xGpjmhwnJ/QNhJ4cgPy2sYW
        ZXuCm07JH2AjLj1SbaShLPo=
X-Google-Smtp-Source: ABdhPJypPq1+yY4Alyz6VgSqSs6OmO8k9eihDpdBmMWWQkv9yAhgcKop4hmrQovkdhubpMAjmQLdhQ==
X-Received: by 2002:a05:6402:14d8:: with SMTP id f24mr15965957edx.79.1623150976072;
        Tue, 08 Jun 2021 04:16:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id f18sm7657134ejz.119.2021.06.08.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 04:16:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/4] test-tool: split up "read-cache" tool
Date:   Tue, 08 Jun 2021 13:14:36 +0200
References: <cover-0.4-0000000000-20210607T115454Z-avarab@gmail.com>
 <xmqqr1hdthla.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqr1hdthla.fsf@gitster.g>
Message-ID: <87tum838u8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> When the sparse index topic was being discussed I suggested that the
>> t/helper/read-cache.c tool was getting to the point of doing too many
>> things and should be split up.
>>
>> Since that series has landed on master here's that suggestion again in
>> the form of patches on top of master. The 4/4 patch is a "while I was
>> at it" addition of an extra perf test for index refreshing.
>>
>> 1. https://lore.kernel.org/git/20210317132814.30175-6-avarab@gmail.com/
>>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   test-tool: split up test-tool read-cache
>>   test-tools: migrate read-cache-perf to parse_options()
>>   test-tools: migrate read-cache-again to parse_options()
>>   read-cache perf: add a perf test for refresh_index()
>
> Is the contrast between tool and tools deliberate?

Yes, I figured "test-tool:" describes the main entry point of the
"test-tool somecmd", so if I split up "somecmd" into "othercmd" that's a
"test-tool" change.

But "test-tools:" when I'm modifying particular tools, I can change 2/4
and 3/4 it to "test-tool read-cache-perf:" and "test-tool
read-cache-again" (or another thing you suggest) if you think this
warrants a re-roll.

>>  Makefile                         |  2 ++
>>  t/helper/test-read-cache-again.c | 47 +++++++++++++++++++++++++++
>>  t/helper/test-read-cache-perf.c  | 47 +++++++++++++++++++++++++++
>>  t/helper/test-read-cache.c       | 56 +++++++++++++-------------------
>>  t/helper/test-tool.c             |  2 ++
>>  t/helper/test-tool.h             |  2 ++
>>  t/perf/p0002-read-cache.sh       |  7 +++-
>>  t/t7519-status-fsmonitor.sh      |  2 +-
>>  8 files changed, 130 insertions(+), 35 deletions(-)
>>  create mode 100644 t/helper/test-read-cache-again.c
>>  create mode 100644 t/helper/test-read-cache-perf.c

