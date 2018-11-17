Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECCF61F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeKRAYX (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 19:24:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59508 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRAYX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 19:24:23 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DB8A115FEE;
        Sat, 17 Nov 2018 09:07:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2II1xgvHbjDr2aF6xQZdFTNvat8=; b=ASRC4E
        T4ksoLW1xMoUP4MYHj5YPp6BP7nXk+s6Lb9l/OlTcAr1xBWDQRB7VMtsGbtThTxq
        yDbogz4Velr9gxoTH3npGZFb0Ns7ZxWE868EU4Sd1rIJpBH8y1aloZI+jSzqBcgV
        hgHdcYP2aL2QTQv+wSx+6VdgM9C1eAxG071Bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aQXaHSG659Xsp3skDxzgshuEGyz9Lh0r
        +uww0fcWZb9xaw7NsrKLGTMOBvK6I9BR3mtivwe1n0JnFGhLCOAoabyf3i1W0rfE
        95w82b+8MqeO8Ky3ywHttbyloTIGbtjyBUftuv6ytYY9ASxiazH3TWZ2vJRUg9BY
        zThNO7X9nxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85BD8115FED;
        Sat, 17 Nov 2018 09:07:34 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06982115FEC;
        Sat, 17 Nov 2018 09:07:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
References: <20181115182826.GB25806@pure.paranoia.local>
        <20181116115639.GO890086@genre.crustytoothpaste.net>
        <xmqq7ehci1td.fsf@gitster-ct.c.googlers.com>
        <20181117122722.GB4094@sigill.intra.peff.net>
Date:   Sat, 17 Nov 2018 23:07:32 +0900
In-Reply-To: <20181117122722.GB4094@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 17 Nov 2018 07:27:22 -0500")
Message-ID: <xmqq7ehbhk63.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21493208-EA72-11E8-A391-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect it would be less confusing if the rewrite were inverted, like:
>
>   [url "gh:"]
>   rewriteTo = https://github.com
>   rewritePrivate
>
>   [url "git://github.com"]
>   rewriteTo = https://github.com
>
> where the mapping of sections to rewrite rules must be one-to-one, not
> one-to-many (and you can see that the flip side is that we have to
> repeat ourselves).
>
> I hate to introduce two ways of doing the same thing, but maybe it is
> simple enough to explain that url.X.insteadOf=Y is identical to
> url.Y.rewriteTo=X. I do think people have gotten confused by the
> ordering of insteadOf over the years, so this would let them specify it
> in whichever way makes the most sense to them.

I do admit that the current "insteadOf" was too cute a way to
configure this feature and I often have to read it aloud twice
before convincing myself I got X and Y right.  It would have been
cleaner if the definition were in the opposite direction, exactly
because you can rewrite a single thing into just one way, but we do
want to support that many things mapping to the same, and the
approach to use "url.Y.rewriteTo=X" does express it better.
