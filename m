From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Makefile uses installed commit-id
Date: Tue, 19 Apr 2005 13:28:38 -0400
Message-ID: <1113931718.3793.8.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 19 19:25:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNwSs-0004I9-Ov
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 19:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbVDSR2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVDSR2x
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 13:28:53 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:14535 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261360AbVDSR2p
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 13:28:45 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1DNwWZ-0003hF-Pj
	for git@vger.kernel.org; Tue, 19 Apr 2005 13:28:37 -0400
Received: from proski by dv.roinet.com with local (Exim 3.36 #1 (Debian))
	id 1DNwWd-0007Nv-00
	for <git@vger.kernel.org>; Tue, 19 Apr 2005 13:28:39 -0400
To: git <git@vger.kernel.org>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello!

Current git-pasky cannot be compiled properly unless it's already
installed.  The rule for creating gitversion.sh requires commit-id in
the PATH, which won't be there until "make install" is run.

Also, commit-id runs gitXnormid.sh, which in turn runs cat-file.  All of
them should be from the current directory to avoid the requirement that
git is installed before gitversion.sh is generated.

This patch adds "." to PATH when running commit-id.  The patch is
against current git-pasky.

Signed-off-by: Pavel Roskin <proski@gnu.org>

--- a/Makefile
+++ b/Makefile
@@ -46,11 +46,11 @@ $(LIB_FILE): $(LIB_OBJS)
 
 %.o: $(LIB_H)
 
-gitversion.sh: $(VERSION)
+gitversion.sh: $(VERSION) commit-id
 	@echo Generating gitversion.sh...
 	@rm -f $@
 	@echo "#!/bin/sh" > $@
-	@echo "echo \"$(shell cat $(VERSION)) ($(shell commit-id))\"" >> $@
+	@echo "echo \"$(shell cat $(VERSION)) ($(shell PATH=.:$$PATH ./commit-id))\"" >> $@
 	@chmod +x $@
 
 install: $(PROG) $(GEN_SCRIPT)


-- 
Regards,
Pavel Roskin


