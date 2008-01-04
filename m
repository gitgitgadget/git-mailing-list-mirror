From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] receive-pack: reject invalid refnames
Date: Fri,  4 Jan 2008 20:37:17 +0100
Message-ID: <1199475437933-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 20:38:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAsMg-000589-FZ
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 20:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYADThV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 14:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYADThU
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 14:37:20 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55312 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbYADThT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 14:37:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 41AB4680BEBA;
	Fri,  4 Jan 2008 20:37:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiJ9pQz+3GBR; Fri,  4 Jan 2008 20:37:17 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 26EDC680067B; Fri,  4 Jan 2008 20:37:17 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69596>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 receive-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index d0a563d..3267495 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -165,7 +165,8 @@ static const char *update(struct command *cmd)
 	unsigned char *new_sha1 = cmd->new_sha1;
 	struct ref_lock *lock;
 
-	if (!prefixcmp(name, "refs/") && check_ref_format(name + 5)) {
+	/* only refs/... are allowed */
+	if (prefixcmp(name, "refs/") || check_ref_format(name + 5)) {
 		error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
-- 
1.4.4.4
