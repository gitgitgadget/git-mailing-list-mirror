From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] checkout: implement "-" shortcut name for last branch
Date: Thu, 15 Jan 2009 14:59:58 +0100
Message-ID: <200901151500.01876.trast@student.ethz.ch>
References: <1231977976-8739-1-git-send-email-trast@student.ethz.ch> <496EE559.3060901@viscovery.net> <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2391053.aZgkXShGl6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 15:01:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNSmT-0002Sa-2t
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 15:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbZAON7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753959AbZAON7p
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:59:45 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:44952 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbZAON7o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 08:59:44 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 14:59:43 +0100
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 14:59:43 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0901151413250.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 15 Jan 2009 13:59:43.0148 (UTC) FILETIME=[842206C0:01C97719]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105812>

--nextPart2391053.aZgkXShGl6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Thu, 15 Jan 2009, Johannes Sixt wrote:
> > You must make sure that commits referenced by LAST_HEAD are not
> > garbage-collected. (I don't know if this happens anyway for symrefs in =
=2Egit.)
>=20
> Note: if you used reflogs for that feature, the garbage collection could=
=20
> not have killed the commit.  However, it is quite possible that the=20
> branch was deleted.

Suddenly I'm not so sure about either behaviour any more.

Consider:

  $ git commit -m initial
  [master (root-commit)]: created 812c476: "initial"
   1 files changed, 1 insertions(+), 0 deletions(-)
   create mode 100644 foo
  $ git checkout $(git rev-parse HEAD)
  Note: moving to "812c476ca23e25efa7e4d7081153ba657a127d95" which isn't a =
local branch
  If you want to create a new branch from this checkout, you may do so
  (now or later) by using -b with the checkout command again. Example:
    git checkout -b <new_branch_name>
  HEAD is now at 812c476... initial
  $ git branch -D master
  Deleted branch master (812c476).
  $ git for-each-ref
  $ git reflog expire --expire=3Dnow --all
  $ git prune --expire now
  $ git show
  fatal: bad object HEAD
  $ git show 812c476
  fatal: ambiguous argument '812c476': unknown revision or path not in the =
working tree.
  Use '--' to separate paths from revisions

Oops.

Some quick RTFS shows that it indeed "only" cares about refs and
reflogs.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch


--nextPart2391053.aZgkXShGl6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklvQWEACgkQqUud07tmzP0kGQCfX7q35VmrQSqyovYVk6jutnrJ
BzQAn2xdXKSiN1k05M81pTQNYO8FwNNr
=k9Xq
-----END PGP SIGNATURE-----

--nextPart2391053.aZgkXShGl6--
