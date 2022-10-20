Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D097C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJTXFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJTXFH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:05:07 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D61118793
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:05:04 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c12-20020a170903234c00b0017f695bf8f0so436823plh.6
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhDFXbKCF/MhZBStbb4x2CfsXd4cnT8+0bNaF5T2xlo=;
        b=X4WjXORhakWpNwbAdq3ENJZxNtkgbXZ8SG5MgdmEn1qTP7QC83hpCjn3FBv37gkR9v
         y/q1uY1dI73a+HJ05ueLCDe7WRCtLqK4oSPlSQTHaA0TTxb4MKj5PYZGiC2V1nzZIJHk
         p7u4DgvGN6t5M7SySu9VJGOYnbWr+hPWElVByEhPSXIO0UpeXEDcuDx60HWWsWAH0kdm
         pr02F5FqaZCKDQu3kqP7EFzyALqYbicpkM4doiOk1PvspIanqE7DH1MOtphQbgragRQM
         qr8bBox9ztUmKvOIuFIsIv4sft7pN+tqN2PHLokz5oAxWJR1zyBXPcCRPbwm4YQrry89
         E9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UhDFXbKCF/MhZBStbb4x2CfsXd4cnT8+0bNaF5T2xlo=;
        b=nK2iug2oe6fv0tfFZfaMjL849YwQzPUm1X7rPyujDVZ0GMI2ka6EuPzjckpZTPtYK7
         Ngsen2IuYOuqzGpxpJVAFwh1wbqeXGnKzpzK45X7wvPTbu8VdpjqkFup929HAFlIJE0K
         LcIexPAQ1U8c6vEOzjxYP9o9cUn5IkYcKt2g4Zag6IqeV64CybZJaoaggYPYqghxL6Sy
         82TiZCsELn0fq/YzgdVVJcbY0dv5tSaEeexmRgCxFCklJUNAM30VDpETlvTxYPnMBL+i
         RpIKBrTgif4+HDmUjMoiIW6Gg1AZhnupKesH7hwWCteq5RUz4Jsh++JWbs+GYx7XFkKS
         eeLQ==
X-Gm-Message-State: ACrzQf33Z5gBXGwY2uw48Co5jeCca65Yd/1fUy2vFqxpTImPwey1smFq
        WjraWHVReeo8D/4GDkkNIN+EQmurDA55Zg==
X-Google-Smtp-Source: AMsMyM7a1a4eT2fTSanCiEfj8fM3xEZZrmChzLZPMjXMhXtdUu9Q0u32A0I5r2ZfW/ADynJHk0odoVLdYWVXGw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b84:b0:565:caea:38bc with SMTP
 id g4-20020a056a000b8400b00565caea38bcmr16457332pfj.80.1666307104295; Thu, 20
 Oct 2022 16:05:04 -0700 (PDT)
Date:   Thu, 20 Oct 2022 16:05:02 -0700
In-Reply-To: <patch-09.10-7f232c5e503-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-09.10-7f232c5e503-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6lmt9qxfj5.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 09/10] submodule: support sub-command-less "--recursive" option
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The inability to specify "--recursive" when we're not providing a
> sub-command name appears to have been an omission in 15fc56a8536 (git
> submodule foreach: Add --recursive to recurse into nested submodules,
> 2009-08-19). Let's support it along with the other "status" options.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/git-submodule.txt |  2 +-
>  builtin/submodule.c             | 16 +++++++++++++---
>  t/t7400-submodule-basic.sh      |  6 +-----
>  3 files changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodul=
e.txt
> index 345ebcafb9c..0c918390f2f 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -9,7 +9,7 @@ git-submodule - Initialize, update or inspect submodules
>  SYNOPSIS
>  --------
>  [verse]
> -'git submodule' [--quiet] [--cached] [--]
> +'git submodule' [--quiet] [--cached] [--recursive] [--]
>  'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>..=
.]
>  'git submodule' [--quiet] init [--] [<path>...]
> diff --git a/builtin/submodule.c b/builtin/submodule.c
> index 1d77f2d0964..ca8e273b6e9 100644
> --- a/builtin/submodule.c
> +++ b/builtin/submodule.c
> @@ -64,7 +64,8 @@ static const char * const git_submodule_usage[] =3D {
>  };
> =20
>  static void setup_helper_args(int argc, const char **argv, const char *p=
refix,
> -			      int quiet, int cached, struct strvec *args,
> +			      int quiet, int cached, int recursive,
> +			      struct strvec *args,
>  			      const struct option *options)
>  {
>  	const char *cmd;
> @@ -79,10 +80,13 @@ static void setup_helper_args(int argc, const char **=
argv, const char *prefix,
>  		return;
>  	}
> =20
> -	/* Did we get --cached with a command? */
> +	/* Did we get a forbidden top-level option with a command? */
>  	if (cached)
>  		usage_msg_optf(_("'%s' option is only supported with explicit 'status'=
"),
>  			       git_submodule_usage, options, "--cached");
> +	if (recursive)
> +		usage_msg_optf(_("'%s' option is only supported with explicit 'status'=
"),
> +			       git_submodule_usage, options, "--recursive");
> =20
> =20
>  	/* Either a valid command, or submodule--helper will barf! */
> @@ -92,6 +96,9 @@ static void setup_helper_args(int argc, const char **ar=
gv, const char *prefix,
>  	argc--;
> =20
>  	/* Options that need to go before user-supplied options */
> +	if (!strcmp(cmd, "status") && recursive)
> +		strvec_push(args, "--recursive");
> +

Unless I'm missing something, doesn't this do nothing because we don't
set cmd =3D "status" when there is no subcommand, and instead, we return
early?

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index c524398e805..7cafc2e1102 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -20,10 +20,6 @@ test_expect_success 'submodule usage: -h' '
>  	test_must_be_empty err
>  '
> =20
> -test_expect_success 'submodule usage: --recursive' '
> -	test_expect_code 129 git submodule --recursive
> -'
> -
>  test_expect_success 'submodule usage: status --' '
>  	git submodule -- &&
>  	git submodule --end-of-options
> @@ -38,7 +34,7 @@ do
>  	'
>  done
> =20
> -for opt in '--cached'
> +for opt in '--cached' '--recursive'
>  do
>  	test_expect_success "submodule usage: status $opt" '
>  		git submodule $opt &&

Frustratingly, it's not easy for me to test my hypothesis above because
there don't seem to be any tests for the output of "git submodule status
--recursive" :(

> --=20
> 2.38.0.1091.gf9d18265e59
