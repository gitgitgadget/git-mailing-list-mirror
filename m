From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH gitk 4/4] gitk: recognize -L option
Date: Sun, 9 Jun 2013 21:44:15 +0200
Message-ID: <a9d0af8f1266cad6edcabd4d8a54ef5d2bb87ab4.1370806329.git.trast@inf.ethz.ch>
References: <cover.1370806329.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllXY-0003Xs-QA
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab3FIToW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:44:22 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:41722 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214Ab3FIToV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:44:21 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:02 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 9 Jun
 2013 21:44:16 +0200
X-Mailer: git-send-email 1.8.3.496.g0d0267b
In-Reply-To: <cover.1370806329.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227152>

This gives line-log support to gitk, by exploiting the new support for
processing and showing "inline" diffs straight from the git-log
output.

Note that we 'set allknown 0', which is a bit counterintuitive since
this is a "known" option.  But that flag prevents gitk from thinking
it can optimize the view by running rev-list to see the topology; in
the -L case that doesn't work.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 gitk | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gitk b/gitk
index 3715136..30474be 100755
--- a/gitk
+++ b/gitk
@@ -235,6 +235,14 @@ proc parseviewargs {n arglist} {
 		set filtered 1
 		lappend glflags $arg
 	    }
+	    "-L*" {
+		# Line-diff: filtered, and diffs must be read as part
+		# of the log output
+		set filtered 1
+		set vinlinediff($n) 1
+		set allknown 0
+		lappend glflags $arg
+	    }
 	    "-n" {
 		# This appears to be the only one that has a value as a
 		# separate word following it
-- 
1.8.3.496.g0d0267b
