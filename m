Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B18C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5F613B4
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhGBNdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhGBNdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:33:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E401DC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:30:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so13242034edc.7
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Rsk5p/9quExKyU1W+xBhfGcvttO281hitxs+GSotQbE=;
        b=qkrmrTGJDrQaANj00LwPlROZCQBNEOp3BfkHLLhV3wKp/n06XB4EOmK5p4nwrDExxt
         ef7+9GL2yeMmGiMEeKQGQZJIrJx9a2vQPyLp6+XhyMr7s3CcTHtXCQHhYwdjz8ZaQiRx
         4ET9z2qwKxFjeaaNntHZcovfohJ6V/t0JnnF3rokrIbtZLqmG+mIps2CQ5R+cbyP/nGh
         Jepmervsoaxuk0tlly4o4mixKqNFksUoCZsIGP+Nn7IHU9FgeqMcOaJjqAR5JyTTdgUq
         0zcWslU+0l7XILs+AsMauBfVT/55yG83Og6vlu6Cb71reMw2DdN4kKU/llrZjXfsk6nO
         wq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Rsk5p/9quExKyU1W+xBhfGcvttO281hitxs+GSotQbE=;
        b=H+6GOzdZ/TkvEtvzyh/vEi6zRcBsNdSxHSMlyb315WeS8YRvznz0ZVC+KLzpEcaxyn
         +im8ynPUZU9MSmL9rgfBTs4+4QbboPYdXgDHF7FnPE6haQKPljGQ8Mbv5dFU3vfeneMU
         OMUYfSvABsXK9kp6IeUKfoGTasPYp1G+s3pJ0OBqqxkUbPD2W0LbU7yzJvuiWUePtmqn
         mt83N6kHXlT25nX67lWWKlw5m1g76mhMu1kbQ6dKaYq4n1CU/eHaBu4FXv/A+isLT4q2
         /8PBXH+z/IeCap4w+etlA1Grz8q5daFrUnYr43cLocTVFW/rY2F2W1VorSwBFEZgpJVn
         t7yw==
X-Gm-Message-State: AOAM531RNIRRU3+Oy0e1tdSskyRmV/P+jZ9SosZ+PzIUHeU6gGP+JbuL
        lIkdAAj5fVodzyUX0kt9zTPyO1agJH6H4w==
X-Google-Smtp-Source: ABdhPJyZioBQLkXqXnSrj5vw5ItkhAHjXete4zaVwuF1Mpb6wyLjxqajGMRU7KZf0lrxpwmXqlIPyg==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr6814692edt.152.1625232633205;
        Fri, 02 Jul 2021 06:30:33 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x17sm1352320edr.88.2021.07.02.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:30:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 03/15] [GSOC] ref-filter: --format=%(raw) re-support --perl
Date:   Fri, 02 Jul 2021 15:29:49 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <7d2314b43f21a470667971f1fdcb382f43bf51ed.1625155693.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <7d2314b43f21a470667971f1fdcb382f43bf51ed.1625155693.git.gitgitgadget@gmail.com>
Message-ID: <87fswwalmv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Because the perl language can handle binary data correctly,
> add the function perl_quote_buf_with_len(), which can specify
> the length of the data and prevent the data from being truncated
> at '\0' to help `--format=3D"%(raw)"` re-support `--perl`.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

Thanks!

> -test_expect_success '%(raw) with --perl must fail' '
> -	test_must_fail git for-each-ref --format=3D"%(raw)" --perl
> +test_expect_success '%(raw) with --perl' '
> +	git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob1 --perl | perl > actual &&
> +	cmp blob1 actual &&
> +	git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob3 --perl | perl > actual &&
> +	cmp blob3 actual &&
> +	git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/blob8 --perl | perl > actual &&
> +	cmp blob8 actual &&
> +	git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/myblobs/first --perl | perl > actual &&
> +	cmp one actual &&
> +	git cat-file tree refs/mytrees/first > expected &&
> +	git for-each-ref --format=3D"\$name=3D %(raw);
> +print \"\$name\"" refs/mytrees/first --perl | perl > actual &&
> +	cmp expected actual
>  '
>=20=20
>  test_expect_success '%(raw) with --shell must fail' '


Nit: Formatting can be "| perl >actual", not "| perl > actual", like the
usual style...
