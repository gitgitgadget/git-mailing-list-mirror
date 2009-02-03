From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 7/8] Tests: let --valgrind imply --verbose and --tee
Date: Wed, 4 Feb 2009 00:26:26 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902040026250.9822@pacific.mpi-cbg.de>
References: <cover.1233702893u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 00:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUUfz-0007K0-BR
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZBCXZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbZBCXZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 18:25:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:38131 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752826AbZBCXZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 18:25:54 -0500
Received: (qmail invoked by alias); 03 Feb 2009 23:25:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp010) with SMTP; 04 Feb 2009 00:25:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19U+LwCFLlUaB7odEqgkte0161k3uX5c2Al09841T
	2ftH/mVKJZdWdm
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1233702893u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108271>

It does not make much sense to run the (expensive) valgrind tests and
not look at the output.

To prevent output from scrolling out of reach, the parameter --tee is
implied, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile    |    2 +-
 t/README      |    4 ++++
 t/test-lib.sh |    4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index e544493..0962341 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -39,6 +39,6 @@ full-svn-test:
 	$(MAKE) $(TSVN) GIT_SVN_NO_OPTIMIZE_COMMITS=0 LC_ALL=en_US.UTF-8
 
 valgrind:
-	GIT_TEST_OPTS='--valgrind -v --tee' $(MAKE) -k
+	GIT_TEST_OPTS=--valgrind $(MAKE)
 
 .PHONY: pre-clean $(T) aggregate-results clean valgrind
diff --git a/t/README b/t/README
index ed1ebb6..d8f6c7d 100644
--- a/t/README
+++ b/t/README
@@ -65,6 +65,10 @@ appropriately before running "make".
 	the test script when running under -i).  Valgrind errors
 	go to stderr, so you might want to pass the -v option, too.
 
+	Since it makes no sense to run the tests with --valgrind and
+	not see any output, this option implies --verbose.  For
+	convenience, it also implies --tee.
+
 --tee::
 	In addition to printing the test output to the terminal,
 	write it to files named 't/test-results/$TEST_NAME.out'.
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2fb2274..495d55d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -9,7 +9,7 @@ case "$GIT_TEST_TEE_STARTED, $* " in
 done,*)
 	# do not redirect again
 	;;
-*' --tee '*)
+*' --tee '*|*' --va'*)
 	mkdir -p test-results
 	BASE=test-results/$(basename "$0" .sh)
 	(GIT_TEST_TEE_STARTED=done ${SHELL-sh} "$0" "$@" 2>&1;
@@ -111,7 +111,7 @@ do
 		# noop now...
 		shift ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
-		valgrind=t; shift ;;
+		valgrind=t; verbose=t; shift ;;
 	--tee)
 		shift ;; # was handled already
 	*)
-- 
1.6.1.2.582.g3fdd5
