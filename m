From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 08/12] git-remote-mediawiki: change return type of get_mw_pages
Date: Thu,  5 Jul 2012 09:36:08 +0200
Message-ID: <1341473772-28023-9-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgcu-0001cS-7A
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab2GEHg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:36:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38985 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754615Ab2GEHg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:36:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q657Zh1s011277
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:35:43 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcP-0006b2-47; Thu, 05 Jul 2012 09:36:53 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcP-0007l6-2R; Thu, 05 Jul 2012 09:36:53 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 05 Jul 2012 09:35:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657Zh1s011277
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078545.10387@Wnlgt3WiJ8wECyBWZhSANg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201029>

The previous version was returning the list of pages to be fetched, but
we are going to need an efficient membership test (i.e. is the page
$title tracked), hence exposing a hash will be more convenient.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 76b78bc..3f57598 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -377,7 +377,7 @@ sub get_mw_pages {
 			get_all_mediafiles(\%pages);
 		}
 	}
-	return values(%pages);
+	return %pages;
 }
 
 # usage: $out = run_git("command args");
@@ -563,7 +563,8 @@ my %basetimestamps;
 sub get_last_remote_revision {
 	mw_connect_maybe();
 
-	my @pages = get_mw_pages();
+	my %pages_hash = get_mw_pages();
+	my @pages = values(%pages_hash);
 
 	my $max_rev_num = 0;
 
@@ -829,7 +830,8 @@ sub mw_import_ref {
 
 	mw_connect_maybe();
 
-	my @pages = get_mw_pages();
+	my %pages_hash = get_mw_pages();
+	my @pages = values(%pages_hash);
 
 	print STDERR "Searching revisions...\n";
 	my $last_local = get_last_local_revision();
-- 
1.7.11.1.147.g47a574d
