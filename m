Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7646C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABEC20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 17:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHBRWP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 2 Aug 2020 13:22:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgHBRWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 13:22:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id b6so32099815wrs.11
        for <git@vger.kernel.org>; Sun, 02 Aug 2020 10:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iZuUD9n3ik4orfBMqjH6uoqbRTSCqDBowZpAdsMU84g=;
        b=nbRbKflz8zQ2v+PBCmHqdZMyh6OpvwLzR0vHjFmyH+zTamilF3SsKrDRvRVd2Dl+AC
         y2lAZQVy4IaghC5G9ynQ6JqlAMoz0vEVRR/qYJsVCY4FmtEfS51TjjR98/xMBURdU7DC
         R1ziFNgLUaHniRdQxjnszZkftye8IrZTjfMcTBOiPA8M4tVSloHWdDwwBSmE4rFXwXzs
         dzXgxCUsweys4rx7JnFeADrJ0W3qU6iludQS/cMWmy+WluygKHLSo9XR5O5gDzMUQ4m2
         ee+/tB4tAmcv6p6bjuEkBY+beTLETyZHswYDjirq30tmNrdtntjtuqN7PzVo16r0J3L0
         BWpA==
X-Gm-Message-State: AOAM530Oq1k+jnK40YELD5JAgw75DIjRHuasOxiOVrg7E4fd2oChifRR
        1Xz5icNqvKQgkFLmnevOSNy+a265JXEK3njCOH7422OMpCE=
X-Google-Smtp-Source: ABdhPJy7DFptqDfMyedScBrWq6T/vIZR+ahLKas5AsxMpmPxI2CNXefskLLrGHpmxn1wPNhvwvcgHEhiM6jFqGLHd0k=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr11467004wrv.120.1596388933769;
 Sun, 02 Aug 2020 10:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqmu3d27vs.fsf@gitster.c.googlers.com> <20200802143018.5501-1-martin.agren@gmail.com>
In-Reply-To: <20200802143018.5501-1-martin.agren@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 Aug 2020 13:22:02 -0400
Message-ID: <CAPig+cR=AdRbJgnVBJsbEtNmV41bRDkXE-tyWsztoYF7jZKeAQ@mail.gmail.com>
Subject: Re: [PATCH] t1450: fix quoting of NUL byte when corrupting pack
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 10:30 AM Martin Ågren <martin.agren@gmail.com> wrote:
> Subject: [PATCH] t: don't spuriously close & open quotes
> [...]
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> @@ -177,7 +177,7 @@ test_expect_success "Sergey Vlasov's test case" '
>         git add ab.c ab &&
> -       git commit -m 'initial' &&
> +       git commit -m "initial" &&
>         git mv ab a
>  '

This was discovered[1] independently a couple weeks ago; glad to see
it was picked up by your grep'ing, as well.

[1]: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
