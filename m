From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/6] t1404: add more tests of update-ref error handling
Date: Fri, 10 Jun 2016 10:14:47 +0200
Message-ID: <484e4048dbc55314c668dcfb584bb2ad01f587cf.1465544913.git.mhagger@alum.mit.edu>
References: <cover.1465544913.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, David Turner <novalis@novalis.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 10:15:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBHb9-0001bQ-GI
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 10:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbcFJIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 04:15:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45850 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751339AbcFJIPD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jun 2016 04:15:03 -0400
X-AuditID: 1207440d-bb3ff7000000090b-43-575a77062673
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 6C.B5.02315.6077A575; Fri, 10 Jun 2016 04:15:02 -0400 (EDT)
Received: from michael.fritz.box (p508EAFFC.dip0.t-ipconnect.de [80.142.175.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5A8EpD6028943
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Jun 2016 04:15:00 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1465544913.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqMtWHhVucOK/sEXXlW4mi4beK8wW
	T+beZba4vWI+s8WSh6+ZLbqnvGW0+NHSw+zA7vH3/Qcmj52z7rJ7PHzVxe7R1X6EzeNZ7x5G
	j4uXlD0+b5ILYI/itklKLCkLzkzP07dL4M549WcpS0GHZ8XGVcvYGhgn23YxcnJICJhIfO1/
	wtrFyMUhJLCVUaLj5212COckk8SZlT+ZQKrYBHQlFvU0g9kiAmoSE9sOsYAUMQt0Mkmc2PMG
	yOHgEBbwkmibxgVSwyKgKnHy72NGEJtXIEqiq/UYC8Q2OYnL0x+wgdicAhYSp69PALOFBMwl
	/s1uYp/AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkiQ8e5g/L9O
	5hCjAAejEg8vw47IcCHWxLLiytxDjJIcTEqivDsDo8KF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifCKgeR4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8amVAjYJFqemp
	FWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgGIgvBkYBSIoHaG8FSDtvcUFiLlAUovUUoy7H
	kf331jIJseTl56VKifMuKgUqEgApyijNg1sBSymvGMWBPhbm3QBSxQNMR3CTXgEtYQJasvxI
	OMiSkkSElFQDo3jEpocbbxTrFH10vnHs6RHGecumyP2sum3secuX80617+dJrxJzPlz7Ii26
	UrA5fkLlk/3SL/kuJuVN3pf5rFvpVJRE0sOYw8nXvt3aLh/YcIT/76FtZ0OqKu2P 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296952>

Some of the error messages will be improved in subsequent commits.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-errors.sh | 221 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
index 7cfeaa9..5234b41f1 100755
--- a/t/t1404-update-ref-errors.sh
+++ b/t/t1404-update-ref-errors.sh
@@ -39,8 +39,9 @@ test_expect_success 'setup' '
 	git commit --allow-empty -m Initial &&
 	C=$(git rev-parse HEAD) &&
 	git commit --allow-empty -m Second &&
-	D=$(git rev-parse HEAD)
-
+	D=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Third &&
+	E=$(git rev-parse HEAD)
 '
 
 test_expect_success 'existing loose ref is a simple prefix of new' '
@@ -187,4 +188,220 @@ test_expect_success 'empty directory should not fool 1-arg delete' '
 	git update-ref --stdin
 '
 
+# Test various errors when reading the old values of references...
+
+test_expect_success 'missing old value blocks update' '
+	prefix=refs/missing-update &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks update' '
+	prefix=refs/incorrect-update &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "update $prefix/foo $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'existing old value blocks create' '
+	prefix=refs/existing-create &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: reference already exists
+	EOF
+	printf "%s\n" "create $prefix/foo $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks delete' '
+	prefix=refs/incorrect-delete &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "delete $prefix/foo $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'missing old value blocks indirect update' '
+	prefix=refs/missing-indirect-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect update' '
+	prefix=refs/incorrect-indirect-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'existing old value blocks indirect create' '
+	prefix=refs/existing-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
+	EOF
+	printf "%s\n" "create $prefix/symref $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect delete' '
+	prefix=refs/incorrect-indirect-delete &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "delete $prefix/symref $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'missing old value blocks indirect no-deref update' '
+	prefix=refs/missing-noderef-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: can${Q}t resolve old value
+	EOF
+	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect no-deref update' '
+	prefix=refs/incorrect-noderef-update &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "option no-deref" "update $prefix/symref $E $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_failure 'existing old value blocks indirect no-deref create' '
+	prefix=refs/existing-noderef-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: reference already exists
+	EOF
+	printf "%s\n" "option no-deref" "create $prefix/symref $E" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'incorrect old value blocks indirect no-deref delete' '
+	prefix=refs/incorrect-noderef-delete &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	git update-ref $prefix/foo $C &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/symref$Q: is at $C but expected $D
+	EOF
+	printf "%s\n" "option no-deref" "delete $prefix/symref $D" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks create' '
+	prefix=refs/ne-create &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks create' '
+	prefix=refs/broken-create &&
+	mkdir -p .git/$prefix &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/foo $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'non-empty directory blocks indirect create' '
+	prefix=refs/ne-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	mkdir -p .git/$prefix/foo/bar &&
+	: >.git/$prefix/foo/bar/baz.lock &&
+	test_when_finished "rm -f .git/$prefix/foo/bar/baz.lock" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: there is a non-empty directory $Q.git/$prefix/foo$Q blocking reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
+test_expect_success 'broken reference blocks indirect create' '
+	prefix=refs/broken-indirect-create &&
+	git symbolic-ref $prefix/symref $prefix/foo &&
+	echo "gobbledigook" >.git/$prefix/foo &&
+	test_when_finished "rm -f .git/$prefix/foo" &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err &&
+	cat >expected <<-EOF &&
+	fatal: cannot lock ref $Q$prefix/foo$Q: unable to resolve reference $Q$prefix/foo$Q: reference broken
+	EOF
+	printf "%s\n" "update $prefix/symref $D $C" |
+	test_must_fail git update-ref --stdin 2>output.err &&
+	test_cmp expected output.err
+'
+
 test_done
-- 
2.8.1
