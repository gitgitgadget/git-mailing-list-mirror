Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3AC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A17B64EB9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 22:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhBRWdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:33:52 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60308 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhBRWds (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 17:33:48 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA4A712C235;
        Thu, 18 Feb 2021 17:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QLjW+H7aKVbQ
        n6UYTZVAYYLiXQc=; b=EtfvOpzDThH4FFDnmpg57D49I1IGGhqRE5jQiYLGSRpC
        ejp2T+WO3wI5ePsvhU0WtTJsvm8GOqBhfJsWNuy9XpUAtJcoFSqz0cjoxSe2J82s
        QLlyKDBluXVGF8COwsAXAIi268/rfbz/MHmRWDlSJy4QZbFie3zgyOZEMH4KXws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ul+kfa
        ezVoTzBiz9xwSgM6GJNLQdaTOT0GnkAD7di7tXkWOpyptSsg+OE4MJe6GCs5LI3C
        k2ieBtneydEv6fGG7OO5V3LdiUgq68GJ2cIwtRqTEJkuodgD+pwkpXN6xaPXTKeU
        sDTtUCBP7P1qgRdl114itL8FEx+XAY7Uy7hLU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C327312C234;
        Thu, 18 Feb 2021 17:33:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1932512C232;
        Thu, 18 Feb 2021 17:33:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 10/10] fsck.h: update FSCK_OPTIONS_* for object_name
References: <20210217194246.25342-1-avarab@gmail.com>
        <20210218105840.11989-11-avarab@gmail.com>
        <YC7GW8L+nJLFYHpY@coredump.intra.peff.net>
Date:   Thu, 18 Feb 2021 14:33:02 -0800
In-Reply-To: <YC7GW8L+nJLFYHpY@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 18 Feb 2021 14:56:11 -0500")
Message-ID: <xmqqh7m9c8gx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 43CDEE08-7239-11EB-8065-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 18, 2021 at 11:58:40AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> Add the object_name member to the initialization macro. This was
>> omitted in 7b35efd734e (fsck_walk(): optionally name objects on the
>> go, 2016-07-17) when the field was added.
>
> We're correct either way here, because trailing fields that are not
> initialized will get the usual zero-initialization. But I don't mind
> trying to be more complete.
>
> That said, we have embraced designated initializers these days, in whic=
h
> case we usually omit the NULL ones. So perhaps:
>
>   #define FSCK_OPTIONS_DEFAULT { \
> 	.walk =3D fsck_error_function, \
> 	.skiplist =3D OIDSET_INIT, \
>   }
>   #define FSCK_OPTIONS_STRICT { \
> 	.walk =3D fsck_error_function, \
> 	.skiplist =3D OIDSET_INIT, \
> 	.strict =3D 1, \
>   }
>
> would be more readable still?

Ahh, I should probably have read your reviews first before reading
patches myself ;-)

Thanks.
