From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4] gitk: Allow commit editing
Date: Thu, 8 Sep 2011 17:59:45 -0300
Message-ID: <20110908205945.GB8091@bloggs.ozlabs.ibm.com>
References: <87obzlwpx0.fsf@steelpick.2x.cz>
 <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
 <20110825031420.GB3465@sigill.intra.peff.net>
 <87bovdvdhd.fsf@steelpick.2x.cz>
 <20110825173018.GA519@sigill.intra.peff.net>
 <87fwknaveh.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Fri Sep 09 00:55:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nVB-00043T-Pt
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 00:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1IHWzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 18:55:08 -0400
Received: from ozlabs.org ([203.10.76.45]:50706 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752035Ab1IHWzC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 18:55:02 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0596FB6FA3; Fri,  9 Sep 2011 07:00:12 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <87fwknaveh.fsf@steelpick.2x.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180978>

On Sat, Aug 27, 2011 at 02:31:02PM +0200, Michal Sojka wrote:
> Here is a new version with the micro-optimization.
> 
> Another minor change is that this patch now applies to gitk repo
> (http://git.kernel.org/pub/scm/gitk/gitk.git) instead of the main git
> repo.
> 
> -Michal
> 
> --8<---------------cut here---------------start------------->8---
> I often use gitk to review patches before pushing them out and I would
> like to have an easy way to edit commits. The current approach with
> copying the commitid, switching to terminal, invoking git rebase -i,
> editing the commit and switching back to gitk is a way too complicated
> just for changing a single letter in the commit message or removing a
> debug printf().
> 
> This patch adds "Edit this commit" item to gitk's context menu which
> invokes interactive rebase in a non-interactive way :-). git gui is
> used to actually edit the commit.
> 
> Besides editing the commit message, splitting of commits, as described
> in git-rebase(1), is also supported.
> 
> The user is warned if the commit to be edited is contained in another
> ref besides the current branch and the stash (e.g. in a remote
> branch). Additionally, error box is displayed if the user attempts to
> edit a commit not contained in the current branch.

I have to say that this patch makes me pretty nervous.  I can see the
attractiveness of the feature, but I don't like making gitk
unresponsive for a potentially long time, i.e. until git gui exits.
It may not be clear to users that the reason gitk isn't responding is
because some other git gui window is still running.

Also, if some subsequent commit no longer applies because of the
changes you make to a commit, it's going to abort the rebase
completely and thus lose the changes you made.  That could be
annoying.

I usually do this by starting a new branch just before the commit I
want to change and then use a combination of the cherry-pick menu item
and git commit --amend.  Maybe something to make that simpler for
users would be good, i.e. automate it a bit but still have it be a
step-by-step process if necessary.  Part of the problem of course is
that neither gitk nor git gui are really designed to be an editing
environment.  In fact you really want an edit/compile/test environment
so you don't introduce new bugs.

Paul.
