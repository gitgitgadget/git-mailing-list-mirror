Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95446C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4596A64EB9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBRWbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:31:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59005 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhBRWaz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:30:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE9FE9AADC;
        Thu, 18 Feb 2021 17:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ypb2hc2oaP83
        S6kLg3s8wv7eRCY=; b=NN4htDz6uhyocq6+BBI5/IIRMWxGOfTQjRMN27Rcq9Yw
        FzWf/Qyb+qlhCCC5IGQKm6EOiijiz/QFcYAImIuVephs7jH9oUXiBfsNAAqI7x9j
        UmL8XojDyvyXk6AB5hYVDI9nN3YlAACZf2gwQ6NyrrqnYRt1N90kUvW4gqgQtfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GjqEy/
        2PILtakBdketbu4EfcNRTqLSMc0IUJ6iTGmtimNwaHAwSO5NpGGvgd5N2CmsOD+T
        mPVspATm7SM6xEWsQR5qnt6+oQLhwuSdi6JoVooX3HImVZPR6Zeqx0U0kdrjEP8k
        0RAjVpiZVL2EN8G3B+dazMtuT5e4LRzexK9lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E209AADB;
        Thu, 18 Feb 2021 17:30:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AD1A9AAD8;
        Thu, 18 Feb 2021 17:30:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 08/10] fsck.c: undefine temporary STR macro after use
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-9-avarab@gmail.com>
Date:   Thu, 18 Feb 2021 14:30:10 -0800
In-Reply-To: <20210218105840.11989-9-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Feb 2021 11:58:38 +0100")
Message-ID: <xmqqpn0xc8lp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD4607B0-7238-11EB-8568-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In f417eed8cde (fsck: provide a function to parse fsck message IDs,
> 2015-06-22) the "STR" macro was introduced, but that short macro name
> was not undefined after use as was done earlier in the same series for
> the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
> messages, 2015-06-22).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fsck.c b/fsck.c
> index 7c53080ad48..88884e91c89 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -100,6 +100,7 @@ static struct {
>  	{ NULL, NULL, NULL, -1 }
>  };
>  #undef MSG_ID
> +#undef STR

Good clean-up.

> =20
>  static void prepare_msg_ids(void)
>  {
