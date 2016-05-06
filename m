From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 01/33] t1404: demonstrate a bug resolving references
Date: Fri,  6 May 2016 18:13:42 +0200
Message-ID: <19dd7d06e5d2c58895dd101025c013404025e192.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:14:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiOd-0007qm-1C
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758426AbcEFQO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:26 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54137 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758171AbcEFQOZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:25 -0400
X-AuditID: 12074413-487ff700000008c7-9d-572cc2df941c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 10.32.02247.FD2CC275; Fri,  6 May 2016 12:14:23 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHUh031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:22 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqHv/kE64wdxtyhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7owpPQ2MBb+kKr5ssGhg7BHrYuTkkBAwkdg27QlL
	FyMXh5DAVkaJ9dOuskM4x5kkJrz7xQpSxSagK7Gop5kJxBYRiJBoeNXC2MXIwcEs8JlRYiU3
	SFhYwF3i4bmjLCBhFgFVie73viBhXoEoiamLlzFC7JKTuDz9ARuIzSlgIXGo9zjYRCEBc4mO
	tTfYJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokRElzCOxh3nZQ7
	xCjAwajEw5txUjtciDWxrLgy9xCjJAeTkijv9wKdcCG+pPyUyozE4oz4otKc1OJDjBIczEoi
	vFf2AeV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8QQeBGgWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBwR9fDAx/kBQP0F55kHbe4oLEXKAoROspRl2O
	I/vvrWUSYsnLz0uVEuc1ACkSACnKKM2DWwFLJa8YxYE+Fua9DFLFA0xDcJNeAS1hAlryfq4m
	yJKSRISUVANjtUWE77xp5evMr9feeLMwcwa/aq3bkW9rvc9s1Fp1fovZJXnzNzcbDnG1Hr19
	KzebcVObheAnPourtnWMp1aeXeMSUHlkbfdFwy6ZzsLerfVvGS+q9k39fIDx/IFf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293795>

Add some tests checking that it is possible to work with a reference
even if there is an empty directory where the loose ref would be stored.

One of the new tests demonstrates a bug that has been with us since at
least 2.5.0--single reference lookup gives up when it sees the
directory, even if the reference exists as a packed ref. This probably
hasn't been reported before because Git usually cleans up empty
directories when packing references.

This bug will be fixed shortly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1404-update-ref-df-conflicts.sh | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/t/t1404-update-ref-df-conflicts.sh b/t/t1404-update-ref-df-conflicts.sh
index 66bafb5..16752a9 100755
--- a/t/t1404-update-ref-df-conflicts.sh
+++ b/t/t1404-update-ref-df-conflicts.sh
@@ -28,7 +28,9 @@ Q="'"
 test_expect_success 'setup' '
 
 	git commit --allow-empty -m Initial &&
-	C=$(git rev-parse HEAD)
+	C=$(git rev-parse HEAD) &&
+	git commit --allow-empty -m Second &&
+	D=$(git rev-parse HEAD)
 
 '
 
@@ -104,4 +106,76 @@ test_expect_success 'one new ref is a simple prefix of another' '
 
 '
 
+test_expect_failure 'empty directory should not fool rev-parse' '
+	prefix=refs/e-rev-parse &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	echo "$C" >expected &&
+	git rev-parse $prefix/foo >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool for-each-ref' '
+	prefix=refs/e-for-each-ref &&
+	git update-ref $prefix/foo $C &&
+	git for-each-ref $prefix >expected &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	git for-each-ref $prefix >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'empty directory should not fool create' '
+	prefix=refs/e-create &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "create %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool verify' '
+	prefix=refs/e-verify &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "verify %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg update' '
+	prefix=refs/e-update-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 2-arg update' '
+	prefix=refs/e-update-2 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "update %s $D $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 0-arg delete' '
+	prefix=refs/e-delete-0 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s\n" $prefix/foo |
+	git update-ref --stdin
+'
+
+test_expect_success 'empty directory should not fool 1-arg delete' '
+	prefix=refs/e-delete-1 &&
+	git update-ref $prefix/foo $C &&
+	git pack-refs --all &&
+	mkdir -p .git/$prefix/foo/bar/baz &&
+	printf "delete %s $C\n" $prefix/foo |
+	git update-ref --stdin
+'
+
 test_done
-- 
2.8.1
