Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDBC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5795761352
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhDLTG2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Apr 2021 15:06:28 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:42839 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236711AbhDLTG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:06:27 -0400
Received: by mail-ej1-f46.google.com with SMTP id w23so6236976ejb.9
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ooS9sPPnExQpYuRvKvN5dA9jq8tKS1dAPXl4gnKFgjE=;
        b=lGrO5La6hc+sEi1m0bVsNgcYSrwlPUHDe2ZMfq8uxekxxiBEnmPrJdU1fQ2SeU/xq1
         D47ef60NdDdqRC7zoeAFSVLXjcGUWKJnM1d26btETN5Deu/2u6SqqqKqOH92GFyTDC1r
         i9Yp6Qnd1mRS8NmgPwsWIm2PgLO/cefFUGkxAdWk2c+Il9sOedIcksEswWatMo132jLo
         8PgHHMFNhC8U4xm8vmiZyCtKNJMTuYw8co9PffZeBkpAcT0yEmV6x9YeGGrKDDo4PmNz
         /OQ+Zpj7hQZFesSLRrgaRjTxgZFEGvbAeEhZMvDDV2QocuD6+ZeU753aWLm3x2SVmMEH
         MA5w==
X-Gm-Message-State: AOAM533OUzG6SbEafNxDfCE2AWVvx4O/LdSx1KWh7I+l9Y975IPreCk5
        2fVnpYS8MV2dCrknIIytiZ3r5jne7NaSiAHlilWInHmKM4w=
X-Google-Smtp-Source: ABdhPJxWdpYf/irR4oCJ6D7/vjK+nGhPykAhzbl8vEdILf3xiFpT9zNl026vCZiI6lceSC3tcuI+CgzxeWzqXNG6hR8=
X-Received: by 2002:a17:906:cc46:: with SMTP id mm6mr2791223ejb.138.1618254367495;
 Mon, 12 Apr 2021 12:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
In-Reply-To: <patch-08.16-352eeff41c9-20210412T110456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Apr 2021 15:05:56 -0400
Message-ID: <CAPig+cTTjX=keJJdXLfsP52tQJZULgzjqbvYm=QZLK2312qRmw@mail.gmail.com>
Subject: Re: [PATCH 08/16] test-lib functions: add --printf option to test_commit
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 7:09 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Add a --printf option to test_commit to allow writing to the file with
> "printf" instead of "echo".
>
> This is useful for writing "\n", "\0" etc., in particular in
> combination with the --append option added in 3373518cc8 (test-lib
> functions: add an --append option to test_commit, 2021-01-12).
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Just a bit of pure bikeshedding...

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -173,6 +173,10 @@ debug () {
> +#   --printf
> +#       Use "printf" instead of "echo" when writing "<contents>" to
> +#       "<file>". You will need to provide your own trailing "\n". You
> +#       can only supply the FORMAT for the printf(1), not its ARGUMENT(s).

The name "printf" has such strong association in programmer's minds
with "%" and argument consumption that the name of this option alone
almost begs people to take advantage of argument interpolation even
though it's documented here as not allowing it. Taking into
consideration that people often do not read documentation, `--printf`
as the name of the option may be an unfortunate one. Perhaps it could
be called `--raw` or something less likely to suggest argument
interpolation.

> @@ -192,6 +196,7 @@ debug () {
>
>  test_commit () {
>         notick= &&
> +       echo=echo &&

This could be slightly confusing. I wonder if naming this variable
`emit` would be clearer.
