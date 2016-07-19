Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64E4B2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 19:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbcGSTeB (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:34:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751597AbcGSTd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 15:33:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F2D2F3F5;
	Tue, 19 Jul 2016 15:33:58 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V+GwSKEpc3y/R4Yk5CmktDWESTg=; b=YSmrzg
	oczGH4QebVX3HI+EGa/Toll/D52IdLGFezyeVwzXKRFSn9uJsFpk14C1L/0BcNVP
	qehZtHOyBRqgCWWzmJpKApLM5iWCm9vflqJhJ57C8j30HCdwWXN3lWSTI3Im8n6Y
	hABJi8AzYBPL/g0IFKNCMhyYqTJ47XcVaQYn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f6ro9HnUYjzZsPDIn1+MfvCnMMprD0fc
	3GKypj/XTWoTwt7JfJoiiuZkXg/EXz7O8N9+zZtyB+FhsNoBkxQxL4WGOSJ14lVI
	j9ivMJ34JECg27IIIBS6hJLXdbRXOEL+re0hX36RdIJLJzMAeQED3OWbP8r10OvV
	sb20q7gNc6o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D9F62F3F4;
	Tue, 19 Jul 2016 15:33:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6A7C2F3F3;
	Tue, 19 Jul 2016 15:33:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin am
References: <cover.1467717729.git.johannes.schindelin@gmx.de>
	<cover.1467902082.git.johannes.schindelin@gmx.de>
	<xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607141414180.6426@virtualbox>
	<xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com>
	<xmqqshv6h460.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607191427400.3472@virtualbox>
	<alpine.DEB.2.20.1607191602520.3472@virtualbox>
Date:	Tue, 19 Jul 2016 12:33:55 -0700
In-Reply-To: <alpine.DEB.2.20.1607191602520.3472@virtualbox> (Johannes
	Schindelin's message of "Tue, 19 Jul 2016 16:28:30 +0200 (CEST)")
Message-ID: <xmqq4m7lfmn0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BCABCB86-4DE7-11E6-B454-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do not need cc/apply-am at all, it turns out, but my patch series has a
> minor conflict with 'jc/renormalize-merge-kill-safer-crlf'.
>
> Since you indicated that you want to cook that branch a bit in 'next'
> first, I will rebase to master+bc/cocci+js/am-call-theirs-theirs and
> re-submit.

Thanks.  I suspect the renomalization would graduate earlier than
the topic in question, but leaving dependency to the minimum and
have rerere take care of minor conflicts has proved to be a better
approach in general over time; the base you chose above sounds
appropriate.

Thanks.
