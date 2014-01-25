From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] Makefile: remove redundant object in git-http{fetch,push}
Date: Sat, 25 Jan 2014 13:11:44 +0000
Message-ID: <9f32a674457f4016136fa4e214921e00a31032bd.1390655504.git.john@keeping.me.uk>
Cc: John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 25 14:12:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7321-00043R-1X
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 14:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbaAYNMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jan 2014 08:12:13 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:57808 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbaAYNMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jan 2014 08:12:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 954DA19805D;
	Sat, 25 Jan 2014 13:12:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qX8AJqJNrkOp; Sat, 25 Jan 2014 13:12:11 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 4F89619805C;
	Sat, 25 Jan 2014 13:12:11 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 482BE161E3A8;
	Sat, 25 Jan 2014 13:12:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGIMyBTRhsdh; Sat, 25 Jan 2014 13:12:10 +0000 (GMT)
Received: from river.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id DE866161E1A5;
	Sat, 25 Jan 2014 13:12:07 +0000 (GMT)
X-Mailer: git-send-email 1.9.rc0.187.g6292fff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241067>

revision.o is included in libgit.a which is in $(GITLIBS), so we don't
need to include is separately.  This fixes compilation with
"-fwhole-program" which otherwise fails with messages like this:

  libgit.a(revision.o): In function `mark_tree_uninteresting':
  /home/john/src/git/revision.c:108: multiple definition of `mark_tree_uninteresting'
  /tmp/ccKQRkZV.ltrans2.ltrans.o:/home/john/src/git/revision.c:108: first defined here

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b4af1e2..b3a408d 100644
--- a/Makefile
+++ b/Makefile
@@ -2050,10 +2050,10 @@ git-imap-send$X: imap-send.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-git-http-fetch$X: revision.o http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL)
-git-http-push$X: revision.o http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
-- 
1.9.rc0.187.g6292fff
