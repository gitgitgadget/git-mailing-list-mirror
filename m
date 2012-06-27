From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/5] git-remote-mediawiki: don't compute the diff when getting commit message
Date: Wed, 27 Jun 2012 11:10:16 +0200
Message-ID: <1340788220-10084-2-git-send-email-Matthieu.Moy@imag.fr>
References: <1340726673-25496-1-git-send-email-Matthieu.Moy@imag.fr>
 <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Pavel.Volek@ensimag.imag.fr, Kim-Thuat.Nguyen@ensimag.imag.fr,
	roucherj@ensimag.imag.fr, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 27 11:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjoIh-0007sT-5d
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 11:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab2F0JMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 05:12:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:50980 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab2F0JKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 05:10:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5R99tnj020027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Jun 2012 11:09:55 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGg-0003O2-0C; Wed, 27 Jun 2012 11:10:34 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SjoGf-0002df-VH; Wed, 27 Jun 2012 11:10:33 +0200
X-Mailer: git-send-email 1.7.11.5.g0c7e058.dirty
In-Reply-To: <1340788220-10084-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 27 Jun 2012 11:09:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5R99tnj020027
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1341392996.09879@65tzyu1B6AG2z9ewFz1n1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200710>

While we're there, simplify the code a bit: since log --format=%s anyway
shows the subject line as a single line, no need to split to take the
first line.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/mw-to-git/git-remote-mediawiki | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki b/contrib/mw-to-git/git-remote-mediawiki
index a34f53f..781dfe2 100755
--- a/contrib/mw-to-git/git-remote-mediawiki
+++ b/contrib/mw-to-git/git-remote-mediawiki
@@ -873,8 +873,8 @@ sub mw_push_revision {
 		# TODO: we could detect rename, and encode them with a #redirect on the wiki.
 		# TODO: for now, it's just a delete+add
 		my @diff_info_list = split(/\0/, $diff_infos);
-		# Keep the first line of the commit message as mediawiki comment for the revision
-		my $commit_msg = (split(/\n/, run_git("show --pretty=format:\"%s\" $sha1_commit")))[0];
+		# Keep the subject line of the commit message as mediawiki comment for the revision
+		my $commit_msg = run_git("log --no-walk --format=\"%s\" $sha1_commit");
 		chomp($commit_msg);
 		# Push every blob
 		while (@diff_info_list) {
-- 
1.7.11.5.g0c7e058.dirty
