From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 4/5] t3904-stash-patch: factor PERL prereq at the top of the file
Date: Thu, 16 Apr 2015 09:02:30 +0200
Message-ID: <1429167751-19398-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1429011168-23216-1-git-send-email-Matthieu.Moy@imag.fr>
 <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Tanky Woo <wtq1990@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 16 09:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YidpX-0004EB-Rf
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 09:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbbDPHDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 03:03:12 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33552 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756917AbbDPHDH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 03:03:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72fkJ029339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Apr 2015 09:02:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t3G72fJl021232;
	Thu, 16 Apr 2015 09:02:41 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Yidov-0005CT-QK; Thu, 16 Apr 2015 09:02:41 +0200
X-Mailer: git-send-email 2.4.0.rc1.42.g9642cc6
In-Reply-To: <1429167751-19398-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 16 Apr 2015 09:02:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t3G72fkJ029339
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1429772564.32008@SpCTtJhpDe9RluRa4jfyiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267256>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 t/t3904-stash-patch.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index 9a59683..0f8f47f 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -3,7 +3,13 @@
 test_description='stash -p'
 . ./lib-patch-mode.sh
 
-test_expect_success PERL 'setup' '
+if ! test_have_prereq PERL
+then
+	skip_all='skipping stash -p tests, perl not available'
+	test_done
+fi
+
+test_expect_success 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -20,7 +26,7 @@ test_expect_success PERL 'setup' '
 
 # note: order of files with unstaged changes: HEAD bar dir/foo
 
-test_expect_success PERL 'saying "n" does nothing' '
+test_expect_success 'saying "n" does nothing' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state dir/foo work index &&
 	(echo n; echo n; echo n) | test_must_fail git stash save -p &&
@@ -29,7 +35,7 @@ test_expect_success PERL 'saying "n" does nothing' '
 	verify_state dir/foo work index
 '
 
-test_expect_success PERL 'git stash -p' '
+test_expect_success 'git stash -p' '
 	(echo y; echo n; echo y) | git stash save -p &&
 	verify_state HEAD committed HEADfile_index &&
 	verify_saved_state bar &&
@@ -41,7 +47,7 @@ test_expect_success PERL 'git stash -p' '
 	verify_state dir/foo work head
 '
 
-test_expect_success PERL 'git stash -p --no-keep-index' '
+test_expect_success 'git stash -p --no-keep-index' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
@@ -56,7 +62,7 @@ test_expect_success PERL 'git stash -p --no-keep-index' '
 	verify_state dir/foo work index
 '
 
-test_expect_success PERL 'git stash --no-keep-index -p' '
+test_expect_success 'git stash --no-keep-index -p' '
 	set_state HEAD HEADfile_work HEADfile_index &&
 	set_state bar bar_work bar_index &&
 	set_state dir/foo work index &&
@@ -71,7 +77,7 @@ test_expect_success PERL 'git stash --no-keep-index -p' '
 	verify_state dir/foo work index
 '
 
-test_expect_success PERL 'none of this moved HEAD' '
+test_expect_success 'none of this moved HEAD' '
 	verify_saved_head
 '
 
-- 
2.4.0.rc1.42.g9642cc6
