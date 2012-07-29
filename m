From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 1/3] remove unnecessary parameter from get_patch_ids()
Date: Sun, 29 Jul 2012 16:25:34 -0700
Message-ID: <1343604336-7966-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svcs6-0003wr-7p
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 01:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826Ab2G2XZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 19:25:58 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:37974 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2G2XZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 19:25:43 -0400
Received: by bkcjc3 with SMTP id jc3so195210bkc.1
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=ytCiRm+wi+9FTfSC7EqdsYYpzASOebpHwop7VeNfsmg=;
        b=C1uuiseujMHZIa4giiioCCz17Ef+QH7IwZnDhdsQqkAoYAR3gz1kIsjC0rEon3JLpk
         r4fKdM2PDhgMU3YU/fs/ccitNBMLZ6xf7GUNLGoimtU+TDSZo8JO72DZrtzvSYStun9n
         OrPGITwPsyOIl9EoNP7E72Wx+6MMNExESqbBEX4S8UW+sxnAkb1hse/5KKLKAMMHZURQ
         QUExiG0Y1hyTSokNsL8nBkcZ6h6XR7n4wyz2/XRsUx8JmLlkEsnQOSmv6ImE927u4LIC
         GL78cuwLOVSiCk5AwEjGxeLusivKTIKBSqBllRzMs5QQ4qlLAYdAFgRlwEk/4fRxI9Tk
         LKtw==
Received: by 10.14.174.196 with SMTP id x44mr7422580eel.7.1343604342153;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: by 10.14.174.196 with SMTP id x44mr7422575eel.7.1343604342100;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id v42si12597377eep.0.2012.07.29.16.25.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id E310B200057;
	Sun, 29 Jul 2012 16:25:41 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 355D4C0EBB; Sun, 29 Jul 2012 16:25:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQnJXMhF0BehYiS0vLDnsfkZ2wPf66DSWPB88CW/WvSfBRIzVLXDV5Nu3nsnEjCRoDRG1zgT2qJpjYwUDWboMvOm9qgq6XMz54cuDc4OSlWEWtcnFOBfFeoEdggfqm7pqlORGcC3XUmOKQlzi3JV+eXlAhVJAmGuYVZN4XuY4aSvhDPt6Y67JVFra4GVhJZZwGKynDGE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202505>

get_patch_ids() takes an already initialized rev_info and a
prefix. The prefix is used when initalizing a second rev_info. Since
the initialized rev_info already has a prefix and the prefix never
changes, we can used the prefix from the initialized rev_info to
initialize the second rev_info.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..7a92e3f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -696,7 +696,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 	return 0;
 }
 
-static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const char *prefix)
+static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 {
 	struct rev_info check_rev;
 	struct commit *commit;
@@ -717,7 +717,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 	init_patch_ids(ids);
 
 	/* given a range a..b get all patch ids for b..a */
-	init_revisions(&check_rev, prefix);
+	init_revisions(&check_rev, rev->prefix);
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
@@ -1306,7 +1306,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
 				return 0;
 		}
-		get_patch_ids(&rev, &ids, prefix);
+		get_patch_ids(&rev, &ids);
 	}
 
 	if (!use_stdout)
@@ -1525,7 +1525,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			return 0;
 	}
 
-	get_patch_ids(&revs, &ids, prefix);
+	get_patch_ids(&revs, &ids);
 
 	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
 		die(_("Unknown commit %s"), limit);
-- 
1.7.11.1.104.ge7b44f1
