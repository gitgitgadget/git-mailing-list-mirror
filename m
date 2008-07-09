From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH 1/4] git-imap-send: Allow the program to be run from subdirectories of a git tree.
Date: Wed,  9 Jul 2008 22:28:59 +0100
Message-ID: <1215638942-25010-1-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhEt-0003Jo-Bc
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYGIV3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbYGIV3Q
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:29:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:51715 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbYGIV3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:29:15 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1632635fkq.5
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YXD6Xc3VxFJWy6LkHdNnMAPFFyvFyhSV6Ug1rQdsS2Y=;
        b=jFodzMEN/7YsySAGVPJ0XP6c0QuXfUQWKn6g0nxersBNTmDj/+UtjK6KgUkmM7mfmy
         axmMqonAbenol2/Q26jGnJTd+KOBjOkteXJvImOAJBoIKf6GKQ7tRicxVgFckQz6ICiE
         /JzqETig09/lhBeoCFJvrTackF1Q3ytPjOs9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ikup+vuSo/6ySGLfHUmm/5w0M55P4VWCimX550VS99h+FeQsYxiLC5qemhkeEwD4N8
         yHjq27VEYI0M/085xzbruUrFT7eNdH52fQ7VGi6wugg+P6qWcMxnLim11bLaY55W0Q/h
         Wm6vu9WcxAnUtJ02iVo9QG8nYdfluC6SiYW9Q=
Received: by 10.125.100.8 with SMTP id c8mr2182130mkm.157.1215638953898;
        Wed, 09 Jul 2008 14:29:13 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id 30sm5779287hue.55.2008.07.09.14.29.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 14:29:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87916>

Call setup_git_directory_gently to allow git-imap-send to be used from subdirectories of a git tree.

Signed-off-by: Robert Shearman <robertshearman@gmail.com>
---
 imap-send.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 1ec1310..24d76a7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1292,10 +1292,12 @@ main(int argc, char **argv)
 	int ofs = 0;
 	int r;
 	int total, n = 0;
+	int nongit_ok;
 
 	/* init the random number generator */
 	arc4_init();
 
+	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, NULL);
 
 	if (!imap_folder) {
-- 
1.5.6.2.224.g26efb.dirty
