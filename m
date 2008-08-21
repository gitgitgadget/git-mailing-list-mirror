From: Jeff King <peff@peff.net>
Subject: Re: Git Errors for local refs
Date: Thu, 21 Aug 2008 16:24:14 -0400
Message-ID: <20080821202414.GD27705@coredump.intra.peff.net>
References: <63013335-CBB4-43E5-9538-204828805849@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Loomis <brianloomis1@mac.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGif-0006U1-RZ
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbYHUUYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbYHUUYS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:24:18 -0400
Received: from peff.net ([208.65.91.99]:4582 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbYHUUYR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:24:17 -0400
Received: (qmail 9384 invoked by uid 111); 21 Aug 2008 20:24:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 16:24:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 16:24:14 -0400
Content-Disposition: inline
In-Reply-To: <63013335-CBB4-43E5-9538-204828805849@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93201>

On Thu, Aug 21, 2008 at 08:12:42AM -0600, Brian Loomis wrote:

> I'm getting the error trying to do a pull from a repos I set up on GitHub 
> yesterday.
>
> error: some local refs could not be updated; try running
> 'git remote prune origin' to remove any old, conflicting branches
>
> I've run the  'git remote prune origin' but still get the error doing the 
> pull.
>
> Any ideas how to resolve this?  Google seems to show me nothing on this 
> and I have also looked at the manual.

Probably google turned up nothing because the error message is new in
the latest version of git.

Generally what happens is that the remote used to have some branch
"foo", so you have "refs/remotes/origin/foo", but now they deleted it in
favor of "foo/bar", so the new remote tracking branch
"refs/remotes/origin/foo/bar" conflicts with "refs/remotes/origin/foo"
(and the conflict, as you might guess, is an artifact of the storage
model for refs, which matches the filesystem semantics).

Running 'git remote prune origin' will see that 'foo' no longer exists
at your origin and remove your refs/remotes/origin/foo, and the next
fetch will work fine.

But in this case (and I _thought_ every other, but perhaps we are
missing one), the full output should have a clue as to what is causing .
In a test repo, I get:

  $ git fetch
  error: 'refs/remotes/origin/foo' exists; cannot create 'refs/remotes/origin/foo/bar'
  From /home/peff/foo/parent/
   ! [new branch]      foo/bar    -> origin/foo/bar  (unable to update local ref)
   error: some local refs could not be updated; try running
    'git remote prune origin' to remove any old, conflicting branches

Are you seeing any other error output from your fetch? If so, what does
it say?

-Peff
