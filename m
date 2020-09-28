Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88972C47420
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC162080C
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 07:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgI1HQi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 28 Sep 2020 03:16:38 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:42512 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1HQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 03:16:37 -0400
Received: by mail-ej1-f67.google.com with SMTP id q13so7007883ejo.9
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 00:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QX8G7COnwQFgmXWGRcM8kQvdARe4ASgBawQPTd3SAJQ=;
        b=QTzjpVeHigLkpJOB9zvmuSDSK4GTy+UwEN7lICPApxgAGX51iUqmVIBtt32pGax7LU
         yd+KvcDoRYbU9JXEGbqwq6DWRaD6qHLlLKEGwZy/SQ2+MK25+v5wFXQWJcA0UIJXm6bp
         Mo6PocK3xlxeJ0cFna+gaRB20f5lDpNv9+OBqtvEu13rT+el+Ud452EGn7r8mnvmas+k
         srii+nyojzW1rrWML0kfrsO7tMfIZ5chQ04bN5Xbhgvsc+VP6rjQcSlhTYAtBdvhVSct
         0gJuW1ViIy74RcX6lzNvmBidXJ7GYzONO7rjY7gcRnaxv71gqgwuADAuvrmwrXBLC0fY
         UfGA==
X-Gm-Message-State: AOAM5303HJcF2mXQFpkssl2a/+UgaRHW/5SVOD9nP4PnsMnU2rX/DcYw
        d6vsZDD4AUwtz9vQmN0C0lXlRl3IhCUbvCbASYc=
X-Google-Smtp-Source: ABdhPJwU4ZALGmE+7MPXoVbkJWHpL07uUo77L/uxLSRTxwcf4gsVzxbYAj7mY1rMUTlZoZqTFjSJ+adcHOry00rsE3Y=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr343950ejb.202.1601277395887;
 Mon, 28 Sep 2020 00:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <cover.1600281350.git.martin.agren@gmail.com>
 <c4825f461e0408970f2adb272098bd6f2a80ef78.1600281351.git.martin.agren@gmail.com>
 <CAPig+cSBPFdF=hM5ho9_g6NCGAprh1mFFT5zX-C9huT3-Qkzow@mail.gmail.com> <CAN0heSr0mZDpjJysvzeG-et3uxpzDWcP3AdPVxiE+KYeY-7nQA@mail.gmail.com>
In-Reply-To: <CAN0heSr0mZDpjJysvzeG-et3uxpzDWcP3AdPVxiE+KYeY-7nQA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 28 Sep 2020 03:16:25 -0400
Message-ID: <CAPig+cS3x1PtNeiMU5a7Dfa8-cCvs4K=LRwELEcb3DQ+ahfeWA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] worktree: inline `worktree_ref()` into its only caller
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 2:57 AM Martin Ågren <martin.agren@gmail.com> wrote:
> On Mon, 28 Sep 2020 at 07:30, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > If I understand correctly, this strbuf_reset() -- which, I suppose,
> > moved here from the retired worktree_ref() -- is no longer needed now
> > that the strbuf stopped being static. So, this line should be dropped
> > from the patch.
>
> What's not obvious from the diff is that this happens inside a loop
> where we go through all worktrees. The strbuf could live one indentation
> level deeper, in which case we'd continuously initialize and release it.
> I placed it at the function-level instead, so that we initialize it
> once and release it once. The "cost" for that is this reset call.
>
> So it's sort of the same reset as before this patch, but it's local to
> this function.

Yep, ignore my stupid comment. I was reading both the patch and the
code yet the reset-in-loop still failed to register.
