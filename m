From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [TESTCASE] Failing 'git am' when core.autocrlf=true
Date: Thu, 23 Aug 2007 16:07:39 +0200
Message-ID: <46CD94AB.7070709@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE46C3DBCDA61183B6EB04898"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 16:06:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IODKJ-0004j6-9l
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 16:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758322AbXHWOGU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 10:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757530AbXHWOGU
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 10:06:20 -0400
Received: from esparsett.troll.no ([62.70.27.18]:60349 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599AbXHWOGT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 10:06:19 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id E1DDF74212; Thu, 23 Aug 2007 16:06:17 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id B5E0274198; Thu, 23 Aug 2007 16:06:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070728 Thunderbird/2.0.0.6 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.3
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56500>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE46C3DBCDA61183B6EB04898
Content-Type: multipart/mixed;
 boundary="------------070108040806060703030000"

This is a multi-part message in MIME format.
--------------070108040806060703030000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I have an issue with git-rebase failing on a repository using
     core.autocrlf=3Dtrue

I've tracked it down to git-am failing with core.autocrlf=3Dtrue and=20
passing with core.autocrlf=3Dfalse. I've tried digging deeper into the=20
code, but for some reason ce_match_stat_basic() (read-cache.c:~187)=20
reports the size of the file in the index to be 0 (when=20
core.autocrlf=3Dtrue), which is why git-am bails out on the patch.=20
(ce->ce_size =3D=3D 0, while st->st_size =3D=3D the correct size on disk)=


If I force the bailout in check_patch() (builtin-apply.c:~2101) to=20
_not_ happen, the patch applies without problems.

Can anyone please enlighten me on why this may happen?

I've attached a SH script which will reproduce the problem. Simply run
     ./git_am_crlf_testcase.sh
to reproduce the problem, and run
     ./git_am_crlf_testcase.sh --no-crlf
to show it working when core.autocrlf=3Dfalse.

Thanks for your help!

--
=2Emarius


--------------070108040806060703030000
Content-Type: text/plain;
 name="git_am_crlf_testcase.sh"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="git_am_crlf_testcase.sh"

#!/bin/sh
#
# Testcase for failing 'git am' on a repository with core.autocrlf =3D tr=
ue
#     ./git_am_crlf_testcase.sh              fails for Git 1.5.3.rc4
#     ./git_am_crlf_testcase.sh --no-crlf    passes
#
# -----------------------------------------------------------------------=
---------------------------

TESTCASE_REPO=3Dgit_am_crlf_testcase
GIT_AUTOCRLF=3Dtrue

# parse the arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
    --no-crlf) # Turn off autocrlf for the repository
        GIT_AUTOCRLF=3Dfalse
        ;;
    --crlf) # Turn on autocrlf for the repository
        GIT_AUTOCRLF=3Dtrue
        ;;
    esac
    shift
done


# Functions -------------------------------------------------------------=
---------------------------

die() {
    echo >&2 "$@"
    exit 1
}

print_patch() {
cat << __END_OF_PATCH__
=46rom 38be10072e45dd6b08ce40851e3fca60a31a340b Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <x@y.com>
Date: Thu, 23 Aug 2007 13:00:00 +0200
Subject: test1

---
 foo |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo

diff --git a/foo b/foo
new file mode 100644
index 0000000000000000000000000000000000000000..5716ca5987cbf97d6bb54920b=
ea6adde242d87e6
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+bar
--=20
1.5.3.rc4.mingw.2.3.g3318a-dirty


=46rom 3bb3855cf028fc90010e2f51aceb6d3a90039c5c Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <x@y.com>
Date: Thu, 23 Aug 2007 13:00:01 +0200
Subject: test2

---
 foo |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/foo b/foo
index 5716ca5987cbf97d6bb54920bea6adde242d87e6..e2994c5ae2f7c41a306d9b41b=
64af4d6b7242793 100644
--- a/foo
+++ b/foo
@@ -1 +1,2 @@
 bar
+baz
--=20
1.5.3.rc4.mingw.2.3.g3318a-dirty


=46rom 38212fd002da735b3626c6f1d801c8ca37ce04e6 Mon Sep 17 00:00:00 2001
From: Marius Storm-Olsen <x@y.com>
Date: Thu, 23 Aug 2007 13:00:02 +0200
Subject: test3

---
 foo |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/foo b/foo
index e2994c5ae2f7c41a306d9b41b64af4d6b7242793..ad94f9e431a24bbe67e9e5935=
e2a8cf20a73e723 100644
--- a/foo
+++ b/foo
@@ -1,2 +1,3 @@
 bar
 baz
+blah
--=20
1.5.3.rc4.mingw.2.3.g3318a-dirty
__END_OF_PATCH__
}


# 'main' ----------------------------------------------------------------=
---------------------------

# Kill old testcase repository
test -d "$TESTCASE_REPO" && rm -rf $TESTCASE_REPO

# Create new testcase repository
mkdir $TESTCASE_REPO &&
cd $TESTCASE_REPO &&
git init || die "Couldn\'t create testcase repository \'$TESTCASE_REPO\'!=
"

# Set autocrlf explicitly
git config core.autocrlf $GIT_AUTOCRLF || die "Couldn\'t set core.autocrl=
f to \'$GIT_AUTOCRLF\'!"

# Create initial commit
(echo foo > bar &&
git add bar &&
git commit -m "initial commit") || die "Couldn\'t create initial file!"

# Apply failing patch set
print_patch | git am --binary -3 || die "Applying patch set to autocrlf=3D=
true repo failed!"

--------------070108040806060703030000--

--------------enigE46C3DBCDA61183B6EB04898
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGzZSsKzzXl/njVP8RAvc/AJ9Nf3NdsqiwA1byPayvUdzij5rcfgCfW4qT
H+TitfLI1vpwOTnvTOAdTxU=
=AdGH
-----END PGP SIGNATURE-----

--------------enigE46C3DBCDA61183B6EB04898--
