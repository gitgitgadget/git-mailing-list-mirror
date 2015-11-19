From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 3/7] modernize t9300: use test_must_be_empty
Date: Thu, 19 Nov 2015 20:09:45 +0100
Message-ID: <52bae1a41e445d308cbfea21dfd696bc16df3cbf.1447959452.git.j6t@kdbg.org>
References: <cover.1447959452.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 20:10:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzUbL-0006yO-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 20:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbbKSTK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 14:10:26 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:57946 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161150AbbKSTKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 14:10:22 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3p1rDs0qy0z5tlQ;
	Thu, 19 Nov 2015 20:10:21 +0100 (CET)
Received: from dx.site (localhost [127.0.0.1])
	by dx.site (Postfix) with ESMTP id B20CB29D8;
	Thu, 19 Nov 2015 20:10:20 +0100 (CET)
X-Mailer: git-send-email 2.6.2.337.ga235d84
In-Reply-To: <cover.1447959452.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281485>

Instead of comparing actual output to an empty file, use
test_must_be_empty. In addition to the better error message provided by
the helper, allocation of an empty file during the setup sequence can be
avoided.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t9300-fast-import.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e9c7602..ceb3db3 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -47,8 +47,6 @@ file5_data='an inline file.
 file6_data='#!/bin/sh
 echo "$@"'
 
->empty
-
 ###
 ### series A
 ###
@@ -2320,12 +2318,12 @@ test_expect_success !MINGW 'R: in-stream cat-blob-fd not respected' '
 	cat-blob $blob
 	EOF
 	test_cmp expect actual.3 &&
-	test_cmp empty actual.1 &&
+	test_must_be_empty actual.1 &&
 	git fast-import 3>actual.3 >actual.1 <<-EOF &&
 	option cat-blob-fd=3
 	cat-blob $blob
 	EOF
-	test_cmp empty actual.3 &&
+	test_must_be_empty actual.3 &&
 	test_cmp expect actual.1
 '
 
@@ -2549,7 +2547,7 @@ EOF
 
 test_expect_success 'R: quiet option results in no stats being output' '
 	cat input | git fast-import 2> output &&
-	test_cmp empty output
+	test_must_be_empty output
 '
 
 test_expect_success 'R: feature done means terminating "done" is mandatory' '
-- 
2.6.2.337.ga235d84
