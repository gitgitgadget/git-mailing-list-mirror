From: mhagger@alum.mit.edu
Subject: [PATCH 5/7] t0000: verify that real_path() works correctly with absolute paths
Date: Tue,  4 Sep 2012 10:14:28 +0200
Message-ID: <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oPL-0003jr-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab2IDIWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:22:37 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:46159 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752352Ab2IDIWg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:22:36 -0400
X-AuditID: 12074411-b7fa36d0000008cc-58-5045b89a9b4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E9.5F.02252.A98B5405; Tue,  4 Sep 2012 04:15:22 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSZ025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:21 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsUixO6iqDtrh2uAQfcza4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGTPfehYc
	56p4876BuYHxAUcXIyeHhICJxIQt91kgbDGJC/fWs4HYQgKXGSWePHbvYuQCsk8zSfxbsIgZ
	JMEmICXxsrGHHcQWEVCTmNh2CKyZWSBd4sSCdjBbWCBc4vHSJ0wgNouAqkTX5rVgcV4BF4mV
	n/6wQSxTlPjxfQ3YTE4BV4lXH14DxTmAlrlIfHzgPIGRdwEjwypGucSc0lzd3MTMnOLUZN3i
	5MS8vNQiXVO93MwSvdSU0k2MkNAR3ME446TcIUYBDkYlHt7KTy4BQqyJZcWVuYcYJTmYlER5
	7Ta7BgjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b29GijHm5JYWZValA+TkuZgURLn5Vui7ick
	kJ5YkpqdmlqQWgSTleHgUJLg3bcdqFGwKDU9tSItM6cEIc3EwQkiuEA28ABtyAIp5C0uSMwt
	zkyHKDrFqCglzrsCJCEAksgozYMbAIvyV4ziQP8I864HqeIBJgi47ldAg5mABru+dwEZXJKI
	kJJqYMy5dLH0paX6P94L7/MPiCi1HJMMVb6lIBVXasC5Mur45Mdv09Y21t1reFEjnRk3WSm4
	l3ubkGDCatM4dvMLdofKb213PBmVO/HVQ9fE3Z/m9m09dPZsREVi4DzlQzL/Pnz5e+AKt+Bj
	Ntb0Ru2WqS7Wb6Z9W7rkdsqSRVq8038bd+ppqZX/E1diKc5INNRiLipOBABmigjo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204728>

From: Michael Haggerty <mhagger@alum.mit.edu>

There is currently a bug: if passed an absolute top-level path that
doesn't exist (e.g., "/foo") it incorrectly interprets the path as a
relative path (e.g., returns "$(pwd)/foo").  So mark the test as
failing.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t0000-basic.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 1a51634..ad002ee 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -458,7 +458,17 @@ test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-test_expect_success SYMLINKS 'real path works as expected' '
+test_expect_failure 'real path works on absolute paths' '
+	nopath="hopefully-absent-path" &&
+	test "/" = "$(test-path-utils real_path "/")" &&
+	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
+	# Find an existing top-level directory for the remaining tests:
+	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&
+	test "$d" = "$(test-path-utils real_path "$d")" &&
+	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
+'
+
+test_expect_success SYMLINKS 'real path works on symlinks' '
 	mkdir first &&
 	ln -s ../.git first/.git &&
 	mkdir second &&
-- 
1.7.11.3
