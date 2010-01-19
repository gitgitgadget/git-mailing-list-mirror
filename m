From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: [PATCH] Fix errors in t6018
Date: Tue, 19 Jan 2010 11:35:48 +0200
Message-ID: <1263893748-23327-1-git-send-email-ilari.liusvaara@elisanet.fi>
References: <20100119065609.GB3946@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 10:36:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXAVG-0000ZL-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 10:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab0ASJf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449Ab0ASJf4
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 04:35:56 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:48810 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab0ASJfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 04:35:55 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id B052513C147;
	Tue, 19 Jan 2010 11:35:52 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00565A7EDD; Tue, 19 Jan 2010 11:35:52 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 51BDB1C6386;
	Tue, 19 Jan 2010 11:35:48 +0200 (EET)
X-Mailer: git-send-email 1.6.6.199.gff4b0
In-Reply-To: <20100119065609.GB3946@coredump.intra.peff.net>
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137445>

Fix errors and shortcomings in t6018 (the rev-parse --namespace test):
1) Some tests were missing &&'s, leading too possibly missing failures
2) Some tests used incorrect commands (didn't test what they were
suppoed to)
3) Some test used 'cmp' instead of 'test_cmp'
4) Tests only tested output up to permutation

Fix these errors in t6018.

Signed-off-by: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
---
This can be appiled on top of rev-parse --namespace patch v3 or this
can be squashed to that patch.

 t/t6018-rev-list-namespace.sh |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t6018-rev-list-namespace.sh b/t/t6018-rev-list-namespace.sh
index 6bb562a..70c8a83 100755
--- a/t/t6018-rev-list-namespace.sh
+++ b/t/t6018-rev-list-namespace.sh
@@ -14,23 +14,23 @@ commit () {
 
 compare () {
 	# Split arguments on whitespace.
-	git $1 $2 | sort >expected &&
-	git $1 $3 | sort >actual &&
-	cmp expected actual
+	git $1 $2 >expected &&
+	git $1 $3 >actual &&
+	test_cmp expected actual
 }
 
 test_expect_success 'setup' '
 
 	commit master &&
-	git checkout -b subspace/one master
+	git checkout -b subspace/one master &&
 	commit one &&
-	git checkout -b subspace/two master
+	git checkout -b subspace/two master &&
 	commit two &&
-	git checkout -b subspace-x master
+	git checkout -b subspace-x master &&
 	commit subspace-x &&
-	git checkout -b other/three master
+	git checkout -b other/three master &&
 	commit three &&
-	git checkout -b someref master
+	git checkout -b someref master &&
 	commit some &&
 	git checkout master &&
 	commit master2
@@ -68,7 +68,7 @@ test_expect_success 'rev-parse --namespace=heads/someref master' '
 
 test_expect_success 'rev-parse --namespace=heads' '
 
-	compare rev-parse "subspace/one subspace/two other/three subspace-x master someref" "--namespace=heads"
+	compare rev-parse "master other/three someref subspace-x subspace/one subspace/two" "--namespace=heads"
 
 '
 
@@ -92,19 +92,19 @@ test_expect_success 'rev-list --namespace=heads/subspace' '
 
 test_expect_success 'rev-list --namespace=heads/someref master' '
 
-	compare rev-parse "master" "--namespace=heads/someref master"
+	compare rev-list "master" "--namespace=heads/someref master"
 
 '
 
 test_expect_success 'rev-list --namespace=heads/subspace --namespace=heads/other' '
 
-	compare rev-parse "subspace/one subspace/two other/three" "--namespace=heads/subspace --namespace=heads/other"
+	compare rev-list "subspace/one subspace/two other/three" "--namespace=heads/subspace --namespace=heads/other"
 
 '
 
 test_expect_success 'rev-list --namespace=heads' '
 
-	compare rev-parse "subspace/one subspace/two other/three subspace-x master someref" "--namespace=heads"
+	compare rev-list "master other/three someref subspace-x subspace/one subspace/two" "--namespace=heads"
 
 '
 
-- 
1.6.6.199.gff4b0
