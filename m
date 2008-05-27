From: Jeff King <peff@peff.net>
Subject: Re: visualizing Git's Git repo
Date: Tue, 27 May 2008 19:49:48 -0400
Message-ID: <20080527234948.GA17424@sigill.intra.peff.net>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org> <loom.20080527T202009-498@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Joshua Haberman <joshua@reverberate.org>
X-From: git-owner@vger.kernel.org Wed May 28 01:50:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18wH-0005uc-Pz
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbYE0Xtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756105AbYE0Xtw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:49:52 -0400
Received: from peff.net ([208.65.91.99]:3366 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755666AbYE0Xtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:49:51 -0400
Received: (qmail 7037 invoked by uid 111); 27 May 2008 23:49:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 27 May 2008 19:49:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 May 2008 19:49:48 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080527T202009-498@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83064>

On Tue, May 27, 2008 at 08:36:16PM +0000, Joshua Haberman wrote:

> > 1. what do you all do to get a high-level view of what's going on with  
> > Git development?  do you use gitk?  if so, what options?
> 
> I get the impression from this thread that core Git developers don't make
> visualizing the repository a regular part of their development workflow.  Is
> that accurate?  What do you all do to keep tabs on Git development?

I don't know if I count as a core Git developer, but I do use gitk daily
to track what goes into Junio's repo. My refs are organized something
like:

  remotes/origin/* - tracking branches of Junio's git.git
  heads/jk/* - long running topics branched from master
  heads/next - Junio's next branch with short or temporary patches on top

My git day generally starts like this:

  git fetch ;# grab newly merged stuff
  gitk origin/next...next ;# see what's new
  git rebase origin/next ;# and bring ourselves up to date

You don't necessarily get to see all of the topic branches labeled
individually, but generally you see each merged topic preceded by the
'Merge ...' commit.

For long running branches, I leave them alone until I'm ready to work on
them. And then it's:

  git checkout jk/whatever
  gitk origin/master.. ;# what was I doing again?
  git rebase origin/master ;# should be clean if nobody else
                            # is touching the same area

And if the rebase isn't clean, then I investigate individual areas with:

  gitk --no-merges jk/whatever...origin/master problematic_file.c

So maybe that is a bit of a boring workflow description, but I do
visualize with gitk all the time. I tend to do a lot of bug-hunting,
too, for which I don't end up doing visualization. Instead, I almost
always rely on asking more specific questions about content: blame
(especially "tig blame"), bisect, and pickaxe ("git log -S").

-Peff
