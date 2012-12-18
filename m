From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Q: do people compile with NO_FNMATCH on OpenBSD 5.2?
Date: Tue, 18 Dec 2012 15:23:50 -0500
Message-ID: <rmisj732jop.fsf@fnord.ir.bbn.com>
References: <7va9tbf7vd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:32:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl3pg-0005Q7-IK
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 21:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753862Ab2LRUbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 15:31:50 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:62231 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348Ab2LRUbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 15:31:50 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2012 15:31:50 EST
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 4CB0BBC5E; Tue, 18 Dec 2012 15:23:50 -0500 (EST)
OpenPGP: id=32611E25
X-Hashcash: 1:20:121218:gitster@pobox.com::IOamdUTATA7qJwhg:000000000000000000000000000000000000000000000Aev
X-Hashcash: 1:20:121218:git@vger.kernel.org::IOamdUTATA7qJwhg:0000000000000000000000000000000000000000001WZ2
In-Reply-To: <7va9tbf7vd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 18 Dec 2012 12:00:38 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211783>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Junio C Hamano <gitster@pobox.com> writes:

> I seem to get a failure from
>
>     git ls-files "a*"
>
> in t/t0000-basic.sh if I link with platform's fnmatch().

Not what you asked, but on NetBSD 5.1, libc fnmatch is used, and with
git 1.8.0.1 that test passes.

This prompted me to look at the rest of the tests.  All tests pass
(except for expected failures) until:

  *** t0070-fundamental.sh ***
  ok 1 - character classes (isspace, isalpha etc.)
  not ok - 2 mktemp to nonexistent directory prints filename
  #
  #               test_must_fail test-mktemp doesnotexist/testXXXXXX 2>err =
&&
  #               grep "doesnotexist/test" err
  #
  ok 3 - mktemp to unwritable directory prints filename
  ok 4 - check for a bug in the regex routines
  # failed 1 among 4 test(s)
  1..4

Running this by hand, I get:

gdt 51 /usr/pkgsrc/devel/scmgit-base/work/git-1.8.0.1/t > ../test-mktemp fo=
o/barXXXXXX > MKTEMP.stdout 2> MKTEMP.stderr; ls -l MKTEMP*
=2Drw-r--r--  1 gdt  wheel  121 Dec 18 15:14 MKTEMP.stderr
=2Drw-r--r--  1 gdt  wheel    0 Dec 18 15:14 MKTEMP.stdout
gdt 52 /usr/pkgsrc/devel/scmgit-base/work/git-1.8.0.1/t > cat MKTEMP.stderr=
=20
fatal: Unable to create temporary file '/usr/pkgsrc/devel/scmgit-base/work/=
git-1.8.0.1/t/foo': No such file or directory

It seems ENOENT is correct for the directory not existing.  I think the
test is complaining that the failed call to mkstemp modified the
argument.=20

Looking at:
=20
  http://pubs.opengroup.org/onlinepubs/9699919799/functions/mkstemp.html

I can't see that it requires anything in particular for the in/out
paramater when there is an error.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlDQ0NYACgkQ+vesoDJhHiX16ACfUsn+VyVoktkS9zuxQEyNNO6h
x+YAn1+FI9/ygpryZQniT4fGzS3Dl2Xn
=ePU1
-----END PGP SIGNATURE-----
--=-=-=--
