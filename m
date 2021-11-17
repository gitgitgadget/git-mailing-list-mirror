Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED30C433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C17D610CA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 07:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhKQHmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:42:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50189 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhKQHmK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:42:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7552716B5DC;
        Wed, 17 Nov 2021 02:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SKqnRSwe0Bha5oMGrHXimFssRhPSaMXB0akXYc8tjuw=; b=tI0+
        80CYk9DmFZ+kTUSpvW5DRhU9PhzuC4WtQ37sE5SMWQTJKkm5q40W6VPlmh0mzN/D
        xKPLV8CK+7vd6Isgov2V7lMyBnVHes2YbA8wz3hQAoTeZt1NxInYRFtMAwlu9903
        TgLRVvJ8y5qd88vU07neZ5efhi0D+iX99JVpsNo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6E97916B5DB;
        Wed, 17 Nov 2021 02:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CEFF116B5D8;
        Wed, 17 Nov 2021 02:39:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
        <20211116033542.3247094-2-sandals@crustytoothpaste.net>
Date:   Tue, 16 Nov 2021 23:39:08 -0800
Message-ID: <xmqq1r3f5izn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73A746CC-4779-11EC-A2A1-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Finally, add a self-test option here to make sure that our buffer
> handling is correct and we aren't truncating data.  We simply read 64
> KiB and then make sure we've seen each byte.  The probability of this
> test failing spuriously is less than 10^-100.

I saw that 10^-100 math in the other message, and have no problem
with that, but I am not sure how such a test makes "sure that our
buffer handling is correct and we aren't truncating data."  If you
thought you are generate 64kiB of random bytes but a bug caused you
to actually use 32kiB of random bytes with 32kiB of other garbage,
wouldn't you still have enough entropy left that you would be likely
to paint all 256 buckets?

I also agree with Peff's comment about making these look as if many
of them can be specified at once, when only one of them would
actually be in effect.  Giving one Makefile macro that the builder
can set to a single value would be much less confusing.

Thanks.
