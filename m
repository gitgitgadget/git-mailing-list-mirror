From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 14:42:59 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908181420330.7195@iabervon.org>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302> <4A8AEAF5.6070205@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 20:43:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdTeH-00075u-9p
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 20:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbZHRSm7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbZHRSm7
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 14:42:59 -0400
Received: from iabervon.org ([66.92.72.58]:40989 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbZHRSm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 14:42:58 -0400
Received: (qmail 29303 invoked by uid 1000); 18 Aug 2009 18:42:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Aug 2009 18:42:59 -0000
In-Reply-To: <4A8AEAF5.6070205@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126436>

On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:

> Johannes Schindelin said the following on 18.08.2009 16:11:
> > On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> > > So, instead of rely on these vcproj files which *will* go stale, we
> > > can simply use the same Makefile system which everyone else is
> > > using. :) After all, we're just compiling with a different
> > > compiler. The end result will still rely on the *msysGit
> > > environment* to function, so we already require it. Thus, GNU Make
> > > is present, and we can use it.
> > 
> > We can also use sed or perl to generate/modify the .vcproj files, or
> > run CMake (once Pau got it to build), and package the stuff using zip
> > (once I got that to build).
> 
> Really? That would be some script being able to parse the Makefile, and create
> something reasonable as a vcproj script :) Keeping all the options in sync,
> conditional files/libs, all the various end executables (a separate .vcproj
> for each of them, and a solution file (.sln)to tie them all together into a ..
> "solution", a complete product blah blah blah) etc.

I think it wouldn't be impossible to split the Makefile into an 
easy-to-parse part and an irrelevant-to-vcproj part. Certainly you don't 
need GNU Make to read a file:

SCRIPT_SH += git-am.sh
SCRIPT_SH += git-bisect.sh

SCRIPT_PERL += git-add--interactive.perl

PROGRAM_NAMES += git-fast-import

BUILTINS_IN_OBJS += add

(etc)

That is, we can probably describe the project sufficiently with a lot of

VAR += value

lines, using only constant values and variables we specify, and then the 
Makefile declares them empty and does an

include UserServicableParts

and puts together the variables it needs. And things that aren't GNU Make 
could also process this file without enormous difficulty, since it's 
essentially a .ini file or java resource file with a stray + on each line. 
Of course, people interested in the vcproj thing would have to update 
whatever makes VC do the right thing when new *rules* are introduced, but 
that's a lot less common than new *files* being introduced, and also more 
obvious (in the sense that the included file is setting variables that the 
builder doesn't know what to do with).

	-Daniel
*This .sig left intentionally blank*
