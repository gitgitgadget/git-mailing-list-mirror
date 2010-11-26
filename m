From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 45/47] t0001: test git init when run via an alias
Date: Fri, 26 Nov 2010 22:32:41 +0700
Message-ID: <1290785563-15339-46-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 17:02:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0kn-0002E4-L9
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 17:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507Ab0KZQCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 11:02:24 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:55459 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KZQCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 11:02:23 -0500
Received: by pzk26 with SMTP id 26so460285pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 08:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uWyKXd+uqztoSEUaD6i1T3A46j+TUFBS5oOzTNQw2/E=;
        b=KMmNKLN5JKh266dg8SlnHQ+hV+HxdXwyXun/HbNL+1Ys7XIznS90TM67caCSPF//Ly
         c2oLWdoyFMezW3CyEl9KREsymUd4nicSerwr2Sg3L/mXzIeptlGnEwU4PfPpD2PnGPZr
         PDX1Gb81QUNXY+d8dGjdDduoiQ2e6pi1IDkxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XVewU3iPucGhjk/0f6dfWhZU97/IXKohmEaZLm25hHp5TIaoxSCi2ybkaxSdt3dKwf
         EdwrIJ4pkA52sgyoGYpvgriaLTpaZ7t+DoXgvSeJedcdotMJtVwFHeoPI7F4Nc1bjsCs
         HbC0378Ey+KgZ5oEXF4X4eiZZ1BaXGOkZ6YT8=
Received: by 10.143.30.19 with SMTP id h19mr2512003wfj.310.1290786664079;
        Fri, 26 Nov 2010 07:51:04 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id w22sm2690442wfd.19.2010.11.26.07.50.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:51:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:49:52 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162257>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

Add some tests to document the correct behavior of (possibly aliased)
init when run within and outside a git directory.

If I set up a simple git alias =E2=80=9Cquietinit =3D init --quiet=E2=80=
=9D, usually it
will work just like =E2=80=98git init --quiet=E2=80=99.

There are some differences, unfortunately, since in the process of
checking for aliases, git has to look for a .git/config file.  If =E2=80=
=98git
quietinit=E2=80=99 is run from a subdirectory of an existing git reposi=
tory,
that repository=E2=80=99s configuration will affect the configuration o=
f the
new repository.  In particular, the new repository can inherit
bogus values for core.bare and core.worktree.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0001-init.sh |   56 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 7fe8883..28c1858 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,62 @@ test_expect_success 'plain' '
 	check_config plain/.git false unset
 '
=20
+test_expect_success 'plain nested in bare' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor.git &&
+		cd bare-ancestor.git &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git init
+	) &&
+	check_config bare-ancestor.git/plain-nested/.git false unset
+'
+
+test_expect_success 'plain through aliased command, outside any git re=
po' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		HOME=3D$(pwd)/alias-config &&
+		export HOME &&
+		mkdir alias-config &&
+		echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+
+		GIT_CEILING_DIRECTORIES=3D$(pwd) &&
+		export GIT_CEILING_DIRECTORIES &&
+
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
+test_expect_failure 'plain nested through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init plain-ancestor-aliased &&
+		cd plain-ancestor-aliased &&
+		echo "[alias] aliasedinit =3D init" >>.git/config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config plain-ancestor-aliased/plain-nested/.git false unset
+'
+
+test_expect_failure 'plain nested in bare through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE &&
+		git init --bare bare-ancestor-aliased.git &&
+		cd bare-ancestor-aliased.git &&
+		echo "[alias] aliasedinit =3D init" >>config &&
+		mkdir plain-nested &&
+		cd plain-nested &&
+		git aliasedinit
+	) &&
+	check_config bare-ancestor-aliased.git/plain-nested/.git false unset
+'
+
 test_expect_success 'plain with GIT_WORK_TREE' '
 	if (
 		unset GIT_DIR
--=20
1.7.3.2.316.gda8b3
