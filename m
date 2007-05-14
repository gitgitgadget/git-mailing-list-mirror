From: Jim Meyering <jim@meyering.net>
Subject: committing selected 'changed' or 'added' files works, but not 'removed'
Date: Mon, 14 May 2007 08:16:39 +0200
Message-ID: <87y7jsgcag.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 08:16:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnTrR-0008NJ-GG
	for gcvg-git@gmane.org; Mon, 14 May 2007 08:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289AbXENGQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 02:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758985AbXENGQn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 02:16:43 -0400
Received: from mx.meyering.net ([82.230.74.64]:47221 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760265AbXENGQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 02:16:40 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id B3BE02C57A; Mon, 14 May 2007 08:16:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47221>

Hello,

If I've just run "git-rm -f c" in a directory with a few modified
or git-added files, is there some way to commit (non-interactively)
only the removal of that selected file?  I.e., not any other changes
in the working directory?  git-commit -m. -- c fails with this:

  error: pathspec 'c' did not match any file(s) known to git

If I use "cg-commit" instead of "git-commit", it works fine.

When I asked on IRC, "cehteh" suggested to create a temporary branch,
do the removal there, and then to rebase that change back onto the
original branch -- and to remove the disposable branch.  Yes, that works,
but I want do the job with a single commit command, the same way I can
for "added" and "modified" files.  And I've been trying (until now,
successfully) to wean myself away from cogito.

Why should "removed" files be handled so differently?  If I cannot commit
a selected "file removal" (regardless of the state of the index), then
isn't that an opportunity to add a feature?

In case you're wondering, I want this functionality in order to make
a version control agnostic commit/diff/ChangeLog tool work the same way
with raw git as it did using cogito.

-------------------------------------------
In case an actual scenario helps, I'd like to be able to commit the
removal of "c", below without also committing the change to "b":

mkdir .j && cd .j && git-init > /dev/null && touch b c && git-add b c \
  && git-commit -q -m. && echo > b && git-rm --quiet -f c \
  && git-commit -m. -- c

The final commit above fails like this:

  error: pathspec 'c' did not match any file(s) known to git.
  Did you forget to 'git add'?
