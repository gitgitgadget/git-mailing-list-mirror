Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A6C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F54613BD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbhI2AYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:24:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55313 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242525AbhI2AX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 20:23:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C1A28E2D4B;
        Tue, 28 Sep 2021 20:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=k753H7SZWtDO
        3X780XNF3qEvD1bMllqxAeiL5D/KWJI=; b=Qm5vcnnRrP6RkJJGSJWGKP0iE6PS
        EQ54VCw0t4W/pK+ya/d4SebO9b0KDtvtPquiox7fYipT/oBSHTkJz+wZFswJ2Mcv
        lWeWxJH3hY4eGXXIfjavzSbUawEyJQNmwTuWEcQb6q2MycispAXWsy6TBLv4TMCi
        zZP9uKAajKbKN3U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9C50E2D4A;
        Tue, 28 Sep 2021 20:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F8FFE2D48;
        Tue, 28 Sep 2021 20:22:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 05/10] parse-options.h: make the "flags" in "struct
 option" an enum
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
        <patch-05.10-697e432c012-20210928T130905Z-avarab@gmail.com>
Date:   Tue, 28 Sep 2021 17:22:17 -0700
In-Reply-To: <patch-05.10-697e432c012-20210928T130905Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 28 Sep
 2021 15:14:26
        +0200")
Message-ID: <xmqq1r58grie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E0D9AAE-20BB-11EC-9906-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the "flags" members of "struct option" to refer to their
> corresponding "enum" defined earlier in the file.
>
> The benefit of changing this to an enum isn't as great as with some
> "enum parse_opt_type" as we'll always check this as a bitfield, so we
> can't rely on the compiler checking "case" arms for us. But let's do
> it for consistency with the rest of the file.

For the same reason as my comment on [02/10], this is more or less
"Meh" for me.  If we wanted to make any change here, I'd probably
suggest making it "unsigned" to clarify that this is a OR'ed bit
patterns.

> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  parse-options.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.h b/parse-options.h
> index a1c7c86ad30..74b66ba6e93 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -134,7 +134,7 @@ struct option {
>  	const char *argh;
>  	const char *help;
> =20
> -	int flags;
> +	enum parse_opt_option_flags flags;
>  	parse_opt_cb *callback;
>  	intptr_t defval;
>  	parse_opt_ll_cb *ll_callback;
