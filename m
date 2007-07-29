From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sun, 29 Jul 2007 13:04:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291258410.14781@racer.site>
References: <20070729002427.GA1566@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
 <20070729041159.GA5544@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
 <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
 <20070729094955.GA14915@coredump.intra.peff.net> <Pine.LNX.4.64.0707291214060.14781@racer.site>
 <20070729113850.GA17796@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 14:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7Vj-0001Ag-6y
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758313AbXG2MEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758604AbXG2MEc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:42924 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758298AbXG2MEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:04:31 -0400
Received: (qmail invoked by alias); 29 Jul 2007 12:04:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 29 Jul 2007 14:04:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F5lY7UNRFbmCKMP1JQY5JZYPqF7proF8CHki2pw
	kOlOeNCzib6H8G
X-X-Sender: gene099@racer.site
In-Reply-To: <20070729113850.GA17796@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54109>

Hi,

On Sun, 29 Jul 2007, Jeff King wrote:

> On Sun, Jul 29, 2007 at 12:14:49PM +0100, Johannes Schindelin wrote:
> 
> > How about
> > 
> > 	if (!rev.diffopt.quiet)
> > 		rev.diffopt.recursive = 1;
> > 
> > instead?
> 
> Can you explain?

The idea is this: when "--quiet" was given, we do not output anything, and 
therefore do not have to recurse into the directories, because we already 
know that there are differences when a _tree_ is different.  I do not 
remember all details of the "--quiet" implementation, but I think that it

- exits early (as you said)

- does not turn on "recursive" to avoid unnecessary work.

Imagine something like this: tree "a" and "b" contain 100,000 elements 
each, which are identical except for the last entry.  "--quiet" does not 
need to check the 99,999 elements before that one, since the tree hashes 
are already different.

Of course, this reasoning breaks down fatally when you specify something 
like "--ignore-whitespace", but those cases should turn on recursive 
explicitely, so that the performance penalty of "recursive = 1" does not 
percolate back to the (much more common) trivial cases.

Ciao,
Dscho
