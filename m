Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E40C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 17:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbiATRky (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiATRkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 12:40:53 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FEEC061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:40:53 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c23-20020aa78817000000b004be3f452a95so4242487pfo.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=NcWaRTPNhxvUBo2vWM5BCYk9msdLw9yTl/0imYEAzgU=;
        b=BnVuZUAl/Qe2fUl4ktdxrg/07N87G2EvTCsDXLhPRPr9+dFB7JGYoyAF4kto9Q4PQ3
         ey/zrnZeRRQKN2DQiLoh94B9PbArYG5bBN81NO9cjgoH2wGSydikGJt249peRrh+TeKR
         MXqa2No/S9ZQpmr2G3I/j/nQFrVlH+pQI/zxSgXW+cfvnC4pmCLZVclKe0Xgvnu67aKw
         P16jLc2i5SFXiwlZizBOSXBdFl659xJUA+oFQnNgqYl66SLJd9qOvVkoLQhQH4207zSA
         4SchvrKVGclwOB59MxsBH4UQciLK4hJPCLSrnL38J62ktyKG2aFW8QBFvN/pe7wggAKW
         FHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=NcWaRTPNhxvUBo2vWM5BCYk9msdLw9yTl/0imYEAzgU=;
        b=Ay1JrG1OVK7XKcR0iWObnqVtzc6PGojZ94c626zzGIwFiKzXvwGNqWZt3BPh/HCT2L
         gE+fteijJklc4YEGmFOUkljbJwE7mwGr/hPn0ZRslAu7SXEGwsQ2ccjTUFtOtM0IQta4
         aApz/k0eQr91hlX4voEPmOiftXjYPqmv99pTzOz78iu9cPCO6C8HtvOvNzDRklBaRFoG
         E5DyyDup3v+Yx7MJ8mlJ8XQ3c8JZeTX+8QsvUaSVFj8QWY6+/4kSBPqXtqiSOgJNTpOO
         eaMI75zmBJ23rbo2BP3VB70SX5HF0BKnVA/Yx7TWytuKLfJv9XlACathKm8HjXV1XYFs
         /osg==
X-Gm-Message-State: AOAM532jCCNUJQ6UM/jCLYgVc9x4M16Hv9RJ9oXBiYS8MBtIg2DbZJpm
        qstwPfPL94mfs2yLP+7z/3uCQEOVMSnMmQ==
X-Google-Smtp-Source: ABdhPJzDEr9bJP5xxGMMTiscwNlQFmV2gQHFSUDbsG4b9uCZq9VaRyAulZ8YSmS/HTxkZkUQ/V6bTsZSyS2l7w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f550:b0:14a:87f6:30bd with SMTP
 id h16-20020a170902f55000b0014a87f630bdmr145863plf.52.1642700453101; Thu, 20
 Jan 2022 09:40:53 -0800 (PST)
Date:   Thu, 20 Jan 2022 09:40:50 -0800
In-Reply-To: <20220120023821.12320-1-worldhello.net@gmail.com>
Message-Id: <kl6lh79yxq3h.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220120023821.12320-1-worldhello.net@gmail.com>
Subject: RE: [PATCH v6 3/3] fetch --negotiate-only: do not update submodules
From:   Glen Choo <chooglen@google.com>
To:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?Q?Jean-No=C3=ABl?= Avila" <jn.avila@free.fr>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> On Tue, 18 Jan 2022 at 16:00:56, Glen Choo wrote:
>
>> @@ -2014,6 +2015,27 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
>> =20
>>  	argc =3D parse_options(argc, argv, prefix,
>>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>> +
>> +	if (recurse_submodules_cli !=3D RECURSE_SUBMODULES_DEFAULT)
>> +		recurse_submodules =3D recurse_submodules_cli;
>> +
>> +	if (negotiate_only) {
>> +		switch (recurse_submodules_cli) {
>> +		case RECURSE_SUBMODULES_OFF:
>> +		case RECURSE_SUBMODULES_DEFAULT:
>> +			/*
>> +			 * --negotiate-only should never recurse into
>> +			 * submodules. Skip it by setting recurse_submodules to
>> +			 * RECURSE_SUBMODULES_OFF.
>> +			 */
>> +			recurse_submodules =3D RECURSE_SUBMODULES_OFF;
>> +			break;
>> +
>> +		default:
>> +			die(_("--negotiate-only and --recurse-submodules cannot be used toge=
ther"));
>
> Found this new l10n message in "po/git.pot" in the next branch[1]. To be
> l10n-friendly, it's better to follow the standard Jean-No=C3=ABl provided=
 in
> commit 246cac8505 (i18n: turn even more messages into "cannot be used
> together" ones, 2022-01-05). And rewrite the l10n messageas as:
>
> -			die(_("--negotiate-only and --recurse-submodules cannot be used toget=
her"));
> +			die(_("options '%s' and '%s' cannot be used together"),
> +			    "--negotiate-only", "--recurse-submodules");
>
> [1]: https://github.com/git-l10n/git-po/blob/pot/next/2022-01-19.diff#L23
>
> --
> Jiang Xin

Thanks for spotting this! I didn't realize we had standardized this.
I'll send a reroll soon.
