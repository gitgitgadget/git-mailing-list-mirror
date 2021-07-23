Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E7C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25E2D60E97
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhGWSwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhGWSwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 14:52:09 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B0C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:32:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id z6-20020a9d24860000b02904d14e47202cso3119447ota.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=UiWkiQ2f66S+xKsKrjlUDJZDCY18p6p+m639R0jfUAQ=;
        b=hZ8cAuAU6Zb/xeYtBswWK76dAAAFpH08q++fHHqFX+9cvkLKSoPbD9nMAXYsD8XQRB
         1Z7OkVfLTBYsPNjTUb/C1mB7B7V0DnLoeMCSgdKT6kdwKctZNcgXWA+E9UvbLS+RZ8h1
         VdAKiiXWEoL+KXwnMGmnYHKV9H3IeXq8pG55ZSaL7BfoRkUBbMNrnOC44LqT1CSKuKLZ
         2TelW9EX/ur+0bosslvz0SN2aZjnkjzuCQL1hiTFVKY/WigVxCM22l/nAyA42xV1VERd
         Gg2ncNLxuiqwmQrG+OY87NUiWDq9+j4eQEGuzV1pjbMK+I5zk6EVYGoBZTaKvVQwQsG8
         +PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=UiWkiQ2f66S+xKsKrjlUDJZDCY18p6p+m639R0jfUAQ=;
        b=TzyVusbFYk7GjL3LlmVSU1mYi4SKR3DGuXx7OkxT43PTb6YsW0FwFfosuNQWanAN/A
         2incC1op+MSXWI5YUm1lzsyxnPe/YJLqo+CuvfEtJSnvamIjC7zVIMPxQWEgImmteNtf
         KtzbICkcRFTH0U0z1oGaCImRXM38fsgsRisW26QK13y/+uL/uo0ZUVKG/R4BxA2Xghdw
         gZRZZ8tGjAEyl7IVoTSS1TywDQa/Igq91GPqZL4SynZqVOPW60Vp3HP3UP/7doXCsg/9
         ealyJM1ewSJfkK1zrLT0klGkw1yxWg2Y8Z113StPLI30+qI1ggSfmvC50HlSkikRLBux
         WURQ==
X-Gm-Message-State: AOAM5336mFGjwgSMQZjAbuucwIVzRcUVKxiohukjqc3R5xUsMB3gbu/G
        Wzq/OBEUWW7q84l+mohre1w=
X-Google-Smtp-Source: ABdhPJxprz+piCcOaOkDr2O2Z1SND0hVxKg12nDZQbO/WELPa2fVOpLxgzfxCogXR9aKMamGqg098Q==
X-Received: by 2002:a9d:7f98:: with SMTP id t24mr4332742otp.366.1627068762467;
        Fri, 23 Jul 2021 12:32:42 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id r1sm884753ooc.16.2021.07.23.12.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 12:32:42 -0700 (PDT)
Date:   Fri, 23 Jul 2021 14:32:40 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <60fb1958b141b_1073e2089e@natae.notmuch>
In-Reply-To: <YPqeX/edrMfYbURa@coredump.intra.peff.net>
References: <cover-0.5-0000000000-20210629T110837Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com>
 <YPqeX/edrMfYbURa@coredump.intra.peff.net>
Subject: Re: [PATCH v3 0/5] Makefile: "make tags" fixes & cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Jul 22, 2021 at 01:23:01AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > The big win here is that none of the tags targets depend on "FORCE"
> > anymore, so we'll only re-generate them if our sources change.
> > =

> > For v2, see
> > https://lore.kernel.org/git/cover-0.5-0000000000-20210629T110837Z-ava=
rab@gmail.com/
> > =

> > This fixes the series per feedback from Jeff King and Ramsay Jones,
> > i.e:
> > =

> >  * In v2 the 3/5 broke things in a way that 4/5 fixed, that's now
> >    re-arranged and fixed.
> =

> Thanks. Aside from some cscope appending arcana I found, these look goo=
d
> to me. I have no opinion on "cscope*" versus "cscope.out", except that
> it is not worth anybody's time to argue about. :)

I agree with that as well.

-- =

Felipe Contreras=
