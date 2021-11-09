Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FAFC433FE
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E0061038
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 13:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhKINlw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 08:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbhKINlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 08:41:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65D9C061766
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 05:39:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so76151421edz.2
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 05:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=pnJT0MKfKZ60kG0veqIfAfLD12LR+E/EKeW+Mzdm03g=;
        b=S2es/qp2SdeoBlGb3z3OlEsstn+KvQhr/iMvBx6mm2PGmaq8D+PTcelOfVPNRd+BS7
         GrzIDacj+XPz84XB2RkAgOrlqywyoYILl7BrHBGmxx/CicB+nVxJ4Lm3E+bh7Uz6+iJU
         tVZeaaJrwx5g3bWk1PK4g5Z5Jjt8AvHyoDPZlcEoUMHR+UcUvUQE9MwHW20GXHeUuFvD
         M8oUdsBZsgMDWJ6iOWe42PlUHa33fuPLnvDVZMlllcGvWN8uC5FZG8XFqW5FI6X4WVuj
         y6EifMM087y5qRWcs+ly4dtUaiTATnu2g68OrPAm+tPCmr/jn9/r/XKsXDK2EqyadaTy
         78MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=pnJT0MKfKZ60kG0veqIfAfLD12LR+E/EKeW+Mzdm03g=;
        b=TsUDI4zYEgpuWu4BIqfGWCUcGwlb13lExBVbspdP1xytuiO2zIIn+hFrXZABPgbdXd
         YIqgMde62KQ/bYvTi03VFXPGfdVp+zWHLJDngsGqck6kYigNvwGlYpa7D7Us/iaWfHKg
         rQc4ZjDXdIEXwp4daZ7vEhVqe8T+3EpzjX/fkG7goXV8oNfc8Q4rLXsjrH2GWZnR4NOc
         9j3Gnr/hn4svLqkz5VL5vXzMqw/uibTQMEIQckwmAZJFzQBjrgCyiq14X87JrjxXx+Jc
         lA6TSN9ewed7mSJxtHIRvQHGZs7qLY1snsN1AIRKbuSHFnRbbN5SKhiBnVm3RXKLRgll
         pRuQ==
X-Gm-Message-State: AOAM531a3GEAsCoMtztXWULxnAWkU6JxuWZ+ux3ypRj8jzbwyR8tkSuh
        Lu0tmlVBufCMv5SLZjUGcrY=
X-Google-Smtp-Source: ABdhPJyqGOSQvGHFHo7oi1er6EhdXyG66vZ4frPSB8SK7XjnSPdnI/4QX+2k3uHGjoL3sTEHokpS8A==
X-Received: by 2002:a17:907:8692:: with SMTP id qa18mr10144285ejc.7.1636465144262;
        Tue, 09 Nov 2021 05:39:04 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hb10sm9682898ejc.9.2021.11.09.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 05:39:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkRL5-0006CW-88;
        Tue, 09 Nov 2021 14:39:03 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] ci: disallow directional formatting
Date:   Tue, 09 Nov 2021 14:34:12 +0100
References: <pull.1071.v2.git.1635942236065.gitgitgadget@gmail.com>
 <pull.1071.v3.git.1636031609982.gitgitgadget@gmail.com>
 <211104.86ee7whvoz.gmgdl@evledraar.gmail.com> <xmqqpmrf3kjz.fsf@gitster.g>
 <211108.86cznafpke.gmgdl@evledraar.gmail.com> <xmqqo86utnpi.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqo86utnpi.fsf@gitster.g>
Message-ID: <211109.86bl2tjvns.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> So you are comparing
>>>
>>>  * requiring bash and C.UTF-8 locale to be available
>>>
>>> vs
>>>
>>>  * requiring git built with PCRE
>>>
>>> assuming that "Dscho says doesn't work with PCRE and you say it
>>> works with PCRE" is resolved?  They seem roughly the same
>>> difficulty to me.
>>
>> We can hard depend on a git built with PCRE, since the point of this
>> thing is to run in GitHub CI, Ubuntu builds git with PCRE, and that's
>> unlikely to ever change.
>
> Yes, so is the availability of bash and C.UTF-8 for the same reason:
> we are talking about controlled environment.  That is what I meant
> by "roughly the same difficulty to me".
>
> FWIW, I am OK with either approach, as I find the patch in question
> is just as readable as any rewrite that would use "grep -P", so...

To each his own I guess :) I do find the simple regex of:

    '[\N{U+202a}-\N{U+202e}\N{U+2066}-\N{U+2069}]'

Much easier to understand than something using printf, shell
interpolation, and needing to switch around LC_CTYPE to two different
values twice on one line.

But anyway, that's a matter of taste.

What isn't is the issue I noted at the bottom of [1], i.e. if we're
relying on '(attr:binary)' we should probably start with an assertion
that our idea of "binary" matches reality, or perhaps go back to the -I
heuristic.

Because now we've got at least one binary non-attribute-marked file, and
if files like that ever get updated they might start matching this
pattern. Maybe not a big deal, but someone updating those might
confusingly trip over this otherwise...

1. https://lore.kernel.org/git/211103.86zgqlhzvz.gmgdl@evledraar.gmail.com/
