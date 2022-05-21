Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43429C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 11:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355070AbiEULRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355110AbiEULPy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 07:15:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F74414E2EE
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:13:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so19789095ejd.9
        for <git@vger.kernel.org>; Sat, 21 May 2022 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+h/hamCLikayF6lqd+ejDXJifpnr6BB55szraneLt0I=;
        b=EeHwSkWt0/SGc8q5Z7axObR4uHi8KbC+v6+bVMQFLqX2Hhz1qEsEZnY0U2m43xdzWl
         W6CVOG2IeMDrIBvvJ1WUF6uH1acCIPqJfBQ5s5pfj1alXQ6o2rr8OEwFI9w/KwU0rE3v
         XyyV2kM28RvVrQixKzmcQEfuaQRvAuPKWsFAX/XqucI77nd3UqK/wUbTG/oH5q1t2C/1
         Sf611fNFANUKsFxhFGywSpnfzlGU7myAsuZUU5NW+hg+XIEnlYTm4OgRb1Hlz/sTK68T
         qLJUteLSKzLvasfbnIugQwfSTjGnk6fMdF0RGs1Qs/OjPk2s2Ff1xQK6o8vVYQtoUzvK
         WZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+h/hamCLikayF6lqd+ejDXJifpnr6BB55szraneLt0I=;
        b=8Dp5UNCaJBjlmozTP8CfaI35pk6m4XBHEb+fgXEJu4hpOxRqw61IE9pBGUoMXoIxEx
         wOwEIGkU8ZGFqiqK4Zz+XSnMQI/BNwLb7m0FJQhRCaHZDILMFf0CvVjt4Llqi0McgV23
         ZVLRjrpEkFJnYTdy6gZJr/fToQnj/3/zYJHpIvLW55/FxDJ5E6jmVk9COssu73YXCkdo
         gQ0h5dm7H82LZ7a0Z7wyzROCTGh6l3HSzTynvEVT0+lstjr+6b/76+R2tpCgVyVHDkrJ
         2pXqRsU4rarAITfWVReKIFG0i1Dx0s4wWC/6869rcGux3fRzqHXwbU6PsvZVLTegG1qd
         7VTw==
X-Gm-Message-State: AOAM531L0gLgShgLkBCtthk9Egd4xt1hzyWYpxhAt0p0TQ29DEmoDOAD
        C2QayjrnEaU0vcg6nf255uk=
X-Google-Smtp-Source: ABdhPJwwrzQY/ECx9+Pfkp3xU8dCqgeNVl0x1L3ZWD2wF6EUE/JV7xTqJyM/d6KTpSZPpx5/3CdvZg==
X-Received: by 2002:a17:906:5204:b0:6fe:902a:da93 with SMTP id g4-20020a170906520400b006fe902ada93mr13177874ejm.155.1653131581236;
        Sat, 21 May 2022 04:13:01 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 16-20020a17090601d000b006f3ef214db3sm4190009ejj.25.2022.05.21.04.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 04:13:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nsN2a-002dtB-8U;
        Sat, 21 May 2022 13:13:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/4] run-command.h: rename "env_array" to "env"
Date:   Sat, 21 May 2022 13:09:45 +0200
References: <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
 <xmqqilq0jhk2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilq0jhk2.fsf@gitster.g>
Message-ID: <220521.86czg716mb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 20 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Follow-up 32ec72c3e1 (Merge branch 'ab/run-command', 2021-12-15) and
>> rename the "env_array" member to simply "env" in the "struct
>> child_process".
>>
>> Changes since v1:
>>
>>  * Added a commit to remove the coccinelle rule after its application,
>>    as suggested by Junio in
>>    https://lore.kernel.org/git/xmqqzgjdkxon.fsf@gitster.g/
>
> I actually think we do not even have to tentatively add one, only to
> remove it at the end.
>
> Wouldn't a two-patch series whose=20
>
>  - first patch does the real damage to the codebase, with the
>    coccinelle rule as part of the commit explanation in the proposed
>    log message (e.g. "the patch was mechanically prepared with the
>    help with this Coccinelle semantic patch"), and
>
>  - the second patch does the non-mechanical "comments and names"
>
> work better than four patch series?  A single patch that says "the
> code was mechanically updated with this s-patch, with names and
> comments that refer to env_array in the surrounding code manually
> adjusted" would also work well.

I can re-roll it if you insist, but I think it's much more useful to
have rules added to contrib/coccinelle, even if they're subsequently
removed within the same series.

I've ofter paged through "git log -p -- contrib/coccinelle" to get
inspiration from previous rules we used or see what's valid syntax. I
think being able to do that consistently and not having to fish through
log messages as well is more useful.

It also makes it easier for someone who needs to modify their code to
just "git checkout" and run "spatch" on the rule, without copy/pasting
from a log message.

But anyway, whatever you prefer. I see from the latest WC you're
expecting a re-roll, maybe the above will convince you, and if not I can
prepare a v3 with your suggested changes. Thanks.
