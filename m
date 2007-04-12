From: Jeff King <peff@peff.net>
Subject: Re: git-branch, older repos and more confusion
Date: Thu, 12 Apr 2007 01:21:18 -0400
Message-ID: <20070412052118.GA30459@coredump.intra.peff.net>
References: <46a038f90704112114t520374b2qea4f860575c21bce@mail.gmail.com> <20070412042308.GA22539@coredump.intra.peff.net> <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:21:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbrkR-0003nG-B2
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 07:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbXDLFVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 01:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbXDLFVV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 01:21:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3412 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422665AbXDLFVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 01:21:20 -0400
Received: (qmail 4713 invoked from network); 12 Apr 2007 05:21:59 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 12 Apr 2007 05:21:59 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2007 01:21:18 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90704112205g53ab4750s673f449ee40165b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44323>

On Thu, Apr 12, 2007 at 05:05:24PM +1200, Martin Langhoff wrote:

> Which means I'll have to write a little list that goes "if your git is
> version X, do this, if it's version Y do that". :-(

Yes, that is frustrating. If you are just working with master/origin, I
think you can get away with it due to the default configuration created,
but otherwise I'm not sure it's avoidable. I seem to recall a thread
about this a few months ago (between me and Bill Lear, maybe?), but I
don't recall that there was any especially good conclusion.

> For example, creating a new "custom" branch on the repo used to be
> trivial and left us with a setup that was simple and safe. For
> example, if you wanted to work on a custom v1.9:
> 
> - cg-clone <repo>#v1.9-maint mydir
> - cd mydir
> - cg-branch-chg origin <repo>#1.9-clientname
> - cg-push     ## this creates the new head on the repo
> - cg-branch-add v1.9-maint <repo>#v1.9-maint mydir
> 
> and from there onwards cg-update / cg-push worked on the custom
> branch, and cg-update v1.9-maint would merge from the maint branch.
> 
> Any hints as to how to run such workflow on v1.5.x?

This will seem like repetition, but it's like this:

  git-clone <repo> mydir
  cd mydir
  git-checkout --track -b v1.9-clientname origin/v1.9-maint
  git-push origin v1.9-clientname    # to create the new head remotely

When you do a git-pull without arguments from the v1.9-clientname
branch, it will first do a fetch of origin (grabbing the entire state,
including the v1.9-maint branch) and then merge in origin's v1.9-maint.

When you do a push without arguments, it will push every head you have
in common with origin. Because we pushed the v1.9-clientname branch
once, it was created and will be part of subsequent pushes.

-Peff
