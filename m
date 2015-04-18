From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] t1509: update prepare script to be able to run t1509 in chroot again
Date: Sat, 18 Apr 2015 18:22:53 +0700
Message-ID: <1429356173-5161-1-git-send-email-pclouds@gmail.com>
References: <xmqqr3rqa131.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 13:23:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjQq1-0006xT-V0
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 13:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbDRLW7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2015 07:22:59 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32814 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbbDRLW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 07:22:58 -0400
Received: by paboj16 with SMTP id oj16so153314462pab.0
        for <git@vger.kernel.org>; Sat, 18 Apr 2015 04:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=smBWWtOPm7OxDqZ5Av/gMhTXzoQbl35Mp4d0iSAvxRg=;
        b=CoNAJ3CCwTkZduO1tUEjdWD8Pd+xn/7ZZdfkpbMnOxSuaXrpA/vPwAwmaDseW/JLYE
         T4NvyW1Ms1boMllT/qi98Z99ymAvnt9eBUjdbpXMDg/bpmavSHdBJiLjOBFdVOZJ5Cyn
         0kkqOlR+QLt9OEoLjoc0zEIimuTbEi4PLdmaGEyEcnt9+6RfHPB2+WcQwvyVned18Nmd
         YRKlTKmQB8UG2WFEvpTPloDVBK43KpufQI3E+yhYYUCN6/rlzqJrbJGNJDY2Xn1Ck5jZ
         1RN8wmmJXMCvZvVrAtU33P9Q2i3SzYv2eKcmy8LHxZbuZ/dFKIRB4Z9uSW8AGIVJIBHP
         Mjcg==
X-Received: by 10.66.156.198 with SMTP id wg6mr894543pab.126.1429356178204;
        Sat, 18 Apr 2015 04:22:58 -0700 (PDT)
Received: from lanh ([115.73.194.246])
        by mx.google.com with ESMTPSA id sl9sm12773892pac.41.2015.04.18.04.22.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Apr 2015 04:22:57 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 18 Apr 2015 18:22:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqqr3rqa131.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267417>

Tested on Gentoo and OpenSUSE 13.1, both x86-64

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Apr 12, 2015 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > Duy Nguyen <pclouds@gmail.com> writes:
 >
 >> On Fri, Apr 3, 2015 at 7:01 PM, Jeff King <peff@peff.net> wrote:
 >>> Aside from the nits above, I did get it to run t1509 with this. I =
can't
 >>> say I'm incredibly excited about the whole thing, if only because =
it is
 >>> clear that nobody is going to run it regularly (so regressions wil=
l
 >>> likely go unnoticed, which is the whole point of the test script).=
 =C2=A0But
 >>> perhaps it is better than nothing, and it is not hurting anyone to=
 sit
 >>> there and bitrot again. ;)
 >>
 >> To be honest, I didn't run it often in the last 5 years. The code i=
t
 >> protects seems not broken during this time and probably so for a
 >> foreseeable future. So I don't mind if you just kill t1509 and rela=
ted
 >> scripts.
 >
 > Yeah, but as long as you two worked out to make it run again on at
 > least two systems (i.e. yours), it would be good not to let that
 > effort go to waste. Care to throw a v2 at me with $(id -u) and other
 > changes Peff mentioned?

 thrown (a little bit late because $DAYJOB consumed much of my energy)

 t/t1509/prepare-chroot.sh | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/t/t1509/prepare-chroot.sh b/t/t1509/prepare-chroot.sh
index 6269117..6d47e2c 100755
--- a/t/t1509/prepare-chroot.sh
+++ b/t/t1509/prepare-chroot.sh
@@ -14,25 +14,45 @@ xmkdir() {
=20
 R=3D"$1"
=20
+[ "$(id -u)" -eq 0 ] && die "This script should not be run as root, wh=
at if it does rm -rf /?"
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
+sed 's|^PERL_PATH=3D.*|PERL_PATH=3D/bin/true|' GIT-BUILD-OPTIONS > "$R=
$(pwd)/GIT-BUILD-OPTIONS"
+for cmd in git $BB;do=20
+	ldd $cmd | grep '/' | sed 's,.*\s\(/[^ ]*\).*,\1,' | while read i; do
+		mkdir -p "$R$(dirname $i)"
+		cp "$i" "$R/$i"
+	done
 done
-echo "Execute this in root: 'chroot $R /bin/su - $(id -nu)'"
+cat <<EOF
+All is set up in $R, execute t1509 with the following commands:
+
+sudo chroot $R /bin/su - $(id -nu)
+IKNOWWHATIAMDOING=3DYES ./t1509-root-worktree.sh -v -i
+
+When you are done, simply delete $R to clean up
+EOF
--=20
2.3.0.rc1.137.g477eb31
