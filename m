Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF4C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 13:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjAQNOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjAQNOO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 08:14:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A236099
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:14:13 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mp20so28652990ejc.7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 05:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9htOEF2sVDbm0fYG+x4/Z1l9iUxGWR8MwgTlk6mb1MY=;
        b=G9TsU/29LiHl1EFnuqfaFZ6y7iq3EWktOmbVFVQwnMvHwiFyW4XCWi37D3livwb6QI
         I8uGfAFGFxOvhBiAQZtTBW4ICyE/GBlwv+4nlFeJxDT5S6dRJvv35EE+8xF+M7ovlGr3
         f7AvMFrUh4te7rCejm39CKhZvhvas6zXrY2rnc+/1tlI7Chwsioj32VeBVxS0Lfl3nJS
         1GbZmZVfNQPxtwDrE8bVyS2/i2eJi6KN/zDx00B6wcrGpYwnJv80GI6eDD4UTOzkiech
         Y45ce/QMrupKTeK5FxupEphenyF85t/Ou4I8usNVYgziosNkYtQI91Mnr4IaMlYAfHH7
         XRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9htOEF2sVDbm0fYG+x4/Z1l9iUxGWR8MwgTlk6mb1MY=;
        b=W5sj97FYXg92tP3dXWeHXr5Pwl34AcJF1fQpbNwv186q32sJXyQ08WOYBahMbCzFzl
         ANAK1lYYfqWZ+ekZJE+ov4IgNQTF2fCcicW5tPsxMv9ZA0TlqeqtJHDpcs5PsYYrQfn0
         J2Iv+elU/BhO47kR9iC7gKN6kFLaauG/JW5Lt/PnxFhJUKZJbpugfAFrQpQpVYyDZXkS
         vvO+tFHttGLHpOvyn/lcyJG2ZaFJnBIepoOORXKDzde5z2MTFPMrnLEQ3S4MVorz4W+L
         GYOOenOlKy4Fa/eK5Mq+SdTMe1rhSjZqmtVput4mCjoyZQejSOjbYFLEt98eRVHkZIdM
         kHVQ==
X-Gm-Message-State: AFqh2kr4ZrbwNsrvWpBFVncOUGW51FDuMJWUBqsgDNUsF0HSRI6j9Hdx
        P3X9823Dse2lwOxwpl9f6BcNbmnlM1A=
X-Google-Smtp-Source: AMrXdXsNaoP540KdVCGJGbAtUw7G28umxPXzh5brrfRrMBy6jXz8DYJk2q23KP8bqCtDSoE6KhYhqg==
X-Received: by 2002:a17:906:3397:b0:86b:e50c:151b with SMTP id v23-20020a170906339700b0086be50c151bmr2634073eja.28.1673961251344;
        Tue, 17 Jan 2023 05:14:11 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k22-20020a17090646d600b0085fc3dec567sm7694305ejs.175.2023.01.17.05.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:14:10 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pHlmz-002e4H-2r;
        Tue, 17 Jan 2023 14:14:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
Date:   Tue, 17 Jan 2023 13:38:50 +0100
References: <20230108155217.2817-1-carenas@gmail.com>
 <20230117105123.58328-1-carenas@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230117105123.58328-1-carenas@gmail.com>
Message-ID: <230117.865yd5z4ke.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 17 2023, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> When UTF is enabled for a PCRE match, the PCRE2_UTF flag is used
> by the pcre2_compile() call, but that would only allow for the
> use of Unicode character properties when caseless is required
> but not to include the additional UTF characters for all other
> class matches.
>
> This would result in failed matches for expressions that rely
> on those properties, for ex:
>
>   $ git grep -P '\b=C3=86var'
>
> Add a configuration that could be used to enable the PCRE2_UCP
> flag to correctly match those cases, when required.
>
> The use of this has an impact on performance that has been estimated
> to be significant.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
> Changes since v2:
> * make setting UCP and opt-in as suggested by =C3=86var

To argue with myself here, I'm not so sure that just making this the
default isn't the right move, especially as the GNU grep maintainer
seems to be convinced that that's the right thing for grep(1).

We've usually just followed GNU grep semantics, so if it's doing X and
we're doing Y after this it's probably better to unify our behavior with
theirs.
=20=20=20=20=20=20=20=20
I was mainly concerned with the behavior change sneaking in as a mere
bugfix, I think it's OK if we change the behavior, as long as we're
going into it with our eyes open...

> * remove performance test and instead add a test

...I didn't follow the thread(s) where this may have been discussed, but
I for one would like to see a perf test with this, but maybe it was
removed for a good reason that I'm not aware of...



>  Documentation/config/grep.txt |  6 ++++++
>  grep.c                        | 11 ++++++++++-
>  grep.h                        |  1 +
>  t/t7810-grep.sh               | 13 +++++++++++++
>  4 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
> index e521f20390..8848db7311 100644
> --- a/Documentation/config/grep.txt
> +++ b/Documentation/config/grep.txt
> @@ -26,3 +26,9 @@ grep.fullName::
>  grep.fallbackToNoIndex::
>  	If set to true, fall back to git grep --no-index if git grep
>  	is executed outside of a git repository.  Defaults to false.
> +
> +pcre.ucp::
> +	If set to true, will use all Unicode Character Properties when matching
> +	`\w`, `\b`, `\d` or the POSIX classes (ex: `[:alnum:]`) and PCRE is used
> +	as the underlying engine. If PCRE is not being used it is ignored.
> +	Defaults to false

