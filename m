Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56429C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 12:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbjAIMRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 07:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbjAIMRq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 07:17:46 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038F23E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 04:17:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s9so7945289wru.13
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 04:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6FM4ode4z9XvpMbkwv8gUrDG/eDbYEnqHfmVDyiMfMs=;
        b=G8sZwJ/QhrGdvyFyUuC0bpLb3Tmz6xNsInXJh0GGNnkfkYM65mqOes0L+zm16fSJxe
         OU9bMKDTWMuoQ/qM1xS5FzXr+vPmKdYCGhu2qpP2KmaNPv8dfjICXg0rDQJ4H0JE9dso
         z1GjkmEjSf7ErO5nIWeDJCA26Za12e6V3k1C3CeXcmnTW6It69sT3wH9OSCGD32YONnb
         qZoOd4PvmvPK1xy3H6uuodcGzA8maPe5oR8LMEOZgMy0svfwxN4P+2MOYGliSSusMCsZ
         IFpbxK1WENXAAto4xdsHUk2UdZ8jARgYNeHNeJmI0r0MbfgJsUH3PVNuZuDsLgsLAaIR
         8FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6FM4ode4z9XvpMbkwv8gUrDG/eDbYEnqHfmVDyiMfMs=;
        b=cLyemnuYb0PJ/Hx0ZNj06VgZJkMxzXD3hHRn842CXTBrYh7CAjemBCmcdaAXcJ/Ynb
         9yq0GSgE8UJ0UOJJ8AEcgWCtm2eN5qw0YwDTPVKmZufr2a5VwwwKbKc5BXyu4/HQ8euo
         4bHBFjESi1lQWEoVVMa/3qn2EC7JU8ryAGjC9NHfasYDhInElne+8oiESnHDkIW0EJPc
         i9MvFOIDU5A3JIbzGmcaR2UgQ4c4E1PN+pRIMImkE/eeJDh3zQ27BJbqsy0yPT3QGbWb
         S1Uzyvl+jpdtka5CtSlOtVQH00yBJvGoMawD87RXXOgKsFH5EItqKBS/3FHAlihJ+/jc
         sTdw==
X-Gm-Message-State: AFqh2ko9pMjtf2nEpbS6lysMxYonC9AkoQAqFgrWrsyuzh61E9EpNi1e
        Go3CJwni2miwLJjWWjSzFFcFlHrwG10=
X-Google-Smtp-Source: AMrXdXuxydozZmGlzg24dWp9mmZ1rdkRLma87wEuyDeIia3LVN0uz1XuTBmCq4sM/JrFiqU8SPVPbg==
X-Received: by 2002:a5d:5d10:0:b0:242:5b1f:3dcf with SMTP id ch16-20020a5d5d10000000b002425b1f3dcfmr55685723wrb.63.1673266661060;
        Mon, 09 Jan 2023 04:17:41 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w5-20020a05600018c500b002420dba6447sm8395393wrq.59.2023.01.09.04.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:17:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pEr5v-0003T0-2o;
        Mon, 09 Jan 2023 13:17:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, bug-grep@gnu.org,
        demerphq <demerphq@gmail.com>, pcre-dev@exim.org
Subject: Re: [PATCH v2] grep: correctly identify utf-8 characters with
 \{b,w} in -P
Date:   Mon, 09 Jan 2023 12:35:05 +0100
References: <20230108062335.72114-1-carenas@gmail.com>
 <20230108155217.2817-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230108155217.2817-1-carenas@gmail.com>
Message-ID: <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 08 2023, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> When UTF is enabled for a PCRE match, the corresponding flags are
> added to the pcre2_compile() call, but PCRE2_UCP wasn't included.
>
> This prevents extending the meaning of the character classes to
> include those new valid characters and therefore result in failed
> matches for expressions that rely on that extention, for ex:
>
>   $ git grep -P '\b=C3=86var'
>
> Add PCRE2_UCP so that \w will include =C3=86 and therefore \b could
> correctly match the beginning of that word.
>
> This has an impact on performance that has been estimated to be
> between 20% to 40% and that is shown through the added performance
> test.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  grep.c                              |  2 +-
>  t/perf/p7822-grep-perl-character.sh | 42 +++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100755 t/perf/p7822-grep-perl-character.sh
>
> diff --git a/grep.c b/grep.c
> index 06eed69493..1687f65b64 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -293,7 +293,7 @@ static void compile_pcre2_pattern(struct grep_pat *p,=
 const struct grep_opt *opt
>  		options |=3D PCRE2_CASELESS;
>  	}
>  	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> -		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> +		options |=3D (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);

