From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git on MSys (or how to make it easy for Windows users to compile
 git)
Date: Fri, 3 Aug 2007 17:46:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708031649480.14781@racer.site>
References: <Pine.LNX.4.64.0708022206130.14781@racer.site> 
 <460B6BF8541C4D9B916F02A12E0576F5@ntdev.corp.microsoft.com> 
 <46B2D4D9.4020103@trolltech.com> <a1bbc6950708030258h16a6514kf5c637af13874fb7@mail.gmail.com>
 <Pine.LNX.4.64.0708031334530.14781@racer.site> <46B328EA.4030309@trolltech.com>
 <Pine.LNX.4.64.0708031411360.14781@racer.site> <46B32C8D.4060804@trolltech.com>
 <Pine.LNX.4.64.0708031434130.14781@racer.site> <46B34B0D.6030106@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>, git@vger.kernel.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 18:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH0IY-0003Pk-M4
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 18:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438AbXHCQqn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 12:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754363AbXHCQqn
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 12:46:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:59975 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752269AbXHCQqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 12:46:42 -0400
Received: (qmail invoked by alias); 03 Aug 2007 16:46:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 03 Aug 2007 18:46:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18G9HRcRCUGwMQLoiIqdGwVEYK/SvXK7q71QgIw65
	a6+V0UB1TeC2DP
X-X-Sender: gene099@racer.site
In-Reply-To: <46B34B0D.6030106@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54734>

Hi,

On Fri, 3 Aug 2007, Marius Storm-Olsen wrote:

> 1) msys.bat still kills the previous window
>    msys.bat needs to change from
> :startsh
> start sh --login -i
> exit
> 
>    to just
> :startsh
> sh --login -i
> 
> (start <cmd> opens a new CMD window, and exit kills the current one)

Done.

> 2) If $HOME is set to the normal home directory of the user (which I
> have, but I doubt it's common)
>       C:\Documents and Settings\<username>
>    then you'll have problems with spaces in path, so the
>       make install
>    actually fails. So, next time you start msys.bat, it will try to do
> the installation step again. I don't think we have to care about that
> right now. The current setup work fine for now. I'll play around a bit
> with it, and we'll see.

I agree, it is much saner to install it to /bin.  That should make 
creating an installer for Git (the compiled one) easier, too.

> 3) When "Setting up git" the second time, it feels like the whole thing
> is hanging; have let it run for ~5min now without anything happening.
> Not sure what's going on here. It looks like git.exe was ran with any
> options, but that should not consume 100% CPU.. Hmm

Yep.  I did not test the initial phase, and there is a serious bug in 
setup_git_directory_gently() in origin/devel.  I fixed that.

> 4) When using the install, I get
> marius@STORM /git
> $ git init
> warning: templates not found C:/msysGit/share/git-core/templates/
> Initialized empty Git repository in .git/
> 
> Probably due to the "Setting up git" step not completing.

That is expected.  Hooks are activated by chmod'ing them to executable.  
AFAIK this concept is thoroughly broken by Windows.  So I do not even 
attempt to install the templates; otherwise all hooks would be blindly 
activated (and you do not want that, trust me).

New installer is available and tagged 0.2.

Ciao,
Dscho

P.S.: I also uploaded the script I created to make the installer.  It 
assumes that you installed 7zip to C:\Program Files\7-Zip but is trivial 
to adapt to your setup.