There's a couple of exceptions to this, but we tend to stick config docs
in their corresponding Documentation/config/<namespace>.txt, so this
should be in a new Documentation/config/pcre.txt if we're adding this
name.

But I'd rather that we don't expose the implementation detail that we're
using PCRE, which we haven't done so far. We just have a
"grep.patternType=3Dperl", which (and that's another issue, in any case)
we should explicitly mention here, i.e. that this is for use with that
config (and corresponding option(s)).

I think calling this e.g.:

	grep.perl.Unicode=3D<bool>
	grep.patternTypePerl.Unicode=3D<bool>

Or even:

	grep.patternTypePerl.Flags=3Du

Would be better, i.e. PCRE's C API is really just mapping to the flags
you can find in "perldoc perlre" (https://perldoc.perl.org/perlre). In
this case the /u flag maps to the "PCRE2_UCP" API flag.

That we happen to use PCRE to give ourselves "Perl" semantics is an
implementation detail we should avoid exposing, so we could either give
our config generic names, or literally map to the perl /flags/.

For now we could just die on any "Flags" value that isn't "u".

Of course all of this is predicated on us wanting to leave this as an
opt-in, which I'm not so sure about. If it's opt-out we'll avoid this
entire question,

> diff --git a/grep.c b/grep.c
> index 06eed69493..ceafb8937d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -102,6 +102,12 @@ int grep_config(const char *var, const char *value, =
void *cb)
>  			return config_error_nonbool(var);
>  		return color_parse(value, color);
>  	}
> +
> +	if (!strcmp(var, "pcre.ucp")) {
> +		opt->pcre_ucp =3D git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	return 0;
>  }
>=20=20
> @@ -292,8 +298,11 @@ static void compile_pcre2_pattern(struct grep_pat *p=
, const struct grep_opt *opt
>  		}
>  		options |=3D PCRE2_CASELESS;
>  	}
> -	if (!opt->ignore_locale && is_utf8_locale() && !literal)
> +	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
>  		options |=3D (PCRE2_UTF | PCRE2_MATCH_INVALID_UTF);
> +		if (opt->pcre_ucp)
> +			options |=3D PCRE2_UCP;
> +	}

This interaction with locale settings etc. is probably correct, but if
we're keeping the config etc. we should really document how this
interacts with those.

I.e. you might expect "-c grep.patternType=3Dperl -c
<whatever_the_setting_is>=3Dtrue" to give you UCP semantics, but we'll
ignore it based on these other criteria.

>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=3D2642 fixed in 10=
.36 */
> diff --git a/grep.h b/grep.h
> index 6075f997e6..082bd3a0c7 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -171,6 +171,7 @@ struct grep_opt {
>  	int file_break;
>  	int heading;
>  	int max_count;
> +	int pcre_ucp;
>  	void *priv;

The reason for why we have some "bool"-like settings (like "int
ignore_case") as an "int" as opposed to an "unsigned int <name>:1"
bitfield is because we need to take their address via the
parse_options() API.

But in this case it's a purely internal field, so (and again, if we're
keeping the option) let's use "unsigned int ...:1" here instead?

Unless that is, we're expecting a corresponding command-line option.

>=20=20
>  	void (*output)(struct grep_opt *opt, const void *data, size_t size);
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 8eded6ab27..a99a967060 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -95,6 +95,7 @@ test_expect_success setup '
>  	then
>  		echo "=C2=BF" >reverse-question-mark
>  	fi &&
> +	echo "=C3=A9motion" >ucp &&

Here we carry this file through the entirety ouf our tests...

>  	git add . &&
>  	test_tick &&
>  	git commit -m initial
> @@ -1474,6 +1475,18 @@ test_expect_success PCRE 'grep -P backreferences w=
ork (the PCRE NO_AUTO_CAPTURE
>  	test_cmp hello_world actual
>  '
>=20=20
> +test_expect_success PCRE 'grep -c pcre.ucp -P fixes \b' '
> +	cat >expected <<-\EOF &&
> +	ucp:=C3=A9motion

...only to use it in this one test, it clearly didn't harm anything (or
rather, I didn't run this, but I expect you did and it passed), but how
about avoiding more global state here doing:

	test_when_finished "rm -rf repo" &&
	git init repo &&
	test_commit -C repo msg ucp =C3=A9motion &&
	[...]

> +	EOF
> +	cat >pattern <<-\EOF &&
> +	\b=C3=A9motion
> +	EOF
> +	LC_ALL=3Den_US.UTF-8 git -c pcre.ucp=3Dtrue grep -P -f pattern >actual =
&&
> +	test_cmp expected actual &&
> +	LC_ALL=3Den_US.UTF-8 test_must_fail git grep -P -f pattern

This will break on platforms that don't have en_US.UTF-8 (and that's not
hypothetical, some systems will skip installing locales for various
reasons).

I see we have some almost recent breakage 1819ad327b7 (grep: fix
multibyte regex handling under macOS, 2022-08-26), but that one adds a
new MB_REGEX prereq, which presumably fails if we don't have this
locale.

You can just use the existing "GETTEXT_LOCALE", which will piggy-back on
our existing locale tests, or we could add a corresponding one for
en_US.UTF-8 and refactor the existing MB_REGEX to be in lib-gettext.sh
where it arguably belongs...

> +'
> +
>  test_expect_success 'grep -G invalidpattern properly dies ' '
>  	test_must_fail git grep -G "a["
>  '

