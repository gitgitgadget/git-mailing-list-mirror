From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] Test grep --and/--or/--not
Date: Sat, 27 Jun 2009 20:47:44 +0200
Message-ID: <00cb3d5121573fd1208bd297ab13ee4be966e915.1246128025.git.trast@student.ethz.ch>
References: <dac606a8ee9b87339d1cf4b1bff23cea3c1b1c23.1246128025.git.trast@student.ethz.ch>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 20:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKcx0-0007YR-Ol
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 20:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbZF0Srs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 14:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752346AbZF0Srs
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 14:47:48 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:26216 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbZF0Srq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 14:47:46 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 20:47:47 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 27 Jun 2009 20:47:46 +0200
X-Mailer: git-send-email 1.6.3.3.437.ge636e
In-Reply-To: <dac606a8ee9b87339d1cf4b1bff23cea3c1b1c23.1246128025.git.trast@student.ethz.ch>
X-OriginalArrivalTime: 27 Jun 2009 18:47:46.0937 (UTC) FILETIME=[C3682E90:01C9F757]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122382>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t7002-grep.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index f275af8..7868af8 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -125,6 +125,36 @@ do
 
 done
 
+cat >expected <<EOF
+file:foo mmap bar_mmap
+EOF
+
+test_expect_success 'grep -e A --and -e B' '
+	git grep -e "foo mmap" --and -e bar_mmap >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file:foo_mmap bar mmap
+file:foo_mmap bar mmap baz
+EOF
+
+
+test_expect_success 'grep ( -e A --or -e B ) --and -e B' '
+	git grep \( -e foo_ --or -e baz \) \
+		--and -e " mmap" >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+file:foo mmap bar
+EOF
+
+test_expect_success 'grep -e A --and --not -e B' '
+	git grep -e "foo mmap" --and --not -e bar_mmap >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'log grep setup' '
 	echo a >>file &&
 	test_tick &&
-- 
1.6.3.3.423.ga0175
