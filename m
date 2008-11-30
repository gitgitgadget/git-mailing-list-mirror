From: Jeff King <peff@peff.net>
Subject: Re: Managing websites with git
Date: Sun, 30 Nov 2008 12:27:17 -0500
Message-ID: <20081130172717.GA7047@coredump.intra.peff.net>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com> <20081130170722.GJ6572@eratosthenes.sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felix Andersen <felix@nibbo.se>, git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Sun Nov 30 18:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6q66-00077d-Pa
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 18:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbYK3R1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 12:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYK3R1V
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 12:27:21 -0500
Received: from peff.net ([208.65.91.99]:3308 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbYK3R1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 12:27:20 -0500
Received: (qmail 9052 invoked by uid 111); 30 Nov 2008 17:27:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Nov 2008 12:27:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Nov 2008 12:27:17 -0500
Content-Disposition: inline
In-Reply-To: <20081130170722.GJ6572@eratosthenes.sbcglobal.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101979>

On Sun, Nov 30, 2008 at 09:07:22AM -0800, David Bryson wrote:

> One really should not push to a non-bare repo.  IIRC there was a patch
> recently to disallow it, but I do not remember if it was merged into
> HEAD.

It's in master and should be in 1.6.1, but it is a config option that
defaults to "warn" for now, so as not to break existing setups. It may
switch to "refuse" after a deprecation period, but I don't think the
length of that period has been set.

> Since I knew the patch was coming I rewrote my scripts to use a bare
> repo in /var/git, and push the changes to /var/www whenever I push to
> the remote repo.

Personally, I think that is a sane way to go; but note that you still
use a non-bare repo with a checkout hook by explicitly setting
receive.denyCurrentBranch to false.

> #!/bin/bash
> LIVE="/var/www/statichacks/blosxom"
> 
> ref=$1
> 
> cd $GIT_DIR
> echo "Pushing updates to $LIVE..."
> git archive --format=tar $ref | tar -C $LIVE --atime-preserve -xpf -
> 
> There may be an easier way to do it, but that script took me about 5
> minutes to write and test.

One disadvantage of this method is that it doesn't remove files from
$LIVE that were deleted in the repository.

-Peff
