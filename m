Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83084C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 12:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 504A0610FB
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 12:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbhDIMxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 08:53:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56989 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhDIMxX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 08:53:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07916134581;
        Fri,  9 Apr 2021 08:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=MUq5eD2RUt3Wo55IDjl2VnjQq
        Ro=; b=kYKCRvjvhVTyqN5szArcGYax5krGRpbnhqoHdkGJjdLGkuAxQC0NN+EYN
        KuO93kp2mAHag5DaS+oJywcZ3FnZSNKfkOWyoCdHt2GJ+VndqlqUT9o2B+pdh6qE
        E8xRcy5teMY71kt1jT1o88Ts7yTcopEHdARa/8frgz2qnLdh1A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=iqmzgHmv9O1YitZHGxP
        /oSbXZo7amp2hkIhU5amZFb5jUBW/2pBr3qxD2F6MVwISE4Mi5QhTzPNEWxeTx+n
        wJ9i2xieoUfaWaLtnj+sRuSYKKqNo+7Fkj6wKRZyGqk1miJEhzvsbia7cMgxh+q+
        5N7IwtegaUt3JzwWsAWZU/BU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 00B72134580;
        Fri,  9 Apr 2021 08:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4591F13457F;
        Fri,  9 Apr 2021 08:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lin Sun <lin.sun@zoom.us>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] config.c: add a "tristate" helper
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
        <patch-4.6-222e91e11b-20210408T133125Z-avarab@gmail.com>
        <xmqqa6q8tymu.fsf@gitster.g> <875z0wicmp.fsf@evledraar.gmail.com>
        <xmqqtuogpc6f.fsf@gitster.g> <87o8eogs2r.fsf@evledraar.gmail.com>
Date:   Fri, 09 Apr 2021 05:53:05 -0700
Message-ID: <xmqq35vzoc0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 87F03616-9932-11EB-9CA4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The benefit in this case is to human readers of the code who know
> they're being helped by the enum checking in "case" arms.

Well, do we have tristate that is handled with switch/case?  And
more importantly, do tristates benefit from getting handled with
switch/case?

The one I cited as an existing example to decide that we should
favour "special case 'auto' and then let it fall through to the
normal bool" is in userdiff.c

        static int parse_tristate(int *b, const char *k, const char *v)
        {
                if (v && !strcasecmp(v, "auto"))
                        *b =3D -1;
                else
                        *b =3D git_config_bool(k, v);
                return 0;
        }

and the caller uses it to set -1/0/1 in driver->binary member.

And the member is often used like so:

	... else if (userdiff->binary !=3D -1) {
		is_binary =3D userdiff->binary;
	} else {
		is_binary =3D auto_detect_based_on_contents(...);
	}
	if (is_binary) {
		... do the binary thing ...
	}

This is because "auto" is the only value among the three that needs
"preprocessing" before it is turned into a concrete yes/no that is
usable in the downstream code.  So with AUTO being the only spelled
out value, a construct like this:

	if ((driver->binary !=3D TRISTATE_AUTO)=20
	    ? driver->binary : auto_detect())
		...; /* do the binary thing */
	else
		...; /* do the non-binary thing */

would be sufficient to help human readers.  You do not need enum
to help, and you do not need switch/case.

You could use switch/case with enum if you really wanted to, but

	switch (temp =3D driver->binary) {
	case TRISTATE_AUTO:
		temp =3D auto_detect();
                break; /* ????? */
	case TRISTATE_FALSE:
		/* do the non-binary thing */
		...;
		break;
	case TRISTATE_TRUE:
		/* do the binary thing */
		...;
		break;
	}

would not be a useful construct for the "auto" use case, where
tristate is used to mean "we cannot decide at the configuration
time, as the appropriate value depends on other factors that are
available when it actually is used, e.g. the contents in the buffer,
if fd=3D1 is connected to the terminal, etc."

If you really wanted to, you could still use switch/case for such a
use case, perhaps like this:

	switch (temp =3D driver->binary) {
	case TRISTATE_AUTO:
		temp =3D auto_detect();
		/* fallthrough */
	default:
		if (!temp) { /* TRISTATE_FALSE */
			/* do the non-binary thing */
			...;
		} else { /* TRISTATE_TRUE */
			/* do the binary thing */
			...;
		}
		break;
	}

and switch may help making sure that all enum values are handled,
but I do not see a value in it.  The earlier code that used "if
auto, run autodetect, otherwise use the value as is" as the
condition for an if/else statement would be far easier to follow,
and equally safe.

> ... in config.c in the future it makes sense to pass a pointer to a
> "is_auto" parameter to these new tristate() functions, similar to
> e.g. the existing git_config_bool_or_int().

I am not sure what you are trying to gain by introducing is_auto
here.

For bool_or_int(), is_bool pointer makes perfect sense, because the
value spelled as "true" cannot be anything but bool, but "1" can be
either boolean true or an integer.  An extra is_bool bit can be used
by callers that care if the user said "true/yes" or "1" and want to
behave differently, when the configuration can take either bool or
integer.  For example, if you originally have a "do you want this
operation to be verbose?" yes/no variable, and later extended it to
add verbosity level, "yes/true" might mean "yes, please use the
default verbosity level", while "1", "2", ... would mean "yes, and
please set the verbosity level to this number".  And the default
verbosity level may not be "1", so the distinction between "yes" and
"1" does matter.

I do not see such a disambiguation need for tristate parsing, so the
immense usefulness of is_bool is not a good analogy to draw value for
the proposed is_auto from.

Thanks.
