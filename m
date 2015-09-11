From: Josef Kufner <josef@kufner.cz>
Subject: [PATCH 3/3] t4205: remove unnecessary use of qz_to_tab_space
Date: Sat, 12 Sep 2015 01:25:13 +0200
Message-ID: <1442013913-2970-3-git-send-email-josef@kufner.cz>
References: <xmqqk2rwzlhi.fsf@gitster.mtv.corp.google.com>
 <1442013913-2970-1-git-send-email-josef@kufner.cz>
Cc: git@vger.kernel.org, josef@kufner.cz, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Sep 12 01:25:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaXhL-0007ZK-7I
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 01:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393AbbIKXZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 19:25:29 -0400
Received: from ip-94-112-209-113.net.upcbroadband.cz ([94.112.209.113]:41418
	"EHLO delfinek.frozen-doe.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753400AbbIKXZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Sep 2015 19:25:28 -0400
Received: by delfinek.frozen-doe.net (Postfix, from userid 1000)
	id 58CD8C50231; Sat, 12 Sep 2015 01:25:26 +0200 (CEST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442013913-2970-1-git-send-email-josef@kufner.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277709>

Many existing tests in this script pipes the result thru
qz_to_tab_space, but the payload does not need any Q or Z to be replaced
to tab or space. Redirect the input directly into iconv or use cat
instead.

Signed-off-by: Josef Kufner <josef@kufner.cz>
---
 t/t4205-log-pretty-formats.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 3358837..1f191cf 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -299,7 +299,7 @@ EOF
 
 test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %>|(40)%s" >actual &&
-	qz_to_tab_space <<EOF >expected &&
+	cat <<EOF >expected &&
 $head1                      message two
 $head2                      message one
 $head3                          add bar
@@ -310,7 +310,7 @@ EOF
 
 test_expect_success 'right alignment formatting at the nth column. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%h %>|(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	iconv -f utf-8 -t $test_encoding <<EOF >expected &&
 $head1                      message two
 $head2                      message one
 $head3                          add bar
@@ -322,7 +322,7 @@ EOF
 # Note: Space between 'message' and 'two' should be in the same column as in previous test.
 test_expect_success 'right alignment formatting at the nth column with --graph. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --graph --pretty="tformat:%h %>|(40)%s" >actual &&
-	qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	iconv -f utf-8 -t $test_encoding <<EOF >expected &&
 * $head1                    message two
 * $head2                    message one
 * $head3                        add bar
@@ -423,7 +423,7 @@ EOF
 old_head1=$(git rev-parse --verify HEAD~0)
 test_expect_success 'center alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%><(1)%s" >actual &&
-	cat <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
+	iconv -f utf-8 -t $test_encoding <<EOF >expected &&
 message two
 message one
 add bar
-- 
2.5.1
