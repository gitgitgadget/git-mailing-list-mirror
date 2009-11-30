From: Jeff King <peff@peff.net>
Subject: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 02:52:21 -0500
Message-ID: <20091130075221.GA5421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF13b-0007TB-NK
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZK3HwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZK3HwP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:52:15 -0500
Received: from peff.net ([208.65.91.99]:40100 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbZK3HwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:52:14 -0500
Received: (qmail 10392 invoked by uid 107); 30 Nov 2009 07:56:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 30 Nov 2009 02:56:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Nov 2009 02:52:21 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134072>

Without this, test-lib checks that the git_remote_helpers
directory has been built. However, if we are building
without python, we will not have done anything at all in
that directory, and test-lib's sanity check will fail.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of sr/vcs-helper.

This feels a little funny for NO_PYTHON to mean "no remote helpers at
all". But that is the way the Makefile is set up, since we seem to have
only python helpers.

 Makefile      |    1 +
 t/test-lib.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 42744a4..443565e 100644
--- a/Makefile
+++ b/Makefile
@@ -1743,6 +1743,7 @@ GIT-BUILD-OPTIONS: .FORCE-GIT-BUILD-OPTIONS
 	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@
 	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
+	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 
 ### Detect Tck/Tk interpreter path changes
 ifndef NO_TCLTK
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a40520..ca0839c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -638,7 +638,7 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
-if test -z "$GIT_TEST_INSTALLED"
+if test -z "$GIT_TEST_INSTALLED" && test -z "$NO_PYTHON"
 then
 	GITPYTHONLIB="$(pwd)/../git_remote_helpers/build/lib"
 	export GITPYTHONLIB
-- 
1.6.6.rc0.327.gd49b
