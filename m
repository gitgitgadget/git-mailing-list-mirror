Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13337C48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2BC2613B9
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 20:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhFPULW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFPULV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 16:11:21 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566DC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:09:14 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id d19so3813579oic.7
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=DnGDaE+WU6VUDd/rGdYpg4eEwc1vKNYg23aZwj7p+9g=;
        b=XXBZ8EQzheLpZC4PFn8JuCk2tkhnbKZUthGkKdl+7Hf6XBIQFa2uqNJ6vzTpYXzOVb
         s5I5/LISJmWUTo5uH3cuDMdCwFWjb2xmVYomcDdAv0pVOwSsQxEw8h56CnutujCnBn5F
         W8z/PoUUVHyS9VK2mhGFRwwcYlpsB1og71dmB88K2tw9LKfbl5X5ZB6CNGp/Lrjj+5yq
         QoDM9juXJ8Yy89JD6Vbhu/N2c/F8CmBi/UgZ4JjdGjzDAnCDdeANvmJ1Vu/WpyLZaEa1
         R2WtQ1c5bFPr1ohOokZ7G2r/hLMTLXOFWM5bt+2XakZbmAfZGP5AQ4mdLN9BRsczyAWo
         ShfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=DnGDaE+WU6VUDd/rGdYpg4eEwc1vKNYg23aZwj7p+9g=;
        b=RzqgkqZk8BwL13VpTKdlxpOpsfGOyZUWR0ukxWQqFMhKWg2CH1eyl8orLmDBLOHl/K
         pwhTJh3r3T+AGFKMNP3ONySrA6o5It1FTyrMIirtur65M7zEPuZd/cDC412+QITqhCns
         xr5msLN6dftt5q4F7SEzDDGjUMpMNRh9LwUtWoZJzFCvBcsJ3ATdKE+K4VgqnpbDYOr3
         XT/FEPe3kOTStTOqebE4AaJAJ7ENMyYBgEXhCh+CnrifRQzyRJMGKTrKs18fuA660kVh
         NNLCp4wIBLU0EZv6C7cHoGAQez64g3214K0H2qWKHVW2SsiSFVGhUF9Hu8ncUMJCzDPZ
         MwNQ==
X-Gm-Message-State: AOAM533UtMC7yinzPUoc9BpUTFbp5stqh8g+gWxjsfjZzNkxsIsREEh6
        H61Dme+cPi3pogn/OZhDw74=
X-Google-Smtp-Source: ABdhPJzeh5fTWdxIugnXevHmNSxS7tf9oXGcTjLqar25q4AlnybWHVKkRxnjI0aRV9k4qLxOmboFJg==
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr856889oic.48.1623874153435;
        Wed, 16 Jun 2021 13:09:13 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id d136sm636049oib.4.2021.06.16.13.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:09:12 -0700 (PDT)
Date:   Wed, 16 Jun 2021 15:09:06 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60ca5a62b2193_602720899@natae.notmuch>
In-Reply-To: <87wnqwzg51.fsf@evledraar.gmail.com>
References: <20210614043450.1047571-1-felipe.contreras@gmail.com>
 <20210614043450.1047571-2-felipe.contreras@gmail.com>
 <87wnqwzg51.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 1/2] completion: graduate out of contrib
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Sun, Jun 13 2021, Felipe Contreras wrote:
> =

> > These have been stable and widely used for quite a long time, they ev=
en
> > have tests outside of the contrib area, and most distributions ship
> > them, so they can be considered part of the core already.
> >
> > We should be consistent and either we move the tests to contrib, or w=
e
> > move the completions out of contrib.
> >
> > Let's move them out of contrib and provide an installation target
> > install-extra.
> >
> > By default bash-completion installs the completions to
> > $(pkgdatadir)/completions, which is
> > $(prefix)/share/bash-completion/completions. And since most distribut=
ions do
> > not change this, it is obviously the right default that distributions=

> > can override with bashcompdir.
> >
> > By default zsh looks for completions in
> > $(prefix)/share/zsh/site-functions.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Makefile                                        |  3 +++
> >  extra/Makefile                                  | 17 +++++++++++++++=
++
> =

> Please let's not continue following the IMO anti-pattern of having thes=
e
> sub-Makefiles. Let's just add the target to the top-level Makefile.

All right. Fine by me.

-- =

Felipe Contreras=
