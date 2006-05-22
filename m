From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Install git builtins into gitexecdir rather than bindir.
Date: Mon, 22 May 2006 00:42:59 -0400
Message-ID: <BAYC1-PASMTP07C5BAC47CC7E8CF750B26AE9A0@CEZ.ICE>
References: <BAYC1-PASMTP09B22AA86724B4F2C01F7FAE9A0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon May 22 06:49:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi2Lg-0001Y4-DK
	for gcvg-git@gmane.org; Mon, 22 May 2006 06:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWEVEsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 00:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWEVEsx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 00:48:53 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:27062 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1750913AbWEVEsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 00:48:53 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 21 May 2006 21:52:10 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 82024644C28
	for <git@vger.kernel.org>; Mon, 22 May 2006 00:48:51 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060522004259.3e86718e.seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP09B22AA86724B4F2C01F7FAE9A0@CEZ.ICE>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 May 2006 04:52:10.0328 (UTC) FILETIME=[7C0BC580:01C67D5B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Moving "git-cmd" commands out of the path and into a special
git exec path, should include the builtins.
---
 Makefile |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index d171829..d9b9671 100644
--- a/Makefile
+++ b/Makefile
@@ -628,7 +628,8 @@ install: all
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
 	$(INSTALL) $(PYMODULES) '$(DESTDIR_SQ)$(GIT_PYTHON_DIR_SQ)'
-	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(bindir_SQ)/$p' && ln '$(DESTDIR_SQ)$(bindir_SQ)/git$X' '$(DESTDIR_SQ)$(bindir_SQ)/$p' ;)
+	ln -f '$(DESTDIR_SQ)$(bindir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' || cp '$(DESTDIR_SQ)$(bindir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X'
+	$(foreach p,$(BUILT_INS), rm -f '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' && ln '$(DESTDIR_SQ)$(gitexecdir_SQ)/git$X' '$(DESTDIR_SQ)$(gitexecdir_SQ)/$p' ;)
 
 install-doc:
 	$(MAKE) -C Documentation install
-- 
1.3.3.ge95c
