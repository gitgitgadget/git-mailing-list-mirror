Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C648C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE38B21D42
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bYvS7N12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLAUsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:48:40 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51814 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgLAUsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:48:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E412114C52;
        Tue,  1 Dec 2020 15:48:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Wl62vxnYF7OB
        kWdKtrNjnd0mAiw=; b=bYvS7N12rzCbEEnBMIsF4tW4O13+3ZpmQuOHNTkvmlz5
        cp6BhYymI1xZxu51E4B6NCcN/LQlphYDHQpMmYJoI0r2jVyya/AMZ+prc0CBV0tb
        Hax8vH9VSLqpmysbic6694QR7if4dBH9IyIUXpKTXSK5Q2WaGeIHL7Gem2oA/Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ufe0o7
        Oso47w7Uujo/IMMpq08TYAUvxsQMmsv0CAZNBHKJ2NkMrNJlqY3HsZKE/YerDbkK
        T1+xIfp5UIf6KkEN/o3/wHS6tvMuAsPvDb9JVbT5/QwXK14vekgZVZa2DXrvFRPO
        xGDLsGLXnMkUOQjwoBVe8KZuBMOIn0lY/pTJU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 15A49114C51;
        Tue,  1 Dec 2020 15:48:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E3F4114C50;
        Tue,  1 Dec 2020 15:47:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 09/10] mktag: use fsck instead of custom verify_tag()
References: <20201126012854.399-1-avarab@gmail.com>
        <20201126222257.5629-10-avarab@gmail.com>
Date:   Tue, 01 Dec 2020 12:47:55 -0800
In-Reply-To: <20201126222257.5629-10-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 26 Nov 2020 23:22:56 +0100")
Message-ID: <xmqqk0u1nthg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E12FA24-3416-11EB-A498-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the validation logic in "mktag" to use fsck's fsck_tag()
> instead of its own custom parser. Curiously the logic for both dates
> back to the same commit[1]. Let's unify them so we're not maintaining
> two sets functions to verify that a tag is OK.
>
> Moving to fsck_tag() required teaching it to optionally use some
> validations that only the old mktag code could perform. That was done
> in an earlier commit, the "extraHeaderEntry" and
> "extraHeaderBodyNewline" tests being added here make use of that
> logic.
>
> There was other "mktag" validation logic that I think makes sense to
> just remove. Namely:

I may not agree with the specifics in this list, but I agree that
the validation should be consistent between mktag and fsck.

> +	switch (msg_type) {
> +	case FSCK_WARN:
> +	case FSCK_ERROR:
> +	case FSCK_EXTRA:
> +		/*
> +		 * We treat both warnings and errors as errors, things
> +		 * like missing "tagger" lines are "only" warnings
> +		 * under fsck, we've always considered them an error.
> +		 */

This is a good comment and design decision. =20

As far as I am concerned, the only reason we warn on a missing
tagger line without erroring out is because very early versions of
Git did allow creating such tag objects, and there are annotated
tags in the wild that lack the tagger line.

> +		fprintf_ln(stderr, "error: tag input does not pass fsck: %s", messag=
e);
> +		return 1;
> +	default:
> +		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
> +		    msg_type);
>  	}
> -	return ret;
>  }
> =20
> -static int verify_tag(char *buffer, unsigned long size)
> ...
> -	/* timezone, 5 digits [+-]hhmm, max. 1400 */
> -	if (!((tagger_line[0] =3D=3D '+' || tagger_line[0] =3D=3D '-') &&
> -	      strspn(tagger_line+1, "0123456789") =3D=3D 4 &&
> -	      tagger_line[5] =3D=3D '\n' && atoi(tagger_line+1) <=3D 1400))
> -		return error("char%"PRIuMAX": malformed tag timezone",
> -			(uintmax_t) (tagger_line - buffer));
> -	tagger_line +=3D 6;
> -
> -	/* Verify the blank line separating the header from the body */
> -	if (*tagger_line !=3D '\n')
> -		return error("char%"PRIuMAX": trailing garbage in tag header",
> -			(uintmax_t) (tagger_line - buffer));
> =20
> -	/* The actual stuff afterwards we don't care about.. */
> -	return 0;

I do not see the "we do not want more than one blank line after the
header" in the original, which was one thing I was looking for after
seeing what 08/10 did.

> +	fsck_options.extra =3D 1;
> +	fsck_options.error_func =3D mktag_fsck_error_func;

I wonder if we really need the new .extra bit member in the
fsck_options.  Wouldn't it be sufficient to instead teach
fsck_error_func() that the extra level is a non-event?

