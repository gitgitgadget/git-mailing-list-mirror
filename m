From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 022/144] t1020-subdirectory.sh: use the $( ... ) construct for command substitution
Date: Tue, 25 Mar 2014 01:24:27 -0700
Message-ID: <1395735989-3396-23-git-send-email-gitter.spiros@gmail.com>
References: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 09:37:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSMrd-0002au-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 09:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974AbaCYIhc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 04:37:32 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:32978 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbaCYI1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 04:27:04 -0400
Received: by mail-pd0-f181.google.com with SMTP id p10so126547pdj.40
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rCk2iproMKdKqJoySvcdyQcZiTke5iodbcYsPXRlBBs=;
        b=W9nY4MMXrreDU5GZjNKMPUJHyIE/BnPa+7OoVDlhb6z+SVMfxH0iQ6wsaZtkeurck8
         eLSrJgzi7WB745lzealkZwJw0j5AGno2OxYFOwcyekp4T02P5WMSACEWbHfiB5RswLEu
         eC7Wlm8UDD2sXE0lG4rnrOkSiSTZUwoIbr3Fj1EVdswkPzNvD45/ycjb7Y7ureFT4mbz
         AGFMRcEtjtITmilfpaGuvCfNuunrmNXhET/miY+yKtASETXHhVi/ecEN2HI971ijrLr3
         psejQcK3MZsgdjoebE4JwGpDihcQsS/pIrwxyTk3kt76a0zI5eAfupl9/zqUTBRl//1R
         uk2Q==
X-Received: by 10.67.14.231 with SMTP id fj7mr76726486pad.115.1395736024016;
        Tue, 25 Mar 2014 01:27:04 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id pr4sm41327198pbb.53.2014.03.25.01.27.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Mar 2014 01:27:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1395735989-3396-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245008>

The Git CodingGuidelines prefer the $( ... ) construct for command
substitution instead of using the back-quotes, or grave accents (`..`).

The backquoted form is the historical method for command substitution,
and is supported by POSIX. However,all but the simplest uses become
complicated quickly. In particular,embedded command substitutions
and/or the use of double quotes require careful escaping with the backs=
lash
character. Because of this the POSIX shell adopted the $(=E2=80=A6) fea=
ture from
the Korn shell.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/t1020-subdirectory.sh |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 6902320..62c0d25 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -20,27 +20,27 @@ test_expect_success setup '
=20
 test_expect_success 'update-index and ls-files' '
 	git update-index --add one &&
-	case "`git ls-files`" in
+	case "$(git ls-files)" in
 	one) echo pass one ;;
 	*) echo bad one; exit 1 ;;
 	esac &&
 	(
 		cd dir &&
 		git update-index --add two &&
-		case "`git ls-files`" in
+		case "$(git ls-files)" in
 		two) echo pass two ;;
 		*) echo bad two; exit 1 ;;
 		esac
 	) &&
-	case "`git ls-files`" in
+	case "$(git ls-files)" in
 	dir/two"$LF"one) echo pass both ;;
 	*) echo bad; exit 1 ;;
 	esac
 '
=20
 test_expect_success 'cat-file' '
-	two=3D`git ls-files -s dir/two` &&
-	two=3D`expr "$two" : "[0-7]* \\([0-9a-f]*\\)"` &&
+	two=3D$(git ls-files -s dir/two) &&
+	two=3D$(expr "$two" : "[0-7]* \\([0-9a-f]*\\)") &&
 	echo "$two" &&
 	git cat-file -p "$two" >actual &&
 	cmp dir/two actual &&
@@ -55,18 +55,18 @@ rm -f actual dir/actual
 test_expect_success 'diff-files' '
 	echo a >>one &&
 	echo d >>dir/two &&
-	case "`git diff-files --name-only`" in
+	case "$(git diff-files --name-only)" in
 	dir/two"$LF"one) echo pass top ;;
 	*) echo bad top; exit 1 ;;
 	esac &&
 	# diff should not omit leading paths
 	(
 		cd dir &&
-		case "`git diff-files --name-only`" in
+		case "$(git diff-files --name-only)" in
 		dir/two"$LF"one) echo pass subdir ;;
 		*) echo bad subdir; exit 1 ;;
 		esac &&
-		case "`git diff-files --name-only .`" in
+		case "$(git diff-files --name-only .)" in
 		dir/two) echo pass subdir limited ;;
 		*) echo bad subdir limited; exit 1 ;;
 		esac
@@ -74,11 +74,11 @@ test_expect_success 'diff-files' '
 '
=20
 test_expect_success 'write-tree' '
-	top=3D`git write-tree` &&
+	top=3D$(git write-tree) &&
 	echo $top &&
 	(
 		cd dir &&
-		sub=3D`git write-tree` &&
+		sub=3D$(git write-tree) &&
 		echo $sub &&
 		test "z$top" =3D "z$sub"
 	)
@@ -96,7 +96,7 @@ test_expect_success 'checkout-index' '
=20
 test_expect_success 'read-tree' '
 	rm -f one dir/two &&
-	tree=3D`git write-tree` &&
+	tree=3D$(git write-tree) &&
 	read_tree_u_must_succeed --reset -u "$tree" &&
 	cmp one original.one &&
 	cmp dir/two original.two &&
--=20
1.7.10.4
