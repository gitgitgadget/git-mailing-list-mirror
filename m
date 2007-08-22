From: David Jack Olrik <david@olrik.dk>
Subject: [PATCH] Fixed non portable use of expr and removed incorrect use of test -eq for string comparison
Date: Wed, 22 Aug 2007 22:18:30 +0200
Message-ID: <11878139102715-git-send-email-david@olrik.dk>
References: <20070822132359.GA13750@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ukleinek@informatik.uni-freiburg.de,
	David Jack Olrik <david@olrik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 22:18:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INwed-0003f1-8y
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 22:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945AbXHVUSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 16:18:12 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753157AbXHVUSK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 16:18:10 -0400
Received: from barcrawl.dk ([149.6.48.213]:60467 "EHLO mail.barcrawl.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbXHVUSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 16:18:09 -0400
Received: from localhost (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id 1BC997CBADA;
	Wed, 22 Aug 2007 22:18:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail.wange.dk
Received: from mail.barcrawl.dk ([149.6.48.213])
	by localhost (barcrawl.dk [149.6.48.213]) (amavisd-new, port 10024)
	with ESMTP id tI+yMRPObf2U; Wed, 22 Aug 2007 22:18:15 +0200 (CEST)
Received: from localhost.localdomain (barcrawl.dk [149.6.48.213])
	by mail.barcrawl.dk (Postfix) with ESMTP id AA8AE7CBAD8;
	Wed, 22 Aug 2007 22:18:15 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc6
In-Reply-To: <20070822132359.GA13750@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56416>

On 22/08/2007, at 15.23, Uwe Kleine-K=C3=B6nig wrote:

> > You'd then need to check against 2 instead of 1, which I find less
> > obvious as we are testing for a '/' at the begining of the string.
> If I understood the problem right you only need to test for the exit
> code, that is the program test is not required at all.

Ah, yes that's true. The following should make it more clear that we ar=
e
looking at the first character.

    if expr "$httpd_only" : "\/" >/dev/null


Signed-off-by: David Jack Olrik <david@olrik.dk>
---
 git-instaweb.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..85646f1 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -30,7 +30,7 @@ test -z "$port" && port=3D1234
=20
 start_httpd () {
 	httpd_only=3D"`echo $httpd | cut -f1 -d' '`"
-	if test "`expr index $httpd_only /`" -eq '1' || \
+	if expr "$httpd_only" : "\/" >/dev/null || \
 				which $httpd_only >/dev/null
 	then
 		$httpd $fqgitdir/gitweb/httpd.conf
--=20
1.5.3.rc6
