From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] Makefile: add a target which will abort compilation with
 ancient shells
Date: Thu, 07 Aug 2008 14:06:26 -0500
Message-ID: <S1hQNVU9hvkXWOErhlMRjqFKaCUFasuIfMwjO4N7QOvu1ddz9cU6_w@cipher.nrlssc.navy.mil>
References: <BUkcoxp99ASidQD8sGQ9PR7w1MT6DXx-6v_djYMHRBKTs_wNXEO3hw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 21:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRAq9-0005gw-EU
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 21:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYHGTGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 15:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbYHGTGh
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 15:06:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34823 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206AbYHGTGg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 15:06:36 -0400
Received: by mail.nrlssc.navy.mil id m77J6Q7l021412; Thu, 7 Aug 2008 14:06:26 -0500
In-Reply-To: <BUkcoxp99ASidQD8sGQ9PR7w1MT6DXx-6v_djYMHRBKTs_wNXEO3hw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Aug 2008 19:06:27.0240 (UTC) FILETIME=[B151DA80:01C8F8C0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91599>

This adds a make target which can be used to try to execute certain shell
constructs which are required for compiling and running git.

This patch provides a test for the $() notation for command substition
which is used in the Makefile and extensively in the git scripts.

The make target is named in such a way as to be a hint to the user that
SHELL_PATH should be set to an appropriate shell. If the shell command
fails, the user should receive a message similar to the following:

make: *** [please_set_SHELL_PATH_to_a_more_modern_shell] Error 2

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Johannes Schindelin wrote:
> Maybe we can even have some sanity check that tests if SHELL_PATH groks 
> $()?

how about this?

-brandon


 Makefile |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 61fc86d..90c5a13 100644
--- a/Makefile
+++ b/Makefile
@@ -1062,7 +1062,7 @@ export TAR INSTALL DESTDIR SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-all:: $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: shell_compatibility_test $(ALL_PROGRAMS) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), $(RM) '$p';)
 endif
@@ -1075,6 +1075,11 @@ endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
+please_set_SHELL_PATH_to_a_more_modern_shell:
+	@$$(:)
+
+shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
+
 strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
@@ -1457,6 +1462,7 @@ endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
 
 .PHONY: all install clean strip
+.PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: .FORCE-GIT-VERSION-FILE TAGS tags cscope .FORCE-GIT-CFLAGS
 .PHONY: .FORCE-GIT-BUILD-OPTIONS
 
-- 
1.5.6.2
