From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git-svn init from Avogadro SVN repo - deleted files showing
Date: Mon, 10 Dec 2007 12:40:51 +0100
Message-ID: <20071210114051.GC7521@xp.machine.xx>
References: <475C8748.6000005@cryos.net> <20071210104235.GA7521@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: "Marcus D. Hanwell" <marcus@cryos.net>
X-From: git-owner@vger.kernel.org Mon Dec 10 12:42:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1h1N-0005Eg-SI
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 12:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643AbXLJLk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 06:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756635AbXLJLk5
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 06:40:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:59554 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756599AbXLJLky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 06:40:54 -0500
Received: (qmail invoked by alias); 10 Dec 2007 11:40:52 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp034) with SMTP; 10 Dec 2007 12:40:52 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19PQC9cc8tP9CxiRkTyVlpkhjxeScqtU4P1OHuN0k
	ifDfH77a7+xwQ+
Content-Disposition: inline
In-Reply-To: <20071210104235.GA7521@xp.machine.xx>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67704>

On Mon, Dec 10, 2007 at 11:42:35AM +0100, Peter Baumann wrote:
> On Sun, Dec 09, 2007 at 07:24:40PM -0500, Marcus D. Hanwell wrote:
> > Hi,
> >
> > I am quite new to git and git-svn but have been using both for my 
> > development work recently. I imported the Avogadro subversion repository 
> > (hosted on Sourceforge) using the following commands,
> >
> > git svn init -t tags -b branches -T trunk 
> > https://avogadro.svn.sourceforge.net/svnroot/avogadro
> >
> > git svn fetch
> >
> >
> > The files avogadro.pro and README in the trunk/ directory appear in my 
> > imported git repository but not in Avogadro subversion trunk. We also had 
> > trunk/src/ and all its files/subdirectories appearing in the git checkout 
> > but not in subversion trunk. We deleted this using git and git svn which 
> > removed it from the git checkouts too after r858.
> >
> > I have been talking to Peter who confirmed this and pointed out that the 
> > repo was reorganised several times in the past. Please CC me on replies as 
> > I am not on the list. There is a copy of my git repo at 
> > http://platinum.cryos.net/avogadro.git/ if you would rather skip the 
> > import. Other than that everything has been working great. It would be good 
> > to get rid of this bug if possible. Let me know if there is anything else I 
> > can do to help.
> >
> 
> [ Eric Cc'ed, as the author of git-svn ]
> 
> I can confirm that this looks like an import problem.
> (e.g see svn log -v -r33:78 https://avogadro.svn.sourceforge.net/svnroot/avogadro)
> 
> I did my analysis on the file /trunk/avogadro.pro, because the error
> happens really early in the history so could just import up to revision 76
> to see what goes wrong. (The file gets never deleted in the import, as it
> should be!)
> 
> 
> 
> trunk/avogadro.pro is added here:
> 
>     ------------------------------------------------------------------------
>     r33 | dcurtis3 | 2006-08-21 07:34:10 +0200 (Mon, 21 Aug 2006) | 3 lines
>     Changed paths:
>        A /trunk/avogadro.pro
> 
>     Does a recursive build.
> 
> 
> Here the refactoring starts (a new directory not tracked by git is added):
>     ------------------------------------------------------------------------
>     r66 | dcurtis3 | 2007-01-03 06:42:45 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro
> 
>     Making room for libavogadro.
> 
> 
> /branches is moved to /avogadro/branches
>     ------------------------------------------------------------------------
>     r67 | dcurtis3 | 2007-01-03 06:47:11 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro/branches (from /branches:66)
>        D /branches
> 
>     Making room for libavogadro
> 
> 
> 
> 
> ERROR HAPPENS HERE:
> ====================
> 
> /trunk and /tags are moved, too.
> (/trunk/avogadro.pro becomes /avogadro/trunk/avogadro.pro):
>     ------------------------------------------------------------------------
>     r68 | dcurtis3 | 2007-01-03 06:47:34 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro/tags (from /tags:66)
>        A /avogadro/trunk (from /trunk:66)
>        D /tags
>        D /trunk
> 
>     Making room for libavogadro.
> 
> The above delete/move of trunk isn't recorded anywhere in the git svn import.
> 'git-svn find-rev r66' doesn't produce any output!

Sorry. I meant r67 and r68 instead of r66.

> And later git-svn thinks that /trunk and all its files are still there, so
> e.g. /trunk/avogadro.pro stays in the repo forever.
> 
> 
> -Peter
> 
> This is just for consistency here and for anyone interested in further
> analyses.
> 
> Here is the rest of the import analyses I've done. Look how "interesting" the
> repo is and how many times the files are moved.
> 
> 
> 
> 
> /libavogadro is added
>     ------------------------------------------------------------------------
>     r69 | dcurtis3 | 2007-01-03 06:50:58 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /libavogadro
>        A /libavogadro/CMakeLists.txt
>        A /libavogadro/FindOpenBabel.cmake
>        A /libavogadro/src
>        A /libavogadro/src/CMakeLists.txt
>        A /libavogadro/src/color.cpp
>        A /libavogadro/src/color.h
>        A /libavogadro/src/engine.h
>        A /libavogadro/src/engines
>        A /libavogadro/src/engines/CMakeLists.txt
>        A /libavogadro/src/engines/ResidueSphereEngine.cpp
>        A /libavogadro/src/engines/ResidueSphereEngine.h
>        A /libavogadro/src/engines/SphereEngine.cpp
>        A /libavogadro/src/engines/SphereEngine.h
>        A /libavogadro/src/engines/StickEngine.cpp
>        A /libavogadro/src/engines/StickEngine.h
>        A /libavogadro/src/engines/WireframeEngine.cpp
>        A /libavogadro/src/engines/WireframeEngine.h
>        A /libavogadro/src/engines/bsengine.cpp
>        A /libavogadro/src/engines/bsengine.h
>        A /libavogadro/src/engines/vertexarray.cpp
>        A /libavogadro/src/engines/vertexarray.h
>        A /libavogadro/src/glwidget.cpp
>        A /libavogadro/src/glwidget.h
>        A /libavogadro/src/primitives.cpp
>        A /libavogadro/src/primitives.h
> 
>     Added libavogadro.
> 
> 
> Create /libavogadro/{trunk,branches,tags} and move anything below the
> former /libavogadro into /libavogadro/trunk
>     ------------------------------------------------------------------------
>     r70 | dcurtis3 | 2007-01-03 06:53:13 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        D /libavogadro/CMakeLists.txt
>        D /libavogadro/FindOpenBabel.cmake
>        A /libavogadro/branches
>        D /libavogadro/src
>        A /libavogadro/tags
>        A /libavogadro/trunk
>        A /libavogadro/trunk/CMakeLists.txt (from /libavogadro/CMakeLists.txt:69)
>        A /libavogadro/trunk/FindOpenBabel.cmake (from /libavogadro/FindOpenBabel.cmake:69)
>        A /libavogadro/trunk/src (from /libavogadro/src:69)
> 
>     Putting in trunk / branches / tags.
> 
> 
>     ------------------------------------------------------------------------
>     r72 | dcurtis3 | 2007-01-03 08:55:32 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro/trunk/CMakeLists.txt
>        A /avogadro/trunk/FindAvogadro.cmake
>        A /avogadro/trunk/FindOpenBabel.cmake
>        D /avogadro/trunk/src/Engine.h
>        D /avogadro/trunk/src/GLWidget.cpp
>        D /avogadro/trunk/src/GLWidget.h
>        D /avogadro/trunk/src/MainWindow.cpp
>        D /avogadro/trunk/src/MainWindow.h
>        D /avogadro/trunk/src/Primitives.cpp
>        D /avogadro/trunk/src/Primitives.h
>        D /avogadro/trunk/src/Renderer.h
>        D /avogadro/trunk/src/Tool.cpp
>        D /avogadro/trunk/src/Tool.h
>        D /avogadro/trunk/src/Views.cpp
>        D /avogadro/trunk/src/Views.h
>        D /avogadro/trunk/src/color.cpp
>        D /avogadro/trunk/src/color.h
>        D /avogadro/trunk/src/engines
>        M /avogadro/trunk/src/main.cpp
>        A /avogadro/trunk/src/mainwindow.cpp (from /avogadro/trunk/src/MainWindow.cpp:70)
>        A /avogadro/trunk/src/mainwindow.h (from /avogadro/trunk/src/MainWindow.h:70)
>        A /avogadro/trunk/src/tool.cpp (from /avogadro/trunk/src/Tool.cpp:70)
>        A /avogadro/trunk/src/tool.h (from /avogadro/trunk/src/Tool.h:70)
>        A /avogadro/trunk/untitled01.gpr
> 
>     Now uses libavogadro.  Starting to think we should package this a
>     little different.
> 
> 
> 
> Renamed /libavogadro to /avogadro-lib
>     ------------------------------------------------------------------------
>     r73 | dcurtis3 | 2007-01-03 16:48:02 +0100 (Wed, 03 Jan 2007) | 3 lines
>     Changed paths:
>        A /avogadro-lib (from /libavogadro:72)
>        D /libavogadro
> 
>     Refactor
> 
> 
> mv /avogadro/trunk/avogadro.pro /trunk/avogadro/avogadro.pro
>    ------------------------------------------------------------------------
>     r75 | dcurtis3 | 2007-01-03 20:49:35 +0100 (Wed, 03 Jan 2007) | 2 lines
>     Changed paths:
>        D /avogadro
>        D /avogadro-lib
>        A /branches
>        A /tags
>        A /trunk
>        A /trunk/avogadro (from /avogadro/trunk:74)
>        A /trunk/libavogadro (from /avogadro-lib/trunk:74)
> 
>     Moving things around.  Conforming to a more KDE-like layout in SVN.
>     I'm going nuts.  SOrry
