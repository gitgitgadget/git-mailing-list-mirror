Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A260C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 22:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350060AbiARWus (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 17:50:48 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62146 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiARWus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 17:50:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC83D17EC50;
        Tue, 18 Jan 2022 17:50:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K8pIn0RirIhJ
        DbBTcZ8lNbW5OVY3tECNUOn2XX7qunU=; b=FUZexrC+ZbICrqUcvnRRBAJ4mRjb
        MCmBjRZmOJGIyX5zkdQPb40BZAS6k5zZjpPp4gI51v3kH2SQp+9KHFHPtfRA/quu
        sF4EMQ/rQXfEvCyFm37GZD/S1crxnyL+MurQh6XtrmJonnZgrW40cVD1BToBmqYH
        fHRvUIpmw2sYYZ8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D51C117EC4F;
        Tue, 18 Jan 2022 17:50:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4ED9317EC4E;
        Tue, 18 Jan 2022 17:50:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v8 09/10] grep: simplify config parsing and option parsing
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
        <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
        <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
Date:   Tue, 18 Jan 2022 14:50:44 -0800
In-Reply-To: <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 18 Jan
 2022 16:55:21
        +0100")
Message-ID: <xmqq8rvcr73v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 124F2B1A-78B1-11EC-803F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
> grep.patternType configuration setting, 2012-08-03) we promised that:
>
>  1. You can set "grep.patternType", and "[setting it to] 'default'
>     will return to the default matching behavior".
>
>     In that context "the default" meant whatever the configuration
>     system specified before that change, i.e. via grep.extendedRegexp.
>
>  2. We'd support the existing "grep.extendedRegexp" option, but ignore
>     it when the new "grep.patternType" option is set. We said we'd
>     only ignore the older "grep.extendedRegexp" option "when the
>     `grep.patternType` option is set. to a value other than
>     'default'".

Extra period in the middle of a sentence after "set".

> As before both "grep.patternType" and "grep.extendedRegexp" are
> last-one-wins variable, with "grep.extendedRegexp" yielding to
> "grep.patternType", except when "grep.patternType=3Ddefault".
>
> Note that this applies as we parse the config, i.e. a sequence of:
>
>     -c grep.patternType=3Dperl
>     -c grep.extendedRegexp=3Dtrue \
>     -c grep.patternType=3Ddefault
>
> Should select ERE due to "grep.extendedRegexp=3Dtrue and

Downcase "S" in "should", as this is still in the middle of the
sentence that began with "Note that".

> grep.extendedRegexp=3Ddefault", not BRE, even though that's the

The second one should be "grep.patternType=3Ddefault".

> "default" patternType. We can determine this as we parse the config,

Drop "even though that's the default patternType".  You've already
explained that it is not what "default" for the "patternType" (which
any reader who has been following so far would take as a reference
to "grep.patternType") at all.  You can also drop ", not BRE," while
doing so.

> because:
>
>  * If we see "grep.extendedRegexp" we set the internal "ero" to its
>    boolean value.
>
>  * If we see "grep.extendedRegexp" but
>    "grep.patternType=3D[default|<unset>]" is in effect we *don't* set
>    the internal "pattern_type_option" to update the pattern type.
>
>  * If we see "grep.patternType!=3Ddefault" we can set our internal
>    "pattern_type_option" directly, it doesn't matter what the state of
>    "grep.extendedRegexp" is, but we don't forget what it was, in case
>    we see a "grep.patternType=3Ddefault" again.
>
>  * If we see a "grep.patternType=3Ddefault" we can set the pattern to
>    ERE or BRE depending on whether we last saw a
>    "grep.extendedRegexp=3Dtrue" or
>    "grep.extendedRegexp=3D[false|<unset>]".

That sounds complex enough, doesn't it?  The statement that opens
the proposed log mesage is "gets rid of complex parsing logic that
isn't needed", but the above sounds more like a complex logic is
being traded with another.

> diff --git a/grep.c b/grep.c
> index 60228a95a4f..bb487e994d0 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -48,6 +48,12 @@ static int parse_pattern_type_arg(const char *opt, c=
onst char *arg)
> =20
>  define_list_config_array_extra(color_grep_slots, {"match"});
> =20
> +static void adjust_pattern_type(enum grep_pattern_type *pto, const int=
 ero)
> +{
> +	if (*pto =3D=3D GREP_PATTERN_TYPE_UNSPECIFIED)
> +		*pto =3D ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
> +}
> +
>  /*
>   * Read the configuration file once and store it in
>   * the grep_defaults template.
> @@ -56,17 +62,22 @@ int grep_config(const char *var, const char *value,=
 void *cb)
>  {
>  	struct grep_opt *opt =3D cb;
>  	const char *slot;
> +	static int ero =3D -1;

Is this new reentrancy issue worth it?  I think it makes the whole
thing unnecessarily complex, compared to a more na=C3=AFve "we keep track
of the last-one-that-won for grep.extendedRegexp and
grep.patternType separately during option and config parsing inside
the grep_opt structure, and then combine the two when we compile the
pattern string into regexp or pcre object" approach.

Let's ask it in a different way.  What is this static, that is way
separated from all the members in the grep_opt structure, buying us?
Certainly not the ease of understanding what the code is doing.  Not
the size of the overall grep_opt structure (which we do not allocate
tons anyway).  Other than that fact that you can say "I did it my
own way, ignoring reviewer suggestions, I won!!!", I do not see any
upside with this code.

PUzzled.
