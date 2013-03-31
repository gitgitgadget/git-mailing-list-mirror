From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 3/3] tests --valgrind: provide a mode without --track-origins
Date: Sun, 31 Mar 2013 10:00:17 +0200
Message-ID: <560f4d3cedf1cf32331f864bae94124c02495c06.1364716452.git.trast@inf.ethz.ch>
References: <cover.1364716452.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 31 10:01:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMDCK-0005Pt-Gi
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 10:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab3CaIAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 04:00:37 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:15925 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543Ab3CaIAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 04:00:36 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:34 +0200
Received: from linux-k42r.v.cablecom.net (213.55.184.251) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 31 Mar
 2013 10:00:34 +0200
X-Mailer: git-send-email 1.8.2.467.gedf93a5
In-Reply-To: <cover.1364716452.git.trast@inf.ethz.ch>
X-Originating-IP: [213.55.184.251]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219606>

From: Thomas Rast <trast@inf.ethz.ch>

With --valgrind=memcheck-fast, the tests run under memcheck but
without the autodetected --track-origins.  If you just run valgrind to
see *if* there is any memory issue with your program, the extra
information is not needed, and it comes at a roughly 30% hit in
runtime.

While it is possible to achieve the same through GIT_VALGRIND_OPTIONS,
this should be more discoverable and hopefully encourage more users to
run their tests with valgrind.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 t/README               | 5 +++++
 t/valgrind/valgrind.sh | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/t/README b/t/README
index f5ee40f..9b41fe7 100644
--- a/t/README
+++ b/t/README
@@ -106,6 +106,11 @@ appropriately before running "make".
 	'drd', but you may use any tool recognized by your valgrind
 	installation.
 
+	As a special case, <tool> can be 'memcheck-fast', which uses
+	memcheck but disables --track-origins.  Use this if you are
+	running tests in bulk, to see if there are _any_ memory
+	issues.
+
 	Note that memcheck is run with the option --leak-check=no,
 	as the git process is short-lived and some errors are not
 	interesting. In order to run a single command under the same
diff --git a/t/valgrind/valgrind.sh b/t/valgrind/valgrind.sh
index 472ac2d..6b87c91 100755
--- a/t/valgrind/valgrind.sh
+++ b/t/valgrind/valgrind.sh
@@ -5,6 +5,8 @@ base=$(basename "$0")
 TOOL_OPTIONS='--leak-check=no'
 
 case "$GIT_VALGRIND_MODE" in
+memcheck-fast)
+	;;
 memcheck)
 	VALGRIND_VERSION=$(valgrind --version)
 	VALGRIND_MAJOR=$(expr "$VALGRIND_VERSION" : '[^0-9]*\([0-9]*\)')
-- 
1.8.2.467.gedf93a5
