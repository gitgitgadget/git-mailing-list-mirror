From: "=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?=" 
	<felipeg.assis@gmail.com>
Subject: [PATCH v5 1/3] merge-recursive: test rename threshold option
Date: Sat, 20 Feb 2016 23:34:30 -0300
Message-ID: <1456022072-5342-2-git-send-email-felipegassis@gmail.com>
References: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, gitster@pobox.com,
	sunshine@sunshineco.com,
	=?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= 
	<felipegassis@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 21 03:36:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXJtH-0007X9-Cx
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 03:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbcBUCgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Feb 2016 21:36:49 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34398 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcBUCgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 21:36:10 -0500
Received: by mail-qg0-f43.google.com with SMTP id b67so89774538qgb.1
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CwwKngJN3a/0u3QCXIMSRPo6HjJFhZLNfTd0CGal5/0=;
        b=fnoccpvniinhK8pfdZgKUydyiuq7wP1aQbxZ+ncLCxwb1h9z2WEx3+sYmhyzudYoqR
         /AFuu+wRmdSMfCZAgzwtxGjWLVTx1cY8Qa67Bpp9Yvv68KY9/aQJVQ0Vd9IwtaxY0oAD
         uNgwndVaVUeUxinexdBGtihtEm6vwWGKxRw8FNWQLFwPw2E+BA54HGtFEfUbeNKz44kv
         FDuD+eTB5S35g+WyiFl/cbG/RYsY6MZp9w33C6ivrrXngz0I8y6BWTEMqccnarD/2BLT
         +8Faf3NQ5JWoAP8eQKKtlr/ub1Jhq7v22eITqE6ZtbSgPjofWwaHwn5BGo5n8Bt6i+Yc
         1AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=CwwKngJN3a/0u3QCXIMSRPo6HjJFhZLNfTd0CGal5/0=;
        b=EbXv3xBho+lR2X8eiyOywJQLAlEyi8Edu8UoHUajwYg+EGLRgGgxOmWk5DzHAuq2Ap
         emrGXJ+alKc4ksTJokqE8zmhomQA82TSLcuj+n14URCdKE4J4eXIWar5JyJPxJ9wAaNE
         3DHli+RFseu3gjmU6W3COhVjSIT78ed3z7dxv+KPH2ellU9tu8TVqb6g8jURSvFkxWCV
         W5jt8RVVBVa5B4mi5qyG6CAaXBrOw46X4fGMIQey8BxaW5P1J4geiHkLlKDmxnZvsvaD
         sX9kk5KO9YiHrhvrncbpmrhqVocOzrgiGizVrLHiy5IkEZ436GCYm51zUCJjc4MyeAtn
         iXcw==
X-Gm-Message-State: AG10YOQ7XDMj76OsG2VeMunsBmKRVx8Y1Y0jS4LuDC3X5hGJy+IhsjgelQhKJZ1/znHahA==
X-Received: by 10.140.38.47 with SMTP id s44mr25785079qgs.22.1456022170272;
        Sat, 20 Feb 2016 18:36:10 -0800 (PST)
Received: from traveller.moon ([177.94.146.172])
        by smtp.gmail.com with ESMTPSA id 188sm7618067qhi.1.2016.02.20.18.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Feb 2016 18:36:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?q?Felipe=20Gon=C3=A7alves=20Assis?= <felipegassis@gmail.com>
X-Mailer: git-send-email 2.7.1.342.gf5bb636
In-Reply-To: <1456022072-5342-1-git-send-email-felipegassis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286796>

Commit 10ae7526bebb505ddddba01f76ec97d5f7b5e0e5 introduced this feature=
,
but did not include any tests. This commit fixes this.

Signed-off-by: Felipe Gon=C3=A7alves Assis <felipegassis@gmail.com>
---

This commit is independent of the proposed feature, so it might be of i=
nterest
even if the rest of the patch is rejected.

 t/t3034-merge-recursive-rename-threshold.sh | 146 ++++++++++++++++++++=
++++++++
 1 file changed, 146 insertions(+)
 create mode 100755 t/t3034-merge-recursive-rename-threshold.sh

