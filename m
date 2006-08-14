From: David Rientjes <rientjes@google.com>
Subject: [PATCH 02/28] makes pprint_tag void
Date: Mon, 14 Aug 2006 13:19:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141318140.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:19:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCiuG-00065m-OZ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWHNUTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWHNUTZ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:19:25 -0400
Received: from smtp-out.google.com ([216.239.45.12]:19342 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932707AbWHNUTZ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:19:25 -0400
Received: from zps36.corp.google.com (zps36.corp.google.com [172.25.146.36])
	by smtp-out.google.com with ESMTP id k7EKJLQU030053
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:19:21 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=wvM7TxQ1zw26H6Sa6HN4Rpc6OC6dlQ6hYt05JPYFmEB1V5qh1U98PzcadPiNBkMkg
	aH9fQh/0l3kfhwuXdvrtw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps36.corp.google.com with ESMTP id k7EKJGec032695
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:19:16 -0700
Received: by localhost (Postfix, from userid 24081)
	id F13A187D71; Mon, 14 Aug 2006 13:19:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id EEEC887D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:19:15 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25382>

Makes pprint_tag void and cleans up call in cmd_cat_file.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-cat-file.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 814fb07..df009ad 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -26,7 +26,7 @@ static void flush_buffer(const char *buf
 	}
 }
 
-static int pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
+static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
 {
 	/* the parser in tag.c is useless here. */
 	const char *endp = buf + size;
@@ -91,7 +91,6 @@ static int pprint_tag(const unsigned cha
 	 */
 	if (cp < endp)
 		flush_buffer(cp, endp - cp);
-	return 0;
 }
 
 int cmd_cat_file(int argc, const char **argv, const char *prefix)
@@ -145,8 +144,10 @@ int cmd_cat_file(int argc, const char **
 		buf = read_sha1_file(sha1, type, &size);
 		if (!buf)
 			die("Cannot read object %s", argv[2]);
-		if (!strcmp(type, tag_type))
-			return pprint_tag(sha1, buf, size);
+		if (!strcmp(type, tag_type)) {
+			pprint_tag(sha1, buf, size);
+			return 0;
+		}
 
 		/* otherwise just spit out the data */
 		break;
-- 
1.4.2.g89bb-dirty
