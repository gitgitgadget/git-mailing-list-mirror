From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 5/6] git_mkstemps_mode: don't set errno to EINVAL on exit.
Date: Mon, 22 Feb 2010 23:32:15 +0100
Message-ID: <1266877936-13537-6-git-send-email-Matthieu.Moy@imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: nhat minh le <nhat.minh.le@huoc.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 22 23:35:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njgs1-0001BR-In
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0BVWfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:35:11 -0500
Received: from mx2.imag.fr ([129.88.30.17]:52325 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab0BVWfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:35:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o1MMUBF2028154
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 23:30:11 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpM-0007kn-3l; Mon, 22 Feb 2010 23:32:32 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NjgpM-0003XT-2Y; Mon, 22 Feb 2010 23:32:32 +0100
X-Mailer: git-send-email 1.7.0.54.gb6a04.dirty
In-Reply-To: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Feb 2010 23:30:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o1MMUBF2028154
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1267482612.89632@zVjR90hXwg2Epd6tu4UPhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140726>

When reaching the end of git_mkstemps_mode, at least one call to open()
has been done, and errno has been set accordingly. Setting errno is
therefore not necessary, and actually harmfull since callers can't
distinguish e.g. permanent failure from ENOENT, which can just mean that
we need to create the containing directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 path.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/path.c b/path.c
index 925039a..6f44921 100644
--- a/path.c
+++ b/path.c
@@ -222,7 +222,6 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
 	}
 	/* We return the null string if we can't find a unique file name.  */
 	pattern[0] = '\0';
-	errno = EINVAL;
 	return -1;
 }
 
-- 
1.7.0.54.gb6a04.dirty
