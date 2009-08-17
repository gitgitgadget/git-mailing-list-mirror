From: Johan Herland <johan@herland.net>
Subject: [RFCv4 6/5] Fix the Makefile-generated path to the git_remote_cvs
 package in git-remote-cvs
Date: Mon, 17 Aug 2009 18:27:34 +0200
Message-ID: <200908171827.34370.johan@herland.net>
References: <1250480161-21933-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Johannes.Schindelin@gmx.de, barkalow@iabervon.org,
	davvid@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 18:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md53g-0000vh-5a
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbZHQQ1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbZHQQ1g
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:27:36 -0400
Received: from smtp.getmail.no ([84.208.15.66]:45618 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751051AbZHQQ1f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:27:35 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOJ00KUR4DZRDB0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 18:27:35 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOJ00FQY4DY3U70@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 18:27:35 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.8.17.161516
User-Agent: KMail/1.12.0 (Linux/2.6.30-ARCH; KDE/4.3.0; x86_64; ; )
In-reply-to: <1250480161-21933-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126219>

Junio discovered that the installed git-remote-cvs executable is unable
to find the installed git_remote_cvs Python package. This is due to the
'instlibdir' target of git_remote_cvs/Makefile being invoked with
insufficient arguments (prefix and DESTDIR). This patch fixes that.

Signed-off-by: Johan Herland <johan@herland.net>
---

Sorry for the inconvenience.

...Johan


 Makefile                |    2 +-
 git_remote_cvs/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b2af678..b9a7f25 100644
--- a/Makefile
+++ b/Makefile
@@ -1479,7 +1479,7 @@ endif # NO_PERL
 ifndef NO_PYTHON
 $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s --no-print-directory instlibdir` && \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_cvs -s --no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' instlibdir` && \
 	sed -e '1{' \
 	    -e '	s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e '}' \
diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
index 061c247..0d9eb31 100644
--- a/git_remote_cvs/Makefile
+++ b/git_remote_cvs/Makefile
@@ -28,7 +28,7 @@ install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
 
 instlibdir: $(pysetupfile)
-	@echo "$(prefix)/$(PYLIBDIR)"
+	@echo "$(DESTDIR_SQ)$(prefix)/$(PYLIBDIR)"
 
 clean:
 	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
-- 
1.6.4.313.g38b9.dirty


-- 
Johan Herland, <johan@herland.net>
www.herland.net
