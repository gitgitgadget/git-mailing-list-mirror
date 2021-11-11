Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB2C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 02:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59C61212
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 02:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhKKCEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 21:04:32 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53458 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbhKKCEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 21:04:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A03131610AD;
        Wed, 10 Nov 2021 21:01:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=QbeKt2Rq2ixYWvAdFWrew2Nva
        FlsfJtIywR1O3UNclE=; b=pUAsUmvdXVGTHcehFFAsAGNgOMMK2Yqp5zq3QDeBW
        mK0cHWn1b1boGTulH/fuu+w8i2LS3lEWKKwRoqXhx+YxzelE0Oz6UWOIxRfi0e0p
        1Nofo5V/JW9LW9WkhxB4r8W3LiYtiqTm/FINysxQV4NT7vPyGgGekK9vMPsUaQ7v
        U4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 983761610AC;
        Wed, 10 Nov 2021 21:01:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0795A1610AA;
        Wed, 10 Nov 2021 21:01:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>, Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2] parse-options.c: use "enum parse_opt_result" for
 parse_nodash_opt()
References: <211110.867ddgkjcp.gmgdl@evledraar.gmail.com>
        <patch-v2-1.1-376f76bb44e-20211110T012523Z-avarab@gmail.com>
Date:   Wed, 10 Nov 2021 18:01:39 -0800
Message-ID: <xmqqilwzv4ak.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4FF0DB0C-4293-11EC-8EA2-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the parse_nodash_opt() function to use "enum
> parse_opt_result".In 352e761388b (parse-options.[ch]: consistently

s/.In/. In/; no need to resend for this.

> use "enum parse_opt_result", 2021-10-08) its only caller
> parse_options_step() started using that return type, and the
> get_value() which will be called and return from it uses the same
> enum.
> ...
> Since we only care about whether the return value here is non-zero
> let's use the more generic PARSE_OPT_ERROR.

I do not see a reason why anybody may think that it is a sensible
thing for "this returns a value from an enum, not int, so make it
so" patch, which is not supposed to change the sematics, to do,
though.  It is even so since we know the current caller does not
care.  The need of the next caller may tell us what the reasonable
return value should be, but we do not know well enough to justify
changing the value.



