From: Sean <seanlkml@sympatico.ca>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 02:15:29 -0400
Message-ID: <BAYC1-PASMTP04CC69006B1B0728D73152AE1A0@CEZ.ICE>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745.15344.qmail@web51005.mail.yahoo.com>
	<20060927033459.GA27622@coredump.intra.peff.net>
	<BAYC1-PASMTP0819E6B1CBE028BD171598AE1A0@CEZ.ICE>
	<7v3badkj4k.fsf@assigned-by-dhcp.cox.net>
	<20060927010437.5fa57ed0.seanlkml@sympatico.ca>
	<20060927055216.GA28490@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Matthew L Foster <mfoster167@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 08:15:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSShu-0004wM-NI
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 08:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWI0GPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 02:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbWI0GPc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 02:15:32 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:43764 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S965134AbWI0GPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 02:15:31 -0400
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.94.249.130]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 26 Sep 2006 23:15:31 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1GSShd-0004io-Pm; Wed, 27 Sep 2006 02:15:29 -0400
To: Jeff King <peff@peff.net>
Message-Id: <20060927021529.69fd7274.seanlkml@sympatico.ca>
In-Reply-To: <20060927055216.GA28490@coredump.intra.peff.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 27 Sep 2006 06:15:31.0526 (UTC) FILETIME=[55DE0660:01C6E1FC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 27 Sep 2006 01:52:16 -0400
Jeff King <peff@peff.net> wrote:

> Yes, that is what I was trying to point out by making the branch/repo
> distinction in my previous mail.

Yeah, Junio's response made me realize that.  Apologies.

> We should be able to make a naive space-time tradeoff: whenever a ref is
> updated from X to Y at time T, for each commit C in X..Y, mark the tuple
> (ref, C) with time T. Assuming a reasonably packed format (20 bytes of
> SHA1, 4 bytes of time, sorted into .git/time-cache/master) the git
> repository would require less than 1M per branch. Updating the ref
> becomes much more expensive, but looking up the value is quite cheap.

Yes.  It should be relatively straight forward, and removes the need to
use the reflog at all.  It's the right tradeoff since the value would
be queried much more often than updated.
 
> Of course, rewinding would make this more complicated. I'm still not
> convinced this approach is worth the effort.

You could almost ignore rewinding without too big a problem, or at least
only deal with it when performing a prune.

As for being worth the effort, we'll have to see if anyone steps up to
actually offer a patch.  If not, you're right again :o)

Sean
