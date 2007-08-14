From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Add read_cache to builtin-check-attr
Date: Tue, 14 Aug 2007 08:18:38 -0500
Message-ID: <11870975181798-git-send-email-bdowning@lavos.net>
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Steffen Prohaska <prohaska@zib.de>, dmitry.kakurin@gmail.com,
	git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 15:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKwIG-0003XD-0O
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 15:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbXHNNSj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Aug 2007 09:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXHNNSi
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 09:18:38 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:14946 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbXHNNSh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 09:18:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtZjAN9IwUZKhvbzRmdsb2JhbACBVIUlhxUBAQE1AZs/
X-IronPort-AV: E=Sophos;i="4.19,259,1183348800"; 
   d="scan'208";a="64653798"
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 14 Aug 2007 09:18:36 -0400
Received: from silvara (silvara.lavos.net [10.4.0.20])
	by mail.lavos.net (Postfix) with ESMTP id C6618309F30;
	Tue, 14 Aug 2007 08:18:26 -0500 (CDT)
Received: by silvara (Postfix, from userid 1000)
	id 5A8FE50117; Tue, 14 Aug 2007 08:18:38 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: 7vwsvycxup.fsf_-_@assigned-by-dhcp.cox.net
References: 7vwsvycxup.fsf_-_@assigned-by-dhcp.cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55829>

We can now read .gitattributes files out of the index, but the index
must be loaded for this to work.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-check-attr.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 9d77f76..d949733 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "cache.h"
 #include "attr.h"
 #include "quote.h"
 
@@ -10,6 +11,10 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	struct git_attr_check *check;
 	int cnt, i, doubledash;
 
+	if (read_cache() < 0) {
+		die("invalid cache");
+	}
+
 	doubledash = -1;
 	for (i = 1; doubledash < 0 && i < argc; i++) {
 		if (!strcmp(argv[i], "--"))
-- 
1.5.3.GIT
