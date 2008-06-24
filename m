From: Theodore Tso <tytso@mit.edu>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 18:54:42 -0400
Message-ID: <20080624225442.GA20361@mit.edu>
References: <m31w2mlki4.fsf@localhost.localdomain> <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Jeske <jeske@google.com>, Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jun 25 00:56:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHRC-0001P5-Mg
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 00:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbYFXWzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 18:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbYFXWzi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 18:55:38 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:58730 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753726AbYFXWzh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 18:55:37 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBHPT-0007rs-G1; Tue, 24 Jun 2008 18:54:47 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBHPO-0005S7-Kh; Tue, 24 Jun 2008 18:54:42 -0400
Content-Disposition: inline
In-Reply-To: <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86173>

On Tue, Jun 24, 2008 at 04:42:49PM -0500, Brandon Casey wrote:
> Again, as I mentioned to Boaz, there is really no benefit to reusing
> a single branch name if that is what you are trying to do. The cost
> of branching in git is 41 bytes i.e. nil.

The main reason that I find for reusing a branch name is for my
integration branch.  I have a script which basically does:

git checkout integration
git reset --hard origin
git merge branch-A
git merge branch-B
git merge branch-C
git merge branch-D

I suppose I could have avoided the use of git reset with something
like this:

git update-index --refresh --unmerged > /dev/null
if git diff-index --name-only HEAD | read dummy; then
	echo "There are local changes; refusing to build integration branch!"
	exit 1
fi
git update-ref refs/heads/integration origin
git checkout integration
git merge branch-A
git merge branch-B
git merge branch-C
git merge branch-D

Instead, I've just learned to be careful and my use of git reset
--hard is mainly for historical reasons.  But the point is, I can very
easily think of workflows where it makes sense to reuse a branch name,
most of them having to do with creating integration branches which are
basically throwaways after I am done testing or building that combined
tree.

							- Ted
