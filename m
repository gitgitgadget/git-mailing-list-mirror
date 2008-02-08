From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Fri, 8 Feb 2008 12:05:08 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081203470.11591@racer.site>
References: <20080206102608.GA1007@coredump.intra.peff.net> <47A98F07.4000402@viscovery.net> <alpine.LSU.1.00.0802071855550.8543@racer.site> <47AC02F5.9080705@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNRz8-0001nY-69
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575AbYBHMFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 07:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753012AbYBHMFE
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:05:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:60582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752150AbYBHMFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:05:03 -0500
Received: (qmail invoked by alias); 08 Feb 2008 12:04:59 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp054) with SMTP; 08 Feb 2008 13:04:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18K8CtUhtAKPEsGuQMizJfM/jKny4Y+HASHT4ZAKY
	5ETAsrCdLAqniU
X-X-Sender: gene099@racer.site
In-Reply-To: <47AC02F5.9080705@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73080>

Hi,

On Fri, 8 Feb 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > On Wed, 6 Feb 2008, Johannes Sixt wrote:
> > 
> >> Jeff King schrieb:
> >>> In setup_git_directory_gently, we have a special rule that says "if 
> >>> GIT_DIR is set but GIT_WORK_TREE is not, then use the current 
> >>> working directory as the work tree." This is the intended behavior 
> >>> for the user perspective.
> >>>
> >>> However, setup_git_directory_gently sets GIT_DIR itself, meaning 
> >>> that further setups (either because we are executing a command via 
> >>> alias, or in a subprocess) will see the non-existent GIT_WORK_TREE 
> >>> and assume we fall into the "current working directory is the 
> >>> working tree" codepath.
> >>>
> >>> Instead, we now use a special value of GIT_WORK_TREE to indicate 
> >>> that we have already checked for a worktree and that there isn't 
> >>> one, setting it when we set GIT_DIR and checking for it in the 
> >>> special case path.
> >>>
> >>> The special value is a blank GIT_WORK_TREE; it could be any value, 
> >>> but this should not conflict with any user values (and as a bonus, 
> >>> you can now tell git "I don't have a work tree" with "GIT_WORK_TREE= 
> >>> git", though I suspect the use case for that is limited).
> >>
> >> Hrm. Unfortunately, on Windows there is no such thing as an empty 
> >> environment string. setenv(x, "") *removes* the environment variable.
> > 
> > That might be a shortcoming of our implementation of setenv():
> 
> No, it is not. It's Windows's putenv(), and it's even documented.

Yes, that's what I said: our setenv() implementation uses putenv(), which 
introduces that bug (setenv() is not supposed to unset variables, 
unsetenv() is).

> That said, we probably should modify environ directly in gitsetenv().

Exactly.

Ciao,
Dscho
