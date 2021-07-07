Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C51AC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E5E461CB2
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGGCRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhGGCRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:17:24 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED68C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:14:44 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so789977otp.5
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=VuGPqiK3AInkKUygdfkDHKkEQGYJADWYHdtuYnNNPCs=;
        b=XeLs3PHshAkKDM/wbYMEl5r14osyHKyiu8QENtXhq67jD2woukTyGy/6dpvVyhsGUd
         kkVuQBWGV8TguqsZTTRzXt5o4vcbdxI5bUnk/VAetNoHB894aVmuU3WGcB1uF46VMcaS
         pjDMqisZmpEm9nt7ONWs5HpFm567O/tDBhuWk3q8D/W+Lg6tBhD0ghM+CLfuoCx64rip
         BjR9h1CfaEfiVvvePqY5F0mmeISWE8UENssYYC4keHN1lMcpIzd3UT5E+FuvK6glDrRj
         HVFyNl6NQdEbxRngd5hTsJkKsmm9Uikgs56BUjkgR7bMCpgce4Qg0Oumc4vG8VkipQld
         7kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=VuGPqiK3AInkKUygdfkDHKkEQGYJADWYHdtuYnNNPCs=;
        b=W21la6qgEB88oq185aEPCZHZg0Y9X4FEoxCLUt7W5+4yw+K1aeB5E8Yhj98X//E25n
         bvkasHsLFypDYuDn8e0hXpGgWxNdolePgWXWFVY87BHqc8KUPD+tHhFLBMHq1hgd7Z2M
         O4Or1WZSh2jAxJwKXZEA4asILtmdGsEDwq0QHqZ8uG5KaTDMGxIHLFOAR6gWSn01jmbk
         QDxTaUz2/6UEFM47SlwS+SekB6hcgVSttLSzfkJh+QQIeUQ/ktRA1iGGUbWdvlVulBUm
         M+XdEo5cJWKArZy9kkVDDTXgHBa+fcTAeE3AQWmqYqPy1gpFFGzkyK3Nmw3lQH1XzxzS
         9O7A==
X-Gm-Message-State: AOAM530n5RabxhK9+3W8s36k82Vtg4/Pnzw3TfjSKE+oukInLjf6HScL
        SoykZXOukR6U/wY1BvDskfg=
X-Google-Smtp-Source: ABdhPJxpdcUPhU+T1MlabDdM6mrrNjleuK1ABETQzpxnhNufJxjGypf7J/L39UaEsLKW6lRmdGL7lg==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr12565048otl.84.1625624083727;
        Tue, 06 Jul 2021 19:14:43 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 186sm3231523ooe.28.2021.07.06.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:14:43 -0700 (PDT)
Date:   Tue, 06 Jul 2021 21:14:26 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        David Turner <David.Turner@twosigma.com>
Message-ID: <60e50e02dc5a6_2fc0f520811@natae.notmuch>
In-Reply-To: <nycvar.QRO.7.76.6.2107061508510.8230@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <87fswyc4dz.fsf@evledraar.gmail.com>
 <e1442a04-7c68-0a7a-6e95-304854adff39@jeffhostetler.com>
 <87czs1d6uy.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107052259340.8230@tvgsbejvaqbjf.bet>
 <874kd874qv.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2107061508510.8230@tvgsbejvaqbjf.bet>
Subject: Re: [PATCH v3 00/34] Builtin FSMonitor Feature
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin wrote:
> On Tue, 6 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> > I think we just disagree. I wouldn't call my opinion "unhelpful" any
> > more than yours.
> =

> You still misunderstand. This is not about any "opinion" of yours, it i=
s
> about your delay tactics to make it deliberately difficult to finish th=
is
> patch series,

The whole job of a reviewer is to *delay* the inclusion of the patch
series being reviewed until it has passed his/her personal standards.

=C3=86var is just doing his job (metaphorically).

> by raising the bar beyond what is reasonable for a single patch
> series.

It is not up to you to determine what is reasonable for a patch series,
and given that you have a vested interest you are also not an objective
observer.

I have hundreds of patches pending review, and I would love for anyone
to try find issues with them, even if I ultimately disagreed with their
assessment.

The Git project doesn't owe your patches any preferential treatment.
The review process will take as long as the review process takes. You
can't put deadlines on open source projects.

-- =

Felipe Contreras=
