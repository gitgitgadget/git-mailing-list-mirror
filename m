Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F08C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2827610C8
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhGOAAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 20:00:48 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:34481 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhGOAAs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 20:00:48 -0400
Received: by mail-ej1-f41.google.com with SMTP id hr1so6145619ejc.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UloyZ8y/xkj2WMobKTzQ1W7yNM6KCLj86PJWSe+g9Yw=;
        b=fAasD21G3Ygn/KwD3b3TEOo7PMXcMM1QNz2B6ou9T32c6FYmVrHNbVi4jSzCy4DJvO
         VY/LYOueYdZP+Krspn3RAo+xDd8yUCpVbsyGXQIiRmAfyibEUgLh3drnhceABvr5quXb
         JziY2dSmFRPwQBDH5CQhyxfO/gRH/uQWd3E9h2h/+FEh1kLHOVxl4xxvg1EK68TKCHoh
         IbtQFyBRdGHy7uLLXgaPm6Kgif5+fAEJ+oFoG95lok17Y6nco0AiyGhUbSEXV4HDapDX
         F5nqJj9QiOXjescCGeoz+32+30z/CMT0yn2ce86CvRkPt74gCYsDkQEk+vUFb8kZOU14
         PqgA==
X-Gm-Message-State: AOAM531nh9d7+BGyNDbpVSbIpH1dtypsnD+7gIcGR2/AUiG2ZMpO8iIh
        tgjD5xLwx1aXtIpPoO1BeJqZBAEnSyXHysUU0po=
X-Google-Smtp-Source: ABdhPJwknPA/qYx7rhPTb754VjsEt/Gi54g2kG9dyFqLSdKTZdKfXstJspriLNG5/K7ejRSG3+QtvzFDC9FXEKEJQZg=
X-Received: by 2002:a17:906:f9c5:: with SMTP id lj5mr872213ejb.482.1626307075001;
 Wed, 14 Jul 2021 16:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1041.v2.git.git.1626092359713.gitgitgadget@gmail.com>
 <pull.1041.v3.git.git.1626264613.gitgitgadget@gmail.com> <390a8f816cda0574cabe49e9f88ae1803142fb51.1626264613.git.gitgitgadget@gmail.com>
 <xmqqlf68wyfa.fsf@gitster.g>
In-Reply-To: <xmqqlf68wyfa.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Jul 2021 19:57:43 -0400
Message-ID: <CAPig+cRmSYNgftKeYoHk0hv54rp_bwrEv6zdhLT7QFx+Q34kKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] Add commit, tag & push signing via SSH keys
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Fabian Stelzer via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 2:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Fabian Stelzer via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > In our corporate environemnt we use PIV x509 Certs on Yubikeys for email
> > signing/encryption and ssh keys which i think is quite common
>
> Upcase "I".

Also: s/environemnt/environment/
