From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] refactor dir_add_name
Date: Tue, 12 Jun 2007 00:13:01 -0700
Message-ID: <7v7iq9lk76.fsf@assigned-by-dhcp.pobox.com>
References: <20070611123045.GA28814@coredump.intra.peff.net>
	<20070611133944.GA7008@coredump.intra.peff.net>
	<7vk5uaqx3q.fsf@assigned-by-dhcp.pobox.com>
	<20070611194651.GA15309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 12 09:13:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy0Yy-0005eB-Fb
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 09:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbXFLHNF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 03:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXFLHNF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 03:13:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49776 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbXFLHNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 03:13:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070612071303.ZTMX3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 12 Jun 2007 03:13:03 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id AXD11X00F1kojtg0000000; Tue, 12 Jun 2007 03:13:02 -0400
In-Reply-To: <20070611194651.GA15309@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Jun 2007 15:46:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49930>

Jeff King <peff@peff.net> writes:

> ... But we could do something like
> (totally untested):
>
> #define alloc_grow(x, nr, alloc) \
>   alloc_grow_helper(&(x), nr, &(alloc), sizeof(*(x)))
>
> inline
> void alloc_grow_helper(void **x, int nr, int *alloc, int size)
> {
>   if (nr >= *alloc) {
>     *alloc = alloc_nr(*alloc);
>     *x = xrealloc(*x, *alloc * size);
>   }
> }
>
> Horribly ugly (I'm seeing stars!) but probably a bit safer in the long
> run, and nobody needs to look at it most of the time. :)
>
> What do you think?

That looks ugly and also I am curious what the generated
assembly would look like.  Hopefully the compiler is clever
enough to generate the same code, but I dunno.

Unless somebody else more versed with C preprocessor tricks
comes along and offers a better advice, I would go with the
earlier simpler one with a big fat warning.  I however would
prefer all caps name for a magic macro like this, whose sole
point is a huge side effect.

Anyway, it appears that Jonas picked up your patch to polish up,
so I won't touch this series until that resurfaces.
