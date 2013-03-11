From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: Rewriting references to existing commits in commit messages with filter-branch
Date: Mon, 11 Mar 2013 12:45:38 +0100
Message-ID: <E1UF1Ag-0006m3-5k@smtp.tt-solutions.com>
Mime-Version: 1.0
Content-Type: MULTIPART/SIGNED; protocol="application/pgp-signature"; micalg=pgp-sha1; BOUNDARY="2143049595-41-1363002338=:6060"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 12:55:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1K1-0006je-9x
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 12:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab3CKLyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 07:54:51 -0400
Received: from sunset.tt-solutions.com ([82.238.156.189]:39474 "EHLO
	smtp.tt-solutions.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886Ab3CKLyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 07:54:50 -0400
X-Greylist: delayed 549 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2013 07:54:50 EDT
Received: from [192.168.17.86] (helo=Twilight)
	by smtp.tt-solutions.com with esmtp (Exim 4.72)
	(envelope-from <vz-git@zeitlins.org>)
	id 1UF1Ag-0006m3-5k
	for git@vger.kernel.org; Mon, 11 Mar 2013 12:45:38 +0100
X-Mailer: Mahogany 0.68.0 'Cynthia', running under Windows 7 (build 7601, Service Pack 1), 64-bit edition
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217869>

--2143049595-41-1363002338=:6060
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE

 Hello,

 I'm in the process of converting an existing svn repository to git. The
first step was a standard "git svn clone" that went successfully (after
taking 15 hours to complete). However I don't want to stop there and would
like massage the repository a little before making it publicly available.

 The first thing I'd like to do is to replace all references to subversion
revision numbers in the commit messages with the corresponding git commit
SHA1s. I've written a small message filter script called "svnmsg2git" that
searches for all occurrences of r12345, runs "git svn find-rev r12345" and
then -- and this is the important part -- looks up the new commit id
corresponding to this under .git-rewrite/map. This seemed to work well in
limited testing I did initially but after running

git filter-branch --msg-filter svnmsg2git --tag-name-filter cat -- --all

on all ~50k revisions, I have a couple of dozens of errors which happen
because the file .git-rewrite/map/$commit doesn't exist yet when I'm trying
to look it up.

 Does anybody know of a way to fix this? This happens apparently because
filter-branch doesn't process the commits in their svn order, and when one
of them is on a branch while the other one is on the trunk, it can happen
that the commit references a previous svn revision is processed before the
commit corresponding to this revision itself. At least this is the only
explanation I see. But even if my hypothesis is correct, I still have no
idea about how to force filter-branch to do things in the "right" order.

 Thanks in advance for any ideas!
VZ

--2143049595-41-1363002338=:6060
Content-Type: APPLICATION/PGP-SIGNATURE

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)

iEYEABECAAYFAlE9w+IACgkQBupB3k9sHoaglgCeL+U+V43UOcMi6R96Rts+qJkX
CnIAnROYKSNMXYX3ZgJ6yy1a6UdGm1tb
=SJZZ
-----END PGP SIGNATURE-----

--2143049595-41-1363002338=:6060--
