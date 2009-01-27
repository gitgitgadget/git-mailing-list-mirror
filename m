From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 17:31:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901271728130.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 17:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRqrG-00007E-0A
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 17:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbZA0Qau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 11:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbZA0Qas
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 11:30:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:52577 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753441AbZA0Qas (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 11:30:48 -0500
Received: (qmail invoked by alias); 27 Jan 2009 16:30:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 27 Jan 2009 17:30:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GZNcQIwUGwFYLZBExzLUnlrTgc8TDsgNDmkc4z/
	YycDQm8jNgpYn0
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090127062512.GA10487@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107358>

Hi,

On Tue, 27 Jan 2009, Jeff King wrote:

> On Thu, Jan 08, 2009 at 04:07:08PM +0100, Johannes Schindelin wrote:
> 
> > Just try this with a submodule that has more changes than fit on a 
> > screen:
> > 
> > 	$ git -p submodule summary
> > 
> > In my tests, it consistently fscks up my console.  I wonder if this is 
> > related to ea27a18(spawn pager via run_command interface).
> 
> OK, here is a patch series that fixes the problem:
> 
>   1/3: git: s/run_command/run_builtin/
>   2/3: run_command: handle missing command errors more gracefully
>   3/3: git: use run_command to execute dashed externals
> 
> 1 is a cleanup, 2 is infrastructure support, and 3 is the actual fix.

I like the patch series, well designed and concise (especially with the 
fixes Hannes proposed).

> There are two potential downsides to the fix:
> 
>  1. There is an extra fork and a parent process sitting in memory for
>     dashed externals. This is pretty necessary to any fix, since
>     something has to wait to do pager cleanup, and we can't rely on the
>     child to do so.

Actually, I think this is a good thing; that way, we can catch 
segmentation fault properly and display an error message in the pager.  
That was not possible previously.

>  2. A failed attempt to execute a dashed external results in an extra
>     fork. For builtins, this has no impact, since they take precedence.
>     For aliases, though, it means we will do an extra fork before
>     realizing that there is no dashed external and trying the alias.

All the more reason to build more programs in :-)

Ciao,
Dscho
