Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D317C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E38E608FC
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhDHTaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:30:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63944 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhDHTaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 15:30:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58A07115D73;
        Thu,  8 Apr 2021 15:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fwnAMSUqvDAf
        54wswR+znCT+15w=; b=NCaoT6RKBnRuTDcgy8uGNJoyQqXRKqHuztcfzi2i8gMw
        iSq2wdnCOEhA11A6uWTJ+1DtZAtvnwyl26gk5tHcbO9H+DDqvLntT867+jaCW/FG
        EaQ4XEYHNkpdkXk5bkvkfaNwK19UUWZ/9L+7alR8r+H/ooaV1wdeRTdC0z3Cty0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MNPOgc
        7KxgMuSYmyAyB2CwO5F31XBd5xs+2ShU4BBRHTorln2GtDSZjVrQTon3SNF/e1JE
        zEyxy9PURfNKkDDNTFkN90+XvH5+PmKcYpYu1oEtkKTQi0fQ/Rq9MewAgJ1hjaPS
        pbdt8gw8Dn9gUBk0H892Z8hDFBltyRn90nWOg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 517DB115D72;
        Thu,  8 Apr 2021 15:30:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C13DF115D6F;
        Thu,  8 Apr 2021 15:30:01 -0400 (EDT)
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
Subject: Re: [PATCH v5 4/9] userdiff: add and use for_each_userdiff_driver()
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
        <patch-04.10-1a3a61e389-20210408T145833Z-avarab@gmail.com>
Date:   Thu, 08 Apr 2021 12:29:59 -0700
In-Reply-To: <patch-04.10-1a3a61e389-20210408T145833Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 8 Apr
 2021 17:04:19 +0200")
Message-ID: <xmqq1rbktw08.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D013B7B6-98A0-11EB-9EF0-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +static int userdiff_find_by_namelen_cb(struct userdiff_driver *driver,
> +				       enum userdiff_driver_type type, void *priv)
>  {
> -	int i;
> -	for (i =3D 0; i < ndrivers; i++) {
> -		struct userdiff_driver *drv =3D drivers + i;
> -		if (!strncmp(drv->name, k, len) && !drv->name[len])
> -			return drv;
> -	}
> -	for (i =3D 0; i < ARRAY_SIZE(builtin_drivers); i++) {
> -		struct userdiff_driver *drv =3D builtin_drivers + i;
> -		if (!strncmp(drv->name, k, len) && !drv->name[len])
> -			return drv;
> +	struct find_by_namelen_data *cb_data =3D priv;
> +
> +	if (!strncmp(driver->name, cb_data->name, cb_data->len) &&
> +	    !driver->name[cb_data->len]) {
> +		cb_data->driver =3D driver;
> +		return 1; /* tell the caller to stop iterating */
>  	}
> -	return NULL;
> +	return 0;
> +}
> ...
> +enum userdiff_driver_type {
> +	USERDIFF_DRIVER_TYPE_BUILTIN =3D 1<<0,
> +	USERDIFF_DRIVER_TYPE_CUSTOM =3D 1<<1,
> +};
> +typedef int (*each_userdiff_driver_fn)(struct userdiff_driver *,
> +				       enum userdiff_driver_type, void *);

Makes sense.
