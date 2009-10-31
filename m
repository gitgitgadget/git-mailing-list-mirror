From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 12/28] remote-helpers: return successfully if everything up-to-date
Date: Fri, 30 Oct 2009 17:47:31 -0700
Message-ID: <1256950067-27938-14-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429p-0001yQ-87
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933161AbZJaAs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933143AbZJaAsR
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:48:17 -0400
Received: from george.spearce.org ([209.20.77.23]:36933 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZJaArw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:47:52 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 80C523826E; Sat, 31 Oct 2009 00:47:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 947A0381D3;
	Sat, 31 Oct 2009 00:47:52 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131799>

From: Clemens Buchacher <drizzd@aon.at>

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5540-http-push.sh |    2 +-
 transport-helper.c   |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 09edd23..2ece661 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -58,7 +58,7 @@ test_expect_success 'push to remote repository with packed refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
-test_expect_failure 'push already up-to-date' '
+test_expect_success 'push already up-to-date' '
 	git push
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 16c6641..5078c71 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -263,6 +263,8 @@ static int push_refs(struct transport *transport,
 		strbuf_addstr(&buf, ref->name);
 		strbuf_addch(&buf, '\n');
 	}
+	if (buf.len == 0)
+		return 0;
 
 	transport->verbose = flags & TRANSPORT_PUSH_VERBOSE ? 1 : 0;
 	standard_options(transport);
-- 
1.6.5.2.181.gd6f41
