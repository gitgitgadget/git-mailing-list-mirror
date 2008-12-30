From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Why can't git pull --rebase work if there are modified files?
Date: Wed, 31 Dec 2008 00:09:09 +0100
Message-ID: <200812310009.12052.trast@student.ethz.ch>
References: <2729632a0812301340y735c3946weee55c9856d4e6a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2892618.M93VlGb3a8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Dec 31 00:10:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHnjN-0002vQ-RC
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 00:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbYL3XJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 18:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYL3XJA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 18:09:00 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:13325 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351AbYL3XI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 18:08:59 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 31 Dec 2008 00:08:58 +0100
Received: from [192.168.0.3] ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 31 Dec 2008 00:08:57 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <2729632a0812301340y735c3946weee55c9856d4e6a9@mail.gmail.com>
X-OriginalArrivalTime: 30 Dec 2008 23:08:57.0893 (UTC) FILETIME=[98150D50:01C96AD3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104223>

--nextPart2892618.M93VlGb3a8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

skillzero@gmail.com wrote:
> If I have locally modified files and I try to 'git pull --rebase', it
> fails because of the locally modified files. If I don't use the
> --rebase option, it works (but generates a merge commit if I have
> local commits). Why does rebasing require an unmodified checkout? It
> seems like it should only stop if I something in the newly fetched
> changes conflict with my local changes.

=46irst you need to be aware that 'git pull --rebase' is conceptually
the same as 'git fetch && git rebase upstream', where 'upstream' is
the remote branch tracked by your current branch.  (The canonical
choice is upstream=3Dorigin/foo for a branch foo.)  git-fetch is of no
further interest to the discussion, as it does not touch the working
tree in any way.

git-rebase is not concerned with "newly fetched changes".  It
*rewinds* your branch to the updated 'upstream' tip, and then
*rebuilds* your commits on top of that.  This involves a lot of
resetting and applying patches, which appears to be why it enforces a
clean working tree.

You can use git-stash (see the man page) to temporarily save away your
uncommitted changes, however.  Maybe you could even write a patch to
git-rebase that lets it automatically save and restore uncommitted
changes?

> I almost always have modified files in my checkout for things I'm
> working on. I also often have a commit or two that haven't been pushed
> because I'm waiting until I get to a good point before pushing. If I
> do 'git pull', I end up with a merge commit each time. That's why I
> want to use --rebase, but for it to work, I have to git stash, then
> rebase then git stash pop.

You could probably improve your workflow a lot by using topic
branches.  See the recently added gitworkflows manpage, also available
at

  http://www.kernel.org/pub/software/scm/git-core/docs/gitworkflows.html

or, e.g., Tv's excellent introduction to git called "Version Control
for Du^H^HDevelopers":

  http://eagain.net/blog/2008/08/11/ep-talk-videos.html

(Pretty much the second half is about branch workflows, topic branches
are explicitly introduced at ~44:15.)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart2892618.M93VlGb3a8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklaqhgACgkQqUud07tmzP0IgQCfSM2bUmUC+IHgErIUhq38Wc9k
QrgAnRQ8VPBclXIChJlD64BKP+7ahaHc
=u4B4
-----END PGP SIGNATURE-----

--nextPart2892618.M93VlGb3a8--
