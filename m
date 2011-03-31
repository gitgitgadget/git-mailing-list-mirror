From: Joey Hess <joey@kitenet.net>
Subject: ignorecase interoperability bugs
Date: Thu, 31 Mar 2011 15:18:36 -0400
Message-ID: <20110331191836.GA16342@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 21:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5NWW-0006Yh-Ai
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265Ab1CaT1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:27:12 -0400
Received: from wren.kitenet.net ([80.68.85.49]:59640 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759220Ab1CaT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:27:11 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Mar 2011 15:27:10 EDT
Received: from gnu.kitenet.net (dialup-4.154.7.95.Dial1.Atlanta1.Level3.net [4.154.7.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id F089C1180B2
	for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:18:41 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id B43DD5759A; Thu, 31 Mar 2011 15:18:36 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170522>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Suppose I have two clones of a repo. "mac" has ignorecase=3Dtrue and is on =
HFS+,
and "lin" has ignorecase=3Dfalse and is on ext4. With git 1.7.4, I have fou=
nd
some very unusual behavior.

on mac (omitting all git output to save space):

$ mkdir X
$ echo mac > X/foo
$ git add X/foo
$ git commit -m "added X/foo"

on lin (omitting all git output to save space):

$ git pull mac master
# now X/foo exists here
$ mkdir x
$ echo lin > x/foo
$ git add x/foo
$ git commit -m "added x/foo"

on mac:

$ git pull lin master
[...]
 * branch            master     -> FETCH_HEAD
Updating a3dbf10..2d4223d
Fast-forward
 x/foo |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 x/foo
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#
#	modified:   X/foo
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git add X/foo
$ git commit X
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#
#	modified:   X/foo
#
no changes added to commit (use "git add" and/or "git commit -a")

So, it's possible to get files that git thinks are changed, but
cannot be committed.

$ echo testing > X/foo
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#
#	modified:   X/foo
#	modified:   x/foo

And it's possible to have multiple cases of the same file show up
even though ignorecase=3Dtrue.


The problems don't end there. Suppose I have a program that expects to
find a file in proggy/config. But, on mac, I already have a Proggy/Data
file that I created & committed for some reason. No problem; I write
my config to proggy/config; the program can read its file, I commit
proggy/config, and all seems well. Now I clone to lin, and see:

$ ls
Proggy/Data
Proggy/config
$ proggy
proggy: cannot open proggy/config: file does not exist


Git 1.7.2.5 seems to handle both these cases better; the ignorecase rework
in 1.7.4 introduced most of these problems AFAICS.

--=20
see shy jo

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTZTTickQ2SIlEuPHAQgImg/9Ggr/F59qMEoO9LIjOp+c7z+g7GxTfqhl
XJju9GnIlbHBqGw2xjM47X0v407p1RV3JS9IeBtFwHIW63S5NgPH2DgfjXAQoW9Y
HHddp+qfmY9xDzEnQoEGrUuAIwlVnom3moLvEY0k9lb8Y3wN6erGHoukKVtpgQBF
I4xPc6yRbiOKuq4/DhWpCpYqdlimm7tSQsYuDXOdM+8hutGEWAtsDachS20iRcGW
tWbPwfSRB53layQB/I0nYMLwat5qqQHr+ZblQ8iDoerNFelQMvGrQNdHU5qcbknH
jk8S6B/RpIHjFa6c3asK/6DIPsAobeZHmS/Xx6QrtjtOQu9KD34tECWv3cfQ3P3s
4aBkLbMVUxqVYoGhCJr/Rionz/NcI+lQmh80xB22mtlexNSdfT0u8dJPSRLQvyqN
dmOsa5jt/+OD6ReUtz+JxDzt0eLhNhn1GvkekiTgkcC8Frzs4nrikq+u5P4Sncg0
E6UNoFvDJBkSqhIfMNaXSuqmLPK8JwVuGIHv366nmizbz2cLNrSZ5lVltbVJMX00
EBLXfWwht6a0Xn7s4vsPvOwtUbX6bnmNaQmPaxIGsqamQonnj/B37Qv1FF3rJrgJ
PFlnATEnrPzkTKiQv5UhoQ8hPv6FykLhgWhd1vvbm2AzYObzffVSdhpH/OamnXeK
HSn0iAoHdeA=
=j+kC
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
