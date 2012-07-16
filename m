From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/8] git-remote-mediawiki: actually send empty comment when they're empty
Date: Mon, 16 Jul 2012 14:00:47 +0200
Message-ID: <1342440053-3058-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jul 16 14:01:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqjzP-0006BN-AE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 14:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab2GPMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 08:01:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50855 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab2GPMBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 08:01:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GBxJ9M011275
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 13:59:19 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz9-0002V4-Ls; Mon, 16 Jul 2012 14:01:07 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Sqjz9-0000oH-Jw; Mon, 16 Jul 2012 14:01:07 +0200
X-Mailer: git-send-email 1.7.11.1.30.g7e1baf9.dirty
In-Reply-To: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 13:59:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GBxJ9M011275
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343044762.45621@9xu67oFnc3ocKp/eDGl13Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201503>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a6ad8cf..a2da52f 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -51,6 +51,9 @@ use constant EMPTY_CONTENT => "<!-- empty page -->\n";
 # used to reflect file creation or deletion in diff.
 use constant NULL_SHA1 => "0000000000000000000000000000000000000000";
 
+# Used on Git's side to reflect empty edit messages on the wiki
+use constant EMPTY_MESSAGE => '*Empty MediaWiki Message*';
+
 my $remotename = $ARGV[0];
 my $url = $ARGV[1];
 
@@ -935,7 +938,7 @@ sub mw_import_revids {
 
 		my %commit;
 		$commit{author} = $rev->{user} || 'Anonymous';
-		$commit{comment} = $rev->{comment} || '*Empty MediaWiki Message*';
+		$commit{comment} = $rev->{comment} || EMPTY_MESSAGE;
 		$commit{title} = mediawiki_smudge_filename($page_title);
 		$commit{mw_revision} = $rev->{revid};
 		$commit{content} = mediawiki_smudge($rev->{'*'});
@@ -1050,6 +1053,10 @@ sub mw_push_file {
 	my $oldrevid = shift;
 	my $newrevid;
 
+	if ($summary eq EMPTY_MESSAGE) {
+		$summary = '';
+	}
+
 	my $new_sha1 = $diff_info_split[3];
 	my $old_sha1 = $diff_info_split[2];
 	my $page_created = ($old_sha1 eq NULL_SHA1);
-- 
1.7.11.1.30.g7e1baf9.dirty
