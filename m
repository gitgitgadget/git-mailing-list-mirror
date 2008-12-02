From: Jeff King <peff@peff.net>
Subject: Re: more merge strategies : feature request
Date: Mon, 1 Dec 2008 22:30:14 -0500
Message-ID: <20081202033013.GD6804@coredump.intra.peff.net>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com> <4933AC03.6050300@op5.se> <81bfc67a0812011838m68100020v727da1c06f0bcee4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 04:31:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Lz4-0008AD-8v
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 04:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYLBDaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 22:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYLBDaR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 22:30:17 -0500
Received: from peff.net ([208.65.91.99]:2830 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYLBDaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 22:30:16 -0500
Received: (qmail 8624 invoked by uid 111); 2 Dec 2008 03:30:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Dec 2008 22:30:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Dec 2008 22:30:14 -0500
Content-Disposition: inline
In-Reply-To: <81bfc67a0812011838m68100020v727da1c06f0bcee4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102120>

On Mon, Dec 01, 2008 at 09:38:07PM -0500, Caleb Cushing wrote:

> conflict: when auto-merging isn't merging the way you want it too, but
> you still want to see the diffs and handle them by hand. no commit
> won't do this, it just doesn't commit. I've had 2 situations now where
> git's fast-forward has overwritten changes in a branch I didn't want
> it to, it would have been better if I could handle them by hand
> without having to have 1 terminal open to the diff and the other open
> to the editor to fix it. and yes git was right by it's perspective,
> but the code it created was wrong by what I wanted and needed. I'm not
> really sure what more of a use case is needed for this.

It's not clear to me exactly what you want. Let's say I have a file
'foo' with changes from my merged branches in two different spots.
For example:

 merge base     branch A      branch B
    1              2             1
    2              3             2
    3              4             3
    4              5             4
    5

Did you want conflict markers in the resulting file? If so, what should
the conflict markers look like, since there isn't actually a conflict?

Alternatively, you could have git leave the file in an unmerged state,
and then access the base, ours, and theirs version from the index (or
even use git mergetool). Then you would get your desired versions into
the merging tool of your choice.

Of course, you could also just use a custom merge driver to accomplish
the same thing:

  git config merge.xxdiff.driver 'xxdiff %A %O %B'
  echo '* merge=xxdiff' >.gitattributes
  git merge your-branch

and of course you can specify whatever subset of files you want to
actually do this for instead of '*'.

-Peff
