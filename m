From: Jeff King <peff@peff.net>
Subject: Re: Usability of git stash
Date: Sun, 19 Oct 2008 20:36:44 -0400
Message-ID: <20081020003644.GA10412@coredump.intra.peff.net>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk> <20081019184029.GF14786@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 14:14:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrimX-0008WI-Cd
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 02:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbYJTAgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 20:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbYJTAgs
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 20:36:48 -0400
Received: from peff.net ([208.65.91.99]:4624 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbYJTAgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 20:36:48 -0400
Received: (qmail 9840 invoked by uid 111); 20 Oct 2008 00:36:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 19 Oct 2008 20:36:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 19 Oct 2008 20:36:44 -0400
Content-Disposition: inline
In-Reply-To: <20081019184029.GF14786@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98659>

On Sun, Oct 19, 2008 at 11:40:30AM -0700, Shawn O. Pearce wrote:

> Ditto.  I never use "git stash".  Its command line usage is too
> unfriendly for me, so I tend to prefer making WIP commits.  If I
> need to stash something I'll do:
> 
>   git commit -a -m wip
>   ... some time later ..
>   git checkout branch
>   git reset --soft HEAD^

That's what I do, too, except when I want to move changes from one
branch to another, or split some changes from their history. So
something like:

  git checkout next ;# which is where I usually am anyway
  hack hack hack
  # oops, I have been building this directly on top of next and it
  # really needs to be a feature-branch on maint
  git stash
  git checkout -b jk/maint-fix-whatever origin/maint
  git stash apply

The equivalent non-stash commands would be "commit -m wip" and
"cherry-pick". But the stash saves me the trouble later of having to
delete the wip cruft on top of next.

Side note: obviously this uses the stash only as a push/pop stack. I
have never personally had a situation where I wanted a named stash or
multiple stashes over a wip commit.

> Personally I wish git-stash wasn't invented the way it is.  I would
> have rather seen it as macros to do a quick:
> 
> 	git commit -m wip-index-state
> 	git commit -A -m wip-worktree-state
> 
> and unwind it with essentially:
> 
> 	git reset --mixed HEAD^
> 	git reset --soft HEAD^

I disagree. I think the strength of stash is that it is divorced from
the history. So it is more like a cherry-pick (or diff | apply, which is
what it was intended to replace).

> time they ran the stash.  I think its rare you'd stash something
> then switch to another branch to apply it.  But that could easily
> be done with cherry-pick.

I guess we are viewing the tool oppositely. :)

-Peff
