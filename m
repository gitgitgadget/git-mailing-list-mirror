From: Stepan Kasal <kasal@ucw.cz>
Subject: [PATCH] send-email: do not insert third header
Date: Sat, 7 Jun 2014 10:09:40 +0200
Organization: <)><
Message-ID: <20140607080940.GA8858@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 10:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtBhN-0002ix-Cg
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 10:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbaFGIJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 04:09:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:57603 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbaFGIJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 04:09:43 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id 562661C006D
	for <git@vger.kernel.org>; Sat,  7 Jun 2014 10:09:41 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s5789fio008870
	for <git@vger.kernel.org>; Sat, 7 Jun 2014 10:09:41 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s5789eiO008869
	for git@vger.kernel.org; Sat, 7 Jun 2014 10:09:40 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251040>

It is sometimes desirable to insert several header lines at the top of
the body, e.g., if From or Date differs from the mail header.
(Linus even recommends to use this second header for all kernel
submissions.)

send-email has a minimal support for this; make sure it is not applied
when there is a second header already inserted in the patch file.

Signed-off-by: Stepan Kasal <kasal@ucw.cz>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9949db0..891df13 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1456,7 +1456,9 @@ foreach my $t (@files) {
 	}
 
 	if (defined $sauthor and $sauthor ne $sender) {
-		$message = "From: $author\n\n$message";
+		if ($message !~ m/^From: /) {
+			$message = "From: $author\n\n$message";
+		}
 		if (defined $author_encoding) {
 			if ($has_content_type) {
 				if ($body_encoding eq $author_encoding) {
-- 
1.9.2.msysgit.0.496.g9a846d6
