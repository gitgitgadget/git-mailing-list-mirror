Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1896EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 19:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjGGTG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 15:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjGGTGy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 15:06:54 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDA2128
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 12:06:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 721BC197CB3;
        Fri,  7 Jul 2023 15:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WA2Y3qU4F0OQ
        D2vzlVb0gpkY/7p52J8B7c9e0r1X19g=; b=KgMY+GBbdaZ4+gEFjA622bO0P//g
        6rmkBHeb38zUu/i1ZQYX8n2neFNNk7wNTyHHfvofSZumIlQQ+l/ewMlIMSfW1bsD
        I2Cvjgj1zWvlzVzH/QwsEtyuemLO3B4ijahzYr1J/fb+Z3/AhFEP513fbweERrnS
        T2Hc7s66spZzajg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68251197CB2;
        Fri,  7 Jul 2023 15:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C57BB197CB0;
        Fri,  7 Jul 2023 15:06:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] pretty: avoid double negative in format_commit_item()
References: <8d4fcad1-5f71-4790-17ee-e9ba0a3118dc@web.de>
Date:   Fri, 07 Jul 2023 12:06:37 -0700
In-Reply-To: <8d4fcad1-5f71-4790-17ee-e9ba0a3118dc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Jul 2023 20:46:26 +0200")
Message-ID: <xmqqcz138rsy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 669049C8-1CF9-11EE-B0A1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Test for equality with no_flush, which has enough negation already.  Ge=
t
> rid of the unnecessary parentheses while at it.

Makes sense.  This double negation was with us since a5752342
(pretty: support padding placeholders, %< %> and %><, 2013-04-19),
that is more than 10 years old ;-)

Will queue.

Thanks.

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  pretty.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/pretty.c b/pretty.c
> index 7862be105d..81cdc9f2cd 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1855,10 +1855,10 @@ static size_t format_commit_item(struct strbuf =
*sb, /* in UTF-8 */
>  	}
>
>  	orig_len =3D sb->len;
> -	if ((context)->flush_type !=3D no_flush)
> -		consumed =3D format_and_pad_commit(sb, placeholder, context);
> -	else
> +	if (context->flush_type =3D=3D no_flush)
>  		consumed =3D format_commit_one(sb, placeholder, context);
> +	else
> +		consumed =3D format_and_pad_commit(sb, placeholder, context);
>  	if (magic =3D=3D NO_MAGIC)
>  		return consumed;
>
> --
> 2.41.0
