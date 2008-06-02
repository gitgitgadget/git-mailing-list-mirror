From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 3/4] Test for another filename quoting issue in tree_status()
Date: Mon, 02 Jun 2008 23:46:30 +0200
Message-ID: <20080602214630.18768.72825.stgit@yoghurt>
References: <20080602214212.18768.63775.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:47:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HsT-0004vi-Iz
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbYFBVqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 17:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbYFBVqg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:46:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4638 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYFBVqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:46:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3HrL-0001Dr-00; Mon, 02 Jun 2008 22:46:31 +0100
In-Reply-To: <20080602214212.18768.63775.stgit@yoghurt>
User-Agent: StGIT/0.14.2.156.gbabd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83582>

stgit.git.tree_status() had another filename quoting issue, similar to
the one just fixed. Test for that one too.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/t3200-non-ascii-filenames.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)


diff --git a/t/t3200-non-ascii-filenames.sh b/t/t3200-non-ascii-filenam=
es.sh
index a04ead8..055b152 100755
--- a/t/t3200-non-ascii-filenames.sh
+++ b/t/t3200-non-ascii-filenames.sh
@@ -10,7 +10,7 @@ test_expect_success 'Setup' '
     stg init &&
     echo foo > unrelated.txt &&
     git add unrelated.txt &&
-    stg new -m "Unrelated file" &&
+    stg new p0 -m "Unrelated file" &&
     stg refresh &&
     stg pop &&
     rm sk=C3=A4rg=C3=A5rds=C3=B6.txt &&
@@ -24,4 +24,15 @@ test_expect_success 'Rebase onto changed non-ASCII f=
ile' '
     stg rebase upstream
 '
=20
+test_expect_success 'Setup' '
+    stg delete p0 &&
+    git reset --hard HEAD^ &&
+    echo "-- ett liv mitt ute i vattnet" >> sk=C3=A4rg=C3=A5rds=C3=B6.=
txt &&
+    stg new p1 -m "Describe island"
+'
+
+test_expect_failure 'Refresh changes to non-ASCII file' '
+    stg refresh
+'
+
 test_done
