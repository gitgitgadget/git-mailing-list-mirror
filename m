Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328D1C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE57E65253
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCHVzP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:55:15 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhCHVzD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:55:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CF5C111F22;
        Mon,  8 Mar 2021 16:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BDX9S7K54/e/
        RYOFVmyMpy96Glg=; b=KMVvGy1hhijOkE9LmoVXDVy6KX632gbK/Uoggu+fjjch
        XJQoJHzQfCS4dvf6COfeoTUHD9zp/n3U/ZbgHI7r7cjfEkMPtbWNPX/Xlib3FHbc
        uehENtkjzZiVbJxwfmAvgw8tITus8I7Xxp8Vyez8ngyWaa+cE8Zovb+QEll/DNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=jkI2KU
        IkkW3+u1QIs2pwLruPcMoZA2+DTZkM8Fih8QBnnTfYY4Mcw10oyWkG5kXWnPXUlk
        gL8wdo5PKYB2ID/CWO3IfHYpHsxdoeRTCZXjOWkN6vBCmGC8o7Gyl8Pf42I1Ei8+
        FFzM3jRpMZv9gVDsk6G/lEY3mioEe6/IkLS/s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 84945111F21;
        Mon,  8 Mar 2021 16:55:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BDBF1111F1B;
        Mon,  8 Mar 2021 16:54:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/7] oid_object_info(): return "enum object_type"
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
        <20210308200426.21824-4-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 13:54:58 -0800
In-Reply-To: <20210308200426.21824-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 21:04:22 +0100")
Message-ID: <xmqqwnuh48gd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EDACD7D6-8058-11EB-9819-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change oid_object_info() to return an "enum object_type", this is what
> it did anyway, except that it hardcoded -1 instead of an
> OBJ_BAD.
>
> Let's instead have it return the "enum object_type", at which point
> callers will expect OBJ_BAD. This allows for refactoring code that
> e.g. expected any "< 0" value, but would only have to deal with
> OBJ_BAD (=3D -1).

Hmph, I have a mixed feeling about this.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5ebf13359e8..1d989c62a4e 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -133,7 +133,7 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name,
> =20
>  	case 'p':
>  		type =3D oid_object_info(the_repository, &oid, NULL);
> -		if (type < 0)
> +		if (type =3D=3D OBJ_BAD)
>  			die("Not a valid object name %s", obj_name);

So, when oid_object_info() starts to return different negative value
to signal new kinds of errors, this codepath need to be changed, or
the control falls through to the rest of the case arm, which would
be worse than what the current code does (which is to die with less
specific error message).

> -		int type =3D oid_object_info(the_repository, &obj->oid, &size);
> -		if (type <=3D 0)
> +		enum object_type type =3D oid_object_info(the_repository, &obj->oid,=
 &size);
> +		if (type =3D=3D OBJ_BAD)
>  			die(_("did not receive expected object %s"),
>  			      oid_to_hex(&obj->oid));

Ditto.

And the issue is the same for all the other explicit comparison with
OBJ_BAD.  If we do it the other way around, i.e. leave these callers
as they are and add new negative return values to the function first,
and then convert "if negative, say error" to "if OBJ_BAD, say so,
else if we have this new type of error, say so", then the risk of
mistake becomes smaller.

But hopefully any such potential issue will be resolved by the end
of this short series, so as long as it won't be left as technical
debt, I am OK.
