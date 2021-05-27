Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696FC4707F
	for <git@archiver.kernel.org>; Thu, 27 May 2021 03:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436E5613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 03:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhE0DQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 23:16:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61853 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhE0DQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 23:16:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7CEC126BF3;
        Wed, 26 May 2021 23:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZqLzTGAKHfPM
        ZEgVyzuCHa0OoqwimNLImu1WuhTvBmc=; b=K+k6AEWI3xGcb/FtMAgx1ikx0Nqq
        kAjZVnU+g+hasc8mACG7GdHk14OPD642vcCzft36pOKemGPkqFafZnT8MZ0hrVa9
        mDBjHXq4s/GIFi9jZqLEWBrXJClJ2Emt1lEy4D8vTv//FfrENsnwK9ud6akxhd5R
        9q7HJY5rVrqi9xk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0673126BF2;
        Wed, 26 May 2021 23:14:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DBAEB126BEF;
        Wed, 26 May 2021 23:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: move builtin-only code to its own header
References: <878s41m5nc.fsf@evledraar.gmail.com>
        <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
Date:   Thu, 27 May 2021 12:14:28 +0900
In-Reply-To: <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 May
 2021 02:52:51 +0200")
Message-ID: <xmqqa6ogamwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A697E5FA-BE99-11EB-BE10-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the code that's only used in builtin/pack-objects.c to a new
> builtin/pack-objects.h header and out of pack-objects.h.

I've amended the early part of the proposed log message in
preparation for merging it to 'next' and then later down to
'master'.

Here is what the result looks like.

Thanks.


Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date:   Thu May 27 02:52:51 2021 +0200

    pack-objects: move static inline from a header to its sole consumer
   =20
    Move the code that is only used in builtin/pack-objects.c out of
    pack-objects.h.
   =20
    This fixes an issue where Solaris's SunCC hasn't been able to compile
    git since 483fa7f42d9 (t/helper/test-bitmap.c: initial commit,
    2021-03-31).
   =20
    The real origin of that issue is that in 898eba5e630 (pack-objects:
    refer to delta objects by index instead of pointer, 2018-04-14)
    utility functions only needed by builtin/pack-objects.c were added to
    pack-objects.h. Since then the header has been used in a few other
    places, but 483fa7f42d9 was the first time it was used by test helper=
.
   =20
    Since Solaris is stricter about linking and the oe_get_size_slow()
    function lives in builtin/pack-objects.c the build started failing
    with:
   =20
        Undefined                       first referenced
         symbol                             in file
        oe_get_size_slow                    t/helper/test-bitmap.o
        ld: fatal: symbol referencing errors. No output written to t/help=
er/test-tool
   =20
    On other platforms this is presumably OK because the compiler and/or
    linker detects that the "static inline" functions that reference
    oe_get_size_slow() aren't used.
   =20
    Let's solve this by moving the relevant code from pack-objects.h to
    builtin/pack-objects.c. This is almost entirely a code-only move, but
    because of the early macro definitions in that file referencing some
    of these inline functions we need to move the definition of "static
    struct packing_data to_pack" earlier, and declare these inline
    functions above the macros.
   =20
    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