I have a definite bias towards liking this change, it would help my find
myself :)

But I don't think it's safe to change the default behavior "git-grep",
it's not a mere bug fix, but a major behavior change for existing users
of grep.patternType=3Dperl. E.g. on git.git:
=09
	$ diff <(git -P grep -P '\d+') <(git -P grep -P '(*UCP)\d')
	53360a53361,53362
	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=91=E8=A1=8C: =E4=BD=95=E3=82=92=E3=
=81=97=E3=81=9F=E3=81=8B=E3=80=81=E3=82=92=EF=BC=91=E8=A1=8C=E3=81=A7=E8=A6=
=81=E7=B4=84=E3=80=82\n"
	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD\n"

So, it will help "do the right thing" on e.g. "\b=C3=86", but it will also
find e.g. CJK numeric characters for \d etc.

I see per the discussion on
https://github.com/PCRE2Project/pcre2/issues/185 and
https://lists.gnu.org/archive/html/bug-grep/2023-01/threads.html that
you submitted similar fixes to GNU grep & PCRE itself.

I see that GNU grep integrated it a couple of days ago as
https://git.savannah.gnu.org/cgit/grep.git/commit/?id=3D5e3b760f65f13856e57=
17e5b9d935f5b4a615be3

As most discussions about PCRE will eventually devolve into "what does
Perl do?": "Perl" itself will promiscuously use this behavior by
default.

E.g. here the same "=EF=BC=91" character (not the ASCII digit "1") will be
matched from the command-line:

	$ perl -Mre=3Ddebug -CA -wE 'shift =3D~ /\d/' "=EF=BC=91"
	Compiling REx "\d"
	Final program:
	   1: POSIXU[\d] (2)
	   2: END (0)
	stclass POSIXU[\d] minlen 1
	Matching REx "\d" against "%x{ff11}"
	UTF-8 string...
	Matching stclass POSIXU[\d] against "%x{ff11}" (3 bytes)
	   0 <> <%x{ff11}>           |   0| 1:POSIXU[\d](2)
	   3 <%x{ff11}> <>           |   0| 2:END(0)
	Match successful!
	Freeing REx: "\d"

But I don't think it makes sense for "git grep" (or GNU "grep") to
follow Perl in this particular case.

For those not familiar with its Unicode model it doesn't assume by
default that strings are Unicode, they have to be explicitly marked as
such. in the above example I'm declaring that all of "argv" is UTF-8
(via the "-CA" flag).

If I didn't supply that flag the string wouldn't have the UTF-8 flag,
and wouldn't match, as the Perl regex engine won't use Unicode semantics
except on Unicode target strings.

Even for Perl, this behavior has been troublesome. Opinions differ, but
I think many would agree (and I've CC'd the main authority on Perl's
regex engine) that doing this by default was *probably* a mistake.

You almost never want "everything Unicode considers a digit", and if you
do using e.g. \p{Nd} instead of \d would be better in terms of
expressing your intent. I see you're running into this on the PCRE
tracker, where you're suggesting that the equivalent of /a (or /aa)
would be needed.

	https://github.com/PCRE2Project/pcre2/issues/185#issuecomment-1374796393


Which brings me home to the seeming digression about "Perl"
above.

Unlike a programming language where you'll typically "mark" your data as
it comes in, natural text as UTF-8, binary data as such etc., a "grep"
utility has to operate on more of an "all or nothing" basis (except in
the case of "-a"). I.e. we're usually searching through unknown data.

Enabling this by default means that we'll pick up characters most people
probably wouldn't expect, particularly from near-binary data formats
(those that won't require "-a", but contain non-Unicode non-ASCII
sequences).

I don't have some completely holistic view of what we should do in every
case, e.g. we turned on PCRE2_UTF so that things like "-i" would Just
Work, but even case-insensitivity has its own unexpected edge cases in
Unicode.

But I don't think those edge cases are nearly as common as those we'd
run into by enabling PCRE2_UCP. Rather than trying to opt-out with "/a"
or "/aa" I think this should be opt-in.

As the example at the start shows you can already do this with "(*UCP)"
in the pattern, so perhaps we should just link to the pcre2pattern(3)
manual from git-grep(1)?
