From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using VC build git (new patch)
Date: Sat, 15 Aug 2009 19:29:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908151908300.8306@pacific.mpi-cbg.de>
References: <1976ea660908150921n516178dbs2ce024ed729e2e02@mail.gmail.com> <alpine.DEB.1.00.0908151851280.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 19:29:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McN3s-0005qv-U0
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 19:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452AbZHOR2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 13:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZHOR2w
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 13:28:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:45936 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753569AbZHOR2v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 13:28:51 -0400
Received: (qmail invoked by alias); 15 Aug 2009 17:28:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 15 Aug 2009 19:28:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wMfE9jgZwSY1k5PtnKWkP2MYaTJRjDnijMJseML
	mc62P03tMwQ6Mt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0908151851280.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126013>

Hi,

On Sat, 15 Aug 2009, Johannes Schindelin wrote:

> A single monster patch?
> 
> Hmm.
> 
> Please understand that I will not review that unless it is split up into 
> nice little and reviewable chunks.

Well, I try to improve.

So I had a look at your patch.  The changes fall naturally into one of the 
following categories:

	- decl-after-statement fixes

	- missing #include "git-compat-util.h"

	- converting a K&R style function definition to modern C

	- #undef's only needed for Microsoft Visual C++

	- the addition of O_BINARY in the file modes

	- disabling link() (why?)

	- double-#define'ing stat (which puzzles me greatly)

	- dummy #define'ing of a few compiler attributes

	- adding _MSVC to a conditional to avoid  #define'ing
	  SNPRINTF_SIZE_CORR yourself

	- #define'ing several symbols without leading underscore to the
	  MS-specific version with a leading underscore

	- implementing strcasecmp() in a misnamed file

	- "fixing" the return value of winansi_vfprintf for Microsoft 
	  Visual C++ (I think this fix is wrong)

	- correctly adding a Visual C++-specific conditional to 
	  git-compat-util.h, pager.c, run-command.c, run-command.h, 
	  setup.c and help.c, although the latter five could use some 
	  refactoring into git-compat-util.h

	  Maybe there is also room to change the MinGW-conditional into a
	  NO_TRUSTABLE_FILEMODE one

	- adding several headers missing from Visual C++'s installation

	- adding _huge_ .vcproj files (can they not be smaller?)

As you can see, there is a pretty natural way to split that huge patch 
into chunks that most people on these lists can review easily, and that 
would actually be a pleasure to look at.

Even better, there are a few fixes (the first three, if you ask me), which 
are not even Windows-specific.

Further, I would like to suggest adding a header file compat/msvc.h which 
contains all the #undef's and #define's necessary only for Visual C++, and 
which can be #include'd from git-compat-util.h, to better separate your 
work from the other platforms (who do not want those changes).  That 
should avoid those unwanted changes to mingw.c and mingw.h.  You just have
to make sure that msvc.h is #include'd before mingw.h.

With these comments, I look forward to your next iteration.

Ciao,
Dscho
