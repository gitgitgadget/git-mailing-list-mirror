From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/4] t6301: new tests of for-each-ref error handling
Date: Wed,  3 Jun 2015 15:51:56 +0200
Message-ID: <48c6ecbe5a963a9ba89e3c25fc6e075a52ebcdbd.1433339279.git.mhagger@alum.mit.edu>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z095e-0005gd-60
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbbFCNwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 09:52:08 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60758 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbbFCNwG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 09:52:06 -0400
X-AuditID: 12074411-f796c6d000000bc9-84-556f06857a65
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F3.B8.03017.5860F655; Wed,  3 Jun 2015 09:52:05 -0400 (EDT)
Received: from michael.fritz.box (p4FC96DFC.dip0.t-ipconnect.de [79.201.109.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t53Dq151005566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Jun 2015 09:52:04 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433339279.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsUixO6iqNvKlh9qcPmHnsWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnbHr6TG2gr2iFc+3P2drYHwv2MXIySEhYCLRtPYWM4QtJnHh3no2EFtI
	4DKjRN8MOwj7BJPEgU/FIDabgK7Eop5mJhBbREBNYmLbIRYQm1lgM6NE58MgEFtYwF3i+6n1
	jCA2i4CqxLvedjCbVyBK4tT2r1C75CTOH/8JZHNwcApYSOy5oQ1iCgmYS5w/KT+BkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1TvdzMEr3UlNJNjJDgEtzBOOOk3CFGAQ5GJR5eh7C8
	UCHWxLLiytxDjJIcTEqivGu+AIX4kvJTKjMSizPii0pzUosPMUpwMCuJ8L58B5TjTUmsrEot
	yodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwirPmhwoJFqWmp1akZeaUIKSZODhB
	hnNJiRSn5qWkFiWWlmTEg2IivhgYFSApHqC9cSDtvMUFiblAUYjWU4y6HD8uNS5mEmLJy89L
	lRLnjQQpEgApyijNg1sBSyWvGMWBPhbmTQGp4gGmIbhJr4CWMAEtaRfIAVlSkoiQkmpgnNFb
	u297upShXWXOO85fO/Km+3w/eprzaOdFnRTuEgNmw1Ajbosdp/hNr01UtHBozP7VwdU9dW2e
	dJrfAu+UHlYdTt6yySFPOKPzNnqHyN41fsY0NSRvk/6lwvMFhfal4g8iHS7n8J39 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270683>

Add tests that for-each-ref correctly reports broken loose reference
files and references that point at missing objects. In fact, two of
these tests fail, because (1) NULL_SHA1 is not recognized as an
invalid reference value, and (2) for-each-ref doesn't respect
REF_ISBROKEN. Fixes to come.

Note that when for-each-ref is run with a --format option that doesn't
require the object to be looked up, then we should still notice if a
loose reference file is corrupt or contains NULL_SHA1, but we don't
notice if it points at a missing object because we don't do an object
lookup. This is OK.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t6301-for-each-ref-errors.sh | 56 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 t/t6301-for-each-ref-errors.sh

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
new file mode 100755
index 0000000..cf25244
--- /dev/null
+++ b/t/t6301-for-each-ref-errors.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description='for-each-ref errors for broken refs'
+
+. ./test-lib.sh
+
+ZEROS=$_z40
+MISSING=abababababababababababababababababababab
+
+test_expect_success setup '
+	git commit --allow-empty -m "Initial" &&
+	git tag testtag &&
+	git for-each-ref >full-list &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-list
+'
+
+test_expect_failure 'Broken refs are reported correctly' '
+	r=refs/heads/bogus &&
+	: >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >broken-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp broken-err err
+'
+
+test_expect_failure 'NULL_SHA1 refs are reported correctly' '
+	r=refs/heads/zeros &&
+	echo $ZEROS >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >zeros-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp zeros-err err &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
+	test_cmp brief-list brief-out &&
+	test_cmp zeros-err brief-err
+'
+
+test_expect_success 'Missing objects are reported correctly' '
+	r=refs/heads/missing &&
+	echo $MISSING >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	test_must_fail git for-each-ref 2>err &&
+	test_cmp missing-err err &&
+	(
+		cat brief-list &&
+		echo "$MISSING $r"
+	) | sort -k 2 >missing-brief-expected &&
+	git for-each-ref --format="%(objectname) %(refname)" >brief-out 2>brief-err &&
+	test_cmp missing-brief-expected brief-out &&
+	test_must_be_empty brief-err
+'
+
+test_done
-- 
2.1.4
