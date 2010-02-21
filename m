Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 15709 invoked by uid 107); 21 Feb 2010 19:45:39 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 21 Feb 2010 14:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889Ab0BUTpQ (ORCPT <rfc822;peff@peff.net>);
	Sun, 21 Feb 2010 14:45:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47456 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab0BUTpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2010 14:45:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 874269C9E5;
	Sun, 21 Feb 2010 14:45:11 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lAJ2pGRXfQ5i+zri0T6Gk98+aUA=; b=NlH0tp
	iE/rvANjJ3/2pEp6/ID8BQtY1SsHO53ehI1eJff+34otaPI+bsGQz4M+cay3NeF+
	xwkQ9YXouD/IP1AkGOlII3XbjCWPTYmKq3waD0rh7bJ2/mFye6qE0hpwfq5mj8JH
	0YJC4umfNxnIwoQBT9TKsHn7pgXUBb0W2t10g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mwzrNZXnepRUNS5ltWcTqejJ5vzL3bDt
	HDnPFQuMRY5ZjUuXSU5ZK1apcSmOloaqSHfU6Yb8DexqRpwx3t70kBAbMVkkkslf
	Wc8+p8l7DbgPEmU9EBbD6qDlSwrqwCk/bpfXhRG5wXum66Zmtof0XJ6PSHugv8hg
	ZnUsiqXnYlA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A7D9C9D5;
	Sun, 21 Feb 2010 14:45:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99DDA9C9D1; Sun, 21 Feb
 2010 14:45:04 -0500 (EST)
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Sun, 21 Feb 2010 11:45:02 -0800
In-Reply-To: <alpine.LFD.2.00.1002202323500.1946@xanadu.home> (Nicolas
 Pitre's message of "Sat\, 20 Feb 2010 23\:27\:31 -0500 \(EST\)")
Message-ID: <7vd3zys79d.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 9D6B5F1C-1F21-11DF-96F1-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> I think this is worth doing independently of the paranoid mode being 
> discussed.

While I agree it might be worth doing, I can see that you really hate
"paranoia".  Now your loop is letting deflate() decide how much it happens
to like to consume in a given round, it is much trickier to plug the
paranoia in without majorly rewriting the loop this patch introduces.

