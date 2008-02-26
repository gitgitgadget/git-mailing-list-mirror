From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix premature call to git_config() causing t1020-subdirectory
 to fail
Date: Tue, 26 Feb 2008 17:12:50 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802261709180.19665@iabervon.org>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <200802261640.48770.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU83m-0005Oe-Tr
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 23:14:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764257AbYBZWM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764205AbYBZWM4
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 17:12:56 -0500
Received: from iabervon.org ([66.92.72.58]:34526 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763793AbYBZWMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 17:12:55 -0500
Received: (qmail 28330 invoked by uid 1000); 26 Feb 2008 22:12:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Feb 2008 22:12:50 -0000
In-Reply-To: <200802261640.48770.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75181>

On Tue, 26 Feb 2008, Johan Herland wrote:

> We need to call git_config(git_default_config) in order to get user.name and
> user.email (so that reflogs will be correct), but if we do it too early, it
> interferes with the setup of reference repos. Therefore, move git_config()
> call to _after_ the reference has been setup (but before we start writing
> reflogs). However, in order for git_config() to read in the global
> configuration at that point, we must unset CONFIG_ENVIRONMENT.
> 
> There are probably better ways of resolving this issue.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> 
> On Tuesday 26 February 2008, Johan Herland wrote:
> > - Call git_config(git_default_config) in order to properly set up
> >   user.name and user.email for reflogs (This BREAKS test #9 in
> >   t1020-subdirectory.sh. Have yet to figure out why)
> 
> Here is a fix for this breakage, although I think it's ugly as hell.
> 
> But with this fix, and the other one I just sent out for the
> for_each_ref() corruption, the whole test suite finally passes on my
> box.
> 
> Feel free to incorporate this into the further builtin-clone work,
> or ignore it, and find better ways of solving these issues.

Actually, I think I'll be leaving CONFIG_ENVIRONMENT alone entirely; I was 
only using it to override the setting that t5505 uses, but t5505 is just 
wrong to set it. So this is the right placement of git_config(), and the 
setenv and unsetenv aren't needed.

	-Daniel
*This .sig left intentionally blank*
