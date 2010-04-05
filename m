From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 41/43] t0001: Add test cases for "git init" with aliases
Date: Mon,  5 Apr 2010 20:41:26 +0200
Message-ID: <1270492888-26589-42-git-send-email-pclouds@gmail.com>
References: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 20:44:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyrI5-0003NW-S3
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 20:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153Ab0DESoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Apr 2010 14:44:11 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44752 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145Ab0DESoF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 14:44:05 -0400
Received: by mail-fx0-f227.google.com with SMTP id 27so1251549fxm.28
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 11:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=FLIhTAZu4meZytTAuTFnxS05D7aOLpm+nwwPpW+zxOA=;
        b=N3pmKNo1RIwxrpGH8Xafod1wMPqhpLKGJiU55s6HicjgfKJOlRutw5wSR/W/QbosvK
         M8MXCKEyR0dTcjAhpsw2tDOVMp/xqjy7SZ1EcL2wp3atZdgoZ1A7sE72oHGKFxZHgh9a
         LmeG0mjpD/i9zTKzYzyNUyIIfeim8dsYsCOqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HI/ZVtFuPHzgdnKt1qKfdr9ZYZTWVqy+2I/g961LSxymf3aJLE9tsXKjlu5I5cNr4B
         wU2e3kEFJcnBE+oNutGX20Q3FfQEx2c+subdV6XZU9FXC099ksEXPbH1uRZIRHP1s+9v
         h0k6mpMVvVR3mwYwcmi4NUmnWXW5966bY99Vo=
Received: by 10.223.17.216 with SMTP id t24mr2338131faa.90.1270493045053;
        Mon, 05 Apr 2010 11:44:05 -0700 (PDT)
Received: from dektop ([212.247.124.209])
        by mx.google.com with ESMTPS id b17sm49573fka.43.2010.04.05.11.44.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 11:44:04 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon,  5 Apr 2010 20:44:02 +0200
X-Mailer: git-send-email 1.7.0.rc1.541.g2da82.dirty
In-Reply-To: <1270492888-26589-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144039>

=46rom: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t0001-init.sh |   52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6757734..dd66352 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -33,6 +33,58 @@ test_expect_success 'plain' '
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
+test_expect_success 'plain through aliased command' '
+	(
+		unset GIT_DIR GIT_WORK_TREE GIT_CONFIG_NOGLOBAL &&
+		HOME=3D$(pwd)/alias-config &&
+		export HOME &&
+		mkdir alias-config &&
+		echo "[alias] aliasedinit =3D init" >alias-config/.gitconfig &&
+		mkdir plain-aliased &&
+		cd plain-aliased &&
+		git aliasedinit
+	) &&
+	check_config plain-aliased/.git false unset
+'
+
+test_expect_success 'plain nested through aliased command' '
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
+test_expect_success 'plain nested in bare through aliased command' '
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
1.7.0.rc1.541.g2da82.dirty
