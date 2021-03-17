Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40ADC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D33864F59
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhCQSpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:45:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57830 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhCQSpI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:45:08 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3DBA311948B;
        Wed, 17 Mar 2021 14:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VF6L7Gtf7XlL
        KKAfY8C45mAmZUg=; b=WkN0WIWqAn5kjAktFAG+mf4DlFJrUs6Uu+UzKYgv9QzF
        qKpfED2BT4HgxsB7QOR/GXojhH1gwmqPMHHP8l8IZymuSLVsMJnRnIAhSX7akpPA
        VBYFrFEti3eo3tCpgl3XPOVCdmtHkCpap5sCqpAocFKwcMUZ9/JvxGCKawp83gs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Krg9jj
        zmenoQgHxUxr4zuAkCPzXGXe5xpG3ZqJ+maeVEWN/Cce5s6zNmNGrAMoBtUdHW4B
        9PHiu6speB2va6OuWfM0eG9BgehjWmCIRPi72Z7XM+rjB/PK136IRQXO5S7vZBDe
        KXUwTeZwnWUoPCRVLUu28wxgd1lbYnviqARYo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36C27119489;
        Wed, 17 Mar 2021 14:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 646D7119488;
        Wed, 17 Mar 2021 14:45:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 08/22] fsck.c: move definition of msg_id into
 append_msg_id()
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-9-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:45:02 -0700
In-Reply-To: <20210316161738.30254-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:24 +0100")
Message-ID: <xmqqsg4tvcup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E3394A56-8750-11EB-98A5-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Refactor code added in 71ab8fa840f (fsck: report the ID of the
> error/warning, 2015-06-22) to resolve the msg_id to a string in the
> function that wants it, instead of doing it in report().

This reintroduces the same confusion 07/22 tried to get rid of,
unless msg_id variable is renamed to msg_id_str in this step,
instead of being left to the next step, no?


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 0a9ac9ca07..b977493f57 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -264,8 +264,9 @@ void fsck_set_msg_types(struct fsck_options *option=
s, const char *values)
>  	free(to_free);
>  }
> =20
> -static void append_msg_id(struct strbuf *sb, const char *msg_id)
> +static void append_msg_id(struct strbuf *sb, enum fsck_msg_id id)
>  {
> +	const char *msg_id =3D msg_id_info[id].id_string;
>  	for (;;) {
>  		char c =3D *(msg_id)++;
> =20
> @@ -308,7 +309,7 @@ static int report(struct fsck_options *options,
>  	else if (msg_type =3D=3D FSCK_INFO)
>  		msg_type =3D FSCK_WARN;
> =20
> -	append_msg_id(&sb, msg_id_info[id].id_string);
> +	append_msg_id(&sb, id);
> =20
>  	va_start(ap, fmt);
>  	strbuf_vaddf(&sb, fmt, ap);
