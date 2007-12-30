From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach revision walker about reflog ranges
Date: Sun, 30 Dec 2007 11:32:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301126560.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0712300000170.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <7vve6h9gvz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 11:32:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8vT7-0000ys-6M
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 11:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXL3KcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 05:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXL3KcI
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 05:32:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:49223 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751350AbXL3KcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 05:32:05 -0500
Received: (qmail invoked by alias); 30 Dec 2007 10:32:04 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp048) with SMTP; 30 Dec 2007 11:32:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195zgR/01p5Xk3hm8yp+aZvm0+nGKrfw/whRcnkED
	4xI4fBvPzBh3nM
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vve6h9gvz.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69344>

Hi,

On Sat, 29 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Now you can ask for a revision range
> >
> > 	master@{2.weeks.ago..1.day.ago}
> >
> > or even something like
> >
> > 	HEAD@{20..yesterday}
> 
> You can _ask_ all you want, but it is not clear what it does from this 
> description.  I guess you are rewriting master@{A..B} to 
> master@{A}..master@{B}, but that is not clear from the commit log nor 
> documentation (did I even see a documentation patch?).

Oh, sorry, I meant to mark this as RFC-after-1.5.4.  It's just that I had 
a need for it, and hacked it.

> Also, I am not convinced that the rewrite gives the semantics the users 
> naturally expect from @{A..B}.  I would even suspect that people would 
> expect "git log master@{0..2}" to behave more like "git show master@{0} 
> master@{1} master@{2}".

Is that so?  I would have expected "git log -g master@{2..0}" like that.  
It would be relatively easy to accomodate your wish (almost: it would not 
handle 0..2, but only 2..0) by calling

	init_reflog_walk(&revs->reflog_info);

in the case that ".." was found inside "@{[...]}".

But my use case was to make it easy to see what changed in a multi-branch 
remote without much typing: "git log origin/master@{1..}", which would not 
be helped by that change.

Ciao,
Dscho
