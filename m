From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] fix testsuite to not use any hooks possibly provided by
	source
Date: Wed, 23 Sep 2009 20:30:28 +0200
Message-ID: <20090923183023.GA85456@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqWby-0005hY-1V
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 20:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179AbZIWSa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 14:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbZIWSa1
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 14:30:27 -0400
Received: from darksea.de ([83.133.111.250]:41417 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752962AbZIWSa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 14:30:27 -0400
Received: (qmail 3050 invoked from network); 23 Sep 2009 20:30:29 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Sep 2009 20:30:29 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128989>

This is useful if you are using the testsuite with local changes that
include activated default hooks suitable for your teams installation.
In some cases the pre-commit or other hooks can prevent the testsuite
from getting the expected result.

Currently all example hooks in the main git repository are deactivated
so it makes no difference when running the testsuite without any. In
case a future testcase wants to test a default hooks behavior it should
copy it locally.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
or would you say that we need hooks in the testsuite template?

 t/test-lib.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2ca536..446ab57 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -626,7 +626,7 @@ else
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
 fi
-GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
+GIT_TEMPLATE_DIR=$(pwd)/trash\ directory.templates
 unset GIT_CONFIG
 GIT_CONFIG_NOSYSTEM=1
 GIT_CONFIG_NOGLOBAL=1
@@ -638,6 +638,11 @@ test -d ../templates/blt || {
 	error "You haven't built things yet, have you?"
 }
 
+test -d "$GIT_TEMPLATE_DIR" || {
+	cp -r ../templates/blt "$GIT_TEMPLATE_DIR"
+	rm -f "$GIT_TEMPLATE_DIR"/hooks/*
+}
+
 if ! test -x ../test-chmtime; then
 	echo >&2 'You need to build test-chmtime:'
 	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
-- 
1.6.5.rc1.12.gc72fe
