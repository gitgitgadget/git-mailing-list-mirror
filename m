Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 31456 invoked by uid 107); 22 Feb 2010 19:57:25 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 22 Feb 2010 14:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167Ab0BVT5B (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Feb 2010 14:57:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab0BVT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:57:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AFE9CD86;
	Mon, 22 Feb 2010 14:56:59 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3rjhcXh/Hi+kADN6ijRjPl4QKls=; b=uLin7p/KH1xua41tS4fKx/F
	RseWxkcmAcZiZ4A0YTWikuktjbCslwrvJnpW8Z/5mALwo01Or1TCTHv8E5n7EWdl
	wIo4ZmLOb6dRHhKi9Q0bPeEZzyR6x5dZEkvaBS34uh7e3capb9ipV2wBLus89VhZ
	vVe8fbbZMpSiI2dbe/ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=NsS95n7E7MHXjD7vnN8ynQFzADG3U1X6QwEKym9Uc/9QFP4S5
	WBaXWWZWHhC+OnxzdCSdgO5OijCb1HobPx92OYkCUeZtfnTIBaIlMyrdWGHBTZG+
	RBk6dIPH+LP53Eg1kY0XdO2lF75olfeLQuP1pzVDimTLLDcnM3mYt7cEwI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FB469CD84;
	Mon, 22 Feb 2010 14:56:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EED7F9CD83; Mon, 22 Feb
 2010 14:56:54 -0500 (EST)
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL for any
 error.
References: <vpq7hq8stjt.fsf@bauges.imag.fr>
 <1266621718-4879-5-git-send-email-Matthieu.Moy@imag.fr>
 <7v4olbpyh3.fsf@alter.siamese.dyndns.org> <vpq7hq5n2mk.fsf@bauges.imag.fr>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 22 Feb 2010 11:56:53 -0800
Message-ID: <7vzl31cad6.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 6EC5BAF6-1FEC-11DF-80F5-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Just removing the line would work with the current code, but this "if
> (errno <= 0) errno = EINVAL;" allows enforcing the invariant that
> errno > 0 when reaching "return -1" in a simple and reliable way (i.e.
> changing the for loop later cannot break this invariant by mistake).

I do not think "errno > 0 when -1 is returned" is a meaningful invariant.
You may return EINVAL which is positive and that may keep that invariant,
but you should not be returning that errno unless the error is "template
not ending with 6-X" to begin with, so there isn't a real gain, no?



