From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 gitk 5/5] gitk: recognize -L option
Date: Sat, 16 Nov 2013 18:37:44 +0100
Message-ID: <8b7580c42027f5a542c0afe8c9f3109a166841be.1384622392.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622392.git.tr@thomasrast.ch>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjp1-0007Pl-I1
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584Ab3KPRiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:07 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38489 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab3KPRiC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 43E8A4D65B3;
	Sat, 16 Nov 2013 18:38:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uRCPpg5SBqDT; Sat, 16 Nov 2013 18:37:56 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 687FD4D6570;
	Sat, 16 Nov 2013 18:37:54 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622392.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237934>

From: Thomas Rast <trast@inf.ethz.ch>

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
index 5ece2a1..3679467 100755
--- a/gitk
+++ b/gitk
@@ -235,6 +235,14 @@ proc parseviewargs {n arglist} {
 		set filtered 1
 		lappend glflags $arg
 	    }
+	    "-L*" {
+		# Line-log with 'sticked' argument (unsticked form is
+		# not supported)
+		set filtered 1
+		set vinlinediff($n) 1
+		set allknown 0
+		lappend glflags $arg
+	    }
 	    "-n" {
 		# This appears to be the only one that has a value as a
 		# separate word following it
-- 
1.8.5.rc2.348.gb73b695
