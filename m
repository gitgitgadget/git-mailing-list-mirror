Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBF801F97F
	for <e@80x24.org>; Sun, 19 Aug 2018 20:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeHSXSQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 19:18:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43889 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeHSXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Aug 2018 19:18:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id f18-v6so14120387qtp.10
        for <git@vger.kernel.org>; Sun, 19 Aug 2018 13:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMT6VZsXq9O1pzegcrrUZB9iid7JGfWxYrOYrvNFL48=;
        b=lcgbR6+yqQggjF4g0IRf+O/VfIZ8juxT6YFsHPkod1BEV8l1caSs5rZq8HWXq8/OKZ
         wVB3Uzg4tDTOYf+8h14nyDTqflODD/D7TD+pa7WpGuGDn9zJd/eWu8/HbQfkyMuI4Qpf
         yRHT28DZEBF6N2ercYe2tWYEvZ5flutTSNbVY+NI9BnuTVL3bO+h5KkD5F4MWnWoSfQ0
         4a0R7RKNdDFzoy/IUnwq/1TGVWLVzeG6sPGea/ZJZX+sumd/Xvtxer7wZlJj51H31WDb
         dEv8uLHSfPqZ2tAunVdJAnnRidfYsg7lpB9P9gfH+Z81W+Ktuke9Zqq5sv5K3Hk7nhm4
         xCAg==
X-Gm-Message-State: AOUpUlFdeSUz0TMKswIuLX8KggJgKDQI6zzy1/Bkxr1HUWbpz9QB6RPk
        /GN/fDYEJIo11ijPHA6zM2CzT+XwgtiHTdeSQ1g=
X-Google-Smtp-Source: AA+uWPxc640g0g1NCn44Mi2OVppxBeh6ODY3JY8k9XaQrA3LXVTLxxaSlR1Mk8jMck25ZfR9wzU6L+77pnobS2FNET0=
X-Received: by 2002:ac8:5188:: with SMTP id c8-v6mr43304617qtn.35.1534709136920;
 Sun, 19 Aug 2018 13:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180819175351.449973-1-sandals@crustytoothpaste.net> <20180819175351.449973-5-sandals@crustytoothpaste.net>
In-Reply-To: <20180819175351.449973-5-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 19 Aug 2018 16:05:25 -0400
Message-ID: <CAPig+cQz4oM-csmniSe5LPkHixUOh04i+CLWbJB4dn-NeYS3jg@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] t0002: abstract away SHA-1 specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 19, 2018 at 1:54 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.

Nit: s/hashes/hash values/

> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> @@ -92,11 +92,12 @@ test_expect_success 'enter_repo non-strict mode' '
>         ) &&
> +       head=$(git -C enter_repo rev-parse HEAD) &&
>         [...]
> +       cat >expected <<-EOF &&
> +       $head   HEAD
> +       $head   refs/heads/master
> +       $head   refs/tags/foo
>         EOF
>         test_cmp expected actual
>  '

Okay, but...

> @@ -107,20 +108,20 @@ test_expect_success 'enter_repo linked checkout' '
> -       [...]
> +       cat >expected <<-EOF &&
> +       $head   HEAD
> +       $head   refs/heads/master
> +       $head   refs/tags/foo
>         EOF
>         test_cmp expected actual
>  '

This is relying upon 'head' set inside an earlier test, which seems
fragile. More robust would be to compute 'head' anew within each test
which needs it (including the other new test added by this patch).
