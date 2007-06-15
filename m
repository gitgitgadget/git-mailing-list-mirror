From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-pack SIGSEGV..
Date: Thu, 14 Jun 2007 22:50:49 -0700
Message-ID: <7vvedp935y.fsf@assigned-by-dhcp.pobox.com>
References: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 15 07:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz4hy-0006A4-P2
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 07:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXFOFuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbXFOFuv
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 01:50:51 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35583 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXFOFuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 01:50:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070615055050.MLSM6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 Jun 2007 01:50:50 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Bhqp1X00L1kojtg0000000; Fri, 15 Jun 2007 01:50:50 -0400
In-Reply-To: <alpine.LFD.0.98.0706142124380.14121@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 14 Jun 2007 21:29:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50243>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I *suspect* it's due to the refspec pattern matching changes Daniel did, 
> but again - I haven't actually debugged it any deeper.

I am officially recuperating from an operation I had today, so I
cannot really take a deep look at this.

I think what is going wrong is that struct refspec for pattern
match that is parsed by parse_ref_spec does not have ->dst
component filled for "refs/tags/*" refspec, but match_refs()
does not check if pat->dst is NULL, in which case it should
reuse pat->src value.

Incidentally I have other remote.c fixes queued in 'next'.  I
haven't yet checked if I (accidentally) fixed this already.
