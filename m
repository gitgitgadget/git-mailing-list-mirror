From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Fri, 20 Mar 2009 14:52:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903201446590.6865@intel-tinevez-2-302>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com>  <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>  <20090319214001.GA6253@blimp.localdomain>  <alpine.DEB.1.00.0903200025170.10279@pacific.mpi-cbg.de> 
 <81b0412b0903200130s594ce3beyae21eb0b5cc8fe0@mail.gmail.com>  <alpine.DEB.1.00.0903201015270.10279@pacific.mpi-cbg.de> <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-172942736-1237557173=:6865"
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 14:54:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkfBC-0006jd-AE
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 14:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZCTNw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 09:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbZCTNw5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 09:52:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:57947 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751720AbZCTNw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 09:52:56 -0400
Received: (qmail invoked by alias); 20 Mar 2009 13:52:53 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp037) with SMTP; 20 Mar 2009 14:52:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/91iZf2P798jhuQyfTiiDmspmmfP3gk90sfqxhdy
	PqOPsJWFJ+Q/ZA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81b0412b0903200639v6d99067csb7715d9a5a3f0ba4@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113958>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-172942736-1237557173=:6865
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 20 Mar 2009, Alex Riesen wrote:

> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > On Fri, 20 Mar 2009, Alex Riesen wrote:
> >
> >> 2009/3/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> > Now, we _do_ have msysGit, you _do_ have shown the capability to 
> >> > fix issues when they arise, so I do _not_ see any obstacle why you 
> >> > should not go msysGit, rather than staying with the pain of trying 
> >> > to stay POSIX-compatible, but not quite all the time.
> >>
> >> I understand. It is not pure POSIX compatibility I seek. I just can't 
> >> use MinGW port, because I absolutely must use the cygwin environment 
> >> (for "hysterical" reasons) and they don't play well together (tried, 
> >> yes. Conflicting libraries, but you already know that).
> >
> > Maybe we can work on those conflicting libraries?  After all, we do 
> > have a "rebase.exe" tool now (for all those as puzzled by the naming 
> > as I was: the rebase.exe tool can shift the memory range used by a 
> > .dll so that it does not overlap with that one of another .dll).
> 
> As long as they can be made to coexist I'm fine. Wasn't the problem that 
> MinGW/MSYS used cygwin1.dll if it were in PATH? Or was it something else 
> with their supporting libraries?

I think it is the fact that msys-1.0.dll is a stripped-down fork of 
cygwin1.dll.

It is needed to run shell and perl scripts.

(Unfortunately, a few important parts of Git are still implemented as 
shell scripts: bisect, pull and rebase being the most obvious to me, but 
repack, stash and submodule are not too unimportant, either.)

> My other problem is that the cygwin programs, and the worst of all - a 
> proprietary compiler based on cygwin, must be in PATH. AFAIR, the 
> presence of cygwin in PATH broken shell scripting.

If it is a PATH issue, then it should be fixable by teaching msysGit to 
prepend $GIT_ROOT/bin and $GIT_ROOT/libexec/git-core to the PATH, but 
AFAIR we already do that.

*clicketyclick*

Yep, from reading setup_path() in exec_cmd.c, it appears that we prepend 
the PATH correctly.

Traditionally, we did have problems with Cygwin, that is correct, but I 
think with your help we can resolve the interaction issues.

Ciao,
Dscho

--8323329-172942736-1237557173=:6865--
