From: Jeff King <peff@peff.net>
Subject: Re: How to go to git from svn without checkout
Date: Sat, 21 Mar 2009 23:20:08 -0400
Message-ID: <20090322032008.GA9526@coredump.intra.peff.net>
References: <22640020.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mercedes6s <bsamman@imagitekltd.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:21:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlEG0-0001nL-5x
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 04:21:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbZCVDUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 23:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752669AbZCVDUN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 23:20:13 -0400
Received: from peff.net ([208.65.91.99]:60721 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZCVDUM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 23:20:12 -0400
Received: (qmail 9269 invoked by uid 107); 22 Mar 2009 03:20:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 21 Mar 2009 23:20:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Mar 2009 23:20:08 -0400
Content-Disposition: inline
In-Reply-To: <22640020.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114111>

On Sat, Mar 21, 2009 at 01:25:38PM -0700, Mercedes6s wrote:

> Hello.  I've been falling more and more in love with git and I want to move
> our biggest project because it is my biggest pain over to git to make our
> lives easier.  The problem is our project is about 50 gigs (A lot of media
> files involved).  Also, we got developers all over the world that are
> running on slow connections.  Some took a week to get the project up and
> running in the first place.  Luckily, they are only isolated instances. 
> What I'm wondering is can I have all of them turn their projects into git
> repositories locally and have all of them sync with a master repository once
> they are done.  The actual project is only about 500 megs and the changes
> are probably only a few K since they keep their projects up to date, so
> that's more acceptable, but I don't want them to bring down all those media
> files again and I doubt they will be willing to do it.  Is this possible,
> and how would I do it?

I'm not sure you can. "git svn clone" will give a stable commit ID in
git; that is, two runs of the same import will yield interoperable git
repositories. However, I'm not sure if that is actually useful to you;
the people with svn checkouts don't _have_ the history. So the clone
operation will have to talk to the server.

However, you should really consider whether you want those 50G in the
git repository at all. Git is pretty good at not looking at parts of the
repository that aren't necessary to an operation, but whole-repository
operations like packing and cloning are going to be absurdly slow.

Are those files actually changing? Would it be feasible to put the
"main" part of the project in git and just include something like
symlinks in the repository pointing to your media? Then each local
developer could clone the git project and just move their existing 50G
of media files into place.

-Peff
