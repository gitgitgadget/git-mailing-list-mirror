From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 03:30:11 -0700
Message-ID: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 19 12:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpMCb-0001Wh-3d
	for gcvg-git@gmane.org; Sat, 19 May 2007 12:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbXESKaG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 06:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756391AbXESKaG
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 06:30:06 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:42723 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756345AbXESKaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 06:30:04 -0400
Received: (qmail 30863 invoked from network); 19 May 2007 10:30:00 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 19 May 2007 10:30:00 +0000
Received: (qmail 15099 invoked by uid 10000); 19 May 2007 03:30:11 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47736>


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Background:
-----------
Using git-svn to work with an external project (non-public), and the
other day I happened to run 'git-svn dcommit' right as their SVN went
down for a moment (under 5 seconds) for the snapshot-backup. I recall
swearing profusely at the time, but thought nothing of it after that,
until now, when I saw that parts of my tree weren't as they should be.

Problem:
--------
A bunch of my commits are NOT present in git-log, git-rev-list, or any
tool that provides the history of my branches.

If I hack around and recover the commitid, I can pass it to git-show,
and the commit does still exist in the data.

git-fsck --unreachable does not list the commit in question either, but
does list other blobs and trees.

Luckily, since the entire tree had ~900 commits, I was able to work some
magic and recovery my work:
1. Hack to get list of all commits
2. Exclude all commits that had git-svn-id in their description.
3. Exclude all merges.
4. Manually review all remaining commits (~70).

The following questions are mainly things that would have made my
recovery far easier.

Questions:
----------
1. Is there a plumbing tool to list EVERY single object of a given type
   (blob, tree, commit, tag) that git is aware of, regardless of it
   being reachable? (Right now I have a hack to read the pack index, and
   use find to find the non-packed object ids, then git-cat-file -t for
   the type).
2. A sane way to view an ordered set of commits, so that it should be
   possible to spot when there's a path of commits that went off and
   isn't used anymore.
3. Given a set of commits, list which are actually unique (in my tree,
   git-svn uses rebase often, so I have a lot of commits that are
   identical bar the commitid).
4. Strongly related to #4, given everything a commit, tell me what other
   identical commits exist in the tree.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGTtGzPpIsIjIzwiwRAmaNAKCpgV1gbHyr7lpiWj5IRn+53nKhGACghlQK
nm8iCvCybngVaomYGOSLjbs=
=e9/m
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--
