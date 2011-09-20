From: Alexey Shumkin <zapped@mail.ru>
Subject: [PATCH] post-receive-email: explicitly set Content-Type header
Date: Tue, 20 Sep 2011 11:52:34 +0400
Message-ID: <1316505154-3904-1-git-send-email-zapped@mail.ru>
Cc: Junio C Hamano <gitster@pobox.com>, Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 09:52:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5v8T-0000Gz-2N
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 09:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab1ITHww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 03:52:52 -0400
Received: from smtp10.mail.ru ([94.100.176.152]:41383 "EHLO smtp10.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab1ITHww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 03:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:Message-Id:Date:Subject:Cc:To:From; bh=1xPmNDWIR9rGI9FV0IxMvmNhve0HZiUJAreUK7w3aHY=;
	b=lfROIqQYEoa/x4e7o39zJiycUDJgYgTbwRw6foDHrNEWn3QHHhy23R4SpR4IOsxHpmHFxCI8r0YjnJjBcmmZxi+6Uq4UR6sPAl8qdZzLCwuLGwW1w9PKrRdLky/vPoUP;
Received: from [91.77.19.104] (port=13316 helo=zappedws)
	by smtp10.mail.ru with asmtp 
	id 1R5v8L-00005S-00; Tue, 20 Sep 2011 11:52:49 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R5v8H-00011d-BX; Tue, 20 Sep 2011 11:52:45 +0400
X-Mailer: git-send-email 1.7.6.3.4.gf71f
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181737>

Some email clients (e.g. claws-mail) incorrectly display
message body when there is no Content-Type header and charset
explicitly defined.
So, set explicitly Content-Type headrer and charset
can be defined with hooks.emailcharset config variable.

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 contrib/hooks/post-receive-email |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 21989fc..64d7c2f 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -60,6 +60,8 @@
 #   email body. If not specified, there is no limit.
 #   Lines beyond the limit are suppressed and counted, and a final
 #   line is added indicating the number of suppressed lines.
+# hooks.emailcharset
+#   The charset used in Content-Type header. UTF-8, if not specified.
 #
 # Notes
 # -----
@@ -229,6 +231,7 @@ generate_email_header()
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
+	Content-Type: text/plain; charset=$emailcharset
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
@@ -723,6 +726,7 @@ envelopesender=$(git config hooks.envelopesender)
 emailprefix=$(git config hooks.emailprefix || echo '[SCM] ')
 custom_showrev=$(git config hooks.showrev)
 maxlines=$(git config hooks.emailmaxlines)
+emailcharset=$(git config hooks.emailcharset || echo 'UTF-8')
 
 # --- Main loop
 # Allow dual mode: run from the command line just like the update hook, or
-- 
1.7.6.3.4.gf71f
