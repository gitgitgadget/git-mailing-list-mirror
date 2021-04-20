Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37BC433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1296C611F2
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhDTPIm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 20 Apr 2021 11:08:42 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36730 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhDTPIl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 11:08:41 -0400
Received: by mail-ed1-f46.google.com with SMTP id j12so20463296edy.3
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mLbtbWO3dcNm0MRe56oVUn1UmKWHBzcu2lyzJI0x4d8=;
        b=gsgkFxpvrG6nQdx2H0U6W0ZBA+0jf3esdg3nw3oPlnOieXn44u2GeaJjoSwhTJ+sch
         6KOUYyNsR6ZHeu6RtDc/GHRW+FVF/gFuaNDcv+zNLUvHJymXCS0tKt81ifyBQxh9IB0U
         UP4GJmQKAQAebFVVDp2DDN/z9nVA2WdpENfPwBGdhvZiT9pYtgOW3lMYYz3X3p3lnEuE
         lkBf1jhpniyYHKASlus8gVVhfPG334YbUYNeXVGh7C1qPt0Z5I1Hx2ANgxcaphnn0MR+
         oLiCMS/CO4JcszGt96UhqUs2gi8Az2zS33VPPu6Q273QM3/KllgmfksjQ05mOexoHMQy
         9L0Q==
X-Gm-Message-State: AOAM531+rMN6WeRu4bVIR9gDZ7JtyX2Jsmz01JYimeq78XzdFb89OJpJ
        JClWhI8BFlrPnTChgWZosMH8pURmh0S3/Ui2s+Q=
X-Google-Smtp-Source: ABdhPJyOcN5qDoAE7TUz2hNuV7lYVaPDp2d0SzKk9FDa2WPcSwM6Mary+eG9O57PKqE7ZgDe4th8vUyZ3bSPRBABwQk=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr33377512eds.291.1618931289257;
 Tue, 20 Apr 2021 08:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <patch-2.3-67ddd821df-20210420T122706Z-avarab@gmail.com>
In-Reply-To: <patch-2.3-67ddd821df-20210420T122706Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Apr 2021 11:07:58 -0400
Message-ID: <CAPig+cS31db=769dNZbADqCpkhR9PMuHv5x9knFvi=zSqoMF_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Revert and amend "test-lib-functions: assert
 correct parameter count"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 8:29 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> The goal here is to get rid of the verbosity of having e.g. a "test 2
> -ne 2" line for every "test_cmp". We use "$@" as an argument to "test"
> to intentionally feed the "test" operator too many arguments if the
> functions are called with too many arguments, thus piggy-backing on it
> to check the number of arguments we get.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -756,41 +756,43 @@ test_external_without_stderr () {
>  # debugging-friendly alternatives to "test [-f|-d|-e]"
> +# The commands test the existence or non-existence of
> +# a given argument.
> +#
> +# The pattern of using "$@" to "test" instead of "$1" is not a bug. We
> +# are counting on "test" to error on too many arguments if more than
> +# one is given. Checking "$#" explicitly would lead to overly verbose
> +# -x output.
>  test_path_is_file () {
> +       if ! test -f "$@"

Thanks. The new comment makes the intent of "$@" clear.

If you do re-roll for some reason, it might make sense to move the new
comment (the one starting "The pattern of...") into the function
itself just before the use of "$@". The reasons I suggest this are:
(1) the comment explains an implementation detail, thus is intended
for people who might change this function, whereas all the text above
the new paragraph is API documentation for callers of the function who
need only the black-box description; (2) it places the comment closer
to the relevant code, thus is less likely to be overlooked by someone
changing the function.
