From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 1/3] commit-tree: use prefixcmp instead of memcmp(..., N)
Date: Sat, 16 Nov 2013 18:37:55 +0100
Message-ID: <7f7d8c9e211b1eb37fbfd558813fbf2828ef9921.1384622379.git.tr@thomasrast.ch>
References: <874n7ywpnd.fsf@thomasrast.ch> <cover.1384622379.git.tr@thomasrast.ch>
Cc: Paul Mackerras <paulus@samba.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 18:38:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhjp2-0007Pl-Ty
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 18:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682Ab3KPRiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 12:38:14 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:38506 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048Ab3KPRiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 12:38:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id AF7F64D6570;
	Sat, 16 Nov 2013 18:38:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RNWF4i-ZiyKd; Sat, 16 Nov 2013 18:38:01 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 9EB714D65AA;
	Sat, 16 Nov 2013 18:38:00 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc2.348.gb73b695
In-Reply-To: <cover.1384622379.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237935>

Handrolling the prefix comparison is harder to read and overruns if
the argument is an empty string.  Use our prefixcmp() instead.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 builtin/commit-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index f641ff2..19d58f9 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -61,7 +61,7 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!memcmp(arg, "-S", 2)) {
+		if (!prefixcmp(arg, "-S")) {
 			sign_commit = arg + 2;
 			continue;
 		}
-- 
1.8.5.rc2.348.gb73b695
