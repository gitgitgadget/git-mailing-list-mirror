Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05D4C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85286206E5
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 03:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgLODXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 22:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgLODXU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 22:23:20 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0986C061793
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:22:40 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id d8so18029479otq.6
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 19:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AJ1JZ5G6FdkLKsVmh4Id2OQfFQ3nlZ2j2aBovS+WVuI=;
        b=snM13diXFxswTvv8K0dvH1jJPQSdtRNDrkHJ8PsDCilJBreMBI2WsxCPuMkItN3OCm
         gipuFNE3vHYH799ixfiA7uveiTQ6zvzA64fBSlvC8CqrlbU1V7by88JWU7A6Hi74bKOX
         leZtoQc4nqUXk4Uq55NfEbWweOgZCiedPVPD+PTtwp8ResMmGKcP4DW/k2UTPzcBODVM
         EBIYOA3AKQ6e4OzA783SUxzUFA9JfKu28od0IrNJh9umrPMfodtuoREZa4Pw0yHQKV/l
         XreCXY2BKVenl8KDRkmzu6Axnq8BZV5A++qK5ctDF2NqnA6W3opyxG3DMQ4hXJxa1I6O
         ZoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AJ1JZ5G6FdkLKsVmh4Id2OQfFQ3nlZ2j2aBovS+WVuI=;
        b=WOO69X0/vgWyGGllalOkBsLfC7X+VMWd6+FdVeBnqlapy/A79G3yFg++z63q1w7xYV
         WbbuFbXSX0TH3r69vN4qAwsR8sragtJ1WllYRVQCqJ5yTrTA0FDJgJKdL641V/TEDziY
         /J0I7n0y3JXohp0BsFrNn342XHpeSn3cTxlC40dicxs+wsEqrkeuOmLj0YuE2NBO9q5b
         kW5JfhJAy8Ww0NupJ+vZnbl2Z/VMoMkvuLvCLffjAe54lCirfGvOn/s4eUWtwLKp3gs3
         vuQL6ivsLfS6GkMjiMea20eX1+35A1uufpFs5lGLvDTc/LiAGnx8RxEChyS1Dnh54+2c
         D/6g==
X-Gm-Message-State: AOAM532mj5JSRovSv70I0lvGLDZcHpaTlts0ywlvpGaEjeynfsDuaLLt
        47ZqSIxs8tteDTJr3u0TAGw=
X-Google-Smtp-Source: ABdhPJwFxcjopw9Mymx1JxmAx9V1k3eqXMrc57fcTEkZ/hnew/DvYREYjizqOQlf/zEzrQI86HvH5Q==
X-Received: by 2002:a9d:7f81:: with SMTP id t1mr22207766otp.166.1608002560204;
        Mon, 14 Dec 2020 19:22:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g200sm4702242oib.19.2020.12.14.19.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 19:22:39 -0800 (PST)
Date:   Mon, 14 Dec 2020 21:22:38 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>
Message-ID: <5fd82bfe20d9c_d7c48208da@natae.notmuch>
In-Reply-To: <878s9zx2ul.fsf@evledraar.gmail.com>
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <20201211210508.2337494-1-jonathantanmy@google.com>
 <87blewwoil.fsf@evledraar.gmail.com>
 <xmqqim94e4et.fsf@gitster.c.googlers.com>
 <878s9zx2ul.fsf@evledraar.gmail.com>
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> To borrow from Felipe Contreras's reply in the side-thread "I expect th=
e
> branch name to be chosen by the person who created that repository".
> =

> I suppose this comes down to a mental model of what it means to have
> "created a repository". When I click "create repo" on those popular
> hosting sites (e.g. github & gitlab) and clone it I was expecting it to=

> just be a shorthand init + a URL in my config (and refspecs...).

Indeed. But then it would be *them* taking away agency from the user (by
not allowing the user to choose the name of the branch), not us.

In Spanish we have a saying: "don't give extra change", which is similar =
to
the lawyery advice: "don't volunteer [information]".

Let's not volunteer user complaints. Let GitHub take some of those.

-- =

Felipe Contreras=
