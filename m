From: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH] gitweb: allow space as delimiter in mime.types
Date: Tue, 14 Jun 2011 16:09:55 +0200
Message-ID: <1308060595-28294-1-git-send-email-ludwig.nussel@suse.de>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:10:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWUJg-0004Dh-MM
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161Ab1FNOJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:09:58 -0400
Received: from cantor.suse.de ([195.135.220.2]:49395 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959Ab1FNOJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:09:57 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 641BE8E8CC
	for <git@vger.kernel.org>; Tue, 14 Jun 2011 16:09:56 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175771>

in openSUSE /etc/mime.types has only spaces. I don't know if there's
a canonical reference that says that only tabs are allowed. Mutt at
least also accepts spaces. So make gitweb more liberal too.
---
 gitweb/gitweb.perl |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1b83a8d..d81d87b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3560,12 +3560,9 @@ sub mimetype_guess_file {
 	open(my $mh, '<', $mimemap) or return undef;
 	while (<$mh>) {
 		next if m/^#/; # skip comments
-		my ($mimetype, $exts) = split(/\t+/);
-		if (defined $exts) {
-			my @exts = split(/\s+/, $exts);
-			foreach my $ext (@exts) {
-				$mimemap{$ext} = $mimetype;
-			}
+		my ($mimetype, @exts) = split(/\s+/);
+		foreach my $ext (@exts) {
+			$mimemap{$ext} = $mimetype;
 		}
 	}
 	close($mh);
-- 
1.7.3.4
