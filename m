From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 23:02:20 -0700
Message-ID: <7viqgdoikz.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS>
 <7vljlauxmk.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231515020.29625@GWPortableVCS>
 <7vzl9qtev0.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908232044060.29625@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Mon Aug 24 08:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfSdg-0002HT-83
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 08:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbZHXGCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 02:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbZHXGCa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 02:02:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45184 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbZHXGC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 02:02:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4980534780;
	Mon, 24 Aug 2009 02:02:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ct3wSmQQZIfUIzbdNAgPIQW3k7E=; b=P/rlY2
	3DkY0YDOHnNMwLB8faftTj8Q2XYfEKfAG+l6gM88v6N3iEDfjDg9YH3t4w3lh9jp
	RbcxdhQR2zweJWzIbvCQXun+S5dB/PP6ZirvmzaerMqNH42J/fnWqBZmvRPmlm0I
	2jbvsVUZripSr2n7kMLaTFbGONt3xA3A1L8R0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8a2n8SDLNbIBCo4AV2vnoopext3wIGv
	pc09o4oZSoYxXRfZQm5DAfljuPem+euNqH8h5FF/7mXbpI8PX6ldCDkgcze5hfJL
	yBKchHknKT78JADKo8sR6hEjqCzoNRQJdMPY3YTrqfbgx+T1UV8KK7IwtXUKxRtO
	X2wCPc7lELo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 227C83477F;
	Mon, 24 Aug 2009 02:02:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 99F943477D; Mon, 24 Aug 2009
 02:02:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0908232044060.29625@GWPortableVCS> (Thell
 Fowler's message of "Sun\, 23 Aug 2009 22\:26\:56 -0500 \(CDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B344AB5A-9073-11DE-AC7D-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126908>

Thell Fowler <git@tbfowler.name> writes:

> It passed every test I threw at it, although it seemed to be a tad bit 
> slower than the previous revision on my sample data so I ran the following 
> command several times for both the previous and current version:
>
> time for i in {1..10}; do ./t4015-diff-whitespace.sh>/dev/null && 
> ./t4015-diff-trailing-whitespace.sh >/dev/null; done
>
> And these results are fairly average on what I saw:
>
> Previous version:
> real	2m32.669s
> user	0m44.051s
> sys	1m34.702s
>
>
> Current version:
> real	2m56.818s
> user	0m47.671s
> sys	1m46.723s

Do you mean by "previous version" the one that was broken, or the one I
sent as a "how about" patch?

Here are the numbers I am getting:

$ /usr/bin/time sh -c 'for i in 1 2 3 4 5 6 7 8 9 0; do  ./t4015-diff-whitespace.sh; done' >/dev/null

----------------

1.99user 3.65system 0:05.10elapsed 110%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288675minor)pagefaults 0swaps

1.86user 3.66system 0:05.04elapsed 109%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288618minor)pagefaults 0swaps

1.76user 3.87system 0:05.02elapsed 112%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288973minor)pagefaults 0swaps

----------------

1.81user 3.86system 0:05.08elapsed 111%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288836minor)pagefaults 0swaps

1.76user 3.87system 0:04.95elapsed 113%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288880minor)pagefaults 0swaps

1.81user 3.88system 0:05.04elapsed 112%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+12560outputs (0major+1288530minor)pagefaults 0swaps

----------------

One set is with patch and one set is the patch reverted.  I cannot quite
remember which one is which ;-) but the difference is within the noise for me.

I have to revisit this sometime after getting a long rest.
