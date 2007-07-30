From: Craig Boston <craig@olyun.gank.org>
Subject: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 13:07:11 -0500
Message-ID: <20070730180710.GA64467@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 20:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFZoC-0006cR-9q
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 20:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967048AbXG3SR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 14:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967036AbXG3SR2
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 14:17:28 -0400
Received: from ion.gank.org ([69.55.238.164]:4267 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762124AbXG3SR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 14:17:27 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jul 2007 14:17:25 EDT
Received: by ion.gank.org (Postfix, from userid 1001)
	id 64761115D7; Mon, 30 Jul 2007 13:07:11 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54247>

Hello, I'm seeking some input from git users/developers to try and solve
a problem I'm encountering.  I'm new with git, having used quite a bit
of Subversion and SVK in the past, but have heard good things and
decided to give it a try.

First, a little bit about what I'm trying to accomplish.  There is a
large source tree -- FreeBSD to be specific -- which is maintained in
CVS.  I want to have several local branches where I can develop specific
projects.  Each of these branches should derive from either the HEAD of
the CVS tree, or from one of the release branches (known as the -STABLE
branch for a particular version of the OS).

That said, I really don't want to have to import the entire CVS
repository.  It has many, many branches and tags that I'm not interested
in, and I really don't need the entire history of the project.  I don't
even really need individual commit history.  I can see that easily enough
on cvsweb.  Repo size is a big factor as I need to replicate it between
several different work machines, some of which don't have unlimited disk
space.

What I'm currently doing (using SVK) is nightly, taking a snapshot using
cvsup of each of the 3 branches that I care about, then using "svk
import" to pull the snapshot into a local branch that I treat as a
vendor branch.  My projects are branched off those and I regularly
smerge changes over.  It works pretty well for me, the only downside is
that svk isn't exactly fast, having to load lots of perl modules for
every command.

I'd like to do something similar with git -- I like the idea of it
having many less dependencies that must be installed, and it's supposed
to be quite a bit faster when dealing with working copies.  From reading
about it I think it may also be easier to generate diffs of my branches
from their origins.

So far the main snag I've found is that AFAIK there's no equivalent to
"svk import" to load a big tree (~37000 files) into a branch and commit
the changes.  Here's the procedure I've come up with:

cd /path/to/git/repo
git checkout vendor_branch_X
git rm -r .
cp -R /path/to/cvs/checkout_X/* ./
git add .
git commit -m"Import yyyymmdd snapshot"

However this has quite a few disadvantages when compared to svk.  The
first is that I have to checkout into a working directory and then copy
the files from the cvs checkout.  It is also considerably slower than
svk import, about 7-8 times on average.  When there are a lot of
changes I've seen the git process use upwards of 1GB of memory; it
actually died the first time I tried it because I didn't have any swap
configured.

Now, I don't have very much experience with git, so for my question: Is
there a better way to do this?  Either importing a lot of files into
git, or a better solution for that I'm trying to do.

Any pointers would be much appreciated.

Thanks!

Craig
