Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A30C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D876610E6
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 18:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbhI1Sep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:34:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60800 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242480AbhI1Sdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:33:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9B671E065A;
        Tue, 28 Sep 2021 14:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kKfZakiNRcGFV9hI+uO1Q5mErebS0MDpOMSZ/o
        q6Fn0=; b=S/TTwmZUYnBg7mMACLJA+n9RDD5Jk1Jc6XhwxOxNEXLFmMhiwS5Pav
        0hULRBw3ztF3ZSJZQy212nlONkWWhFE1EaL7Xwgv8+wSmsA06ipK7S6eU0SH4zue
        0j7a86/CxOiLxubDpOqcnTC8yQgk6KLAetpG8PGAMKWQKLPLQRt6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 918F7E0658;
        Tue, 28 Sep 2021 14:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB76EE0657;
        Tue, 28 Sep 2021 14:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
        <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
        <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
        <87czou1dmp.fsf@evledraar.gmail.com>
        <YVJZrOYucywgoi+v@coredump.intra.peff.net>
Date:   Tue, 28 Sep 2021 11:32:02 -0700
In-Reply-To: <YVJZrOYucywgoi+v@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 27 Sep 2021 19:54:20 -0400")
Message-ID: <xmqqpmssk0v1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 608FA82E-208A-11EC-86BE-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> >> +	memcpy(t, &blank, sizeof(*t));
>> >
>> > Is
>> > 	*t = blank;
>> >
>> > not a thing in C?
>
> It would be fine to use struct assignment here, and should be equivalent
> in most compilers. They know about memcpy() and will inline it as
> appropriate.

FWIW, I'd be fine with structure assignment, but we already have too
many such memcpy(<ptr>, &<struct>, sizeof(struct)), adding one more
is not giving us too much incremental burden for later clean-up.

> I think some C programmers tend to prefer memcpy() just because that's
> how they think. It also wasn't legal in old K&R compilers, but as far as
> I know was in C89.

I think so, too.
