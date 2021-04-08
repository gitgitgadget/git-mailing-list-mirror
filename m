Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8242C43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD043610CB
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 18:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhDHSd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 14:33:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57295 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHSd0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 14:33:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08ECCB2842;
        Thu,  8 Apr 2021 14:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MFOPmawf5qbQ
        zmrCb/trqQEGdn0=; b=vXlSUq0Omf63u9AuD+yz6VzC0fnJamA0HY7nG2HZzW3a
        K8/2zzqL9X6H5ZWxhSzeHvaolXTADiSVB3piUyfakuCv3jXODEvIV1LOQqQicV/B
        95uPajjfCrZsR8niGBPAJ1A1y2dfxCQDL6a4fh42tUwulBmPGZIuogYXd3EgSDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=J98qog
        Loc+pgDNn8W3S6FWMLw/6oule6h15vCVO7n1G+/FYAJSs2dlNxecUyJyTB1fcWKw
        ZXUE0YQ7bJPG/Xp0tD62MJbSwqtbRsTNuQ4JykJ/T6quKbk4NxTmwTPVHeUe8rJs
        Tk3Dmh6fV687OmLozyHMv5jv2vNKUBR/6erdQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2D4EB2841;
        Thu,  8 Apr 2021 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7ACDAB2840;
        Thu,  8 Apr 2021 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 11:33:13 -0700
In-Reply-To: <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 15:34:28 +0200")
Message-ID: <xmqqa6q8tymu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E12CD238-9898-11EB-BF87-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add "tristate" functions to go along with the "bool" functions and
> migrate the common pattern of checking if something is "bool" or
> "auto" in various places over to the new functions.
>
> We also have e.g. "repo_config_get_bool" and
> "config_error_nonbool". I'm not adding corresponding "tristate"
> functions as they're not needed by anything, but we could add those in
> the future if they are.
>
> I'm not migrating over "core.abbrev" parsing as part of this
> change. When "core.abbrev" was made optionally boolean in
> a9ecaa06a7 (core.abbrev=3Dno disables abbreviations, 2020-09-01) the
> "die if empty" code added in g48d5014dd4 (config.abbrev: document the
> new default that auto-scales, 2016-11-01) wasn't adjusted. It thus
> behaves unlike all other "maybe bool" config variables.
>
> I have a planned series to start adding some tests for "core.abbrev",
> but AFAICT there's not even a test for "core.abbrev=3Dtrue", and I'd
> like to focus on thing that have no behavior change here, so let's
> leave it for now.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/log.c  | 13 +++++++------
>  compat/mingw.c |  6 +++---
>  config.c       | 16 ++++++++++++++++
>  config.h       | 12 ++++++++++++
>  http.c         |  5 +++--
>  userdiff.c     |  6 ++----
>  6 files changed, 43 insertions(+), 15 deletions(-)

> diff --git a/config.c b/config.c
> index fc28dbd97c..74d2b2c0df 100644
> --- a/config.c
> +++ b/config.c
> @@ -1257,6 +1257,14 @@ int git_parse_maybe_bool(const char *value)
>  	return -1;
>  }
> =20
> +int git_parse_maybe_tristate(const char *value)
> +{
> +	int v =3D git_parse_maybe_bool(value);
> +	if (v < 0 && !strcasecmp(value, "auto"))
> +		return 2;
> +	return v;
> +}

This is not parse_mayb_bool_text(), so "1" and "-1" written in the
configuration file are "true", "0" is "false", like the "bool" case.

I wonder if written without an unnecessary extra variable, i.e.

	if (value && !strcasecmp(value, "auto"))
		return 2;
	return git_parse_maybe_bool(value);

is easier to follow, though, as it is quite clear that it is mostly
the same as maybe_bool and the only difference is when "auto" is
given.

> +int git_config_tristate(const char *name, const char *value)
> +{
> +	int v =3D git_parse_maybe_tristate(value);
> +	if (v < 0)
> +		die(_("bad tristate config value '%s' for '%s'"), value, name);
> +	return v;
> +}

OK.

> diff --git a/config.h b/config.h
> index 19a9adbaa9..c5129e4392 100644
> --- a/config.h
> +++ b/config.h
> @@ -197,6 +197,12 @@ int git_parse_ulong(const char *, unsigned long *)=
;
>   */
>  int git_parse_maybe_bool(const char *);
> =20
> +/**
> + * Same as `git_parse_maybe_bool`, except that "auto" is recognized an=
d
> + * will return "2".
> + */
> +int git_parse_maybe_tristate(const char *);

A false being 0 and a true being 1 is understandable for readers
without symbolic constant, but "2" deserves to have a symbolic
constant, doesn't it?

> @@ -226,6 +232,12 @@ int git_config_bool_or_int(const char *, const cha=
r *, int *);
>   */
>  int git_config_bool(const char *, const char *);
> =20
> +/**
> + * Like git_config_bool() except "auto" is also recognized and will
> + * return "2"
> + */
> +int git_config_tristate(const char *, const char *);

Likewise.

Thanks.
