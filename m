Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6DC433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 04:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B5A9619C2
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 04:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhCXEvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 00:51:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57361 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhCXEui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 00:50:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54B011301C3;
        Wed, 24 Mar 2021 00:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=w/kZ60kJnmhb
        0LjUBuFYqb+p1dI=; b=R7Jq5VdN7/vFUyw8YofeEDVgCqBYA5rQqak9xYwCfuqw
        oCKFgihVdN9QQ942Vz0f3pQFsOkExMeLQ1dpkATUP/lLgq4DdkBf34Yd/nMCbfBW
        jaluy+PSUU8UEgbhb67aOQ0wPAKfoObE4b6PnRn8nqc2aiALjm+doHvIaWqIBpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MZvswN
        YzEjG8z/HdYAtC0f+FSvrfYfFJLdHlLmjuPCLZyO7B5RgmEUPPrzEZQlbEs2rxm/
        EnbbcT1JJlPknRr71v1rOWMJ/++aN+E0e9tMqkGtXF3irjmjYPDe/yxy/LcU2Y/X
        cHFQCfQuGdWpiwpqjMg7CepKdMIHpLZ7esnbg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4D23E1301C2;
        Wed, 24 Mar 2021 00:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94AE313019D;
        Wed, 24 Mar 2021 00:50:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v4 05/10] userdiff: add and use for_each_userdiff_driver()
References: <20210224195129.4004-1-avarab@gmail.com>
        <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
Date:   Tue, 23 Mar 2021 21:50:32 -0700
In-Reply-To: <patch-05.11-64ea5e8443f-20210324T014604Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 24 Mar
 2021 02:48:47
        +0100")
Message-ID: <xmqqtup1yx2f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7830A324-8C5C-11EB-8C2C-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +struct for_each_userdiff_driver_cb {
> +	const char *k;
> +	size_t len;
> +	struct userdiff_driver *driver;
> +};

Makes me wonder if we want to rename s/k/name/;

> +static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
> +				       enum userdiff_driver_type type, void *priv)
>  {
> +	struct for_each_userdiff_driver_cb *cb_data =3D priv;
> +
> +	if (!strncmp(driver->name, cb_data->k, cb_data->len) &&
> +	    !driver->name[cb_data->len]) {
> +		cb_data->driver =3D driver;
> +		return -1; /* found it! */
>  	}
> -	return NULL;
> +	return 0;
> +}

Makes sense.

> +static struct userdiff_driver *userdiff_find_by_namelen(const char *k,=
 size_t len)
> +{
> +	struct for_each_userdiff_driver_cb udcbdata =3D { .k =3D k, .len =3D =
len, .driver =3D NULL };

No need to explicitly spell the zero initialization.  Wrapping it
like this:

	struct for_each_userdiff_driver_cb udcbdata =3D {
		.k =3D k, .len =3D len
	};

would avoid the overlong line.

> +
> +	for_each_userdiff_driver(userdiff_find_by_namelen_cb,
> +				 USERDIFF_DRIVER_TYPE_UNSPECIFIED, &udcbdata);
> +	return udcbdata.driver;


> @@ -373,3 +385,28 @@ struct userdiff_driver *userdiff_get_textconv(stru=
ct repository *r,
> =20
>  	return driver;
>  }
> +
> +int for_each_userdiff_driver(each_userdiff_driver_fn fn,
> +			     enum userdiff_driver_type type, void *cb_data)
> +{
> +	int i, ret;
> +	if (type & (USERDIFF_DRIVER_TYPE_UNSPECIFIED | USERDIFF_DRIVER_TYPE_C=
USTOM)) {

I presume that the concrete ones are bitmask (i.e. BUILTIN occupies
bit #0 while CUSTOM occupies bit #1, or something like that).  Then

    #define USERDIFF_DRIVER_TYPE_UNSPECIFIED (-1)

would make this (and the other) condition far easier to read, i.e.

	if (type & USERDIFF_DRIVER_TYPE_CUSTOM) {
		... if the caller wants to iterate over "custom" drivers
		... do these things

