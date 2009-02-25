From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 2/3] git-show-branch: sha1 based branch head determination
Date: Wed, 25 Feb 2009 11:17:19 +0100
Message-ID: <14706b525c71ab0628e54f7bd24b3303bf422698.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
Cc: Dirk Wallenstein <halsmit@t-online.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 11:36:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcH80-00083o-Bl
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 11:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077AbZBYKfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 05:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757532AbZBYKfJ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 05:35:09 -0500
Received: from mailout03.t-online.de ([194.25.134.81]:52400 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbZBYKfH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 05:35:07 -0500
Received: from fwd03.aul.t-online.de 
	by mailout03.sul.t-online.de with smtp 
	id 1LcGpd-0002UC-02; Wed, 25 Feb 2009 11:17:37 +0100
Received: from localhost.localdomain (rXBTSMZbghinNCtVQf-ngd-E4ij4Lu-lkqmIx3HWJXmdN4vtVzhKzH96OpsajEwZkS@[84.139.85.50]) by fwd03.t-online.de
	with esmtp id 1LcGpL-0Hjvd60; Wed, 25 Feb 2009 11:17:19 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
In-Reply-To: <cover.1235499771.git.halsmit@t-online.de>
References: <cover.1235499771.git.halsmit@t-online.de>
X-ID: rXBTSMZbghinNCtVQf-ngd-E4ij4Lu-lkqmIx3HWJXmdN4vtVzhKzH96OpsajEwZkS
X-TOI-MSGID: b41b7216-b657-48ce-a39c-fa2c1a1b6356
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111441>

Any ref that points to the same object as the one that is
currently pointed at by HEAD, is recognized as head, which is
then marked with a '*' in the corresponding column.
---
 builtin-show-branch.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index df83491..96ae3cb 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -460,9 +460,16 @@ static void snarf_refs(int head, int remotes)
 static int rev_is_head(char *head, int headlen, char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
-	if ((!head[0]) ||
-	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
+	if (!head[0])
 		return 0;
+	if (head_sha1 && sha1) {
+		if (hashcmp(head_sha1, sha1)) {
+			return 0;
+		} else {
+			return 1;
+		}
+	}
+
 	if (!prefixcmp(head, "refs/heads/"))
 		head += 11;
 	if (!prefixcmp(name, "refs/heads/"))
-- 
1.6.1
