From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/7] ls-files -h: show usage even with corrupt index
Date: Fri, 22 Oct 2010 01:48:14 -0500
Message-ID: <20101022064814.GF6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:52:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BTz-00043E-2I
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab0JVGwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:52:01 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42239 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0JVGwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:52:00 -0400
Received: by yxn35 with SMTP id 35so361327yxn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=REBzV9gbvrA/7yaUtAsWwU2VABzGMWhAvmDrVwpOL78=;
        b=PIadx7hCqY0k1LY0qcjN+Bb1odXfsM9Lpd+6u+HgPyyknyg8IRQ8g/9gVD+8fjhWgZ
         BFYVRgcuFKqqMaRQjrtSjNGNLawQBWL1NP/sH7mIlTMlZkbPYTYji1RJkMc5+FGmcGeN
         utOH8Iu8IAyLSLWM/5FmL+Zh4It9jWTlX435A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=H91kGH6jWFuC75//8Ag3+F5N9YWgxcDVOa1R/T0Hg6E+IVUGDZ4O8HCOEhClf/7+9W
         xKth4Pv+AIQZaHLuEgTtyhGoYC2gOzrdBpfGObPY4bL06rbGUxesNi1bAhu2iitYn2qP
         rmyXQzrEMf/0Vl8JX7Vh/8pAmGDT+8hywl0r8=
Received: by 10.90.89.3 with SMTP id m3mr2026024agb.76.1287730320148;
        Thu, 21 Oct 2010 23:52:00 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id n28sm2099289yha.16.2010.10.21.23.51.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:51:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159655>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Part of a campaign to avoid git <command> -h being distracted by
access to the repository.  A caller hoping to use "git ls-files"
with an alternate index as part of a repair operation may well use
"git ls-files -h" to show usage while planning it out.

[jn: with rewritten log message and tests]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/ls-files.c        |    3 +++
 t/t3004-ls-files-basic.sh |   39 +++++++++++++++++++++++++++++++++++++=
++
 2 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100755 t/t3004-ls-files-basic.sh

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..87f0b8a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -530,6 +530,9 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		OPT_END()
 	};
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(ls_files_usage, builtin_ls_files_options);
+
 	memset(&dir, 0, sizeof(dir));
 	prefix =3D cmd_prefix;
 	if (prefix)
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
new file mode 100755
index 0000000..490e052
--- /dev/null
+++ b/t/t3004-ls-files-basic.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description=3D'basic ls-files tests
+
+This test runs git ls-files with various unusual or malformed
+command-line arguments.
+'
+
+. ./test-lib.sh
+
+>empty
+
+test_expect_success 'ls-files in empty repository' '
+	git ls-files >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'ls-files with nonexistent path' '
+	git ls-files doesnotexist >actual &&
+	test_cmp empty actual
+'
+
+test_expect_success 'ls-files with nonsense option' '
+	test_expect_code 129 git ls-files --nonsense 2>actual &&
+	grep "[Uu]sage: git ls-files" actual
+'
+
+test_expect_success 'ls-files -h in corrupt repository' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		>.git/index &&
+		test_expect_code 129 git ls-files -h >usage 2>&1
+	) &&
+	grep "[Uu]sage: git ls-files " broken/usage
+'
+
+test_done
--=20
1.7.2.3
