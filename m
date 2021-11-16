Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63215C433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AACC61BF6
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 12:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhKPMxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 07:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbhKPMxc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 07:53:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31C9C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:50:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y12so30829573eda.12
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SNO8IFNjdv2g4p0YGMTVRK4yYwx8DhLf8teLY+jzJog=;
        b=KuTfu5P0B8/ctUY5935mDUnv6j6IrtTNgpt3qR/90JVqIkvrnDrhoPBVheXeo685kk
         Xxj9DvqydIpZAH5W28850IERmar0s55e/LD2HjPapVk87BKPQfdgZhqp/Qar8GQe90Va
         4AsL9NxVKAkA2AMMWvNbuGsGBcw++5PBiKr755eFYmMgLhgfX1q++6cG+76SSeHakStG
         MnfNPiSXeV6G+h7V/IVv95RH3Wi0O3f66EsTdWN6V4yULuUk3x2e9wfYnhF0dRD3tKWX
         bGpAMqHeHF7hi8SDj8X7++YFYoUsb83kSKbaJCG43QZCkbjqLt/duSvRin9zx9BHIIBs
         1ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SNO8IFNjdv2g4p0YGMTVRK4yYwx8DhLf8teLY+jzJog=;
        b=VFU2Zp8DLnIGoAkRPhFWB+cgBRUOjClhG6w3A1J4Ftj4lvGGVJpF7rGmDHEHezH+JU
         c4ZhUWxamoi47Zj9+B7eV8XWJ2kmzsdiW1otoY+RaGMngYcb2Q0wRl9/dWQk6Vf83HtR
         KluY8SMKd1NxyG+PDB59nl3PgebrpGVven0SRuDLppwZvutcRua6S7ZAACWbaAhBGCGI
         y0qM7adMigvcHaRFfxeoR3JlwyyyJg+VQaG1f/FhuBy3IiT20JQbVxX7eGVj/0OacEFp
         T/0BwujTZZ/M+Y5pcBoTT5/jJYCbOtc/4m4IejczJKSJbzCXGoyI5D9A1zN2Q7ie60nW
         Nb0A==
X-Gm-Message-State: AOAM530sspIGIPCpldb9DruBsb0Dab0bXmFzHmqlXOu7IxUxoWh2FpJj
        4QK/rPtOUiFxvpUBQxBmMjI=
X-Google-Smtp-Source: ABdhPJy/iH2S23z4U1lQHhJq6YbeJMr/xH9XANnESgeEhL+gTvGX1dCfti2imugvuQZDSwePvBZC7w==
X-Received: by 2002:a05:6402:3590:: with SMTP id y16mr10031442edc.343.1637067032537;
        Tue, 16 Nov 2021 04:50:32 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e1sm8187419ejy.82.2021.11.16.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 04:50:31 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mmxux-001PTN-7k;
        Tue, 16 Nov 2021 13:50:31 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, someguy@effective-light.com,
        gitster@pobox.com, Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] grep: avoid setting UTF mode when not needed
Date:   Tue, 16 Nov 2021 13:32:17 +0100
References: <87bl2kv309.fsf@igel.home>
 <20211116110035.22140-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211116110035.22140-1-carenas@gmail.com>
Message-ID: <211116.86tugcp8mg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 16 2021, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> Since ae39ba431a (grep/pcre2: fix an edge case concerning ascii patterns
> and UTF-8 data, 2021-10-15), PCRE_UTF mode is enabled in cases where it
> will fail because of UTF-8 validation, which is needed for versions of
> PCRE2 older than 10.34.
>
> Revert the change on logic to avoid failures that were reported from the
> test cases, but that should also reflect in normal use when JIT is enabled
> and could result in crashes (or worse), as UTF-8 validation is skipped.
>
> Keeping the tests, as they pass even without the fix as replicated locally
> in Debian 10 and the CI.
>
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index f6e113e9f0..fe847a0111 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -382,10 +382,8 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if ((!opt->ignore_locale && !has_non_ascii(p->pattern)) ||
> -	    (!opt->ignore_locale && is_utf8_locale() &&
> -	     has_non_ascii(p->pattern) && !(!opt->ignore_case &&
> -					    (p->fixed || p->is_fixed))))
> +	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern=
) &&
> +	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
>=20=20
>  #ifdef GIT_PCRE2_VERSION_10_36_OR_HIGHER

