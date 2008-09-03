From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 09:20:11 +0200
Message-ID: <20080903072011.GA14252@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 09:22:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kamh4-0004p6-Ia
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 09:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbYICHUS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 03:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755754AbYICHUR
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 03:20:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:52229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756069AbYICHUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 03:20:16 -0400
Received: (qmail invoked by alias); 03 Sep 2008 07:20:13 -0000
Received: from i577B853E.versanet.de (EHLO atjola.local) [87.123.133.62]
  by mail.gmx.net (mp032) with SMTP; 03 Sep 2008 09:20:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18To9JaMLAT7+qofwtbLILVdsuX6opw5ube9I5UYI
	rDe9A+NIQPqrVm
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94755>

Hi,

"git merge" produces a (IMHO) wrong result, when a commit from the
branch that is to be merged in was cherry-picked into the current branc=
h
and later reverted on the original branch. Basically ignoring the
revert.

Example:
mkdir gmt
cd gmt
git init

/bin/echo -e "1\n2\n3\n4\n5\n6\n" > file
git add file
git commit -m init

/bin/echo -e "1\n2\n3\na\n4\n5\n6\n" > file
git add file
git commit -m add

git revert --no-edit HEAD

git checkout -b test HEAD~2
sleep 1 # Avoid race
git cherry-pick master^
git merge master


That last "git merge" call happily tells:
Already uptodate!
Merge made by recursive.

And "file" still contains the "a" that was added in the second commit.

Seems broken to me, of course I want that revert to "show up" in the
merge result, probably as a conflict for me to resolve.

Bj=F6rn
