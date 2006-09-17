From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Add [-s|--hash] option to Linus' show-ref.
Date: Sun, 17 Sep 2006 06:20:24 +0200
Message-ID: <20060917062024.c476e07d.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 06:14:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOo3M-00073s-Cc
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 06:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWIQEOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 00:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWIQEOV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 00:14:21 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:57996 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750717AbWIQEOV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 00:14:21 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id A82ED11738;
	Sun, 17 Sep 2006 06:14:19 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27157>

With this option only the sha1 hash of the ref should
be printed.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin-show-ref.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 161b236..577d934 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -3,9 +3,10 @@ #include "refs.h"
 #include "object.h"
 #include "tag.h"
 
-static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--deref] [--tags] [--heads] [--] [pattern*]";
+static const char show_ref_usage[] = "git show-ref [-q|--quiet] [--verify] [-h|--head] [-d|--deref] [-s|--hash] [--tags] [--heads] [--] [pattern*]";
 
-static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0, found_match = 0, verify = 0, quiet = 0;
+static int deref_tags = 0, show_head = 0, tags_only = 0, heads_only = 0,
+	found_match = 0, verify = 0, quiet = 0, hash_only = 0;
 static const char **pattern;
 
 static int show_ref(const char *refname, const unsigned char *sha1)
@@ -50,7 +51,10 @@ match:
 	}
 	if (quiet)
 		return 0;
-	printf("%s %s\n", sha1_to_hex(sha1), refname);
+	if (hash_only)
+		printf("%s\n", sha1_to_hex(sha1));
+	else
+		printf("%s %s\n", sha1_to_hex(sha1), refname);
 	if (deref_tags && obj->type == OBJ_TAG) {
 		obj = deref_tag(obj, refname, 0);
 		printf("%s %s^{}\n", sha1_to_hex(obj->sha1), refname);
@@ -86,6 +90,10 @@ int cmd_show_ref(int argc, const char **
 			deref_tags = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-s") || !strcmp(arg, "--hash")) {
+			hash_only = 1;
+			continue;
+		}
 		if (!strcmp(arg, "--verify")) {
 			verify = 1;
 			continue;
-- 
1.4.2.1.gea00f-dirty
