From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 08/16] t5302: Use prerequisite tags to skip 64-bit offset tests
Date: Sat, 21 Mar 2009 22:26:31 +0100
Message-ID: <8b7aae1a054a86ae7984386bc8e061a408534873.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 22:28:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll8kG-0003u8-8C
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 22:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZCUV1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 17:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbZCUV1A
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 17:27:00 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:27934 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbZCUV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 17:26:59 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9B49C2C400B;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 52BB7427B8;
	Sat, 21 Mar 2009 22:26:55 +0100 (CET)
X-Mailer: git-send-email 1.6.2.1.224.g2225f
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
In-Reply-To: <cover.1237667830.git.j6t@kdbg.org>
References: <cover.1237667830.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114062>

The effects of this patch can be tested on Linux by commenting out

  #define _FILE_OFFSET_BITS 64

in git-compat-util.h.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t5302-pack-index.sh |   15 +++++----------
 1 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 77982cd..4360e77 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -69,32 +69,27 @@ test_expect_success \
     'index v2: force some 64-bit offsets with pack-objects' \
     'pack3=$(git pack-objects --index-version=2,0x40000 test-3 <obj-list)'
 
-have_64bits=
 if msg=$(git verify-pack -v "test-3-${pack3}.pack" 2>&1) ||
 	! (echo "$msg" | grep "pack too large .* off_t")
 then
-	have_64bits=t
+	test_set_prereq OFF64_T
 else
 	say "skipping tests concerning 64-bit offsets"
 fi
 
-test "$have_64bits" &&
-test_expect_success \
+test_expect_success OFF64_T \
     'index v2: verify a pack with some 64-bit offsets' \
     'git verify-pack -v "test-3-${pack3}.pack"'
 
-test "$have_64bits" &&
-test_expect_success \
+test_expect_success OFF64_T \
     '64-bit offsets: should be different from previous index v2 results' \
     '! cmp "test-2-${pack2}.idx" "test-3-${pack3}.idx"'
 
-test "$have_64bits" &&
-test_expect_success \
+test_expect_success OFF64_T \
     'index v2: force some 64-bit offsets with index-pack' \
     'git index-pack --index-version=2,0x40000 -o 3.idx "test-1-${pack1}.pack"'
 
-test "$have_64bits" &&
-test_expect_success \
+test_expect_success OFF64_T \
     '64-bit offsets: index-pack result should match pack-objects one' \
     'cmp "test-3-${pack3}.idx" "3.idx"'
 
-- 
1.6.2.1.224.g2225f
