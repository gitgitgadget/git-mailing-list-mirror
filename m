Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894BDC433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 10:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6F7610E8
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 10:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhJQKPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 06:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbhJQKPR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 06:15:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51473C061765
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 03:13:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g10so58204661edj.1
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qQrSB7VOPXcwlUmelJ0QgAvVYHcPJHLj1TCYnMolOd0=;
        b=bnIyhJJkPPLEI478ydAxFfBCMKtaFsCUJiOlh3TeIyruCSKVK3WFS0wAk4L2+an2Hs
         SJadxzrSpX9JNh82y34JmRoOeGP3S0iWwElXluP6i1iEZVH8s8BKzHDb+04Z0iWQCwPD
         tPZrfQUGPBF6gHhDdgvRFGjlbcSOkYu2fgWZcU4aqjlFpMM887EM2dHqHr2gotPWBW1w
         zoS9POKgv/q/UnMugW6Ne4PAT9NWxvq/bkOgyBva/WURhu2AzHok2Cku9JycVw04FbAy
         IynT/9fWcnoMzP1w5NRXUBS63WdYg8lIDkzDUFpi/uc5ZKqdVkS5jikXfpK7TIUu4MsY
         edow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qQrSB7VOPXcwlUmelJ0QgAvVYHcPJHLj1TCYnMolOd0=;
        b=qtKHX9MSwG8QLtTLdgK0728jHtHjw6+PtG7CM7kO1Hf75qBvFnCgCenMkRoC99xhPN
         gxKuNlGnlG09PQt4SvsoKAMCuN3rc8TkjNgOYOvhLkk3oW8r4CC00n8xKMyjoF2h6czc
         tr0uJglz0LhUHb1GcMgP+Ej4FH6UOv+Z4EiHC3ibpRluMSA7By2B2xejNxP2ITysE8hQ
         DHzvvhb/ylRmfxw2Rhn+XBnzH51dyvONVoMngdAQI4/NL8vlxf3MfXlT5uP0S5PK4zhZ
         LIe7lZyu5L8MYk2ZaR0L0CK6PupfZ5wY2I8OK4rHV9cKkZfVURLdU8ZcGKkPLb0pY5BC
         NwxQ==
X-Gm-Message-State: AOAM530OZvadhhA7zN79UqP6pWtlynE0zqoZD7E1iiyxOXfKAghKYexZ
        Uyem49goi2KnLj2VETq6FUU=
X-Google-Smtp-Source: ABdhPJyXroO0jRV0Dnr+eIB/YWY+s7jxc9IFlFzleT+Ck5Jx/3q9ebBqtatV/4g0cUnKTlbSOmesGg==
X-Received: by 2002:a50:bf07:: with SMTP id f7mr34292911edk.288.1634465585876;
        Sun, 17 Oct 2021 03:13:05 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t15sm8087288ejx.75.2021.10.17.03.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 03:13:05 -0700 (PDT)
Received: from avar by evledraar with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mc3A9-000ADI-0Z;
        Sun, 17 Oct 2021 12:13:05 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Build failure of 'seen'
Date:   Sun, 17 Oct 2021 12:06:22 +0200
References: <48748e0e-7c18-b7ff-e1c3-ac0733cc7d34@ramsayjones.plus.com>
 <xmqqo87o1mgm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqo87o1mgm.fsf@gitster.g>
Message-ID: <87mtn8c633.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Oct 16 2021, Junio C Hamano wrote:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Hi Junio,
>>
>> Tonight's build of 'seen' failed for me (on Linux and Cygwin):
>
> Yes, I saw the same with the report at
>
> https://lore.kernel.org/git/xmqqh7djba6e.fsf@gitster.g/
>
> the ball is in =C3=86var's court.

You'll probably saw this already, but just for the list's reference &
Ramsay's (b.t.w. thanks for the report, and sorry) I'd already re-rolled
this:
https://lore.kernel.org/git/cover-v2-00.21-00000000000-20211016T093845Z-ava=
rab@gmail.com/; Hopefully that fixes any failures

As an aside is that "uninitialized" found by any tool/compiler? I didn't
trigger it with anything I tried.
