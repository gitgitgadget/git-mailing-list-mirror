Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3BBC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB0B6101E
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 16:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbhJNQlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:41:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60150 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbhJNQlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 12:41:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0F52E087E;
        Thu, 14 Oct 2021 12:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yPIomNn9bovrWD2l7m0pbAZzXRgl/G1h9wXRDU
        uMJ2Y=; b=YnsGCl8UtyYDLVZOF3zICjJkbv7IE9xgpYmdY3ggO67a/3M5DPoZNM
        m3l2VBh/RzfqRQhdgKIr44/kp/E/IB2lQMIcI/rBpgmVJxPb160E0Ewb0/kpu29C
        5wUlfsbOeBQ7FZjwpTpGIHl7ktWKuM/9vYlV2231UrEowFYjutm94=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8ABFE087D;
        Thu, 14 Oct 2021 12:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4688CE087C;
        Thu, 14 Oct 2021 12:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test-lib.sh: use "Bail out!" syntax on bad
 SANITIZE=leak use
References: <cover-0.2-00000000000-20211014T004542Z-avarab@gmail.com>
        <patch-2.2-6fd2a64bcfa-20211014T004542Z-avarab@gmail.com>
Date:   Thu, 14 Oct 2021 09:39:16 -0700
In-Reply-To: <patch-2.2-6fd2a64bcfa-20211014T004542Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 14 Oct
 2021 02:47:29 +0200")
Message-ID: <xmqqsfx3d0i3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45F40FE8-2D0D-11EC-97F2-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +BAIL_OUT () {
> +	test $# -ne 1 && BUG "1 param"
> +
> +	# Do not change "Bail out! " string. It's part of TAP syntax:
> +	# https://testanything.org/tap-specification.html
> +	local bail_out="Bail out! "
> +	local message="$1"
> +
> +	say_color error $bail_out "$message"
> +	_error_exit
> +}

This looks like a good addition that can be used in similar cases
later.  I'd assume that "Bail out!" early of a test sequence will
mark the test suite as a failure as a whole, but I wonder if there
is a similar "early abort" mechanism that would cause a success?  In
some tests we do

	if .. some condition ..
	then
		test_done ;# because we cannot test the remainder
	fi

        .. more tests ...

and I've always thought the "done" an ugly hack.

But that has nothing to do with the value of this change.

Thanks.
