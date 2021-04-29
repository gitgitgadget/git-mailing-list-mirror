Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8DCC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 05:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA4D61158
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 05:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhD2FCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 01:02:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54079 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2FC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 01:02:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0590AD0E8C;
        Thu, 29 Apr 2021 01:01:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZCu0b+Cy+JQh
        VT/zAilfx9JVHhntnjkjVyPYfy09bZQ=; b=SCkZeV4qailiB7jk4RhH/Xy/awR+
        7SWqcoLGN9dydA5mztWqBmU0MtH4ukacUGKHJ537eBu2flEuRQRoi2hF6LhyPMac
        fsFKqq2cYDwZIOtDJoJPixKefRtxBHTbUPrtLftbFM2Zo7EuhcF2PbMSg2bGLAqd
        jc7l+MNr8Nc9cuI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0F10D0E8B;
        Thu, 29 Apr 2021 01:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E550D0E8A;
        Thu, 29 Apr 2021 01:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 09/10] mktree: stop setting *ntr++ to NIL
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-09.10-e463fe5f6a-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 14:01:41 +0900
In-Reply-To: <patch-09.10-e463fe5f6a-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:42 +0200")
Message-ID: <xmqqwnsl7kga.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD2AB800-A8A7-11EB-BAF4-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since 58ce21b819e (builtin/mktree: remove hard-coded constant,
> 2018-10-15) we have not made any subsequent use of the ntr variable
> itself, but we did rely on it to NIL-delimit the string we were about
> to feed to type_from_string().
>
> Using type_from_string() here results in needless work, as we'd do a
> strlen() on it, just to find point at which we had a SPC
> character (now NIL) earlier in this function.

Since when do we write in LISP? ;-)  The name of the ASCII character
with value 0 is NUL (null).

> We can instead skip incrementing the ntr pointer, then pass the
> pointer and length to the type_from_string() function instead.

Makes sense.  Not clobbering the input buffer is good.
