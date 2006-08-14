From: David Rientjes <rientjes@google.com>
Subject: [PATCH 09/28] makes prune_dir void
Date: Mon, 14 Aug 2006 13:26:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141325350.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:26:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCj0z-0007TT-AE
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbWHNU0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWHNU0W
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:26:22 -0400
Received: from smtp-out.google.com ([216.239.45.12]:2962 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932719AbWHNU0V
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:26:21 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7EKQGbZ012887
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:26:16 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=sJfExT+WlNm0iKGMXSPX7fhofdpd41DC0itD19m8prAgMeki0ZcmKP34Zpt5FZmBf
	kExWK69fD48Aclk1+J0Ig==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps38.corp.google.com with ESMTP id k7EKQFU1014922
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:26:15 -0700
Received: by localhost (Postfix, from userid 24081)
	id 3D14F87D71; Mon, 14 Aug 2006 13:26:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 3AFF987D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:26:15 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25389>

Makes prune_dir void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 builtin-prune.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 89ec7f1..f01f275 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -14,24 +14,24 @@ static const char prune_usage[] = "git-p
 static int show_only = 0;
 static struct rev_info revs;
 
-static int prune_object(char *path, const char *filename, const unsigned char *sha1)
+static void prune_object(char *path, const char *filename,
+			 const unsigned char *sha1)
 {
 	if (show_only) {
 		printf("would prune %s/%s\n", path, filename);
-		return 0;
+	} else {
+		unlink(mkpath("%s/%s", path, filename));
+		rmdir(path);
 	}
-	unlink(mkpath("%s/%s", path, filename));
-	rmdir(path);
-	return 0;
 }
 
-static int prune_dir(int i, char *path)
+static void prune_dir(int i, char *path)
 {
 	DIR *dir = opendir(path);
 	struct dirent *de;
 
 	if (!dir)
-		return 0;
+		return;
 
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
@@ -65,7 +65,6 @@ static int prune_dir(int i, char *path)
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
 	}
 	closedir(dir);
-	return 0;
 }
 
 static void prune_object_dir(const char *path)
-- 
1.4.2.g89bb-dirty
