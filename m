From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 12/12] git-remote-mediawiki: be more defensive when requests fail
Date: Thu,  5 Jul 2012 09:36:12 +0200
Message-ID: <1341473772-28023-13-git-send-email-Matthieu.Moy@imag.fr>
References: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 09:37:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smgcw-0001cS-Cu
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 09:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780Ab2GEHhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 03:37:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58621 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754727Ab2GEHhK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 03:37:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q657a1DY029278
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Jul 2012 09:36:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcY-0006fW-NF; Thu, 05 Jul 2012 09:37:02 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SmgcY-0007ml-KG; Thu, 05 Jul 2012 09:37:02 +0200
X-Mailer: git-send-email 1.7.11.1.147.g47a574d
In-Reply-To: <1341473772-28023-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Jul 2012 09:36:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q657a1DY029278
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1342078565.46116@og4DwfCuLSFX49eATYyJJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201033>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index dd18142..63f02b8 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -939,6 +939,14 @@ sub mw_import_revids {
 
 		my $result = $mediawiki->api($query);
 
+		if (!$result) {
+			die "Failed to retrieve modified page for revision $pagerevid";
+		}
+
+		if (!defined($result->{query}->{pages})) {
+			die "Invalid revision $pagerevid.";
+		}
+
 		my @result_pages = values(%{$result->{query}->{pages}});
 		my $result_page = $result_pages[0];
 		my $rev = $result_pages[0]->{revisions}->[0];
-- 
1.7.11.1.147.g47a574d
