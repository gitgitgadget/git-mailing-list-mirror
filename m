Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC241F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfHSRg3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:36:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57596 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbfHSRg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:36:29 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D05216A90E;
        Mon, 19 Aug 2019 13:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZUUApYOifgGQZZKthlg1jaOTY/Y=; b=HvGVyE
        bPvjvzy9mEqhGw5lJF+U5MTkWf1Fwf9cCOID9NqX64rkK4WN7YBw1bzTGzrFp71V
        C1DWsfFGnMgpxJ/s21+gXb7/nG9YKoitru0WgalFtZAdqhHe0YGkykBPRUEoDDwx
        v/PVqf71ZYv72g9gIVlExuya59RCFiz0oekps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XDXUPDpKHQ0Bx+f0RKOezY8gJP5Po9pO
        /xkxwFsdTf3tgNhTJM1z3Lp77YU40d5jMkvjzyYY6T4+UbtGedbNZcr2X/dFEEd6
        Fnr3mXfmgiilXG3DB8TbfV/nh6IghR4p7/iy0vUn9dR2f5lLSCy5dcLk+PstjoFO
        30ob2jVztb0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13C8D16A90D;
        Mon, 19 Aug 2019 13:36:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D74216A90C;
        Mon, 19 Aug 2019 13:36:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     16657101987@163.com, git@vger.kernel.org, mhagger@alum.mit.edu,
        sunchao9@huawei.com, worldhello.net@gmail.com
Subject: Re: [PATCH v2 0/1] pack-refs: always refreshing after take the lock file
References: <20190730063634.GA4901@sigill.intra.peff.net>
        <20190731183544.24406-1-16657101987@163.com>
        <20190816204906.GA29853@sigill.intra.peff.net>
Date:   Mon, 19 Aug 2019 10:36:25 -0700
In-Reply-To: <20190816204906.GA29853@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 16 Aug 2019 16:49:06 -0400")
Message-ID: <xmqqr25hxdk6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DED43436-C2A7-11E9-9769-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm undecided on this. I think reftables are still a while off, and even
> once they are here, many people will still be using the older format. So
> it makes sense to still apply fixes to the old code.

Yeah.

> What I wonder, though, is whether always refreshing will cause a
> noticeable performance impact (and that's why I was so slow in
> responding -- I had hoped to try to come up with some numbers, but I
> just hadn't gotten around to it).
>
> My gut says it's _probably_ not an issue, but it would be nice to have
> some data to back it up.

I am tempted to let correctness (and ease-of-reasoning about the
code) take precedence over potential and unknown performance issue,
at least for now.  A single liner is rather simple to revert (or in
the worst case we could add "allow pack-refs to efficiently lose a
ref to a race" configuration option) anyway.

