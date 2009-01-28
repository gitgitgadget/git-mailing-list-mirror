From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Windows: Fix intermittent failures of t7701
Date: Wed, 28 Jan 2009 13:43:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901281341330.3586@pacific.mpi-cbg.de>
References: <497F076F.8060509@viscovery.net> <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de> <20090128042814.GA18216@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 13:44:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS9m7-0005hy-Id
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 13:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbZA1Mmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 07:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbZA1Mmp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 07:42:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:38633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbZA1Mmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 07:42:44 -0500
Received: (qmail invoked by alias); 28 Jan 2009 12:42:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 28 Jan 2009 13:42:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+8tMIqvt+8xMDux4c4zw519NbCq7PZkp/nvXWGEt
	lEVTcEWTRd9UGb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090128042814.GA18216@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107531>

Hi,

On Tue, 27 Jan 2009, Jeff King wrote:

> On Tue, Jan 27, 2009 at 05:42:03PM +0100, Johannes Schindelin wrote:
> 
> > > We want to catch failures of test-chmtime; but since it appears in a 
> > > pipe, we cannot access its exit code. Therefore, we at least make sure 
> > > that it prints time stamps of all files that are passed on its command 
> > > line.
> > 
> > I use this trick in my valgrind series:
> > 
> > 	($PROGRAM; echo $? > exit.code) | $OTHER_PROGRAM &&
> > 	test 0 = "$(cat exit.code)"
> 
> Oh, that's far too readable. How about:
> 
>   exec 3>&1
>   status=$( ( ($PROGRAM ; echo $? >&4) | $OTHER_PROGRAM >&3) 4>&1 )
>   exec 3>&-
> 
> But seriously, I think if we are talking about tests, then
> 
>   $PROGRAM >output &&
>   $OTHER_PROGRAM <output
> 
> is very clear to read, and as a bonus makes "output" accessible for
> viewing when the test breaks.

The real problem is that in my case, OTHER_PROGRAM=tee.

But you're right, Hannes was talking about tests, where it might 
even make sense to have a record of what was passed between the 
two programs.

Ciao,
Dscho
