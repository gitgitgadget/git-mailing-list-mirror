From: Petr Baudis <pasky@suse.cz>
Subject: Re: linearising TopGit forests into patch series (was: [ANNOUNCE]
	TopGit - A different patch queue manager)
Date: Sat, 9 Aug 2008 03:08:21 +0200
Message-ID: <20080809010821.GT10151@machine.or.cz>
References: <20080803031424.GV32184@machine.or.cz> <20080807175623.GA16833@lapse.rw.madduck.net> <36ca99e90808071258h62b65981s20a5b053d9bc5754@mail.gmail.com> <20080808170658.GA16055@lapse.rw.madduck.net> <20080803031424.GV32184@machine.or.cz> <20080807175623.GA16833@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	vcs distro packaging discussion list 
	<vcs-pkg-discuss@lists.alioth.debian.org>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: martin f krafft <madduck@debian.org>
X-From: git-owner@vger.kernel.org Sat Aug 09 03:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRcxT-0003UB-0X
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 03:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYHIBIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 21:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580AbYHIBIZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 21:08:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53014 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568AbYHIBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 21:08:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0305F2C4C031; Sat,  9 Aug 2008 03:08:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080808170658.GA16055@lapse.rw.madduck.net> <20080807175623.GA16833@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91736>

Hi!

On Thu, Aug 07, 2008 at 02:56:24PM -0300, martin f krafft wrote:
> Assuming a number of interdependent topic branches, does TopGit
> provide a way for me to linearise/flatten/serialise these branches
> in a one-patch-per-branch fashion, so that I could turn any TopGit
> repository into a quilt series? I am only interested in a one-way
> conversion from TopGit to quilt for now.

Not _yet_. But it very well could, and it should be really simple.

There are two parts:

(i) First, getting a "tidied up" commit structure from TopGit, having
one commit per patch (branch). This is something covered currently in
the README by:

	TODO: tg collapse for creating a one-commit-per-patch tidied up
		history (for pulling by upstream)

So it's not implemented yet, but it should be *very* easy to do.

(ii) Second, linearizing this commit structures to a series. This should
be as simple as running

	git log --pretty=email -p --topo-order

on the collapsed history.

> The reason for this is quite simply that while it's fabulous to use
> e.g. Git for managing the source repository from which to build
> distro packages, the resulting packages will have all
> distro-specific changes applied or collated into a single diff. This
> makes it hard for other distributions to grab patches, for upstream
> to keep on top of what is being distributed, and for bug fixers to
> separate patches and test only specific ones.

This is exactly what TopGit seeks to alleviate.

On Fri, Aug 08, 2008 at 02:06:58PM -0300, martin f krafft wrote:
> Also, what happens if branches cross-merge?

This would mean there is circular dependence between the branches, which
is invalid setup for TopGit - you could not get a linear ordering out of
the branches anyway; in result, each branch has to turn out to a single
final Git commit - with circular dependencies, you cannot do that.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
