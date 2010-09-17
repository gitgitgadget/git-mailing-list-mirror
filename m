From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] remote-helpers: build in platform independent directory
Date: Fri, 17 Sep 2010 18:17:56 +0200
Message-ID: <36e03068ded278b5145fdf82658c3270a25c2762.1284740217.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 18:17:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwddM-0000tq-IC
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab0IQQRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 12:17:52 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39319 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754596Ab0IQQRv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 12:17:51 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CBC611E2;
	Fri, 17 Sep 2010 12:17:50 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 17 Sep 2010 12:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=jVFxgaatkKLWULJZGyF7sp24Zps=; b=KV3M32xSy2gMazXXz6bnJ9FmjZ1yc6rM1x79bLADQXX1ILwWqiBFSvnuZb1FGegGklNNN4huvvHLwnr9RaXVIJMuNKKGx6MxkdhN8bPfHvfiM0RNJE3uhx5E7RCzkymhbm4VgKZ+kz1DYIHSJzT+u3yAssb8T3M4XtnjO36jfgY=
X-Sasl-enc: SfynpjMNrOtwUz5E8Zj9uAVUZ7QTA373M5bddd9ic+cz 1284740270
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C285408BE5;
	Fri, 17 Sep 2010 12:17:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156394>

The build directory which is used by distutils depends on the platform
(e.g. build/lib on Fedora 13, build/lib.linux-i686-2.6 on Ubuntu 9.04).
But test-lib.sh expects to find the build in build/lib which can cause
t5800-remote-helpers.sh to fail early.

Override distutils' choice so that the build is always in build/lib.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 git_remote_helpers/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
index 74b05dc..e8172d3 100644
--- a/git_remote_helpers/Makefile
+++ b/git_remote_helpers/Makefile
@@ -26,7 +26,7 @@ PYLIBDIR=$(shell $(PYTHON_PATH) -c \
 	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
 
 all: $(pysetupfile)
-	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build --build-purelib=build/lib --build-platlib=build/lib
 
 install: $(pysetupfile)
 	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
-- 
1.7.3.rc2.221.gbf93f
