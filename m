Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6FBC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3F02089D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDlAEa91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfKUFXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:23:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58376 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUFXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 00:23:04 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 06569A24ED;
        Thu, 21 Nov 2019 00:22:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vM7uU7eh7/jc
        7ny3RRL+ixFCdUg=; b=TDlAEa91uiBg5Xdwigq/TtAZ1+NRNvhvVdNcturXdwmh
        4NfyFPXb2pgY6N6AQQFDKUClavNr1vOJqKC/q3g5yCmO0EtVb1G73z1+9iXMCqrz
        FTWhuiRIC74fxYa1UOJpcmAt1PY5fnPScsHbipq4atNKBflqCjF0b1a1i/TRVWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=EYhCcw
        rl5D+nABFzTdnmtOfu3V+AlrhNmEkf9n9M5z2J6Sh41QUFGakj9ZEsCmacXTZ0gF
        KFe5jvglte43D1rdpZ4zRNjWlIYG0SGB2AOoT3gQWADHfT/TwEy1skVykeBluDa8
        BS0N3V+Q791FVnI+/Xn+dfmp1cBAY0A1dQjxU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F348FA24EC;
        Thu, 21 Nov 2019 00:22:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28B20A24EB;
        Thu, 21 Nov 2019 00:22:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/8] builtin/config: collect "value_regexp" data in a struct
References: <cover.1573670565.git.martin.agren@gmail.com>
        <336eaa77e4974f84ea1eef473672e1d300f3a43d.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 14:22:52 +0900
In-Reply-To: <336eaa77e4974f84ea1eef473672e1d300f3a43d.1573670565.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 Nov 2019 19:55:03
 +0100")
Message-ID: <xmqqy2w9951v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8DA309A-0C1E-11EA-A9CD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> `git config` can take an optional "value_regexp". Collect the
> `regex_t`-pointer and the `do_not_match` flag into a new `struct
> cmd_line_value`.

A "struct cmd_line_value" sounded, to me at least during my first
reading, as if it is about all command line options, but that is not
at all what you meant to imply.  Is this only about the optional
value-regexp (if so perhaps calling it "value_regexp_option" would
have helped me avoid such a misunderstanding)?

> Rather than signalling/judging presence of a regexp by the NULL-ness of
> the pointer, introduce a `mode` enum.

OK.  Tangentially this makes readers wonder why the existing code
for key_regexp does not follow the same "NULL-ness" pattern but has
a separate use_key_regexp boolean.  It appears that the original
code is quite confused---it is totally outside the scope of this
series to clean it up and inject sanity into it though ;-)

>  static regex_t *key_regexp;
> -static regex_t *regexp;
> +static struct {
> +	enum { none, regexp } mode;

We often use the same identifier for a struct and an instance of the
struct, taking advantage of the fact that they live in separate
namespaces, but lowercase enumerated values like 'regexp' that
collides with the field name (and possibly a variable name used
elsewhere) smells a bit too much.

> +	regex_t *regexp;
> +	int do_not_match; /* used with `regexp` */
> +} cmd_line_value;
>  static int show_keys;
>  static int omit_values;
>  static int use_key_regexp;

> @@ -283,19 +288,21 @@ static int collect_config(const char *key_, const=
 char *value_, void *cb)
>  static int handle_value_regex(const char *regex_)
>  {
>  	if (!regex_) {
> -		regexp =3D NULL;
> +		cmd_line_value.mode =3D none;
>  		return 0;

Now we are back to relying on cmd_line_value.regexp staying to be
NULL after initialized, which is the state before the previous
patch.  If the end result is correct, then it is OK, I think, but
then the previous step shouldn't have added the NULL assignment here
in the first place.

>  	}
> =20
> +	cmd_line_value.mode =3D regexp;
> +
>  	if (regex_[0] =3D=3D '!') {
> -		do_not_match =3D 1;
> +		cmd_line_value.do_not_match =3D 1;
>  		regex_++;
>  	}
> =20
> -	regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
> -	if (regcomp(regexp, regex_, REG_EXTENDED)) {
> +	cmd_line_value.regexp =3D xmalloc(sizeof(*cmd_line_value.regexp));
> +	if (regcomp(cmd_line_value.regexp, regex_, REG_EXTENDED)) {
>  		error(_("invalid pattern: %s"), regex_);
> -		FREE_AND_NULL(regexp);
> +		FREE_AND_NULL(cmd_line_value.regexp);

Hmph.  !regexp in old code should mean cmd_line_value.mode=3D=3Dregexp
in the new world order after this patch is applied, no?  Should we
be treaking the mode field here before we leave?  I think it should
not matter, but thought it wouldn't hurt to ask.

In collect_config(), cmd_line_value.regexp is blindly passed to
regexec(3) as long as cmd_line_value.mode=3D=3Dregexp, so the invariant
"when .mode is regexp, .regexp must be valid, or collect_config() would
never be called for such cmd_line_value" is rather important to
avoid crashing ;-)

>  		return CONFIG_INVALID_PATTERN;
>  	}
> =20
> @@ -372,9 +379,9 @@ static int get_value(const char *key_, const char *=
regex_)
>  		regfree(key_regexp);
>  		free(key_regexp);
>  	}
> -	if (regexp) {
> -		regfree(regexp);
> -		free(regexp);
> +	if (cmd_line_value.regexp) {
> +		regfree(cmd_line_value.regexp);
> +		free(cmd_line_value.regexp);

Likewise.

>  	}
> =20
>  	return ret;
