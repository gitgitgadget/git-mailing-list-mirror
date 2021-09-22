Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E978C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435D261131
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhIVQOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:14:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54434 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhIVQOw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:14:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8F3D158FC6;
        Wed, 22 Sep 2021 12:13:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bqKJUyrmHC/W
        LhlfZD3ggLpohCEs252xrDLWhINaQJI=; b=kkdwkh9fx8bXVYFcNkNzH5Qv7eYW
        Q12kRirQ0Ex5j2MZrYeE1fWJdbrZGcS72HadDBk6YZRyJGt7ntfRXVG3OQJaJ6TR
        AEaxvg8miEh3qi6y0xmHT90bDRbQol+LzrDTL6A95DAuqrmotHtMjcQvop0BRvJd
        vXaXteja7OIXzNM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1F10158FC5;
        Wed, 22 Sep 2021 12:13:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F84B158FC3;
        Wed, 22 Sep 2021 12:13:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and
 -Wno-pedantic-ms-format
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
Date:   Wed, 22 Sep 2021 09:13:19 -0700
In-Reply-To: <87lf3q9u6b.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 21 Sep 2021 10:44:02 +0200")
Message-ID: <xmqqilys8u74.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00B9516C-1BC0-11EC-998F-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. complaining about "%m$" instead of "%" in printf formats, it's eas=
y
> enough to fix in my case, it's just something I used to de-duplicate a
> rather complex format, this makes it C(89|99)-compliant:
>    =20
>     -       strbuf_addf(&fmt, "%%s%%s%%s-%%0%1$lud.%%0%1$lud-%%s-%%s-%%=
s",
>     -                   (unsigned long)tmp.len);
>     +       strbuf_addf(&fmt, "%%s%%s%%s-%%0%lud.%%0%lud-%%s-%%s-%%s",
>     +                   (unsigned long)tmp.len, (unsigned long)tmp.len)=
;
>
> But in general, do we view -pedantic as an implicit endorsement that we
> should be using less POSIX and more standard C than we otherwise would?
>
> I may be wrong, but I believe that construct is widely portable, we
> don't use it in the main source, but in the po/ files (so anything that
> uses git + gettext tests for this already):

Reordering (_("%s %s"), a, b) to ("%2$s %1$s", a, b) is essential to
make po/ work.=20

While I do not think of a reason why it should not work, I am not
sure duplicating (%1$s %1$s", a) falls into the same category.

Any solution that makes the per-cent ridden format string is better
;-)

