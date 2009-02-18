From: Gerfried Fuchs <rhonda@deb.at>
Subject: [PATCH] git-svn: Allow using arguments to the editor.
Date: Wed, 18 Feb 2009 14:47:49 +0100
Message-ID: <1234964869-11159-1-git-send-email-rhonda@deb.at>
Cc: Gerfried Fuchs <rhonda@deb.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 15:12:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZn9f-0003LY-E8
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 15:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZBROKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 09:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbZBROKU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 09:10:20 -0500
Received: from mail.biedermanns.net ([213.133.100.49]:43516 "EHLO
	mail.biedermann.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890AbZBROKS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 09:10:18 -0500
X-Greylist: delayed 1340 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Feb 2009 09:10:18 EST
Received: from lmlo.sil.at ([213.235.212.193] helo=edna.deb.at)
	by mail.biedermann.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 #1 (Debian))
	id 1LZmmI-00069s-V5; Wed, 18 Feb 2009 14:47:57 +0100
Received: from rhonda by edna.deb.at with local (Exim 4.69)
	(envelope-from <rhonda@deb.at>)
	id 1LZmmD-0002ut-FO; Wed, 18 Feb 2009 14:47:49 +0100
X-Mailer: git-send-email 1.5.6.5
X-Spam-Score: -4.3 (----)
X-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110545>

When setting the EDITOR or VISUAL environment variable, one might want
to hand over arguments (like e.g. for not backgrounding a GUI editor but
waiting for it to finish. This patch enables that posibility, before it
did look for a program with the content of the variable, including the
space as filename part. The change is in sync with regular behavior with
various other tools, git itself included.

Signed-off-by: Gerfried Fuchs <rhonda@deb.at>
---
 git-svn.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 83cb36f..d29664c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1137,8 +1137,9 @@ sub get_commit_entry {
 
 	if ($_edit || ($type eq 'tree')) {
 		my $editor = $ENV{VISUAL} || $ENV{EDITOR} || 'vi';
+		my (@editor) = split /\s+/, $editor;
 		# TODO: strip out spaces, comments, like git-commit.sh
-		system($editor, $commit_editmsg);
+		system(@editor, $commit_editmsg);
 	}
 	rename $commit_editmsg, $commit_msg or croak $!;
 	{
-- 
1.5.6.5
