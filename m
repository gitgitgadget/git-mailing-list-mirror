From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 19 Feb 2007 18:28:40 -0500
Message-ID: <1171927720.2257.41.camel@dv>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
	 <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
	 <20070212202634.GX4266@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070212214704.GS5362@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 00:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJHw8-0006mu-4O
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 00:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965536AbXBSX2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965543AbXBSX2p
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 18:28:45 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:50757 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965536AbXBSX2o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 18:28:44 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HJHuf-0005di-Ah
	for git@vger.kernel.org; Mon, 19 Feb 2007 18:27:17 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HJHw1-0001zL-22; Mon, 19 Feb 2007 18:28:41 -0500
In-Reply-To: <b0943d9e0702191507m636348e7yab2a712925f9f55@mail.gmail.com>
X-Mailer: Evolution 2.9.91 (2.9.91-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40162>

On Mon, 2007-02-19 at 23:07 +0000, Catalin Marinas wrote:
> On 12/02/07, Yann Dirson <ydirson@altern.org> wrote:
> > On Mon, Feb 12, 2007 at 09:26:34PM +0100, Yann Dirson wrote:
> > > No, I agree it's a bug.  Rebasing after a fetch should allow this
> > > workflow to work as well.  If the parent branch is not a rewinding
> > > one, we should ensure there is nothing lost.  And even for rewinding
> > > branches, we should probably keep track of the existence of commits,
> > > so we can warn and nothing gets lost without knowing.
> >
> > Thinking about it, detecting whether we're going to lose a commit is
> > just checking *before pulling* whether the current base is reachable
> > from the parent's current head.
> 
> There is a potential problem with this approach - pulling/fetching
> from a tree which is always rebased (either managed with StGIT or
> simply running git-rebase before publishing it) would report an error
> since the old base is no longer reachable from the current head. In
> this case, the current fetch+rebase behaviour would be desirable.

One possible workaround would be to report an error and do nothing if
the old head would become unreachable (it's possible that I'm missing
something and that it was discussed to death already).

> I think the fail-safe solution would be to leave the old behaviour
> (i.e. git-pull and pull-does-rebase=no) and people that need to pull
> from branches like that described above would use the fetch+rebase
> approach. Ideally, we'll have this configurable per-branch (and could
> leave the global one as well if the most specific is not available,
> but should default to git-pull).

By the way, it would be great to reduce all complexity to "one bit" per
branch.  If stgit.internal-pull (the name is subject to improvement) is
on, "stgit pull" calls git-fetch and does rebase.  Otherwise, it calls
git-pull.  No need to configure two variables per branch.

> Let me know what you think so that I'll try to release a 0.12.1 update
> (I already have the simple patch for using git-pull by default if you
> are OK with this scenario).

Any fix for the current behavior would be fine to me.  Either restore
the old default or don't rebase if the old head becomes unreachable.

-- 
Regards,
Pavel Roskin
