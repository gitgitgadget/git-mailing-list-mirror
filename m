From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/3] combine-diff: suppress a clang warning
Date: Sun,  3 Feb 2013 14:37:10 +0000
Message-ID: <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
References: <cover.1359901732.git.john@keeping.me.uk>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 15:38:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U20ht-0000JE-AU
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 15:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417Ab3BCOhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 09:37:17 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:55468 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3BCOhR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 09:37:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C13B122CBE;
	Sun,  3 Feb 2013 14:37:16 +0000 (GMT)
X-Quarantine-ID: <8zfw-F19DI3X>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zfw-F19DI3X; Sun,  3 Feb 2013 14:37:16 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id EAC831FFC0;
	Sun,  3 Feb 2013 14:37:09 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
In-Reply-To: <cover.1359901732.git.john@keeping.me.uk>
References: <cover.1359901732.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215310>

When compiling combine-diff.c, clang 3.2 says:

    combine-diff.c:1006:19: warning: adding 'int' to a string does not
	    append to the string [-Wstring-plus-int]
		prefix = COLONS + offset;
			 ~~~~~~~^~~~~~~~
    combine-diff.c:1006:19: note: use array indexing to silence this warning
		prefix = COLONS + offset;
				^
			 &      [       ]

Suppress this by making the suggested change.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 combine-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/combine-diff.c b/combine-diff.c
index bb1cc96..dba4748 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1003,7 +1003,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 		offset = strlen(COLONS) - num_parent;
 		if (offset < 0)
 			offset = 0;
-		prefix = COLONS + offset;
+		prefix = &COLONS[offset];
 
 		/* Show the modes */
 		for (i = 0; i < num_parent; i++) {
-- 
1.8.1.2
