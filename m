From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 10/13] git-svn: add UTF-8 message test
Date: Tue, 13 Jun 2006 11:02:12 -0700
Message-ID: <11502217493878-git-send-email-normalperson@yhbt.net>
References: <11502217352245-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jun 13 20:03:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqDE4-0004t6-Fo
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 20:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWFMSCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 14:02:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWFMSCc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 14:02:32 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51653 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932096AbWFMSCa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 14:02:30 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 4418D7DC021;
	Tue, 13 Jun 2006 11:02:29 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 13 Jun 2006 11:02:29 -0700
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11502217352245-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21795>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/t/t0000-contrib-git-svn.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/git-svn/t/t0000-contrib-git-svn.sh b/contrib/git-s=
vn/t/t0000-contrib-git-svn.sh
index a07fbad..0c6ff20 100644
--- a/contrib/git-svn/t/t0000-contrib-git-svn.sh
+++ b/contrib/git-svn/t/t0000-contrib-git-svn.sh
@@ -4,6 +4,7 @@ # Copyright (c) 2006 Eric Wong
 #
=20
 test_description=3D'git-svn tests'
+GIT_SVN_LC_ALL=3D$LC_ALL
 . ./lib-git-svn.sh
=20
 mkdir import
@@ -163,6 +164,18 @@ test_expect_success "$name" \
      diff -u help $SVN_TREE/exec-2.sh"
=20
=20
+if test -n "$GIT_SVN_LC_ALL" && echo $GIT_SVN_LC_ALL | grep -q '\.UTF-=
8$'
+then
+	name=3D"commit with UTF-8 message: locale: $GIT_SVN_LC_ALL"
+	echo '# hello' >> exec-2.sh
+	git update-index exec-2.sh
+	git commit -m '=C3=A9=C3=AF=E2=88=8F'
+	export LC_ALL=3D"$GIT_SVN_LC_ALL"
+	test_expect_success "$name" "git-svn commit HEAD"
+	unset LC_ALL
+else
+	echo "UTF-8 locale not set, test skipped ($GIT_SVN_LC_ALL)"
+fi
=20
 name=3D'test fetch functionality (svn =3D> git) with alternate GIT_SVN=
_ID'
 GIT_SVN_ID=3Dalt
--=20
1.4.0
