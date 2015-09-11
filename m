From: Josef Kufner <josef@kufner.cz>
Subject: [PATCH 2/3] Add tests for "pretty: Pass graph width to pretty formatting for use in '%>|(N)'"
Date: Sat, 12 Sep 2015 01:25:12 +0200
Message-ID: <1442013913-2970-2-git-send-email-josef@kufner.cz>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
 <1442013913-2970-1-git-send-email-josef@kufner.cz>
Cc: git@vger.kernel.org, josef@kufner.cz, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 01:25:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXhG-0007Py-C2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbbIKXZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:25:30 -0400
Received: from ip-94-112-209-113.net.upcbroadband.cz ([94.112.209.113]:41420
	"EHLO delfinek.frozen-doe.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754151AbbIKXZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 19:25:29 -0400
Received: by delfinek.frozen-doe.net (Postfix, from userid 1000)
	id 5BE94C53B3D; Sat, 12 Sep 2015 01:25:26 +0200 (CEST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442013913-2970-1-git-send-email-josef@kufner.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277708>

Signed-off-by: Josef Kufner <josef@kufner.cz>
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
