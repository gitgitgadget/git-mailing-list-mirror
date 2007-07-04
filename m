From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Tue, 03 Jul 2007 22:10:46 -0700
Message-ID: <7vodiskb3d.fsf@assigned-by-dhcp.cox.net>
References: <20070703085906.GA4963@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, <nanako3@bluebottle.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 07:11:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5x93-0001Ir-Nv
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 07:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbXGDFK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 4 Jul 2007 01:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXGDFK7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 01:10:59 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40502 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbXGDFKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jul 2007 01:10:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704051048.OHBG3098.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 01:10:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KHAn1X0041kojtg0000000; Wed, 04 Jul 2007 01:10:47 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51570>

Uwe Kleine-K=C3=B6nig  <ukleinek@informatik.uni-freiburg.de> writes:

> If I do
>
> 	git cat-file commit $commitid
>
> for a commit created by stash, the next prompt starts directly after =
the
> shortlog of HEAD.

Thanks.

I noticed another thing.  The entries shown in "git stash list"
look like this:

stash@{0}: js/stash: e1d32c1... Teach git-stash to "apply --index"
stash@{1}: master: 5be6007... Rewrite "git-frotz" to "git frotz"
stash@{2}: master: 36e5e70... Start deprecating "git-command" in favor =
of "git command"
stash@{3}: master: 3b0d999... Merge branch 'jo/init'

But each of the stash is _not_ about these commits, but is about
some change that happens to be on top of them.

So risking to make it a tad longer, how about doing this on top?

---

 git-stash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9deda44..dd721d2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -71,7 +71,7 @@ save_stash () {
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
 		die "Cannot record working tree state"
=20
-	git update-ref -m "$msg" $ref_stash $w_commit ||
+	git update-ref -m "WIP on $msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
 	printf >&2 'Saved WIP on %s\n' "$msg"
 }
