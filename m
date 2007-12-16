From: Junio C Hamano <gitster@pobox.com>
Subject: Re: trim_common_tail bug?
Date: Sun, 16 Dec 2007 11:43:28 -0800
Message-ID: <7v8x3ul927.fsf@gitster.siamese.dyndns.org>
References: <20071215111621.GA8139@coredump.intra.peff.net>
	<20071215155150.GA24810@coredump.intra.peff.net>
	<7vprx7n90t.fsf@gitster.siamese.dyndns.org>
	<20071215200202.GA3334@sigill.intra.peff.net>
	<20071216070614.GA5072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 20:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zPL-00073q-14
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 20:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbXLPTnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 14:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbXLPTnt
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 14:43:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbXLPTnt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 14:43:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F00753606;
	Sun, 16 Dec 2007 14:43:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 752FC3605;
	Sun, 16 Dec 2007 14:43:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68480>

Jeff King <peff@peff.net> writes:

> On Sat, Dec 15, 2007 at 03:02:02PM -0500, Jeff King wrote:
>
>> >   	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
>> > 		while (recovered < trimmed && ap[recovered++] != '\n')
>> > 	        	; /* nothing */
>> > 	}
>> > 
>> > then (warning: I haven't had my coffee yet)?
>> 
>> Yes, I think that is equivalent. My sleep-deprived brain keeps thinking
>> there must be a more clear way of writing this whole loop, but it
>> escapes me at the moment.
>
> And this came to me in a dream. :) It fixes the bug, and I think it is a
> bit simpler to see the termination conditions in a single loop. But
> please double-check correctness, and that you agree that it is more
> readable.

I wanted to recover to the end of the line that includes the cut-off
point, even when (ctx == 0), to be extra safer, but I do not think it
was necessary.

> ...
>  		bp -= blk;
>  	}
>  
> +	while (recovered < trimmed && ctx)
> +		if (ap[recovered++] == '\n')
> +			ctx--;
>  	a->size -= (trimmed - recovered);
>  	b->size -= (trimmed - recovered);
>  }
