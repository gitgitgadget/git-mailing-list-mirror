Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EDC47082
	for <git@archiver.kernel.org>; Thu, 27 May 2021 01:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C221613D4
	for <git@archiver.kernel.org>; Thu, 27 May 2021 01:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhE0Bbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 21:31:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51964 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhE0Bbt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 21:31:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 983A513A31D;
        Wed, 26 May 2021 21:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=r1tp+a+1+qSw
        rkHVWSbXQYcvjEyVXdmfQ+sO+omn58E=; b=woKejQesrq+P3sJLzQufl6eeFUHY
        Q841PlLGuxNzJvtS+l/kfe/uQe05gr40dVeJJOjSTQToYaGujtPRTaSLVYVB8RRA
        zgKPcqd/2a5d0yyAcKZCZNmWHVOrWvL0iKGw8bklsoMML4pTpo0XFLprv0d5ivlB
        JvMyDW5pqM6MJUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9033313A31C;
        Wed, 26 May 2021 21:30:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCEFF13A31B;
        Wed, 26 May 2021 21:30:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: move builtin-only code to its own header
References: <878s41m5nc.fsf@evledraar.gmail.com>
        <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
Date:   Thu, 27 May 2021 10:30:12 +0900
In-Reply-To: <patch-1.1-d085d59a417-20210527T005213Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 27 May
 2021 02:52:51 +0200")
Message-ID: <xmqqr1ht9d5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 15BA6340-BE8B-11EB-A530-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move the code that's only used in builtin/pack-objects.c to a new
> builtin/pack-objects.h header and out of pack-objects.h.
>
> This fixes an issue where Solaris's SunCC hasn't been able to compile
> git since 483fa7f42d9 (t/helper/test-bitmap.c: initial commit,
> 2021-03-31).
>
> The real origin of that issue is that in 898eba5e630 (pack-objects:
> refer to delta objects by index instead of pointer, 2018-04-14)
> utility functions only needed by builtin/pack-objects.c were added to
> pack-objects.h. Since then the header has been used in a few other
> places, but 483fa7f42d9 was the first time it was used by test helper.

Hmph.  Its good that removing these functions that should not be
called by other people from *.h and move them to their only user
regardless of the Solaris issue.  Sounds good.
