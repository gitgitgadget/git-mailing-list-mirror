Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CDFC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376AF64DDF
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 18:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCQS6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:58:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51497 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhCQS5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 14:57:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF91F134D49;
        Wed, 17 Mar 2021 14:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iU0qsvAfkr0q
        H1zTCKIMjqUCT5E=; b=DaWH13UPvzIc/EALhfqpaTuAoPQclYSUU2RGt40BYfbs
        T697XMVdICWNwDVWXvP8TuCGumUa2zMub4WRoDPZJC9bvGQgxW/DmyD0rsgP2t2d
        9pFs9gGIBrI/J2xLeeybvVWgFDqeIUdlz6jfmtwPn6iVWwUYj+7tcjan0Qc/vbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eUTD7V
        ybM74/8tinKxDubZXvKKAnZcjGWFwEXerht6Wy/h7MbOgqgALcLfDYNBWiK17IDY
        WjFzibZ6V093i/suJN2r6qiiNQj0rOuNPbCcm/8lGopsKSo6U981FRz59QcRbEtC
        VLjRhQ4lt5OckHl9CfK0saoJMQQ99XJQWiqi0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8C28134D48;
        Wed, 17 Mar 2021 14:57:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EEA98134D46;
        Wed, 17 Mar 2021 14:57:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 14/22] fsck.c: undefine temporary STR macro after use
References: <20210306110439.27694-1-avarab@gmail.com>
        <20210316161738.30254-15-avarab@gmail.com>
Date:   Wed, 17 Mar 2021 11:57:37 -0700
In-Reply-To: <20210316161738.30254-15-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 16 Mar 2021 17:17:30 +0100")
Message-ID: <xmqqft0tvc9q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4FB8540-8752-11EB-B6CA-E43E2BB96649-77302942!pb-smtp20.pobox.com
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

Makes sense.  Thanks.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  fsck.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fsck.c b/fsck.c
> index 2ccf1a2f0f..f4c924ed04 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -100,6 +100,7 @@ static struct {
>  	{ NULL, NULL, NULL, -1 }
>  };
>  #undef MSG_ID
> +#undef STR
> =20
>  static void prepare_msg_ids(void)
>  {
