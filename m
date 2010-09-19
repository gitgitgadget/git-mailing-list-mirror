From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Add testcases showing how pathspecs are handled with rev-list --objects
Date: Mon, 20 Sep 2010 09:24:29 +1000
Message-ID: <1284938669-16753-3-git-send-email-pclouds@gmail.com>
References: <1284938669-16753-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 01:25:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxTFm-0008RK-HO
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 01:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab0ISXYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 19:24:52 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:64060 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0ISXYv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 19:24:51 -0400
Received: by pxi10 with SMTP id 10so1010992pxi.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 16:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zeHGsHbMom7JGv507tx/xi5zLMNXHc6nJ5Cz8VTd2HI=;
        b=s1LdYj8tUQn26DPD6gYb3iubRJiIKA+I8v8YPumXDdk6O6yUyIdvf4xeyyckrlZrv1
         nxNfN6+aZlAjBuYCQF/kxMQnBQKH7ZWk8kb+psOFI40C9NSNJZThkD3KcBpR6JmIEbLv
         3rN7pajuYhjKOp8YxGyIQu0mDMm4KCp67BqbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WPVeK4WE2fl+/o3n0dnOGhWtZ4o2uR15akKtry36/nWEB4swpcSnsziu/7Tw6e6z0u
         WtPh2Jxns9OJ+6Nry2G6vpjhs/yVGc+MIhj6qkujJvH4NHzpRZeDV4mF6qsNLhSOKow6
         dKNHGlPt5W10BPycsb+cWm81MPqvo2XCO2bEA=
Received: by 10.114.39.18 with SMTP id m18mr9041305wam.196.1284938690824;
        Sun, 19 Sep 2010 16:24:50 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id o17sm12270129wal.9.2010.09.19.16.24.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 16:24:49 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Mon, 20 Sep 2010 09:24:44 +1000
X-Mailer: git-send-email 1.7.1.rc1.70.g788ca
In-Reply-To: <1284938669-16753-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156530>

=46rom: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
new file mode 100755
index 0000000..b10685a
--- /dev/null
+++ b/t/t6000-rev-list-misc.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description=3D'miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo content1 >wanted_file &&
+	echo content2 >unwanted_file &&
+	git add wanted_file unwanted_file &&
+	git commit -m one
+'
+
+test_expect_success 'rev-list --objects heeds pathspecs' '
+	git rev-list --objects HEAD -- wanted_file >output &&
+	grep wanted_file output &&
+	! grep unwanted_file output
+'
+
+test_expect_success 'rev-list --objects with pathspecs and deeper path=
s' '
+	mkdir foo &&
+	>foo/file &&
+	git add foo/file &&
+	git commit -m two &&
+
+	git rev-list --objects HEAD -- foo >output &&
+	grep foo/file output &&
+
+	git rev-list --objects HEAD -- foo/file >output &&
+	grep foo/file output &&
+	! grep unwanted_file output
+'
+
+test_expect_success 'rev-list --objects with pathspecs and copied file=
s' '
+	git checkout --orphan junio-testcase &&
+	git rm -rf . &&
+
+	mkdir two &&
+	echo frotz >one &&
+	cp one two/three &&
+	git add one two/three &&
+	test_tick &&
+	git commit -m that &&
+
+	ONE=3D$(git rev-parse HEAD:one)
+	git rev-list --objects HEAD two >output &&
+	grep "$ONE two/three" output &&
+	! grep one output
+'
+
+test_done
--=20
1.7.1.rc1.70.g788ca
