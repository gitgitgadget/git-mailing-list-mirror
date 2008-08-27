From: Jeff King <peff@peff.net>
Subject: Re: Dropping core.worktree and GIT_WORK_TREE support (was Re:
	limiting relationship of git dir and worktree)
Date: Tue, 26 Aug 2008 20:49:24 -0400
Message-ID: <20080827004924.GA8204@coredump.intra.peff.net>
References: <7vsksw92nh.fsf@gitster.siamese.dyndns.org> <quack.20080824T0140.lth3aku956e@roar.cs.berkeley.edu> <7vprnyqo59.fsf@gitster.siamese.dyndns.org> <20080824220854.GA27299@coredump.intra.peff.net> <7vzln2j9y2.fsf@gitster.siamese.dyndns.org> <20080824231343.GC27619@coredump.intra.peff.net> <7vhc9aj82i.fsf@gitster.siamese.dyndns.org> <20080824235124.GA28248@coredump.intra.peff.net> <7v7ia6j5q9.fsf_-_@gitster.siamese.dyndns.org> <48B3B256.6010609@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Karl Chen <quarl@cs.berkeley.edu>
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Aug 27 02:50:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY9F2-0008Kx-IH
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 02:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYH0At1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 20:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbYH0At1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 20:49:27 -0400
Received: from peff.net ([208.65.91.99]:2877 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbYH0At1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 20:49:27 -0400
Received: (qmail 3330 invoked by uid 111); 27 Aug 2008 00:49:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 20:49:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 20:49:24 -0400
Content-Disposition: inline
In-Reply-To: <48B3B256.6010609@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93844>

[resend: urgh, I somehow missed the git-list when replying, so it is
cc'd here]

On Tue, Aug 26, 2008 at 09:35:50AM +0200, Michael J Gruber wrote:

> "Typical" developers track source code in the proper sense (somewhere in
> $HOME); on local file systems; mostly on machines where they have root
> access, or least can get extra accounts (for gitosis) or a port for "git
> daemon" etc; they collaborate with peers for whom basically the same
> assumptions apply.
> 
> Now think of a user say in academics, who tracks "source code" for
> scientific papers (somewhere in $HOME) but also needs to track, e.g.,
> central web pages or other "sources" where he has partial write access
> but can't have ".git" in place (and shouldn't change ownership &

Actually, I do all of those things, and I don't use the work-tree config
variable or command line options at all. :)

I think the general advice with things like web access is "don't just
dump your git stuff into a production area; instead, build and/or
install from your git work tree into your production area". Because
things like merges _can_ leave your files in a broken state.

But I do recognize that there are some special circumstances where that
isn't possible, and you are willing to accept the tradeoff. E.g., if the
checkout is extremely large and you can't afford another copy, if you
have clueless collaborators who can't understand a build procedure.

And even though I expect those cases to be the exception, it seems a
shame for git not to support split git-dir/work-tree setups because we
really are 99% there. This code has been the source of a number of
problems.

I think what is really needed is somebody to look carefully at the git
startup sequence and figure out a sane set of rules for the order of:

  - looking at env variables
  - looking at config
  - figuring out GIT_DIR and GIT_WORK_TREE
  - chdir'ing to top level of work tree if necessary

Because we obviously have some corner cases where very confusing things
are happening.

This is on my long term todo list, but my git time is very short at
least for the next few months. I think it would be great if somebody
else wanted to take the lead on this, and I would be happy to give
pointers about some of the corner cases we have already seen.

-Peff
