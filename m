From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 3/3] log: remove redundant check for merge commit
Date: Sun, 29 Jul 2012 16:25:36 -0700
Message-ID: <1343604336-7966-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 01:26:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvcsS-00047j-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 01:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab2G2XZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 19:25:55 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:47228 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab2G2XZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 19:25:43 -0400
Received: by obbwc20 with SMTP id wc20so3178080obb.1
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=1vAliMWkN6C8T6M5PE16tevao7v8dAPMafjtHSDO9GM=;
        b=XJewPdGrT/GAAYf/N+tvCvaM2ROCRspnmTAKFe/VgaMrIay69Ne5swsGNkpxtO5vl5
         87J64M1mrIcW+aAav4qDjRWYjq/7cK4hDwoAGAy69pyBO9RBe6jdqGRbDF7Da2Swgu81
         rCPqos+TbDT3PvgH9BUtb1PfDtmzG7Ms/Z7Ul0F4wKgbnl6DWC+QBgPqUmsUem3q922C
         tfeqJhjXGP0hQMn1oKyBuKk6W3MK2MwXgt2r7TkAWvmeOTSK8atsxp+27LdTH9xXVobT
         pZPXVKbpZkPY+aJzeT1wGxoCoZEU2tL9VLlfX8X9pwEMeojGg9jxRS45baWDWsNuh3CG
         oSuw==
Received: by 10.50.203.103 with SMTP id kp7mr4714666igc.2.1343604342121;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: by 10.50.203.103 with SMTP id kp7mr4714663igc.2.1343604342087;
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id gv6si2715133igb.0.2012.07.29.16.25.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Sun, 29 Jul 2012 16:25:42 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id AEA0B1E0043;
	Sun, 29 Jul 2012 16:25:41 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 4EDB2C1A2E; Sun, 29 Jul 2012 16:25:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1343604336-7966-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQm6VY7knhp5Kxfa57sK0KngkeF1vVnioKaz/sNA2sgr6ANB6Oj8YR6wEF37a+5JLZwn7HSYQlAsp8gIqPnau70/aQjCGoiQuFpsnqEYQODN4++xjbSCKI4pX/Yn1uUgW12tz1ib3+U1hI62HRvSQF5k/oo0SbLsBNy02Nib6Kj5eDxCFDzUB26e2gtPUCpVGg/Rebxp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202506>

While walking the revision list in get_patch_ids and cmd_cherry, we
check for each commit if there is more than one parent and ignore the
commit if that is the case. Instead, set rev_info.max_parents to 1 and
let the revision traversal code handle it for us.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8cea1e5..3423d11 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -718,6 +718,7 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 
 	/* given a range a..b get all patch ids for b..a */
 	init_revisions(&check_rev, rev->prefix);
+	check_rev.max_parents = 1;
 	o1->flags ^= UNINTERESTING;
 	o2->flags ^= UNINTERESTING;
 	add_pending_object(&check_rev, o1, "o1");
@@ -726,10 +727,6 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 		die(_("revision walk setup failed"));
 
 	while ((commit = get_revision(&check_rev)) != NULL) {
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		add_commit_patch_id(commit, ids);
 	}
 
@@ -1508,6 +1505,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	}
 
 	init_revisions(&revs, prefix);
+	revs.max_parents = 1;
 
 	if (add_pending_commit(head, &revs, 0))
 		die(_("Unknown commit %s"), head);
@@ -1530,10 +1528,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 	while ((commit = get_revision(&revs)) != NULL) {
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		commit_list_insert(commit, &list);
 	}
 
-- 
1.7.11.1.104.ge7b44f1
