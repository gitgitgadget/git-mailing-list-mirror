From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] t1509: update prepare script to be able to run t1509 in chroot again
Date: Fri,  3 Apr 2015 17:08:57 +0700
Message-ID: <1428055737-8943-1-git-send-email-pclouds@gmail.com>
References: <20150331191420.GE22844@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 12:09:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdyXH-0006Wp-7t
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 12:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbbDCKJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Apr 2015 06:09:03 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33509 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbDCKJA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 06:09:00 -0400
Received: by paboj16 with SMTP id oj16so31077850pab.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 03:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mWqAm9QIfzYqFmu+FmW1sjNWz1PqnO965feMxm4MIjk=;
        b=SMmhK/dtZ6EkJIkCZLv634sQdeNj39lKpSmErymOICZKgIDtobewmpjbMGj3yU7HwW
         I7e7ToNPtsAUrwEGhO6rrYS42r1ffsaX8tSsoA+VycSvkIoaXfeQpOhFlx6QOM8apVZH
         4V6IRSe21ZiJCDJzJ7qmjp6RAUpnppEul9arkWaRaVR8zTKmkB8F0csHC0xiuIrWAScD
         0+9iXeZn4KKjGuNDg6El5KS+FmFMi8dNXu/YtKR6mHg8Cnph/DilJBzeR5QUAVg2hkZX
         ZR3nZ3a1VbMmWrZhdJGfQnAg4wj8AuLx6B2OZI+A23/2cXq59qwkUC6XH9on9NRs4ntq
         S0Ww==
X-Received: by 10.70.35.193 with SMTP id k1mr3125674pdj.46.1428055740454;
        Fri, 03 Apr 2015 03:09:00 -0700 (PDT)
Received: from lanh ([115.73.233.16])
        by mx.google.com with ESMTPSA id fr13sm7649568pdb.55.2015.04.03.03.08.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 03:08:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 03 Apr 2015 17:09:02 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <20150331191420.GE22844@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266702>

Tested on Gentoo and OpenSUSE 13.1, both x86-64

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Wed, Apr 1, 2015 at 2:14 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
 > Jeff King wrote:
 >
 >> No tests, as we would need to be able to write to "/" to do
 >> so.
 >
 > t1509-root-worktree.sh is supposed to test the repository-at-/ case.
 > But I wouldn't be surprised if it's bitrotted, since people don't se=
t
 > up a throwaway chroot or VM for tests too often.

 Can't leave it rotting. Either fix it or kill it. This is the first
 option. Good news is the test passes, nothing else is broken. Bad
 news is it does not detect the core.worktree breakage, but this on
 top would verify that Jeff's patch works

  diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
  index b6977d4..17ff4ce 100755
  --- a/t/t1509-root-worktree.sh
  +++ b/t/t1509-root-worktree.sh
  @@ -224,6 +224,10 @@ test_expect_success 'setup' '
   	test_cmp expected result
   '
  =20
  +test_expect_success 'no core.worktree after git init' '
  +	test "`git config core.worktree`" =3D ""
  +'
  +
   test_vars 'auto gitdir, root' ".git" "/" ""
   test_foobar_root
=20


 t/t1509/prepare-chroot.sh | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
index 6269117..c61afbf 100755
--- a/t/t1509/prepare-chroot.sh
+++ b/t/t1509/prepare-chroot.sh
@@ -14,25 +14,42 @@ xmkdir() {
=20
 R=3D"$1"
=20
+[ "$UID" -eq 0 ] && die "This script should not be run as root, what i=
f it does rm -rf /?"
 [ -n "$R" ] || die "usage: prepare-chroot.sh <root>"
 [ -x git ] || die "This script needs to be executed at git source code=
's top directory"
-[ -x /bin/busybox ] || die "You need busybox"
+if [ -x /bin/busybox ]; then
+	BB=3D/bin/busybox
+elif [ -x /usr/bin/busybox ]; then
+	BB=3D/usr/bin/busybox
+else
+	die "You need busybox"
+fi
=20
 xmkdir "$R" "$R/bin" "$R/etc" "$R/lib" "$R/dev"
-[ -c "$R/dev/null" ] || die "/dev/null is missing. Do mknod $R/dev/nul=
l c 1 3 && chmod 666 $R/dev/null"
+touch "$R/dev/null"
 echo "root:x:0:0:root:/:/bin/sh" > "$R/etc/passwd"
 echo "$(id -nu):x:$(id -u):$(id -g)::$(pwd)/t:/bin/sh" >> "$R/etc/pass=
wd"
 echo "root::0:root" > "$R/etc/group"
 echo "$(id -ng)::$(id -g):$(id -nu)" >> "$R/etc/group"
=20
-[ -x "$R/bin/busybox" ] || cp /bin/busybox "$R/bin/busybox"
-[ -x "$R/bin/sh" ] || ln -s /bin/busybox "$R/bin/sh"
-[ -x "$R/bin/su" ] || ln -s /bin/busybox "$R/bin/su"
+[ -x "$R$BB" ] || cp $BB "$R/bin/busybox"
+for cmd in sh su ls expr tr basename rm mkdir mv id uname dirname cat =
true sed diff; do
+	ln -f -s /bin/busybox "$R/bin/$cmd"
+done
=20
 mkdir -p "$R$(pwd)"
 rsync --exclude-from t/t1509/excludes -Ha . "$R$(pwd)"
-ldd git | grep '/' | sed 's,.*\s\(/[^ ]*\).*,\1,' | while read i; do
-	mkdir -p "$R$(dirname $i)"
-	cp "$i" "$R/$i"
+# Fake perl to reduce dependency, t1509 does not use perl, but some
+# env might slip through, see test-lib.sh, unset.*PERL_PATH
+sed 's|^PERL_PATH=3D*|PERL_PATH=3D/bin/true|' GIT-BUILD-OPTIONS > "$R$=
(pwd)/GIT-BUILD-OPTIONS"
+for cmd in git $BB;do=20
+	ldd $cmd | grep '/' | sed 's,.*\s\(/[^ ]*\).*,\1,' | while read i; do
+		mkdir -p "$R$(dirname $i)"
+		cp "$i" "$R/$i"
+	done
 done
-echo "Execute this in root: 'chroot $R /bin/su - $(id -nu)'"
+cat <<EOF
+Execute this in root:
+chroot $R /bin/su - $(id -nu)
+IKNOWWHATIAMDOING=3DYES ./t1509-root-worktree.sh -v -i
+EOF
--=20
2.3.0.rc1.137.g477eb31