Hrm.

A few things:

First, if we've got a post-PCREv2 version whatever fix let's guard that
with an ifdef, see thep GIT_PCRE2_VERSION_*_HIGHER at the top of grep.h.

It really helps to have those, both to know to test on those older
versions, and also so that we can at some point in the future bump the
required version and drop these workarounds entirely (as we do with
git-curl-compat.h).

Secondly, whatever do here let's first fix the test added in ae39ba431a,
so we're not groping around in the dark even more.

I didn't spot this at the time but the test that Hamza added in that
based on my initial report[1] is broken & doesn't test anything
meaningful. It needs to have this applied:
=09
	diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-asci=
i.sh
	index 22487d90fdc..1da6b07a579 100755
	--- a/t/t7812-grep-icase-non-ascii.sh
	+++ b/t/t7812-grep-icase-non-ascii.sh
	@@ -60,7 +60,7 @@ test_expect_success GETTEXT_LOCALE,PCRE 'log --author wi=
th an ascii pattern on U
	        test_write_lines "forth" >file4 &&
	        git add file4 &&
	        git commit --author=3D"=C3=80 =C3=9A Thor <author@example.com>" -m=
 s=C3=A9cond &&
	-       git log -1 --color=3Dalways --perl-regexp --author=3D".*Thor" >log=
 &&
	+       git log -1 --color=3Dalways --perl-regexp --author=3D". . Thor" >l=
og &&
	        grep Author log >actual.raw &&
	        test_decode_color <actual.raw >actual &&
	        test_cmp expected actual

I.e. the whole point of using the color output to test this is to
discover where PCRE2 is going to consider a character boundary to be,
using .* means that it won't be tested at add, since .* will happily eat
up whatever arbitrary data it finds with or without UTF-8 mode.

Other tests added in that & adjacent (if any?) commits may have the same
issue, I haven't dug into it.

If we lead with that patch we'll get the test passing on master as
before, but with your patch above it'll break. I.e. the "when not
needed' in the $subject isn't true, it's just that the test is
completely broken.

In the context of this being a pretty urgent post-release fix (but I
don't know if Junio would consider a point-release, so perhaphs it's
not) I'd be OK with either of:

 A. Let's back out this new log grep color thing entirely while we
    reconsider this. The gitster/hm/paint-hits-in-log-grep topic
    currently reverts cleanly.

 B. Don't break the new log grep color thing, and also fix the 'grepping
    binary' regression (which is much more important than having A)

But let's not go for some in-between where we break the new feature to
the point of it being worse than the state of not having it at all in
v2.33.0.

I.e. without the that log grep color feature we wouldn't screw up the
display of non-ASCII characters in log output (yay), in v2.34.0 we
don't, but also color the match (yay), but we broke grepping binary
*files* (boo!).

I think the approach I suggested in [2] is a much more viable way
forward, i.e. let's stop fiddling with this giant nested if statement
that's mainly meant for the grep-a-file-case, revert to the
pre-log-grep-color state, and have the log-grep-color mode pass in a
"yes, I'd like the UTF-8 mode, please".

Having said that that's probably also broken, just in ways we're less
likely to spot (or maybe some of the log encoding settings/reencoding
saves us there?), we may need to have that ifdef'd to 10.34 and higher,
or have some opt-in setting for this.

1. https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/
2. https://lore.kernel.org/git/87v92bju64.fsf@evledraar.gmail.com/
