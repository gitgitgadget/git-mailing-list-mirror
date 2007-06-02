From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: git-svn adding too many blank lines during git-cherry-pick, and
	git-cherry getting confused
Date: Fri, 1 Jun 2007 21:50:07 -0700
Message-ID: <20070602045007.GJ27013@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mFHiwr52TKrxpkjc"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 06:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuLYq-0005ZC-3C
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 06:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753972AbXFBEtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 00:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbXFBEtt
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 00:49:49 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:60415 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753972AbXFBEts (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 00:49:48 -0400
Received: (qmail 29987 invoked from network); 2 Jun 2007 04:49:46 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sat, 02 Jun 2007 04:49:46 +0000
Received: (qmail 25366 invoked by uid 10000); 1 Jun 2007 21:50:07 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48911>


--mFHiwr52TKrxpkjc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Bit of weirdness I ran into.

I have a SVN tree, with a branch that gets some backported fixe (they
usually apply cleanly).

I commit the fix to the trunk + git-svn dcommit, and then switch to the
other branch, and git-cherry-pick the fix.

For git-svn commits, the log has:
On the trunk side, there is a two blank line before git-svn-id.
On the branch side, there are three blank lines before git-svn-id.
If I cherry-pick from that branch to a third branch, I get 4 blank
lines.

For regular SVN commits, the log has:
Only a single blank line before git-svn-id.

I think the source of the problem is that git-svn-id is being removed
when cherry-picking, but NOT the leading blank line.

This all leads to the hashes of the commits diverging badly, and then
git-cherry gets very confused when asked to compare the trunk vs. the
branches.

How do we solve it?
This is only on a conceptual level here, looking at the present state of
git-svn, I'm not sure how best to solve it.

git-svn fetch:
1. Get commit message from SVN.=20
2. Trim ALL trailing blank lines (and existing git-svn-id lines).
3. If the last line was header-style (Signed-off-by, CC, etc)
3.1. if it was, do not add a blank line.
3.2. If not, add a single blank line.
4. Insert git-svn-id header.

git-svn dcommit:
1. Get commit message (git cat-file commit ....)
2. Remove the git-svn-id line.
3. Remove all trailing blank lines.
4. Commit.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--mFHiwr52TKrxpkjc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGYPb+PpIsIjIzwiwRAoQNAKDIMxXHS8sDuTjyX+zLEnN8d8sG3gCfXoWp
NhSkKFRhIvfaSSjCslZ5aGY=
=1rr6
-----END PGP SIGNATURE-----

--mFHiwr52TKrxpkjc--
