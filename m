From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] mw-to-git: check blank credential attributes via length
Date: Wed, 18 Jul 2012 08:04:30 -0400
Message-ID: <20120718120430.GB6726@sigill.intra.peff.net>
References: <20120718120307.GA6399@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:04:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrSze-0006Tj-C9
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab2GRMEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:04:34 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39072
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab2GRMEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:04:33 -0400
Received: (qmail 18934 invoked by uid 107); 18 Jul 2012 12:04:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jul 2012 08:04:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2012 08:04:30 -0400
Content-Disposition: inline
In-Reply-To: <20120718120307.GA6399@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201678>

When writing a credential to git-credential, we omit fields
that do not have a true value. This will skip empty or
undefined fields (which we want), but will also accidentally
skip usernames or passwords which happen to have a non-true
value (e.g., "0"). Be more careful by checking for non-zero
length.

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/mw-to-git/git-remote-mediawiki | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index accd70a..b06f27b 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -207,7 +207,7 @@ sub credential_write {
 	my $credential = shift;
 	my $writer = shift;
 	while (my ($key, $value) = each(%$credential) ) {
-		if ($value) {
+		if (length $value) {
 			print $writer "$key=$value\n";
 		}
 	}
-- 
1.7.10.5.40.g059818d
