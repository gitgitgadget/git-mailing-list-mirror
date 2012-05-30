From: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Subject: [PATCH 3/3] Tests file for git-remote-mediawiki
Date: Wed, 30 May 2012 19:04:52 +0200
Message-ID: <1338397492-13360-3-git-send-email-simon.cathebras@ensimag.imag.fr>
References: <4FC64B0C.6070507@ensimag.imag.fr>
 <1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
Cc: Matthieu.Moy@imag.fr, simon.cathebras@ensimag.imag.fr,
	charles.roussel@ensimag.imag.fr, Guillaume.Sasdy@ensimag.imag.fr,
	Julien.Khayat@ensimag.imag.fr, Simon.Perrat@ensimag.imag.fr,
	Charles Roussel <charles.roussel@ensimag.fr>,
	Julien Khayat <julien.khayat@ensimag.imag.fr>,
	Simon Perrat <simon.perrat@ensimag.imag.fr>,
	Guillaume Sasdy <guillaume.sasdy@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 30 19:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZmKj-0005Yw-1j
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 19:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab2E3RFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 13:05:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39733 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab2E3RFB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 13:05:01 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q4UGubmG004682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 May 2012 18:56:37 +0200
Received: from Hithlum.grenet.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4UH4qWj014805;
	Wed, 30 May 2012 19:04:55 +0200
X-Mailer: git-send-email 1.7.10.2.552.gaa3bb87
In-Reply-To: <1338397492-13360-1-git-send-email-simon.cathebras@ensimag.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 May 2012 18:56:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4UGubmG004682
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: simon.cathebras@ensimag.imag.fr
MailScanner-NULL-Check: 1339001801.29814@ZMae4lMh0ddYR8i+xlX5Fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198820>

From: Charles Roussel <charles.roussel@ensimag.fr>

This file (will) contains all tests for git-remote-mediawiki.
For now, we have one test of git-clone on a wiki with one page.

Signed-off-by: Simon Cathebras <simon.cathebras@ensimag.imag.fr>
Signed-off-by: Charles Roussel <charles.roussel@ensimag.imag.fr>
Signed-off-by: Julien Khayat <julien.khayat@ensimag.imag.fr>
Signed-off-by: Simon Perrat <simon.perrat@ensimag.imag.fr>
Signed-off-by: Guillaume Sasdy <guillaume.sasdy@gmail.com>
---
 t/t9360-git-mediawiki.sh | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100755 t/t9360-git-mediawiki.sh

diff --git a/t/t9360-git-mediawiki.sh b/t/t9360-git-mediawiki.sh
new file mode 100755
index 0000000..8de56c5
--- /dev/null
+++ b/t/t9360-git-mediawiki.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (C) 2012
+#     Charles Roussel <charles.roussel@ensimag.imag.fr>
+#     Simon Cathebras <simon.cathebras@ensimag.imag.fr>
+#     Julien Khayat <julien.khayat@ensimag.imag.fr>
+#     Guillaume Sasdy <guillaume.sasdy@ensimag.imag.fr>
+#     Simon Perrat <simon.perrat@ensimag.imag.fr>
+#     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
+#
+# License: GPL v2 or later
+
+# tests for git-remote-mediawiki
+
+test_description='Test the Git Mediawiki remote helper'
+
+. ./test-gitmw-lib.sh
+. ./test-lib.sh
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping gateway git-mw tests, perl not available'
+	test_done
+fi
+
+if [ ! -f /$GIT_BUILD_DIR/git-remote-mediawiki ];
+then
+	skip_all='skipping gateway git-mw tests, no remote mediawiki for git found'
+	test_done
+fi
+
+if [ ! -d "$WIKI_DIR_INST/$WIKI_DIR_NAME" ] ;
+then
+	skip_all='skipping gateway git-mw tests, no mediawiki found'
+	test_done
+fi
+
+test_expect_success 'git clone works with page added' '
+	cmd_reset &&
+	wiki_editpage foo "hello_world" false &&
+	wiki_editpage bar "hi everybody !" false &&
+	git clone mediawiki::http://localhost/wiki mw_dir &&
+	wiki_getallpage ref_page &&
+	git_content mw_dir ref_page &&
+	wiki_delete_page foo &&
+	wiki_delete_page bar
+'
+
+test_done
-- 
1.7.10.2.552.gaa3bb87
