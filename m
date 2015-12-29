From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/20] t5500: test for shallow depth since a specific date
Date: Tue, 29 Dec 2015 19:10:38 +0700
Message-ID: <1451391043-28093-16-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8d-000785-HZ
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbbL2MMY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:24 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34110 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbbL2MMX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:23 -0500
Received: by mail-pf0-f171.google.com with SMTP id e65so74288947pfe.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=D/KXYjRft7imHytlVhhGdeBMAWMM2YU3l8M0A4x+Pso=;
        b=H5+GspgS5nYrcmMp1ZPw7sEt5zIRNVUlv7im0+BArkgud45MTdOfZZzhed/+89/kST
         evSO/hwBL15ifNSe1z4j0GDr3FAuCx6lKeH/eC28netVIWHNSu7ZbhQpvHzG1lN9zrGp
         Z6Uxo6lR9Nt/lkQqTMLssOlTa8kAOgt+hhMCy3tvNF0zajZNCkxTZgz5fNZ9xspmC056
         hHVIOEcAca7yGYB4o2mYLQWbck+a46yUWSUA282B64THbukNoZ0z/XnqxkCHFafH3+Vf
         I/PpzdjPlB0YzVH7iVMgddrBsmUOhE9URjowX5601W223ZYKWkkva1jzdtkFxd3SN9OV
         3FIQ==
X-Received: by 10.98.16.139 with SMTP id 11mr29231994pfq.17.1451391142711;
        Tue, 29 Dec 2015 04:12:22 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id yn8sm87974395pac.32.2015.12.29.04.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:17 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283125>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5500-fetch-pack.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 3a9b775..338b46e 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -637,4 +637,22 @@ test_expect_success MINGW 'fetch-pack --diag-url c=
:repo' '
 	check_prot_path c:repo file c:repo
 '
=20
+test_repo_expect_success 'clone shallow since ...' '
+	GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-empty -m on=
e &&
+	GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-empty -m tw=
o &&
+	GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-empty -m th=
ree &&
+	git clone --since "300000000 +0700" "file://$(pwd)/." ../shallow11 &&
+	git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
+	echo three >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetch shallow since ...' '
+	git -C shallow11 fetch --since "200000000 +0700" origin &&
+	git -C shallow11 log --pretty=3Dtformat:%s origin/master >actual &&
+	echo three >expected &&
+	echo two  >>expected &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
