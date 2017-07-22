Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C319E1F89D
	for <e@80x24.org>; Sat, 22 Jul 2017 15:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdGVPye (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 11:54:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65486 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750838AbdGVPye (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 11:54:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3424A1AC6;
        Sat, 22 Jul 2017 11:54:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=n8KSsRGa0+cb
        Sds1fXt/8uikll0=; b=i6TQchh+gF0egn1lc8aQDBocXcn70ACRBcy6x3B5fUKi
        3wAWNah2HoVE0rix7k198Zb+W9I8C/4TS4LfWfeStC472Z/MFnHhR5wQtgQ9lreY
        mrff7Uknk0fXUsDIGyxXPj55xGfm70xMFx4sQzUqu+EclvVG7jt/KKZ+XVaS164=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PhOH/g
        gLGWJeqZDbcSWD6CzYKnx8GKFV3ZYnTJSBTbDe98DGx1sILOASYWESmsJD+Y2kco
        g+4zjAfUR+e4gsPyeJO8Vgq9clnHf+H2O0JpadDp3HMfrM1NJe9VSfMo809bjaLb
        CztWFTxg6ACJekTMbsI/V1MxEpNWPjxuIS2IQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B9D7A1AC5;
        Sat, 22 Jul 2017 11:54:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AB99A1AC4;
        Sat, 22 Jul 2017 11:54:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] make get_be64() compile on pu with NO_UNALIGNED_LOADS
References: <20170722094717.16305-1-martin.agren@gmail.com>
Date:   Sat, 22 Jul 2017 08:54:31 -0700
In-Reply-To: <20170722094717.16305-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Sat, 22 Jul 2017 11:47:17 +0200")
Message-ID: <xmqq60ekfow8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0DCC1310-6EF6-11E7-A595-61520C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Applies to pu and passes the tests. I think this should be squashed in
> somewhere. Perhaps a mismerge in commit d553324d ("Merge branch
> 'bp/fsmonitor' into pu", 2017-07-21).

Yes, you spotted a mistaken evil-merge.  Thanks.

>
>  compat/bswap.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/compat/bswap.h b/compat/bswap.h
> index 133da1d2b..f86110a72 100644
> --- a/compat/bswap.h
> +++ b/compat/bswap.h
> @@ -188,11 +188,11 @@ static inline void put_be32(void *ptr, uint32_t v=
alue)
>  	p[3] =3D value >>  0;
>  }
> =20
> -static inline unit64_t get_be64(const void *ptr)
> +static inline uint64_t get_be64(const void *ptr)
>  {
> -	unsigned char *p =3D ptr;
> +	const unsigned char *p =3D ptr;
>  	return  ((uint64_t)get_be32(p) << 32) |
> -		((uint64_t)get_be32(p + 4);
> +		((uint64_t)get_be32(p + 4));
>  }
> =20
>  #endif
