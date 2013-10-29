From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 5/7] gitk: recognize -L option
Date: Tue, 29 Oct 2013 08:20:38 +0100
Message-ID: <41fc155e3b020e6aa899b97bc936e198865ff4f6.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cC-0006Ma-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091Ab3J2HVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:16 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56306 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982Ab3J2HVO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 383AB4D659D;
	Tue, 29 Oct 2013 08:21:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id bYRgEQ1lE5d7; Tue, 29 Oct 2013 08:21:02 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 93AFB4D65A5;
	Tue, 29 Oct 2013 08:21:00 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
In-Reply-To: <cover.1383031141.git.tr@thomasrast.ch>
References: <cover.1383031141.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236900>

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
 gitk-git/gitk | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5ece2a1..3679467 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
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
1.8.4.2.838.ga9a3e20
