From: Paul Mackerras <paulus@samba.org>
Subject: Re: New features in gitk
Date: Thu, 1 Nov 2007 21:00:11 +1100
Message-ID: <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710272229430.30120@woody.linux-foundation.org>
	<18212.13862.637991.30536@cargo.ozlabs.ibm.com>
	<alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 11:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InX1b-0008Sc-51
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 11:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535AbXKAKL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 06:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757063AbXKAKL2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 06:11:28 -0400
Received: from ozlabs.org ([203.10.76.45]:52147 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756704AbXKAKL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 06:11:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 94268DDE1F; Thu,  1 Nov 2007 21:11:26 +1100 (EST)
In-Reply-To: <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62933>

Linus Torvalds writes:

> (And as mentioned many times earlier - if you can avoid topo-order and 
> date-order entirely, you are going to perform a million times better at 
> startup for the cold-cache case. Since you seem to be doing the graph 
> layout lazily now, maybe you could aim for that some day? It does mean 
> that you might - occasionally - end up having to add a commit to 
> *before* one you already laid out).

The other thing --topo-order does is reorder the commits so that
related commits come together.  So far, doing that in Tcl has turned
out to be much slower than having it done in C (within git log) for
the hot-cache case (which I expect is the common case).

I'm now thinking that the best approach would be to have gitk cache
the topology, and on startup only read in the part of the graph that
isn't in the cache.  Mostly that will be small and so git log should
be fast even in the cold-cache case with --topo-order.

Paul.
