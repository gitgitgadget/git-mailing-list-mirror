Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAA7A20987
	for <e@80x24.org>; Thu, 29 Sep 2016 17:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934266AbcI2Rbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:31:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63319 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933853AbcI2Rbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E229D41661;
        Thu, 29 Sep 2016 13:31:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HrxlYOdVHWVk
        R1rtjadKusvtBJE=; b=oL+yi5k0zxN540/adQ0BQVq6O9cukk1zWIO6q6orx9bS
        0mZs3N6kHLRFJScruO/WTylLFsMWOehc6wtX1gS2BXiHUHu+u6M5uk/EfOXfzT+E
        WJgSk4r2XbkG6Hiiyl1sp+BiJ/2V458KVcmWrKigxJE5ACJ9iNsP/wL7XIhAhxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U5OaML
        RcLkCSj5T9aMYoCQ47db5nHmgZpXEpDRAE1g7CC13P106k4jomeuFobqJaIN9zOQ
        QqdcD7dbAh8mK/tlcPrUT4YboMJ7VEksYaKusN6WVkwrolo3IMzZOG8VpT8qi165
        Kye9Ix57BCc7jRlfteGBzSGy2WfPpydofPluE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D912641660;
        Thu, 29 Sep 2016 13:31:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 645394165F;
        Thu, 29 Sep 2016 13:31:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pretty: allow formatting names as initials
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
        <20160929083654.nofgkn6kwb7bavzk@sigill.intra.peff.net>
Date:   Thu, 29 Sep 2016 10:31:30 -0700
In-Reply-To: <20160929083654.nofgkn6kwb7bavzk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 29 Sep 2016 04:36:54 -0400")
Message-ID: <xmqq37kihatp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 90237684-866A-11E6-B480-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Initials are shorter and often unique enough in a
> per-project setting, so they can be used to give a more
> informative version of --oneline.
>
> The 'S' in the placeholder is for "short" (and 's' is
> already taken by DATE_SHORT), but obviously that's pretty
> arcane.
>
> Possibly there should be more customization of initials,
> asking for only 2-letter initials, etc.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> When I first tested it with "git log --format=3D%aS" I had to wonder "w=
ho
> the heck is ntnd?". So using only the first-and-last would match the gi=
t
> project's practice better, at least.

And there is also "isalpha() good enough?" question.

I think we have a few Chinese and Hangul as well as Cyrillic names
in our history, some of them having outside-ascii first letters.
One of the more prolific contributor's initial is =C3=86AB ;-)

>  pretty.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/pretty.c b/pretty.c
> index c532c17..de62405 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -674,6 +674,23 @@ static int mailmap_name(const char **email, size_t=
 *email_len,
>  	return mail_map->nr && map_user(mail_map, email, email_len, name, nam=
e_len);
>  }
> =20
> +static void format_initials(struct strbuf *out, const char *name, size=
_t len)
> +{
> +	int initial =3D 1;
> +	size_t i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		char c =3D name[i];
> +		if (isspace(c)) {
> +			initial =3D 1;
> +			continue;
> +		}
> +		if (initial && isalpha(c))
> +			strbuf_addch(out, tolower(c));
> +		initial =3D 0;
> +	}
> +}
> +
>  static size_t format_person_part(struct strbuf *sb, char part,
>  				 const char *msg, int len,
>  				 const struct date_mode *dmode)
> @@ -702,6 +719,10 @@ static size_t format_person_part(struct strbuf *sb=
, char part,
>  		strbuf_add(sb, mail, maillen);
>  		return placeholder_len;
>  	}
> +	if (part =3D=3D 'S') {
> +		format_initials(sb, name, namelen);
> +		return placeholder_len;
> +	}
> =20
>  	if (!s.date_begin)
>  		goto skip;
