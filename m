From: Jeff King <peff@peff.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Wed, 25 May 2011 11:29:35 -0400
Message-ID: <20110525152935.GD8795@sigill.intra.peff.net>
References: <4DDA618E.4030604@drmicha.warpmail.net>
 <BANLkTinu3AbTmtswn6DLQKAWdLL=gBvAqA@mail.gmail.com>
 <20110523181147.GA26035@sigill.intra.peff.net>
 <20110523201529.GA6281@sigill.intra.peff.net>
 <BANLkTikvPjO=bbhAoPCftdXzGSYtryNvzw@mail.gmail.com>
 <20110523234131.GB10488@sigill.intra.peff.net>
 <7v39k4aeos.fsf@alter.siamese.dyndns.org>
 <4DDB5C0F.1080102@drmicha.warpmail.net>
 <20110524191337.GB584@sigill.intra.peff.net>
 <4DDCB203.3020802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 25 17:29:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPG1m-00017i-Mm
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab1EYP3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:29:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34323
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044Ab1EYP3h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:29:37 -0400
Received: (qmail 1054 invoked by uid 107); 25 May 2011 15:29:37 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 11:29:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 11:29:35 -0400
Content-Disposition: inline
In-Reply-To: <4DDCB203.3020802@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174415>

On Wed, May 25, 2011 at 09:38:43AM +0200, Michael J Gruber wrote:

> > I agree with Junio that we would need a new config option and external
> > interface for "n-way combined diff". However, isn't what things like
> > vimdiff and meld do the reverse of our combined diff? That is, don't
> > they assume the 3 trees are: ours, theirs, and ancestor (i.e., merge
> > base)? Whereas in a combined diff, it is actually: merge parent 1
> > (ours), merge parent 2 (theirs), and merge _result_.
> > 
> > Also, do those tools generally handle n-way comparisons as opposed to
> > 3-way?
> 
> "Those" tools do "that" which I mean :)

OK, they are more capable than I realized, then. :)

> So, in vimdiff, you could in principle change and write any buffer but
> our tools don't support it so far because it is not needed for a merge
> which has one "target" only. In the ui of my dreams, I would have 3
> buffers HEAD INDEX WORKTREE (H I W) and moving hunks between them would
> do all of add -p, reset -p and checkout -p (the HEAD buf would be
> read-only).

This should be relatively easy to implement on the git side, as you are
doing the hard parts of the "-p" operation in vim already. You just need
to write vim's buffer into the worktree or into the index via
hash-object / update-index.

Also, wouldn't you potentially want more than 3 buffers, if you were
cherry-picking changes from another commit (as in "git checkout -p
$commit" or even putting and taking things from a stash? I think that
would be a simple generalization of what you are proposing though.

> With "differently abled" tools it could still be useful to have, say a
> tool invoked for the merge HEAD+WORKTREE -> INDEX (with the current
> state of the INDEX as the automatic resolution to start off from) so
> that you can do add+reset -p with your mergetool, and maybe similarly
> for HEAD+INDEX -> WORKTREE. I.e. addtool and checkouttool in addition to
> the difftool and mergetool which we have. Just not for the current
> release cycle any more.

Yeah, getting back to the original discussion. How badly do people
actually want an external diff driver that can do fancy things with
multiple parents? It seems that for non-text diff viewers, the preferred
solution is to use difftool these days (but that is just my impression;
I don't use either difftool or external diff drivers).

-Peff
