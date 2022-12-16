Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6628C001B2
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiLPQRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiLPQQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 11:16:47 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686751D0F6
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:16:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id b2so7286245eja.7
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vUzyng6PgJf83kLjxQ048MF1IFspvdekWPQvEeAHFtI=;
        b=QjbdI2gu+Zaqu/Nx6yRRlphOp7cilOauXn8b9RlLjOij6xD8vXfWLZxnw+o7D/jgW6
         +yO+vRcWX3qvmuNchsz+/XKFo9s6grr/65H9NtQFUgg3uXfRCyyrrWRFtwe/4rjd8mRg
         em4aPUlOBqSYGWQBbLgKTLgyQ598rBzjxcrJ1/YaBpFfYp7+A6Ur/kQuO8KpV+C2FF9N
         PznMlZMws8Rf9tsiIVHTweAHoj89ppYOk/qpvWQz2MjSPcaYJGVfmamA0kKSh7ofFEkU
         rJltxbvlsdQ3o/wivNlb6vUS1f6djDiEX8m+jB2I0uAHduRSof6IWpcDyfaaUIxJVeKB
         LKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUzyng6PgJf83kLjxQ048MF1IFspvdekWPQvEeAHFtI=;
        b=GUpjFiJozuL+oRX/n7k848dg3sMiuvEo+W7iMuHIHKQP8riNa/7LF9lVvoq7BRMANN
         YajFURbFF9h+iHGQGIO0q0xgCghHsbY8lfm1HBXPF5zEN0LyALjSMRIMfDH6WcL6RkRg
         BbMtU2aVlGjEQv4pPrB6NAJ2c973mNnwaniWAGeIf/yLcdVKOb8NRS2TIFei2vSY4b/W
         +4akFhHgXCdsamXsfsxDDvmlAoQW4feVYhFwGJCLZJL9B80tDKE3sNdolqV0TRL65DsY
         JB8/xJp4JUpBCMzfDeTz61k7JXzCX1EMvxCCcXLyLsz+/9YmvLd8J3hlUPRg0NtxlHNJ
         f9/A==
X-Gm-Message-State: ANoB5pl/B4lfXB5Zh8DG9YKRUQFMfwRj9/8yi7JZ8VF8fXKHwMO38WB1
        EHhObyebKltt2Btd5yrTnkeVykee5aA=
X-Google-Smtp-Source: AA0mqf5RPNUmAztYU3LIxQjb8qdyMpVjhgHYymowQaVWcIvyFJdQoSsPVvnqIpSqcozd1hjptYgwNQ==
X-Received: by 2002:a17:906:f6d7:b0:7c0:bf7c:19f4 with SMTP id jo23-20020a170906f6d700b007c0bf7c19f4mr27871506ejb.74.1671207403862;
        Fri, 16 Dec 2022 08:16:43 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id lb15-20020a170907784f00b007c0f217aadbsm1000104ejc.24.2022.12.16.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:16:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p6DO6-006QRg-2u;
        Fri, 16 Dec 2022 17:16:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
Date:   Fri, 16 Dec 2022 17:12:46 +0100
References: <20221216121557.30714-1-minipli@grsecurity.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221216121557.30714-1-minipli@grsecurity.net>
Message-ID: <221216.86o7s31fyt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 16 2022, Mathias Krause wrote:

> From: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
>
> Under Linux systems with SELinux's 'deny_execmem' or PaX's MPROTECT
> enabled, the allocation of PCRE2's JIT rwx memory may be prohibited,
> making pcre2_jit_compile() fail with PCRE2_ERROR_NOMEMORY (-48):
>
>   [user@fedora git]$ git grep -c PCRE2_JIT
>   grep.c:1
>
>   [user@fedora git]$ # Enable SELinux's W^X policy
>   [user@fedora git]$ sudo semanage boolean -m -1 deny_execmem
>
>   [user@fedora git]$ # JIT memory allocation fails, breaking 'git grep'
>   [user@fedora git]$ git grep -c PCRE2_JIT
>   fatal: Couldn't JIT the PCRE2 pattern 'PCRE2_JIT', got '-48'
>
> Instead of failing hard in this case and making 'git grep' unusable on
> such systems, simply fall back to interpreter mode, leading to a much
> better user experience.
>
> Such a change was already proposed 4 years ago [1] but wasn't merged for
> unknown reasons.

Yeah, it's unfortunate that it fell between the cracks, and it's good to
have such a fallback mechanism.

> 1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# tweaked changelo=
g, added comment
> ---
>  grep.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 06eed694936c..f2ada528b21d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -317,8 +317,21 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
>  	if (p->pcre2_jit_on) {
>  		jitret =3D pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
> -		if (jitret)
> -			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, ji=
tret);
> +		if (jitret) {
> +			/*
> +			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
> +			 * indicated JIT support, the library might still
> +			 * fail to generate JIT code for various reasons,
> +			 * e.g. when SELinux's 'deny_execmem' or PaX's
> +			 * MPROTECT prevent creating W|X memory mappings.
> +			 *
> +			 * Instead of faling hard, fall back to interpreter
> +			 * mode, just as if the pattern was prefixed with
> +			 * '(*NO_JIT)'.
> +			 */
> +			p->pcre2_jit_on =3D 0;
> +			return;

From my reading of the docs it returns two different codes:
PCRE2_ERROR_JIT_BADOPTION or PCRE2_ERROR_NOMEMORY.

This change will start treating both the same, but we only want to allow
the latter, surely?

So shouldn't this be e.g.:

	jitret =3D pcre2_jit_compile(...);
	if (jitret =3D=3D PCRE2_ERROR_NOMEMORY) {
		/* code you added here */
	} else if (jitret) {
		BUG(...);
	}

I put a BUG() there, we could keep the die(), but
PCRE2_ERROR_JIT_BADOPTION is really more appropriate as a BUG(), and if
it starts returning any other codes our use of the API is also in some
unknown state, so we should also BUG() out.