diff --git a/t/t3034-merge-recursive-rename-threshold.sh b/t/t3034-merg=
e-recursive-rename-threshold.sh
new file mode 100755
index 0000000..f0b3f44
--- /dev/null
+++ b/t/t3034-merge-recursive-rename-threshold.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+
+test_description=3D'merge-recursive rename threshold option
+
+Test rename detection by examining rename/delete conflicts.
+
+Similarity index:
+R100 a-old a-new
+R075 b-old b-new
+R050 c-old c-new
+R025 d-old d-new
+'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	get_expected_stages () {
+		git checkout rename -- $1-new &&
+		git ls-files --stage $1-new > expected-stages-undetected-$1
+		sed "s/ 0	/ 2	/
+		" < expected-stages-undetected-$1 > expected-stages-detected-$1
+		git read-tree -u --reset HEAD
+	} &&
+
+	rename_detected () {
+		git ls-files --stage $1-old $1-new > stages-actual-$1 &&
+		test_cmp expected-stages-detected-$1 stages-actual-$1
+	} &&
+
+	rename_undetected () {
+		git ls-files --stage $1-old $1-new > stages-actual-$1 &&
+		test_cmp expected-stages-undetected-$1 stages-actual-$1
+	} &&
+
+	check_common () {
+		git ls-files --stage > stages-actual &&
+		test $(wc -l < stages-actual) -eq 4
+	} &&
+
+	check_find_renames_25 () {
+		check_common &&
+		rename_detected a &&
+		rename_detected b &&
+		rename_detected c &&
+		rename_detected d
+	} &&
+
+	check_find_renames_50 () {
+		check_common
+		rename_detected a &&
+		rename_detected b &&
+		rename_detected c &&
+		rename_undetected d
+	} &&
+
+	check_find_renames_75 () {
+		check_common
+		rename_detected a &&
+		rename_detected b &&
+		rename_undetected c &&
+		rename_undetected d
+	} &&
+
+	check_find_renames_100 () {
+		check_common
+		rename_detected a &&
+		rename_undetected b &&
+		rename_undetected c &&
+		rename_undetected d
+	} &&
+
+	check_no_renames () {
+		check_common
+		rename_undetected a &&
+		rename_undetected b &&
+		rename_undetected c &&
+		rename_undetected d
+	} &&
+
+	cat <<-\EOF > a-old &&
+	aa1
+	aa2
+	aa3
+	aa4
+	EOF
+	sed s/aa/bb/ < a-old > b-old &&
+	sed s/aa/cc/ < a-old > c-old &&
+	sed s/aa/dd/ < a-old > d-old &&
+	git add [a-d]-old &&
+	test_tick &&
+	git commit -m base &&
+	git rm [a-d]-old &&
+	test_tick &&
+	git commit -m delete &&
+	git checkout -b rename HEAD^ &&
+	cp a-old a-new &&
+	sed 1,1s/./x/ < b-old > b-new &&
+	sed 1,2s/./x/ < c-old > c-new &&
+	sed 1,3s/./x/ < d-old > d-new &&
+	git add [a-d]-new &&
+	git rm [a-d]-old &&
+	test_tick &&
+	git commit -m rename &&
+	get_expected_stages a &&
+	get_expected_stages b &&
+	get_expected_stages c &&
+	get_expected_stages d
+'
+
+test_expect_success 'the default similarity index is 50%' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive HEAD^ -- HEAD master &&
+	check_find_renames_50
+'
+
+test_expect_success 'low rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 HEAD^ -- H=
EAD master &&
+	check_find_renames_25
+'
+
+test_expect_success 'high rename threshold' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D75 HEAD^ -- H=
EAD master &&
+	check_find_renames_75
+'
+
+test_expect_success 'exact renames only' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D100% HEAD^ --=
 HEAD master &&
+	check_find_renames_100
+'
+
+test_expect_success 'rename threshold is truncated' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D200% HEAD^ --=
 HEAD master &&
+	check_find_renames_100
+'
+
+test_expect_success 'last wins in --rename-threshold=3D<m> --rename-th=
reshold=3D<n>' '
+	git read-tree --reset -u HEAD &&
+	test_must_fail git merge-recursive --rename-threshold=3D25 --rename-t=
hreshold=3D75 HEAD^ -- HEAD master &&
+	check_find_renames_75
+'
+
+test_done
--=20
2.7.1.342.gf5bb636
