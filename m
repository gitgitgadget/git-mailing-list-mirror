From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: un-brace file handles in binmode calls
Date: Wed,  3 Jul 2013 11:14:19 +0200
Message-ID: <1372842859-16598-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: celestin.matte@ensimag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jul 03 11:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuJ8z-0006jY-OT
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 11:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377Ab3GCJOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 05:14:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47474 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342Ab3GCJO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 05:14:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r639EK15011475
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Jul 2013 11:14:20 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UuJ8n-0000dz-H5; Wed, 03 Jul 2013 11:14:21 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1UuJ8n-0004KM-5p; Wed, 03 Jul 2013 11:14:21 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Jul 2013 11:14:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r639EK15011475
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1373447665.49464@l8LdpcTGLSZthQlu9e5+qw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229474>

Commit e83d36b66fc turned "print STDOUT" into "print {*STDOUT}", as
suggested by perlcritic. Unfortunately, it also changed two "binmode
STDOUT" calls the same way, which does not work and yield a "Not a GLOB
reference" error.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index e40c034..f8d7d2c 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -576,9 +576,9 @@ sub literal_data_raw {
 	my ($content) = @_;
 	# Avoid confusion between size in bytes and in characters
 	utf8::downgrade($content);
-	binmode {*STDOUT}, ':raw';
+	binmode STDOUT, ':raw';
 	print {*STDOUT} 'data ', bytes::length($content), "\n", $content;
-	binmode {*STDOUT}, ':encoding(UTF-8)';
+	binmode STDOUT, ':encoding(UTF-8)';
 	return;
 }
 
-- 
1.8.3.1.495.g13f33cf.dirty
