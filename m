From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 09:47:03 +0200
Message-ID: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 09:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5D62-000259-MX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 09:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab0JKHqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 03:46:51 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47624 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751193Ab0JKHqu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 03:46:50 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AA33E355;
	Mon, 11 Oct 2010 03:46:49 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 11 Oct 2010 03:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=235uomIUMJvGHRqYalAFCzPsyl8=; b=k5pS+hwYuKoBXDZgeNAJmsyqjkncJ3E3zFTM3hCS64QonaFiPdNSC4xFx1Q1CiFZ4snYD1ebvDOhqI0I/LMv+9OKciSV/nVX60NWzuK5vCqkVpPo2CMgAt6Nawas7LV3w2LicQm3KB4M/Uthl0xEBAeDKI6o4gd4LQmtMdpsQRA=
X-Sasl-enc: X7uJ4Tc0c3GStp0oxeSDgOMzhSsjrlXrFtTG5PR9knp/ 1286783209
Received: from localhost (p54859006.dip0.t-ipconnect.de [84.133.144.6])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F1F9840251A;
	Mon, 11 Oct 2010 03:46:48 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.1.184.g5b1fd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158752>

For most software packages, untar-autoconf/make configure-configure-make
is the preferred way to build the package; not so for Git. But the
presence of the make target makes people believe so.

Try and make people use "make configure" only when they are sure they
need to.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
    This does not help with people running autoconf themselves, of course.
    But we keep answering questions about failed configure attempts.
    
    On an annecdotical note: When I decided to switch to a dvcs, I failed building
    Git (with configure) and tried out hg instead. Imagine!

 Makefile |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 1f1ce04..430c096 100644
--- a/Makefile
+++ b/Makefile
@@ -1744,11 +1744,18 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
 endif # NO_PYTHON
 
 configure: configure.ac
+ifdef USEAUTOCONF
 	$(QUIET_GEN)$(RM) $@ $<+ && \
 	sed -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    $< > $<+ && \
 	autoconf -o $@ $<+ && \
 	$(RM) $<+
+else
+	@echo "Using the Makefile and defining variables in config.mak is the"
+	@echo "preferred way of building Git. Please use"
+	@echo "USEAUTOCONF=1 make configure"
+	@echo "if you are really sure you need configure."
+endif
 
 # These can record GIT_VERSION
 git.o git.spec \
-- 
1.7.3.1.184.g5b1fd
