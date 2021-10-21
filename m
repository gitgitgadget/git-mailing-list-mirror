Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A867C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A96861506
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhJURBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 13:01:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53649 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhJURBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 13:01:44 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00F28FC214;
        Thu, 21 Oct 2021 12:59:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJNxyJ2SB3tOaW+RRiWYGTmyZX1TbIGNoSZnHm
        6/i6M=; b=dt76N3T7xJmzWukf4NL4b+YhTH+9XKVKwoUZZ6KC30ypWI+bEeZ8Rn
        CYUxnDmTdr4EL5LzABFyJ2YRY3xHtJXl0RmHVtuwL1Ukb83oUB35yOTldIJKzF4I
        3UkGLRazNxcACO57uo9a5474egPvasnqMbe2prpeBN9SGXDWvCxqk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED3DFFC213;
        Thu, 21 Oct 2021 12:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EBE9FC211;
        Thu, 21 Oct 2021 12:59:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 08/11] pack-bitmap.c: don't leak type-level bitmaps
References: <cover.1634787555.git.me@ttaylorr.com>
        <29920e773527e6e82065205ed98262ce9b01de28.1634787555.git.me@ttaylorr.com>
Date:   Thu, 21 Oct 2021 09:59:26 -0700
In-Reply-To: <29920e773527e6e82065205ed98262ce9b01de28.1634787555.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 20 Oct 2021 23:40:05 -0400")
Message-ID: <xmqq8rymmhzl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 401EDCB4-3290-11EC-94A8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> test_bitmap_walk() is used to implement `git rev-list --test-bitmap`,
> which compares the result of the on-disk bitmaps with ones generated
> on-the-fly during a revision walk.
>
> In fa95666a40 (pack-bitmap.c: harden 'test_bitmap_walk()' to check type
> bitmaps, 2021-08-24), we hardened those tests to also check the four
> special type-level bitmaps, but never freed those bitmaps. We should
> have, since each required an allocation when we EWAH-decompressed them.
>
> Free those, plugging that leak, and also free the base (the scratch-pad
> bitmap), too.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---

I've looked at the patches up to this point.  The ones I did not
comment (including this one ;-) looked perfect, and all of them
(including the ones I did comment) were cleanly described to easily
read the reasoning behind these changes, which I highly appreciated.

Especially if I did not quite agree with the reasoning, it helped me
clarify my thought where I found it not agreeable.

Thanks.
