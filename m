From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH compatibility
Date: Mon, 11 Mar 2013 13:21:27 +0100
Message-ID: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 11 13:22:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF1jr-0006EG-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 13:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939Ab3CKMVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 08:21:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41250 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753751Ab3CKMVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 08:21:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2BCLRpu002459
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 13:21:27 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UF1jM-0003Jo-JG; Mon, 11 Mar 2013 13:21:28 +0100
Received: from moy by anie with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1UF1jM-0000Ch-Fh; Mon, 11 Mar 2013 13:21:28 +0100
X-Mailer: git-send-email 1.8.2.rc3.16.g0a33571.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 13:21:27 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BCLRpu002459
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1363609290.22665@u8o+b5zm35fA3teWiTxJjQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217871>

The function-wide redirection used for __git_ls_files_helper and
__git_diff_index_helper work only with bash. Using ZSH, trying to
complete an inexistant directory gave this:

  git add no-such-dir/__git_ls_files_helper:cd:2: no such file or directory: no-such-dir/

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
These two instances seem to be the only ones in the file.

I'm not sure whether the 2>/dev/null would be needed for the command
on the RHS of the && too (git ls-files and git diff-index).

 contrib/completion/git-completion.bash | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b62bec0..0640274 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -300,8 +300,8 @@ __git_index_file_list_filter ()
 __git_ls_files_helper ()
 {
 	# NOTE: $2 is not quoted in order to support multiple options
-	cd "$1" && git ls-files --exclude-standard $2
-} 2>/dev/null
+	cd "$1" 2>/dev/null && git ls-files --exclude-standard $2
+}
 
 
 # Execute git diff-index, returning paths relative to the directory
@@ -309,8 +309,8 @@ __git_ls_files_helper ()
 # specified in the second argument.
 __git_diff_index_helper ()
 {
-	cd "$1" && git diff-index --name-only --relative "$2"
-} 2>/dev/null
+	cd "$1" 2>/dev/null && git diff-index --name-only --relative "$2"
+}
 
 # __git_index_files accepts 1 or 2 arguments:
 # 1: Options to pass to ls-files (required).
-- 
1.8.2.rc3.16.g0a33571.dirty
