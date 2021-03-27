Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF2C433DB
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 08:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925B0619F9
	for <git@archiver.kernel.org>; Sat, 27 Mar 2021 08:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC0IbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhC0Iat (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 04:30:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86912C0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 01:30:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a7so11882192ejs.3
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 01:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YAdGbpUA5SEBf2zKrv5hV+kt4J3SQiClm+OIRIW66G8=;
        b=vYeqeNOErNvMEo9TI+jvhJhqUdC7i849hqE9szIPKPWaXA6pJ97vRxAEsKzuPHWW1Y
         g3sxRAFKOdasQq6FQVEAGPRVyTBo9d0dZx+4qX4vaN1K+RAz10VHDT1Jpj/Eu2sxTLYd
         +63J+2p5DmfkTTbRV8OodCEjIaIpmG3LubtRRCly9fnOW+n8yJFdPCEyiyVDlUiMyqhh
         tZ30dNmVU+9woqefpMpEMLqMl5wVgzJzRbUOGDEro6IKBG3ey7a5NxM60A/dNnWRn66U
         bE32EMrC+TvPySZOb+GbnmstEn8P6XemGMiVBZJm8uqV/gN8H4nDOIvo7Ej0BnZbLGqA
         kfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=YAdGbpUA5SEBf2zKrv5hV+kt4J3SQiClm+OIRIW66G8=;
        b=phSR1VqWaC3XH3tg0y8LS/ENHhy3BHnFYi0smXqdSkBXzD4Sg3c0qssTlFj+3K0Kgj
         wu4nJbKNkeNx1CiNyms5/4/kS8N03HwZ+L46kMrb12NmLR3bGmj8AJawlU648qytTG9S
         C5NQkkGEs2XGLn/xkqndGKGmUJOptIYXSKlNNxsUXiu9yBv31JkBtY/jG1CtuQcHuEaH
         Scth63d9nhaGTomhrK1AV60GWrlPsEEjR4PdpaecJNaLlBQeEwYFZ8cU97uFNmWzAA2T
         UBTouwMCLaHRsT1aHKnbCZAklLguq8aC8QSEW42UU77w5er05W/9ZHSthT1TlPJRXXTY
         r9zA==
X-Gm-Message-State: AOAM532YbpsssVtBvujhiq+NTO/mENo5xK0t8IApy6CHOBrdNCQHtNDU
        wfgJFcahnwOkB+ndREJyHmpdQgpKofQLmx1ksxOLJ++DQgE0Lg==
X-Google-Smtp-Source: ABdhPJxzRCQLfQaOvZ8fXszW5Av9dE/fIe4246F9ICrF11OVtgp+2l4HW3YKCE4s9jCcw6CySr0jX9N1jDDg64dHBVE=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr19215009ejt.216.1616833847082;
 Sat, 27 Mar 2021 01:30:47 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 27 Mar 2021 09:30:36 +0100
Message-ID: <CAP8UFD3Sv7d+raNdY6fnjnw+8bLh__8B2peojNDbNK0V4RgzFQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 73
To:     git <git@vger.kernel.org>
Cc:     lwn@lwn.net, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
        Yaron Wittenstein <yaron.wittenstein@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Charvi Mendiratta <charvi077@gmail.com>,
        Joey Salazar <jgsal@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 73rd edition of Git Rev News is now published:

  https://git.github.io/rev_news/2021/03/27/edition-73/

Thanks a lot to =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason and Matheus Tavares =
Bernardino
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/484
