From: Josef Kufner <josef@kufner.cz>
Subject: [PATCH] Add tests for "Pass graph width to pretty formatting, so '%>|' can work properly"
Date: Fri, 11 Sep 2015 19:50:45 +0200
Message-ID: <1441993845-25778-1-git-send-email-josef@kufner.cz>
References: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
Cc: Josef Kufner <josef@kufner.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 19:51:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaSTW-0008Ci-54
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 19:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbIKRu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 13:50:57 -0400
Received: from ip-94-112-209-113.net.upcbroadband.cz ([94.112.209.113]:44670
	"EHLO delfinek.frozen-doe.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751514AbbIKRu4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 13:50:56 -0400
Received: by delfinek.frozen-doe.net (Postfix, from userid 1000)
	id CE302C53B39; Fri, 11 Sep 2015 19:50:53 +0200 (CEST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277685>

---
 t/t4205-log-pretty-formats.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 7398605..3358837 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -319,6 +319,18 @@ EOF
 	test_cmp expected actual
 '
 
+# Note: Space between 'message' and 'two' should be in the same column as in previous test.
+test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
+	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
+	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+* $head1                    message two
+* $head2                    message one
+* $head3                        add bar
+* $head4            $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF >expected &&
@@ -330,6 +342,17 @@ EOF
 	test_cmp expected actual
 '
 
+test_expect_success 'right alignment formatting with no padding and with --graph' '
+	git log --graph --pretty="tformat:%>(1)%s" >actual &&
+	cat <<EOF >expected &&
+* message two
+* message one
+* add bar
+* $(commit_msg)
+EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'right alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
-- 
2.5.1
