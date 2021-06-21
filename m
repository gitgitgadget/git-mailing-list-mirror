Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB92C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D2A61002
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 09:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUJdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUJdI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 05:33:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3CDC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 02:30:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h2so4461632edt.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WdhYd61vlNMYbdp/5uYl20ijVqyZ8GjLjOMk5Sbl/Bo=;
        b=GyMBmK+8ZeXWTOlHEiPgtl3KGJRJfVvf6V6ZACON4h5LfpThWZs4EWvMhGB/ubPXiH
         r5L6d+XZbYG+pElBgAxoUngCX99jOORpTUGCuJjWQt8qtzERhfBo6ZHghYB3ItHY08Hm
         SOFYcvUBnW+jErhOx3bkQG13lHL1YcVuxHQYEZ8Nqq95QJrVHihWIgu1Jovd/aeD1Y6M
         GG9cnwh53Qa4B234c9cbh9MNBVwMCaVRF2EaWmpyGmN60Vr4qtg7slfs4LKr1kwM4THu
         vmq30KURalmXOg+fV6yHjHWEZdvLAMRItC00aL4KOJkO2+C4UF7fHz7FI6lvAXBN+sbo
         tphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WdhYd61vlNMYbdp/5uYl20ijVqyZ8GjLjOMk5Sbl/Bo=;
        b=robNVluTwzYTRuRAG+PNtbCSzp5IuktlcWKOvYjioVM//slfai9clqCUoyGYuXqdfS
         1XKmKh8VBk+i1h1h5k9xrwAHizEHAnjY6OX8a6FryFrpOrZJ//+lvJ8IIXtQKOrtPhk7
         h67iVGLf0OZoWfJaAV5w1DhY8vfos863esV17MBGzVXYYrqqrNsj8FRNxYF2MdsLsCRU
         lyVeVUCyGEm2s8UMNa/LdFYOqLnIe1J3C53epmTgBzife8PtCKOyqGqDqU3XwBoL/HSV
         qGM8P3AcJUGApCk6F3OIe3WtrxBMkEO69w6DepEYcs6i5PYcC+/DbJNk88sIOWCykTDJ
         uxNg==
X-Gm-Message-State: AOAM530jhNLTeolLFtfZgGGJpKp+l+DczEIaG/uZT8KhQYwCKTTMF2Ll
        a4ufntcv0+az7n5lS5SYzzg=
X-Google-Smtp-Source: ABdhPJy5XrJOzhJigG9FcUmID5gb63n7+cpmHU6HRXwMGiMho4BFvAhLyOT3PHH96zub68We/csHAQ==
X-Received: by 2002:a05:6402:1345:: with SMTP id y5mr1557067edw.206.1624267851848;
        Mon, 21 Jun 2021 02:30:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l26sm10601377edt.40.2021.06.21.02.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 02:30:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3] t6020: fix incompatible parameter expansion
Date:   Mon, 21 Jun 2021 10:41:36 +0200
References: <CANYiYbHA+obZPPNw3Oc0h5BbtdVyqpxOK-u3dxDB-sQbdcY0yQ@mail.gmail.com>
 <20210617031411.80684-1-zhiyou.jx@alibaba-inc.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210617031411.80684-1-zhiyou.jx@alibaba-inc.com>
Message-ID: <87v96736ph.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 17 2021, Jiang Xin wrote:

> =C3=86var reported that the function `make_user_friendly_and_stable_outpu=
t()`
> failed on a i386 box (gcc45) in the gcc farm boxes with error:
>
>     sed: couldn't re-allocate memory
>
> It turns out that older versions of bash (4.3) or dash (0.5.7) cannot
> evaluate expression like `${A%${A#???????}}` used to get the leading 7
> characters of variable A.
>
> Replace the incompatible parameter expansion so that t6020 works on
> older version of bash or dash.
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---

For what it's worth I've also tested this v3 on gcc45, it works too.
