From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] execv_git_cmd(): also try PATH if everything else fails.
Date: Tue, 23 Oct 2007 12:12:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710231209240.25221@racer.site>
References: <1192867937.v2.fusewebmail-240137@f> <20071020205721.GA16291@srparish.net>
 <Pine.LNX.4.64.0710202258440.25221@racer.site> <20071021023614.GB14735@spearce.org>
 <Pine.LNX.4.64.0710212256270.25221@racer.site> <20071022042110.GJ14735@spearce.org>
 <Pine.LNX.4.64.0710221135100.25221@racer.site> <20071023043405.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 13:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkHh4-0001Uk-R5
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 13:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbXJWLMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 07:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXJWLMx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 07:12:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:45027 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751749AbXJWLMw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 07:12:52 -0400
Received: (qmail invoked by alias); 23 Oct 2007 11:12:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp023) with SMTP; 23 Oct 2007 13:12:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QxCAfOQaQ7O3pc5bVMdX4lS/41YaQTGUh0Sq5/C
	1IziNTVfj/YK4H
X-X-Sender: gene099@racer.site
In-Reply-To: <20071023043405.GA14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62126>

Hi,

On Tue, 23 Oct 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 22 Oct 2007, Shawn O. Pearce wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > Earlier, we tried to find the git commands in several possible exec
> > > > dirs.  Now, if all of these failed, try to find the git command in
> > > > PATH.
> > > ...
> > > > diff --git a/exec_cmd.c b/exec_cmd.c
> > > > index 9b74ed2..70b84b0 100644
> > > > --- a/exec_cmd.c
> > > > +++ b/exec_cmd.c
> > > > @@ -36,7 +36,8 @@ int execv_git_cmd(const char **argv)
> > > >  	int i;
> > > >  	const char *paths[] = { current_exec_path,
> > > >  				getenv(EXEC_PATH_ENVIRONMENT),
> > > > -				builtin_exec_path };
> > > > +				builtin_exec_path,
> > > > +				"" };
> > > 
> > > So if the user sets GIT_EXEC_PATH="" and exports it we'll search 
> > > $PATH before the builtin exec path that Git was compiled with? Are 
> > > we sure we want to do that?
> > 
> > I thought the proper way to unset EXEC_PATH was to "unset 
> > GIT_EXEC_PATH".  In that case, getenv(EXEC_PATH_ENVIRONMENT) returns 
> > NULL and we're fine, no?
> 
> Sure.  But can't you also export an environment variable that is set to 
> the empty string?  At least on UNIX.  Windows thinks unset and empty 
> string are the same thing.

Not here.  I just tried (with msysGit, of course).

Anyway, I like the other patch Scott sent much more than mine, which 
offloads the work to execvp().

Ciao,
Dscho
