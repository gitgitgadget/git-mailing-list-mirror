From: Ludwig Nussel <ludwig.nussel@suse.de>
Subject: [PATCH v2] gitweb: allow space as delimiter in mime.types
Date: Wed, 15 Jun 2011 08:10:08 +0200
Message-ID: <1308118208-30845-1-git-send-email-ludwig.nussel@suse.de>
References: <7v62o8ksq5.fsf@alter.siamese.dyndns.org>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 15 08:10:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWjIv-0004zT-7J
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 08:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1FOGKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 02:10:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:47330 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410Ab1FOGKL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 02:10:11 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 3A1F690847
	for <git@vger.kernel.org>; Wed, 15 Jun 2011 08:10:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <7v62o8ksq5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175808>

in openSUSE /etc/mime.types has only spaces. I don't know if there's
a canonical reference that says that only tabs are allowed. Mutt at
least also accepts spaces. So make gitweb more liberal too.

Signed-off-by: Ludwig Nussel <ludwig.nussel@suse.de>
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
