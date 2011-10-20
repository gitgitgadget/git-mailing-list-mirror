From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-mediawiki: don't include HTTP login/password in author
Date: Thu, 20 Oct 2011 19:04:59 +0200
Message-ID: <1319130299-13259-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 20 19:05:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGw3R-0002yL-JF
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 19:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab1JTRFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 13:05:11 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33969 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab1JTRFK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 13:05:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9KH1e7W003492
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 20 Oct 2011 19:01:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1RGw3E-0005bE-19; Thu, 20 Oct 2011 19:05:04 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1RGw3D-0003Sj-Tz; Thu, 20 Oct 2011 19:05:03 +0200
X-Mailer: git-send-email 1.7.7.140.ge3099
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 20 Oct 2011 19:01:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9KH1e7W003492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1319734903.49846@uA1etkEQPqv4k+64KFchZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184029>

On the MediaWiki side, the author information is just the MediaWiki login
of the contributor. The import turns it into login@$wiki_name to create
the author's email address on the wiki side. But we don't want this to
include the HTTP password if it's present in the URL ...

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index 0b32d18..c18bfa1 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -109,6 +109,10 @@ $dumb_push = ($dumb_push eq "true");
 
 my $wiki_name = $url;
 $wiki_name =~ s/[^\/]*:\/\///;
+# If URL is like http://user:password@example.com/, we clearly don't
+# want the password in $wiki_name. While we're there, also remove user
+# and '@' sign, to avoid author like MWUser@HTTPUser@host.com
+$wiki_name =~ s/^.*@//;
 
 # Commands parser
 my $entry;
-- 
1.7.7.140.ge3099
