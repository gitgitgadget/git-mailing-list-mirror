From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 3/4] t5704: match tests to modern style
Date: Thu, 23 Feb 2012 10:42:23 +0100
Message-ID: <c6579adc648119fbd1c54e2a1a9a0de86e0e8b57.1329988335.git.trast@student.ethz.ch>
References: <cover.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VCQ-0007kC-2y
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346Ab2BWJmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:42:42 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:28309 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab2BWJmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:42:33 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:30 +0100
Received: from thomas.inf.ethz.ch (129.132.209.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:32 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <cover.1329988335.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.209.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191342>

The test did not adhere to the current style on several counts:

- empty lines around the test blocks, but within the test string

- ': > file' or even just '> file' with an extra space

- inconsistent indentation

- hand-rolled commits instead of using test_commit

Fix all of them.  There's a catch to the last point: test_commit
creates a tag.  We still change it to test_commit, and explicitly
delete the tags, so as to highlight that the test relies on not having
them.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 t/t5704-bundle.sh |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 4ae127d..f35f559 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -4,59 +4,42 @@ test_description='some bundle related tests'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-
-	: > file &&
-	git add file &&
-	test_tick &&
-	git commit -m initial &&
+	test_commit initial &&
 	test_tick &&
 	git tag -m tag tag &&
-	: > file2 &&
-	git add file2 &&
-	: > file3 &&
-	test_tick &&
-	git commit -m second &&
-	git add file3 &&
-	test_tick &&
-	git commit -m third
-
+	test_commit second &&
+	test_commit third &&
+	git tag -d initial &&
+	git tag -d second &&
+	git tag -d third
 '
 
 test_expect_success 'tags can be excluded by rev-list options' '
-
 	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
 	git ls-remote bundle > output &&
 	! grep tag output
-
 '
 
 test_expect_success 'die if bundle file cannot be created' '
-
 	mkdir adir &&
 	test_must_fail git bundle create adir --all
-
 '
 
 test_expect_failure 'bundle --stdin' '
-
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
 	git ls-remote stdin-bundle.bdl >output &&
 	grep master output
-
 '
 
 test_expect_failure 'bundle --stdin <rev-list options>' '
-
 	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
 	git ls-remote hybrid-bundle.bdl >output &&
 	grep master output
-
 '
 
 test_expect_success 'empty bundle file is rejected' '
-
-    >empty-bundle && test_must_fail git fetch empty-bundle
-
+	: >empty-bundle &&
+	test_must_fail git fetch empty-bundle
 '
 
 test_done
-- 
1.7.9.1.430.g4998543
