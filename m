From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Usability of git stash
Date: Sun, 19 Oct 2008 11:40:30 -0700
Message-ID: <20081019184029.GF14786@spearce.org>
References: <87wsg9acfv.fsf@cup.kalibalik.dk> <nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil> <86vdvsg4up.fsf@lola.quinscape.zz> <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> <87prly5k5r.fsf@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, David Kastrup <dak@gnu.org>,
	git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Mon Oct 20 12:57:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrdDj-0005sP-Su
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 20:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYJSSkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 14:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbYJSSkb
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 14:40:31 -0400
Received: from george.spearce.org ([209.20.77.23]:45161 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYJSSka (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 14:40:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 09AD53835F; Sun, 19 Oct 2008 18:40:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87prly5k5r.fsf@cup.kalibalik.dk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98649>

Anders Melchiorsen <mail@cup.kalibalik.dk> wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
> > In exchange for allowing new users to stub their toe on new commands, the
> > work flow of more experienced users is made a little easier.
> 
> I wonder whether experienced users even use stash a lot. Personally,
> after getting my head around the DAG, and thus getting more
> comfortable with git reset, I tend to make "WIP" commits instead.

Ditto.  I never use "git stash".  Its command line usage is too
unfriendly for me, so I tend to prefer making WIP commits.  If I
need to stash something I'll do:

  git commit -a -m wip
  ... some time later ..
  git checkout branch
  git reset --soft HEAD^

> The primary thing that stash does for me is preserve the index state.
> Unfortunately, --index is not default for stash apply, so I often
> forget it.

I never find the index saving useful.  My commits are frequent
enough that losing the index state usually only costs me a few
minutes when I go back to the branch and pop the wip commit.
 
> Sometimes, I also want stash to store away changes to untracked files
> (to get a clean working directory), but that is not possible.

Indeed, that's an advantage of the wip commit approach, you can shove
the untracked files quickly into the wip commit, especially with 1.6:

	git commit -A -m wip


Personally I wish git-stash wasn't invented the way it is.  I would
have rather seen it as macros to do a quick:

	git commit -m wip-index-state
	git commit -A -m wip-worktree-state

and unwind it with essentially:

	git reset --mixed HEAD^
	git reset --soft HEAD^

then its a lot less black magic to users, as they can see it in the
DAG, and its more explicitly tied to the branch they were on at the
time they ran the stash.  I think its rare you'd stash something
then switch to another branch to apply it.  But that could easily
be done with cherry-pick.

-- 
Shawn.
