Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6281D203BD
	for <e@80x24.org>; Thu, 14 Jul 2016 22:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbcGNWbF (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 18:31:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60764 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751911AbcGNWbE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 18:31:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A7F012C9C2;
	Thu, 14 Jul 2016 18:31:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eobF9eOrcmrUHRv9kbypfemMKk8=; b=MPMPV4
	pwLxdSPow2D4pHKYGLs8iXOX6kVbqeOCtKxBAlJTK3jMCUXe5GwJdIs4I4dlNCgH
	XjwuTk8at3T46XxtUttQofCZ8D7Q3JWqpQINPgbzyTrYAbtm12imrtt3yTay486j
	6MJiHe32zZyzi3m9G/Zwi9rpC1nLaE5I2OesU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XRdxUKFcBxeWTxIjrlRQMO6cYEJmRLAM
	yiOLqTdYud94d8gmEXDDC1EuqUBBP0O8s1neKb09q2T5Ngqr8u7PZYd1f5onH/Vy
	o+wGFXDtRNdBQXBE9T5BEiKDAaAYQ3CYPWwM7rH6EGlN62aTx4PtyJCj/IbYErx2
	ljKD8m4MBMI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F6992C9C1;
	Thu, 14 Jul 2016 18:31:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 844592C9BF;
	Thu, 14 Jul 2016 18:31:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 2/5] t5000: test tar files that overflow ustar headers
References: <20160630090614.GA16725@sigill.intra.peff.net>
	<20160630090857.GB17463@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607141745420.6426@virtualbox>
	<19a2d02e-3918-3bc9-db34-66e12ab950e4@kdbg.org>
	<xmqqa8hkrvu5.fsf@gitster.mtv.corp.google.com>
	<3d71cf3a-44c7-0620-0375-fb7ecf2fac13@kdbg.org>
	<20160714213222.GA20645@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 15:30:58 -0700
In-Reply-To: <20160714213222.GA20645@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 17:32:22 -0400")
Message-ID: <xmqqpoqfonrx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A45055A8-4A12-11E6-98EC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If we move to time_t everywhere, I think we'll need an extra
> TIME_T_IS_64BIT, but we can cross that bridge when we come to it.
>
> Likewise I think we'll need SIZE_T_IS_64BIT eventually (for real 32-bit
> systems; LLP64 systems like Windows will then be able to run the test).

I guess I wrote essentially the same thing before refreshing my
Inbox.

I am a bit fuzzy between off_t and size_t; the former is for the
size of things you see on the filesystem, while the latter is for
you to give malloc(3).  I would have thought that off_t is the type
we would want at the end of the raw object header, denoting the size
of a blob object when deflated, which could be larger than the size
of a region of memory we can get from malloc(3), in which case we
would use the streaming interface.


