Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EC62018A
	for <e@80x24.org>; Mon, 27 Jun 2016 13:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728AbcF0NC2 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 09:02:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53026 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751740AbcF0NCR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 09:02:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 902DD265B9;
	Mon, 27 Jun 2016 09:02:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CAPOsW6Gvcrjg866LLgWyAIw9EI=; b=lvvIj4
	aap9fN9UkK79+1jT1Yybpb8nopTKjWCXbBz/srwCvZhdPXJIxsbKW0+2g6cIpad5
	WNGKnaq+1djj9jGZ+lWjTiSNzaD+J+R0y17nKWiFHIrdbDi2cGZlQcN7ZKxqvRNy
	Psm2c0LpWs25hLYQYLKxbi6DnggmX9TrdDTxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jmRoMdAUsp2bccFxd126UDsOpAp48x6c
	QtwP5zAiBeemXRSaEq8qPZp6Ab9aA3Xn10pqdgnNziV62jegH6FhD21eo0kuHObA
	pZQxPmOVa2BMyPbJJG7BrbmKgoA3sNUa6br6ZZhJ6aulEirzzz3+iLLNguh8lN59
	oWyMxyTpLN0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 883CF265B8;
	Mon, 27 Jun 2016 09:02:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D73F265B7;
	Mon, 27 Jun 2016 09:02:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Eric Wong <e@80x24.org>, Stefan Beller <sbeller@google.com>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] xread: retry after poll on EAGAIN/EWOULDBLOCK
References: <20160626232112.721-1-e@80x24.org>
	<20160626232112.721-2-e@80x24.org>
	<20160626234251.GA21668@sigill.intra.peff.net>
Date:	Mon, 27 Jun 2016 06:02:12 -0700
In-Reply-To: <20160626234251.GA21668@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 26 Jun 2016 19:42:51 -0400")
Message-ID: <xmqqoa6mdbu3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E2D0098-3C67-11E6-A807-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also wondered how we managed to miss such an obvious point in review
> of the original patch. Sadly, we _did_ notice it[1] but it looks like we
> never fixed the problem. That is even more disturbing.

Yes indeed.

I try to pay attention to "this is broken because..."  comments in
discussions to make a note in my copy of "What's cooking" report for
a problematic topic, as that is where I work from when merging
topics down, but apparently that procedure failed work in this case.
There needs a stronger mechanism to stop a known-buggy patch from
going thru, but I am not sure offhand what that should be.

