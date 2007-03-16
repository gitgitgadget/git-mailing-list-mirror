From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 12:51:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703161248380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
 <45FA501B.FA5B9F30@eudaptics.com> <vpqveh15zvn.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Mar 16 12:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSAxt-0007JI-Al
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 12:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbXCPLvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 07:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbXCPLvQ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 07:51:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:41469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964802AbXCPLvP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 07:51:15 -0400
Received: (qmail invoked by alias); 16 Mar 2007 11:51:13 -0000
X-Provags-ID: V01U2FsdGVkX18CweUfBPUCZQKDFp1R0gCvs/YvKbdpzTJVE801Tc
	b65C4E9KaqHRMS
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <vpqveh15zvn.fsf@olympe.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42349>

Hi,

On Fri, 16 Mar 2007, Matthieu Moy wrote:

> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > You could think about longjmp(3)ing out into main(), which would have to
> > setjmp(3). But in order to clean up intermediate frames, you would have
> > to have a stack of setjmp/longjmp buffers.
> >
> > Oh, well, how do I *love* them C++ exceptions!
> 
> You can have exceptions in C too.
> 
> I've used it a bit while contributing to Baz 1.x (the fork of tla).
> The library used was cexcept ( http://cexcept.sourceforge.net/ ).
> 
> As you mention, jumping is the easy part, and cleaning up is the hard
> one. Baz was using talloc, hacked to somehow work with cexcept. The
> mini-library doesn't seem to be available as a tarball anymore, so I
> did the checkout+targz in case someone's curious to have a look, and
> lazy enough not to install baz to get it:
> 
> http://www-verimag.imag.fr/~moy/tmp/talloc-except--2.0.1--patch-2.tar.gz
> 
> This stuff is not supported anymore, but very small anyway.

I was thinking about a similar approach some time ago. But that means that 
you _must not_ have static variables that you rely on being initialised 
correctly.

I mean, we have xmalloc(), and it would be easy to enforce xfree(), too 
(which would be good for memory profiling anyway), and we _could_ hack 
that into tracking which pointers were returned after which checkpoint.

But we _cannot_ say which static variables should be initialised (and 
how), after some "exception" was thrown at a certain point.

Ciao,
Dscho
