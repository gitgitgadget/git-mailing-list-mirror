From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 3/7] fast-import: Allow cat command with empty path
Date: Wed, 13 Oct 2010 00:50:20 +1100
Message-ID: <1286891424-2067-4-git-send-email-david.barr@cordelta.com>
References: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:51:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5fGF-0004ii-1J
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507Ab0JLNu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Oct 2010 09:50:57 -0400
Received: from static-198-196.grapevine.transact.net.au ([121.127.198.196]:58872
	"EHLO mailhost.cordelta" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932319Ab0JLNud (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:50:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id E8C48C068;
	Wed, 13 Oct 2010 00:50:34 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qb9yAjC1lNvY; Wed, 13 Oct 2010 00:50:29 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.127])
	by mailhost.cordelta (Postfix) with ESMTP id AC2D0C06A;
	Wed, 13 Oct 2010 00:50:29 +1100 (EST)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1286891424-2067-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158847>

From: Jonathan Nieder <jrnieder@gmail.com>

Rather than erroring out, treat an empty path as the path to
the root of a tree so frontends can be simplified a little.

While at it, fix a typo in an error message: the cat command is used
to examine paths within trees, not branches.

Cc: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fast-import.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 099f63e..f3c4123 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2702,9 +2702,13 @@ static void quoted_path_sha1(unsigned char sha1[20], struct tree_entry *root,
 		die("Invalid path: %s", line);
 	if (*x)
 		die("Garbage after path: %s", line);
+	if (uq.len == 0) {
+		hashcpy(sha1, root->versions[1].sha1);
+		return;
+	}
 	tree_content_get(root, uq.buf, &leaf);
 	if (!leaf.versions[1].mode)
-		die("Path %s not in branch", uq.buf);
+		die("Path %s not in tree", uq.buf);
 	hashcpy(sha1, leaf.versions[1].sha1);
 }
 
-- 
1.7.3.1
