From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH] Make the '%d' for log pretty format look the same as
 --decorate
Date: Wed, 11 May 2011 22:18:27 -0500
Message-ID: <4dcb540a.c2d5e70a.1a77.14aa@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 05:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKMaX-0006VK-KU
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 05:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381Ab1ELD3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 23:29:16 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51256 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1ELD3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 23:29:16 -0400
Received: by iyb14 with SMTP id 14so877403iyb.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:from:date:subject:to;
        bh=g3VfNter0jW6vbVSBDgq8WsYwOaRkUuEa3udVtP/FAQ=;
        b=XDqPOYab6h//O/1TWxxoSPMQEG9bsX6zlciAWR/TcN6YEpeiUO0BPQWqOKUEfhFP7t
         imtfSlp5WPhMKrKfP2ffs9e9Ezfl+zy2hWsbvfjyF6MOw5gOC24FiIsMASPT1qXLYPvv
         cjkEnFDRFrBioTWwYZFQ79ELMM+MnXqXwMSAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:date:subject:to;
        b=YLW+TNb8IDQc9GWsC0aGaEKkZxg7FCJ1Gx3oTb95whlSt5RmTbfYaSrYwMQUOP/Dgg
         C1nzSjDi8LuLh7i5W/ztACX3jR4f9BviXYwzB9MOVx44etJoij4Yot0HzRUYB7zm9WsH
         x5eD7G5HAtuoVLMP8K6jclbsOom+6QyEzkLgI=
Received: by 10.231.60.73 with SMTP id o9mr7265656ibh.33.1305170955376;
        Wed, 11 May 2011 20:29:15 -0700 (PDT)
Received: from localhost (ppp-70-226-173-12.dsl.mdsnwi.ameritech.net [70.226.173.12])
        by mx.google.com with ESMTPS id gx2sm308836ibb.60.2011.05.11.20.29.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 20:29:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173438>

We teach git to add a "tag: " prefix to tag names when the '%d' pretty format
option is given.  It is then the same format as the --decorate option given
directly to log.
---
 log-tree.c |    9 ---------
 log-tree.h |    9 +++++++++
 pretty.c   |    2 ++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2a1e3a9..9c24cbf 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -11,15 +11,6 @@
 
 struct decoration name_decoration = { "object names" };
 
-enum decoration_type {
-	DECORATION_NONE = 0,
-	DECORATION_REF_LOCAL,
-	DECORATION_REF_REMOTE,
-	DECORATION_REF_TAG,
-	DECORATION_REF_STASH,
-	DECORATION_REF_HEAD,
-};
-
 static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
 	GIT_COLOR_BOLD_GREEN,	/* REF_LOCAL */
diff --git a/log-tree.h b/log-tree.h
index 5c4cf7c..29861f0 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -3,6 +3,15 @@
 
 #include "revision.h"
 
+enum decoration_type {
+	DECORATION_NONE = 0,
+	DECORATION_REF_LOCAL,
+	DECORATION_REF_REMOTE,
+	DECORATION_REF_TAG,
+	DECORATION_REF_STASH,
+	DECORATION_REF_HEAD,
+};
+
 struct log_info {
 	struct commit *commit, *parent;
 };
diff --git a/pretty.c b/pretty.c
index dff5c8d..8130556 100644
--- a/pretty.c
+++ b/pretty.c
@@ -786,6 +786,8 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
 	while (d) {
 		strbuf_addstr(sb, prefix);
 		prefix = ", ";
+		if(d->type == DECORATION_REF_TAG)
+			strbuf_addstr(sb, "tag: ");
 		strbuf_addstr(sb, d->name);
 		d = d->next;
 	}
-- 
1.7.5.1
