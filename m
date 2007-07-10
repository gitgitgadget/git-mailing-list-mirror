From: Jeff King <peff@peff.net>
Subject: Re: pushing changes to a remote branch
Date: Tue, 10 Jul 2007 13:34:01 -0400
Message-ID: <20070710173401.GB5032@sigill.intra.peff.net>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:34:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8JbG-0000Hx-BA
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 19:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646AbXGJReG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756239AbXGJReG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 13:34:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1625 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757351AbXGJReF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 13:34:05 -0400
Received: (qmail 30934 invoked from network); 10 Jul 2007 17:34:28 -0000
Received: from unknown (HELO sigill.intra.peff.net) (128.61.125.94)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP
  (cert postmaster@peff.net); 10 Jul 2007 17:34:28 -0000
Received: (qmail 5065 invoked by uid 1000); 10 Jul 2007 17:34:01 -0000
Content-Disposition: inline
In-Reply-To: <20070710143614.GA29681@piper.oerlikon.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52098>

On Tue, Jul 10, 2007 at 04:36:14PM +0200, martin f krafft wrote:

>   git checkout origin/vim
>     Note: moving to "origin/vim" which isn't a local branch
>   echo change > newfile; git add newfile
>   git commit -m'make change'
>     Created commit 64b8b2e: make change
>      1 files changed, 1 insertions(+), 0 deletions(-)
>       create mode 100644 newfile
>   
> If I now checkout master and then return to origin/vim, the commit
> is gone.

That's because 'origin/vim' is a tracking branch for the remote; it's
where you store the information "here's what the remote 'origin' thinks
is in the branch 'vim'." That's why you get the "note" warning above.

If you want to make changes, you should make a local branch starting
from that point:

  git-checkout -b vim origin/vim
  # hack hack hack
  git-commit -m changes

> Much more, however, I am interested how I am supposed to push
> commits back to select remote branches.

Now when you issue a git-push, you will push _your_ 'vim' branch to the
remote's 'vim' branch. Before, you didn't _have_ a vim branch, so
nothing was pushed.

So the key thing you are missing in all of this is that you shouldn't be
doing _anything_ with branches in origin/* (which are, of course,
actually refs/remotes/origin/*) except for read-only operations (like
diffing against them, merging with them, etc). They are purely for
tracking the remote's branches.

-Peff
