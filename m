From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 13:05:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703141301210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com> 
 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:05:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRSEf-0000Cm-8m
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 13:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbXCNMF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 08:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbXCNMF1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 08:05:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:41535 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161177AbXCNMF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 08:05:26 -0400
Received: (qmail invoked by alias); 14 Mar 2007 12:05:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 14 Mar 2007 13:05:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sVrt2swNs/rn1FZjkzBmy79x6AWK1V+xybL82DE
	LtKvGfB8YWmLTP
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703140137i6d0df44aua9205e81249570ea@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42202>

Hi,

On Wed, 14 Mar 2007, Alex Riesen wrote:

> On 3/14/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > So, big master to hom everybody bows, how to return the correct value
> > > > when executing a pager? Because this _has_ to be done if we go that
> > > > way.
> > >
> > > Why? If you execute the pager, nobody cares about the error value
> > > anyway.
> > >
> > > I don't see why you would mix in a pager here. If you do
> > >
> > >       diff -u file1 file2 | less -S
> > >
> > > the return value of the pipe will not only generally be totally
> > > uninteresting and never used, but it will be the return value of "less"
> > > anyway. Which is what we'd get quite naturally.
> > 
> > The thing is, most people do not realize that
> > 
> >         git diff file1 file2
> > 
> > _will_ execute a pager. As foreground process. And the return value is
> > that of the pager.
> 
> In this example this is obviously (sometimes it is obscurely) interactive.
> The return code is seldom expected.
> 
> More sneaky case could be this:
> 
>  git diff file1 file2 > tmp && do_something
>  rm -f tmp
> 
> But we have isatty in setup_pager, so this works properly.

The problem is test cases. I think that we pipe the output of the test 
case _anyway_, so the isatty() call is helping us there.

If we did not (this applies to test cases _outside_ of Git, too), then a 
simple

	git diff bla || exit

would not work as expected. Even worse, as long as it is piped somewhere, 
even cat, it works. But once you no longer pipe it (to get the nice pager, 
for example), it stops working.

Ciao,
Dscho
