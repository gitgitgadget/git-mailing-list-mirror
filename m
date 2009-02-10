From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFH: spawning pager takes long time when when unconnected from
  network
Date: Tue, 10 Feb 2009 12:03:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902101159300.10279@pacific.mpi-cbg.de>
References: <loom.20090210T015515-886@post.gmane.org>  <4991337B.2010102@viscovery.net>  <loom.20090210T085859-630@post.gmane.org>  <alpine.DEB.1.00.0902101124160.10279@pacific.mpi-cbg.de> <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqPa-0008H9-JG
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbZBJLCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752788AbZBJLCv
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:02:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:41306 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752625AbZBJLCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 06:02:50 -0500
Received: (qmail invoked by alias); 10 Feb 2009 11:02:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 10 Feb 2009 12:02:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ocBsqTJNoPJ5fZ2TP3Gjli7sihU6/EjtjEhuAPW
	L5r2cAESdDhMci
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <279b37b20902100253v3cfd8e45kefa6da7de2ea4a4b@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109201>

Hi,

On Tue, 10 Feb 2009, Eric Raible wrote:

> On Tue, Feb 10, 2009 at 2:24 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 10 Feb 2009, Eric Raible wrote:
> >
> >> Johannes Sixt <j.sixt <at> viscovery.net> writes:
> >>
> >> > Do you have a directory in your PATH that points to a disconnected network
> >> > drive? Do you use the default pager settings, or did you customize the pager?
> >>
> >> All components in my path are local.
> >
> > Could you run it with GIT_TRACE=<file>?
> 
> The first thing I tried was to set GIT_TRACE=1, and it doesn't give much:
> trace: built-in: git 'diff' 'ss' '--name-only'
> trace: run_command: 'sh' '-c' 'less'
> 
> The long pause in question begins after the above output is produced
> but before the list of files is shown.  The output is identical when setting
> GIT_TRACE to a file.
> 
> When I pipe the git diff to less or set core.pager="",
> then obviously it doesn't call run_command.

You could also try to set it to /bin/false, just so you know if the delay 
is caused by the shell startup.

> Since I can't really reproduce this in the debugger (because the "bug" 
> is an intermittent delay of 3-10 seconds), I tried littering the code 
> with trace_printf's.  Didn't really help, partially because after the 
> dup2 (which is part of spawning the pager process) they don't on stdout 
> any longer.  Now that I know about setting GIT_TRACE to a file perhaps 
> this is worth trying again.
> 
> But once it started to look like the delay was in the xdiff machinery,
> I figured I was chasing a side-effect, and that the real problem was
> some interaction between the two processes.  That's when I sent
> my first RFH  to the list.

In my experience, such intermittent delays are often triggered by some 
(mostly unnecessary) calls to either DNS (which might hang for quite some 
time) or domain controllers (same).  These can be triggered by shell 
startup looking for the user or host name.

However, I am just fishing here, as I cannot begin to get an idea what is 
happening on your side.

Also, it does not help that the platform is Windows, an OS I am mostly 
unfamiliar with.  But there have to be profiling tools for that platform 
where you should be able to see what function is blocking (I assume it is 
a blocking call, of course).

Ciao,
Dscho
