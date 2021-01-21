Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AE5C433E0
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F0B2389B
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 05:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbhAUDpZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 22:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436468AbhAUCA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 21:00:28 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD3C0613C1
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 17:59:48 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f6so540908ybq.13
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 17:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ygDKGUD53ve5zf/iid7tCXhI38TNdu89vdtuStOtHjE=;
        b=Tzjj6gZOKSusWMjcq3wD4DxN6cr8aTgjzlXXAzPwQfz3I00VG7tMKL/9KCusgUZcLl
         dAmnm0VciOVsR5SGDvE9L4Yaft6DK12bQmLrpl2b2f1i5Cmuc8SpVLI/1MncfB/q7ttG
         GkEUhulVkjs3Q645tIXEkiqBWv+smuATvbwA0K4qYTO0ij8r27FM+pU2/vqFxzWAfoHj
         LrJt8UHi4jXDXoCBh/cAYhqFSwSoZFouY6Ght4Xr/KgXFRYslSpz4BT4NPnPGU2V/Sdv
         L8N6XQ4r9z2T0z6swBsMIM7bwomFDMFEasjoiPkRROfs+PYvn1vsxl/0+riJ94EaztBV
         yO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ygDKGUD53ve5zf/iid7tCXhI38TNdu89vdtuStOtHjE=;
        b=UAhFc187UfjZIOwo9K09/NU6nRUG+SDv2xtusSdhMDbkEHyV1JOaLPZ3j7CUvMPJbm
         UAiy2hobAbW49GaCDSUhBtlmGaSBOD3WmvkUHL0LPstZKM6F+fylZkhjLb1YCy5HERNd
         i1FDRacHN46a8MYEyn3gsEoaRbDIzKRJdSOTNTwNbeJHVfjzgH/bSmluIhPO9j08EAVJ
         gXUgxoh2EyGlZpHXA97OUZOmTiyhQLVbBaAsX0FXGukVkaPfbUGoEhUTNzPgwVS/8fNk
         2WHTDotNdgv0ae6pjpcqyAtRccm6dI1VDPRuic+6hDp6nnYPgfmcn9FsOCm+GccXdZhM
         humw==
X-Gm-Message-State: AOAM530B/jZgLinDoPRfsfy0b+2+da22fnHVPAyRLh8BvAx1+tyMgLjJ
        DYEjIRJ/YgHHvdTfmozCo3VsnyZFZ5DuGd2l9jhw9bguxbAkVg==
X-Google-Smtp-Source: ABdhPJxcOYbUQqC5htZNuebVxXDNK9qeJWC73mhl1YBY7wMIxRItHF6P7/bVMqcLimwWUfFOVdjGhe1kpAzaCOdZXLs=
X-Received: by 2002:a25:d2c8:: with SMTP id j191mr10880871ybg.279.1611194387819;
 Wed, 20 Jan 2021 17:59:47 -0800 (PST)
MIME-Version: 1.0
References: <e1c9c9cf-4498-6861-bb39-53ceeb9c0fe7@kdbg.org>
 <20210119102459.28986-2-worldhello.net@gmail.com> <20210120124906.GA8396@szeder.dev>
In-Reply-To: <20210120124906.GA8396@szeder.dev>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 21 Jan 2021 09:59:36 +0800
Message-ID: <CANYiYbFU=mFwotLMhE99+gB1KAz=v6i4QSBHSAR-5ZVOPeB=VQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t5411: use different out file to prevent overwriting
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:49=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Would it be possible/desirable to die gracefully when the receiving
> end doesn't support push options?

If want to die gracefully, we need to end the pack protocol by sending
a flush packet, close the connection. However, since we can easily fix
this test case, I think changes for git protocol is unnecessary.

> > diff --git a/t/t5411/test-0000-standard-git-push.sh b/t/t5411/test-0000=
-standard-git-push.sh
> > index 47b058af7e..b074417d4b 100644
> > --- a/t/t5411/test-0000-standard-git-push.sh
> > +++ b/t/t5411/test-0000-standard-git-push.sh
> > @@ -35,11 +35,11 @@ test_expect_success "git-push --atomic ($PROTOCOL)"=
 '
> >       test_must_fail git -C workbench push --atomic origin \
> >               main \
> >               $B:refs/heads/next \
> > -             >out 2>&1 &&
> > +             >out-0000-1 2>&1 &&
> >       filter_out_user_friendly_and_stable_output \
> >               -e "/^To / { p; }" \
> >               -e "/^ ! / { p; }" \
> > -             <out >actual &&
> > +             <out-0000-1 >actual &&
> >       cat >expect <<-EOF &&
> >       To <URL/of/upstream.git>
> >        ! [rejected] main -> main (non-fast-forward)
> > @@ -65,8 +65,8 @@ test_expect_success "non-fast-forward git-push ($PROT=
OCOL)" '
> >               push origin \
> >               main \
> >               $B:refs/heads/next \
> > -             >out 2>&1 &&
> > -     make_user_friendly_and_stable_output <out >actual &&
> > +             >out-0000-2 2>&1 &&
> > +     make_user_friendly_and_stable_output <out-0000-2 >actual &&
>
> There will be a lot of sequential numbers this way, which might lead
> to additional churn in the future, if we ever were to add more tests
> somewhere in the middle.  However, our test framework does already
> have a counter for test cases, so we could perhaps use that, i.e.
> 'out-$test_count', to make sure that each test case has its own output
> file.

Using $test_count is better, and will do.

Thanks.
--
Jiang Xin
