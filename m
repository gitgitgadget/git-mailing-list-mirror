Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 31475 invoked by uid 107); 22 Feb 2010 19:57:36 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 22 Feb 2010 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab0BVT5Q (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Feb 2010 14:57:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0BVT5P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:57:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B721F9CD91;
	Mon, 22 Feb 2010 14:57:14 -0500 (EST)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MLjwBq+330mlc92c+cJCVqPHqvE=; b=sJBkP9ADxuwrVIXzbxOfDSD
	gTc7S09vj1MNDWVbaKAh0xikV5mYpfWJgEMOBpOJhE7qfFXXUNebN1AZRl5azfWS
	M1/NtNyCFwVYjpe+PcJnfBZWJxgnWry7FMzlbpDJc/uAfin+gCnVu3GkcZjGBq/9
	FT9iK04jKzSFLeEJMm30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PfnsgSAEifQzcoEhMRHXGCxlJ4bjX9tZYdpIgG24voELxUQBK
	NMWv5IhgyIp9Pn4JF6WFV+ZN/ivJ5UUHeyBjIQGwiqbw4F3FV+QJzukNgPwpBrbo
	pnuGV01XU1vOJ4qlNBrZ+gUBbAXNVz8BQaz9TE5IkB3wf4vQntpEB7TqnQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 382B19CD8A;
	Mon, 22 Feb 2010 14:57:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3C369CD85; Mon, 22 Feb
 2010 14:56:58 -0500 (EST)
To:	Nicolas Pitre <nico@fluxnic.net>
Cc:	Zygo Blaxell <zblaxell@gibbs.hungrycats.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Teach "git add" and friends to be paranoid
References: <20100214011812.GA2175@dpotapov.dyndns.org>
 <7vljer1gyg.fsf_-_@alter.siamese.dyndns.org>
 <20100219082813.GB17952@dpotapov.dyndns.org>
 <7v635tkta7.fsf@alter.siamese.dyndns.org>
 <7v8waniue8.fsf@alter.siamese.dyndns.org>
 <20100221072142.GA5829@dpotapov.dyndns.org>
 <7vhbpas7ut.fsf@alter.siamese.dyndns.org>
 <20100222033553.GA10191@dpotapov.dyndns.org>
 <7vwry5pxg8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002221033120.1946@xanadu.home>
 <20100222173122.GG11733@gibbs.hungrycats.org>
 <alpine.LFD.2.00.1002221238110.1946@xanadu.home>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 22 Feb 2010 11:56:57 -0800
Message-ID: <7vtyt9cad2.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Pobox-Relay-ID: 7484115E-1FEC-11DF-960E-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nicolas Pitre <nico@fluxnic.net> writes:

> We do have to make two separate passes anyway.  The first pass is to 
> hash the data only, and if that hash already exists in the object store 
> then we call it done and skip over the deflate process which is still 
> the dominant cost.  And that happens quite often.
>
> However, with a really large file, then it becomes advantageous to 
> simply do the hash and deflate in parallel one chunk at a time, and 
> simply discard the newly created objects if it happens to already 
> exists.  That's the whole idea behind the newly introduced 
> core.bigFileThreshold config variable (but the code to honor it in 
> sha1_file.c doesn't exist yet).

The core.bigFileThreshold could be used in sha1_file.c to decide writing
straight into a new packfile; that would avoid both the later repacking
cost and the cross directory rename issue for loose object files.
