From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 15:21:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241518290.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>   
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
   <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
  <46A5FF69.F5D75C9E@eudaptics.com> <Pine.LNX.4.64.0707241435290.14781@racer.site>
 <46A607EB.BA31D7C5@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLGN-0006e7-PF
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231AbXGXOVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758211AbXGXOVT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:21:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:37228 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757533AbXGXOVT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:21:19 -0400
Received: (qmail invoked by alias); 24 Jul 2007 14:21:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 24 Jul 2007 16:21:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NZAl/ICJNWGJRFmZ7+PPDYrl894ZjmpRVQaBpZJ
	ZucxdyD4xLdJh8
X-X-Sender: gene099@racer.site
In-Reply-To: <46A607EB.BA31D7C5@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53600>

Hi,

On Tue, 24 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
>
> > On Tue, 24 Jul 2007, Johannes Sixt wrote:
> >
> > > But there's another problem. Consider this history:
> > >
> > >    ---X--o--M         <- master
> > >              \
> > >           ...-o-...-o <- topic
> > >
> > > Then this (rather contrieved) command:
> > >
> > >    $ git-filter-branch -n $n master topic --not X
> > >
> > > If $n is small enough so that M is never rewritten, then
> > >
> > >    git rev-list -1 "$ref" $negatives
> > >
> > > still expands to non-empty even for 'master' (= M), which then 
> > > incorrectly ends up in "$tempdir"/heads.
> > 
> > Aaargh!  Of course!  Since I have to add --topo-order at the end. 
> > Otherwise it makes no sense.
> 
> No, that was no my point: In my example above, if n=1, `git rev-list -1
> "$ref" $negatives` evaluates to
> 
>     $ git rev-list -1 "master" -n 1 ^X
> 
> which returns M, even though M is not going to be rewritten. 
> --topo-order changes nothing. The problem is that the -n is a relative 
> restriction. --since is turned into --max-age, which is absolute, 
> therefore, the test works as expected with --since.

So you think we have to say something like

	git rev-list "$ref" $negatives | grep "$ref" > /dev/null || continue

?

I really should add a test case for that.

Ciao,
Dscho
