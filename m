From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the reflogs
 twice
Date: Tue, 20 Jan 2009 01:23:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901200121190.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de> <200901200111.38917.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 20 01:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP4Ql-0005lm-9F
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 01:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765858AbZATAX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765852AbZATAX6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 19:23:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:33691 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765835AbZATAX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 19:23:57 -0500
Received: (qmail invoked by alias); 20 Jan 2009 00:23:55 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 20 Jan 2009 01:23:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19MgrFYdhZMls7KCwi/44GMbessMGioeO6qMFxVdF
	BPSeCtW7cZgLIB
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901200111.38917.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106418>

Hi,

On Tue, 20 Jan 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > > Junio C Hamano <gitster@pobox.com> writes:
> > > > You can have quite a many reflog entries, but you typically won't recall
> > > > which branch you were on after switching branches for more than several
> > > > times.
> > 
> > This, together with a removal of the hard-coded limit of 16 could be 
> > squashed with this patch:
> 
> You know, I'm quite puzzled as to why we had working code that could
> read the reflog backwards earlier in this thread, but it got shot down
> solely based on impact and line counts, and you now have to jump
> through hoops to work around the lack of this exact functionality.

Okay, I should have told you what my two main concerns with the patch 
were.

1) it introduces a lot of code, with a lot of possibility for bugs to hide 
   (and I found it not simple enough to slap my head and say "of course, 
   this is obvious" as I did with Junio's code (except the modulo thing 
   which I had to thing about for half a minute)).

2) on Windows, mmap() is really implemented as xmalloc() && fread().  So 
   all the shortcomings of what Junio said about my array approach would 
   hold true for your approach, too.

Ciao,
Dscho
