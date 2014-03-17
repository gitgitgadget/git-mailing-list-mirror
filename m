From: Hiroyuki Sano <sh19910711@gmail.com>
Subject: [PATCH 3/3][GSOC] fsck: use is_dot_or_dotdot() instead of strcmp()
Date: Tue, 18 Mar 2014 06:30:25 +0900
Message-ID: <1395091825-8330-3-git-send-email-sh19910711@gmail.com>
References: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Cc: Hiroyuki Sano <sh19910711@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 17 22:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPf7V-0005NI-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbaCQVaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:30:46 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42562 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaCQVap (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:30:45 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so6263582pbc.32
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FD0XIlOHsOP2AygU87sX7HgEQzeapAC/P10K2viSR+o=;
        b=hSZsyT0YS54GwkpOEaISYiWi+WhBMotivykmOpgQY752koNmaqXbs38hYDz0yxQw/u
         8bLHJNmEOsMDxNQm9VfKwXtlGclBKRB8/anYXjmlVL3Xt+dZRZxAzN+0P8Sui75luxFl
         VGSsDlvIKPBDcl5h9kja/3kkM3/GoU++9udtTdL1EPeRVIyFC/V02GShbnJEkzSfCWSM
         RP/ib8GHDWoEh47/NH5Ok2/2ZYeCoQ6pEFetahAf4RANcX7YyXAAPzMNk5AwGEAbyVEQ
         jox1CVpV2qvbdpc0xljYoF95kgXtGobo+kyBT0tO9rhEqKE0iUV3S7nP3ZSuEXjaQgGe
         o2uw==
X-Received: by 10.68.43.2 with SMTP id s2mr28888353pbl.60.1395091844650;
        Mon, 17 Mar 2014 14:30:44 -0700 (PDT)
Received: from localhost (ntfkok023001.fkok.nt.adsl.ppp.infoweb.ne.jp. [218.217.179.1])
        by mx.google.com with ESMTPSA id my6sm46155580pbc.36.2014.03.17.14.30.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2014 14:30:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395091825-8330-1-git-send-email-sh19910711@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244288>

The is_dot_or_dotdot() is used to check if the string is either "." or "..".

Signed-off-by: Hiroyuki Sano <sh19910711@gmail.com>
---
 fsck.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index b3022ad..c9d7784 100644
--- a/fsck.c
+++ b/fsck.c
@@ -6,6 +6,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "fsck.h"
+#include "dir.h"
 
 static int fsck_walk_tree(struct tree *tree, fsck_walk_func walk, void *data)
 {
@@ -171,10 +172,12 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 			has_full_path = 1;
 		if (!*name)
 			has_empty_name = 1;
-		if (!strcmp(name, "."))
-			has_dot = 1;
-		if (!strcmp(name, ".."))
-			has_dotdot = 1;
+		if (is_dot_or_dotdot(name)) {
+			if (!name[1])
+				has_dot = 1;
+			else
+				has_dotdot = 1;
+		}
 		if (!strcmp(name, ".git"))
 			has_dotgit = 1;
 		has_zero_pad |= *(char *)desc.buffer == '0';
-- 
1.9.0
