Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AD0C2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E18E21734
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T+3QouO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgI2AlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:41:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53763 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2AlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:41:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A5088F39A;
        Mon, 28 Sep 2020 20:41:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xpcu8re26xyP1LDed3lJJ/N2NQs=; b=T+3Qou
        O304JiW1moptH0vDb+tKz0KN1D+g04+q7Fw4THs1qErlz8wDUe4gmOYXc0InOZ7w
        pX2mUHtkR48MIAAIwhQox7zZ/1BEVkUuvsqkUChYZ5h8jM65o9BwQKaL/WH65SpM
        88gFVCIR6BcfF0Tztkx34FUwfHeslL358F8R4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rUCtFWuDpFXdLx2radmP1ZUB7LCEOJQj
        EyA+7AvXTcd1nu+/Xjngmn7GBmq/H44PlLhKHXOjXaPN9tI2FkjmY6QoGaUtrdPR
        uaJC9K5upqbVhoxfbzZLu1bB38iG1BTgHbh6C9NHxfJoSD+ne0Aj1SbIVVQvnchI
        kcxno9eWHPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22D218F399;
        Mon, 28 Sep 2020 20:41:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FF408F398;
        Mon, 28 Sep 2020 20:41:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>,
        Nikita Leonov via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nikita Leonov <nykyta.leonov@gmail.com>
Subject: Re: [PATCH v2 2/3] credentials: make line reading Windows compatible
References: <pull.710.git.git.1581688196706.gitgitgadget@gmail.com>
        <pull.710.v2.git.git.1601293224.gitgitgadget@gmail.com>
        <f69076036fe4dfe8b57fc1d4329c7be3f7346850.1601293224.git.gitgitgadget@gmail.com>
        <CAPUEspgW9CFO3WtbiuTUsmXp05fPqr2Cs81piDJFJ0g3KcTy3A@mail.gmail.com>
        <20200929003000.GA898702@coredump.intra.peff.net>
Date:   Mon, 28 Sep 2020 17:41:14 -0700
In-Reply-To: <20200929003000.GA898702@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 28 Sep 2020 20:30:00 -0400")
Message-ID: <xmqqwo0difdh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AAA7ECC-01EC-11EB-9815-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think that:
>
>   - we'd never write a raw CR ourselves, as we'd urlencode the character
>
>   - if somebody did put in a raw CR manually like:
>
>       https://example.com\r\n
>
>     then we'd currently fail to match "example.com". Which is probably
>     not what they wanted. I suspect that \r in a hostname is bogus
>     anyway (certainly curl will complain about it).

I may be misremembering, but an argument I recall against the kind
of change we are dicussing now was that we ignore such an entry
right now, and the user may have added an entry for the host anew,
possibly with a more recent password.  Changing the parsing to
ignore CR would silently resurrect such a stale entry that the user
has written off as unused, and depending on the order of entries in
the file, a site that used to work may start failing suddenly.

I don't think I'd care too heavily either way.  As long as other
people will deal with possible backward-incompatibility fallout,
I do not mind seeing the change ;-).

I still don't see why we need to touch the cache-daemon, though.

Thanks.

