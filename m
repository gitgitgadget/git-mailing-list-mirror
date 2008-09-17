From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Wed, 17 Sep 2008 12:11:11 +0200
Message-ID: <20080917101111.GR10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <20080915080131.GA30396@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 12:12:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfu1J-0006IC-8B
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYIQKLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbYIQKLR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:11:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48373 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751610AbYIQKLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:11:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BB921393A811; Wed, 17 Sep 2008 12:11:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080915080131.GA30396@noris.de>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96082>

  Hi,

On Mon, Sep 15, 2008 at 10:01:31AM +0200, Michael Radziej wrote:
> I wonder about the .topmsg and .topdeps files. Why is this information
> within the topic branch? It tends to get into the way even though a special
> merge driver is provided. For example, you cannot do octopus merges (which I
> found very confusing as first-time user).

  what do octopus merge have to do with that? If these files prevent
octopus merges somehow, I think that'd be a Git bug. (TopGit making
octopus merges whenever possible is deep on my mental TODO list.)

> And it might also confuse people
> cloning a TopGit repository and want to use a topgit branch. They might not
> be aware of these special TopGit things.

  They need to be properly educated by whoever gives them the clone URL.
Using TopGit branches outside of TopGit is still dangerous - they have
*unholy* history and they are not really suitable for non-TopGit merging
etc. If TopGit users want non-TopGit users to use their work, they
should tg export.

> I'd rather have a dedicated branched named e.g. 'TopGit' which includes the                                                           
> information that is currently in .topmsg and .topdeps, but for all branches
> in a repository.

  This was indeed a difficult design decision, perhaps the most major
one I had to make. Both approaches have their pros and cons, and in the
end I chose the .top* files mainly to keep the changes atomicity - if
you revert your branch to older version, your .topmsg and .topdeps are
rewound appropriately as well, and if you change something in your
branch that affects your topmessage, these changes are connected
appropriately. Also, you do not need to use special tools to edit your
top message and merges are much simpler than if you had to merge two
people's work on a single branch (besides, the merge semantics of the
TopGit branch would be really, really nasty, perhaps downright
impossible to specify properly).

  Hmm, well, oops. Merging of two people's work on a single branch is
broken right now anyway, because we unconditionally use our 'ours' merge
driver in these cases. I wonder how to fix this best... swapping two
gitattributes files in .git/info/attributes during tg update seems like
the only solution to me.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
