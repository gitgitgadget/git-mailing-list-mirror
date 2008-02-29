From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 22/40] Windows: Implement asynchronous functions as
 threads.
Date: Fri, 29 Feb 2008 01:17:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802290112340.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-23-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281525510.22527@racer.site> <200802282201.06802.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 29 02:19:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUtu0-0002SU-Lz
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 02:19:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYB2BSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 20:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYB2BSQ
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 20:18:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:33496 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751061AbYB2BSO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 20:18:14 -0500
Received: (qmail invoked by alias); 29 Feb 2008 01:18:12 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp011) with SMTP; 29 Feb 2008 02:18:12 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+GtacUQ9SGYXBGwM4SnyGKAHqr1X1v3tFT8hLeWC
	jLbDDGq2w20OHR
X-X-Sender: gene099@racer.site
In-Reply-To: <200802282201.06802.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75482>

Hi,

On Thu, 28 Feb 2008, Johannes Sixt wrote:

> On Thursday 28 February 2008 16:28, Johannes Schindelin wrote:
>
> > On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > > In upload-pack we must explicitly close the output channel of 
> > > rev-list. (On Unix, the channel is closed automatically because 
> > > process that runs rev-list terminates.)
> >
> > When I read this patch, my impression was that it litters the source 
> > code with #ifdef's.  IMO this makes the code less readable, and as a 
> > consequence easer to fsck up.
> >
> > Unfortunately, I have no idea how to help that, other than 
> > implementing compat/thread.[ch], abstracting the thread functions, and 
> > introducing a NO_FORK Makefile variable and preprocessor constant.
> >
> > Hmpf.
> 
> The number of #ifdef/#endif is already at a minimum unless you are 
> willing to have entire functions in separate #ifdef/#else/#endif 
> branches. Whether to have compat/thread.[ch] or not is just a question 
> of whether you want to have asynchronous functions in threads also on 
> Unix or not.

Well, my idea was that Git's code looks as good as it does now not only 
because the functions are well written, but because the 
conditionally-compiled code is not classified by _platform_ but by 
_reason_.

For example, we do not write that on FreeBSD, we do this and that, but 
we define for FreeBSD that there is no strlcpy(), and if NO_STRLCPY is 
defined, we implement it.

Likewise, I would prefer to have it in the code here _not_ that we do this 
and that on MinGW32, but that in the absence of a usable fork(), we 
require certain functions (declared in compat/thread.h, for example), and 
use them.

But I know this is a lot of work, so I hoped for a better solution, that 
still excites my "elegance neuron".

Ciao,
Dscho

