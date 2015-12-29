From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/20] t5500: test for shallow depth excluding a ref
Date: Tue, 29 Dec 2015 19:10:42 +0700
Message-ID: <1451391043-28093-20-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8z-0007RM-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbbL2MMr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:47 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35201 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbL2MMp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:45 -0500
Received: by mail-pa0-f44.google.com with SMTP id do7so4720029pab.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FTPk+FIahG5cEttK4SSwnI90Bc9hIqwxjSInzV+QIIo=;
        b=mfq7SfacRchGZh6J3CcVXjpPAe0Klj8QI0HkZGnUxNkOL5LBgJd+JfvJwY+logPyAa
         k9VGrSaisHCGookVVBW6qJZxM/jCCpIlAfoGgS4WT1w1CcbS4K+ssxS7ZTtew68DD0ll
         KRb/F/0rTiRqSM0eEE3ZtEdWvuXdyw8AnCeC/HxXsL8A9u3zaJPpiXgxa7XT900InSvv
         NpVfGUVAurqbB9g2/+UeC9cy+T7MCSQabxipmSQ3VE2TcoT057c8MvOLJsjqUtk+sVnu
         GplrnHYDtQFiTzajOsgiQLeSmVTuLYbqJd/j+8cCQOh7MypMRJ32L2zt9ZP3FC4DbWv9
         /c9w==
X-Received: by 10.66.102.97 with SMTP id fn1mr86482325pab.131.1451391165208;
        Tue, 29 Dec 2015 04:12:45 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id r90sm83020820pfi.80.2015.12.29.04.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:44 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:40 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283129>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 338b46e..2259631 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -655,4 +655,22 @@ test_expect_success 'fetch shallow since ...' '
 	test_cmp expected actual
 '
=20
+test_repo_expect_success 'shallow clone exclude tag two' '
+	test_commit one &&
+	test_commit two &&
+	test_commit three &&
+	git clone --not two "file://$(pwd)/." ../shallow12 &&
+	git -C ../shallow12 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch exclude tag one' '
+	git -C shallow12 fetch --not one origin &&
+	git -C shallow12 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
