From: David Rientjes <rientjes@google.com>
Subject: [PATCH 15/28] makes sha1flush void
Date: Mon, 14 Aug 2006 13:32:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141331160.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj6Z-0000E7-8k
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932728AbWHNUcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWHNUcH
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:32:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:18325 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932728AbWHNUcG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:32:06 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EKW25o022914
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:02 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=IzYKjoRgBa1e156zRr8vxVJOj+PETLlHXTm8ZwHq3PaukqhWn2BwQfRsn9CRmxJdy
	tBwPW6wQEEgzHMJb4KTeA==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EKW1Gs008966
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:02 -0700
Received: by localhost (Postfix, from userid 24081)
	id D659787D71; Mon, 14 Aug 2006 13:32:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id D386B87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:32:01 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25395>

Makes sha1flush void and removes conditional return.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 combine-diff.c |    4 +---
 csum-file.c    |    4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index f2f3806..312035a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -9,9 +9,7 @@ #include "log-tree.h"
 
 static int uninteresting(struct diff_filepair *p)
 {
-	if (diff_unmodified_pair(p))
-		return 1;
-	return 0;
+	return !!diff_unmodified_pair(p);
 }
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
diff --git a/csum-file.c b/csum-file.c
index 6a7b40f..e227889 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -10,7 +10,7 @@
 #include "cache.h"
 #include "csum-file.h"
 
-static int sha1flush(struct sha1file *f, unsigned int count)
+static void sha1flush(struct sha1file *f, unsigned int count)
 {
 	void *buf = f->buffer;
 
@@ -21,7 +21,7 @@ static int sha1flush(struct sha1file *f,
 			count -= ret;
 			if (count)
 				continue;
-			return 0;
+			return;
 		}
 		if (!ret)
 			die("sha1 file '%s' write error. Out of diskspace", f->name);
-- 
1.4.2.g89bb-dirty
