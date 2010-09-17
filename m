From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] remote-helpers: build in platform independent directory
Date: Fri, 17 Sep 2010 23:00:53 +0200
Message-ID: <705f70e3df519fc28e551b4c0bd7512277e7a190.1284757060.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 17 23:00:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owi3C-0003UD-Iq
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 23:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754211Ab0IQVAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 17:00:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:51083 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751561Ab0IQVAs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 17:00:48 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E91A63DA;
	Fri, 17 Sep 2010 17:00:47 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Sep 2010 17:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=QCsa3A0dS7cGQ8O3frrmEQuSHGk=; b=l0CqaoTTx+oGFtlPngr7h4JlLn8JTf75MOcyIOkwYvR5I//IGZLooqMcKlgrGZC1bKBCpPa9FQbpap9CPkNhXkngf8GWOwXCrLaFjCY/eX//+vUFEqdaZqKe/6WUeeBW905alVCzHmGBjs6+SNeJ+ps3vczCiNv7LpR4Z01zzKo=
X-Sasl-enc: NZIZOBBjQHb0ZHL4KfVsvRko5VuRuwzrK9gIz3ILlBCR 1284757247
Received: from localhost (p54858FBE.dip0.t-ipconnect.de [84.133.143.190])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3911A5E28D8;
	Fri, 17 Sep 2010 17:00:47 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc2.221.gbf93f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156412>

The build directory which is used by distutils depends on the platform
(e.g. build/lib on Fedora 13, build/lib.linux-i686-2.6 on Ubuntu 9.04).
But test-lib.sh expects to find the build in build/lib which can cause
t5800-remote-helpers.sh to fail early.

Override distutils' choice so that the build is always in build/lib.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Sorry for the v2 so soon. With the previous version, the "make install" step
would still possibly create a platform dependent build dir. This works but
creates two lib dirs within build, which is unnecessary and confusing.
The solution with setup.cfg avoids this and is cleaner anyways.

 git_remote_helpers/setup.cfg |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 create mode 100644 git_remote_helpers/setup.cfg

diff --git a/git_remote_helpers/setup.cfg b/git_remote_helpers/setup.cfg
new file mode 100644
index 0000000..4bff887
--- /dev/null
+++ b/git_remote_helpers/setup.cfg
@@ -0,0 +1,3 @@
+[build]
+build_purelib = build/lib
+build_platlib = build/lib
-- 
1.7.3.rc2.221.gbf93f
