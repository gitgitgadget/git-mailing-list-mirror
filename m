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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7584C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CE060231
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFERIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 13:08:20 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:33744 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFERIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 13:08:20 -0400
Received: by mail-ej1-f48.google.com with SMTP id g20so19429549ejt.0
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vwKifirAcGaRCgjYeP/Fwi4Lbxcv2jNTulThfGckEBA=;
        b=ff6Tgd4BGUepKW5j9oUXPlpV2GE437sawGj1cqZ2/Ee6g016G4pVndAtzkMILvnzYL
         NsHeYOJV4CmSfxvDNRWpmwEYj4na1oSi9Aiy4S6CT5O+rbEHz7T7H2vhKTfmOR5GIRyz
         5OZDXzghrq6XLtSRwNSuTdmYtJvg2enPGgDOSC0d07xt+6be/a8rJusN+LvfOwoeK9eI
         xV6b/NpmR1JaGgMeHEgPL0EKhYYufIuUofHNV+0ZEcHsRLeL6gbTlrIveDmO4VVqdL/h
         ADyXiicugFA5EqigdtvF/ZflMSLhye5lt2cP1nKlQJmpfTopNkGA7Lr25kVlnY7kt6CB
         tB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vwKifirAcGaRCgjYeP/Fwi4Lbxcv2jNTulThfGckEBA=;
        b=SsVaBBOADXDbcU8OZcRi56rI4+KDD4ue1PC3lZOl5nOe1z79R6+NA70wVUezLmO5tw
         UhTfNqduarInJkqVrsNjOmBzx72v2Jjg5fGI7Jh9EJrqgaKkHzTaQ/1KeMYArgT3bv56
         iF/LgMVdfosAk+Od3Jnsb7GZoh1kcdJ1O1whR3vcHEVZg9lEN76WSMyfGdYlKPXjVi4v
         vnIzikQASiczK5y6enmI3/2HNpogy1u1dVMnZN2oayFY3lshI1/jcKsTvpTevLb7EwNb
         PeqaKffe3RhH/KzUVFccAhCEca7Bk1b6U1Bso1+cgVqcMS24ADcobCJKg822pqDB9Lsb
         SWQg==
X-Gm-Message-State: AOAM530koRtasLxIXtmGjZaTA5iCriwwqiatT0x7cy7x2BQbIefljfen
        6978kFCdFev/pqOklaZGsQQ=
X-Google-Smtp-Source: ABdhPJyyCuQeo0LlnFA9AfcPJvGGXwH3ng2CbTFFkwt0QwMpsFtjcH3GKSCVf8O36gohiDA60RUnxw==
X-Received: by 2002:a17:906:e2d6:: with SMTP id gr22mr10079482ejb.514.1622912719790;
        Sat, 05 Jun 2021 10:05:19 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bh3sm4352667ejb.19.2021.06.05.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 10:05:18 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] t6020: do not mangle trailing spaces in output
Date:   Sat, 05 Jun 2021 19:02:41 +0200
References: <CANYiYbEXiaJ-iN+wLijoKGB_ebEF3eDK8BBwtYz0unE0mKtR8w@mail.gmail.com>
 <20210601144901.31375-2-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210601144901.31375-2-worldhello.net@gmail.com>
Message-ID: <87im2s5jjm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jun 01 2021, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> We used to call `make_user_friendly_and_stable_output` to mangle
> trailing spaces in output before comparing with the expect file.
> =C3=86var recommends generating expect file using pattern "'s/Z$//'" to
> compare expect file with raw output.

I've tested both of these patches and they fix the reported issue on
that gcc45 machine.

> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t6020-bundle-misc.sh | 89 ++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 43 deletions(-)
>
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index c6a8ea7f76..7ee43fb1df 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -83,7 +83,7 @@ test_commit_setvar () {
>=20=20
>  # Format the output of git commands to make a user-friendly and stable
>  # text.  We can easily prepare the expect text without having to worry
> -# about future changes of the commit ID and spaces of the output.
> +# about future changes of the commit ID.
>  make_user_friendly_and_stable_output () {
>  	sed \
>  		-e "s/$A[0-9a-f]*/<COMMIT-A>/g" \
> @@ -104,8 +104,11 @@ make_user_friendly_and_stable_output () {
>  		-e "s/$P[0-9a-f]*/<COMMIT-P>/g" \
>  		-e "s/$TAG1[0-9a-f]*/<TAG-1>/g" \
>  		-e "s/$TAG2[0-9a-f]*/<TAG-2>/g" \
> -		-e "s/$TAG3[0-9a-f]*/<TAG-3>/g" \
> -		-e "s/ *\$//"
> +		-e "s/$TAG3[0-9a-f]*/<TAG-3>/g"
> +}
> +
> +format_and_save_expect () {
> +	sed -e 's/^> //' -e 's/Z$//' >expect
>  }
>=20=20
>  #            (C)   (D, pull/1/head, topic/1)
> @@ -180,11 +183,11 @@ test_expect_success 'create bundle from special rev=
: main^!' '
>=20=20
>  	git bundle verify special-rev.bdl |
>  		make_user_friendly_and_stable_output >actual &&
> -	cat >expect <<-\EOF &&
> -	The bundle contains this ref:
> -	<COMMIT-P> refs/heads/main
> -	The bundle requires this ref:
> -	<COMMIT-O>
> +	format_and_save_expect <<-\EOF &&
> +	> The bundle contains this ref:
> +	> <COMMIT-P> refs/heads/main
> +	> The bundle requires this ref:
> +	> <COMMIT-O> Z
>  	EOF
>  	test_cmp expect actual &&

I think for this test it would be better to just have the "Z" suffix and
leave off prefixing all the lines with ">". That's done in t0000.sh
because we have various empty lines, but here that's not the case.

I don't think that nit is worth a re-roll, and as you noted you're doing
some larger changes to these tests in follow-up patches.

It's just convenient to have the test_cmp expect input as close to
copy/paste-able as possible.
