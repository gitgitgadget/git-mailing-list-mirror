From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/2] log: remove redundant check for merge commit
Date: Fri, 27 Jul 2012 10:21:39 -0700
Message-ID: <1343409699-27199-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 19:21:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuoEb-0006s8-4Q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 19:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2G0RVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 13:21:48 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:45361 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab2G0RVq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 13:21:46 -0400
Received: by vcqp1 with SMTP id p1so353062vcq.1
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=zrohKCKynND6MlQ3vTkRqllGcChAvOD+GNxTGFwSb9k=;
        b=MZXs7h90u4G93uagVccBUEKCJQGME9OVkqnTGWSO/4/3PqWDcW/IC+4WFJNkHJ8DSu
         aM2Wt7LD6gzwOEhgs38zWN7E6ie4xPC2mbm4CtHjLUe7sQlUawW683hUKpEQfo1mc3fL
         uak+Tm5MC1cGCoTdb6dKBiUudXPbDYrD6kjatg7/IRn08iRaYfz1e8+NgyPdRXnCcPSH
         fJk/P7w1UXN/GfWaRL/nRYvvTh2hup2FE3xEaJ56XJYH0VfthCrDIrqWZKHRSjnpA9b0
         NEuc3QN1zEAK/iUKcM1Il/tX0S1bxyvGDa/rvo4K2foCCKGodRmfKa6+D90HkO/o81Jm
         bb7g==
Received: by 10.236.116.74 with SMTP id f50mr1621020yhh.33.1343409705803;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by 10.236.116.74 with SMTP id f50mr1621017yhh.33.1343409705764;
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id c61si720979yhm.3.2012.07.27.10.21.45
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id A32D51E0043;
	Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 38F52C14D9; Fri, 27 Jul 2012 10:21:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1343409699-27199-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQmca5Ve0KfXe+vFc2uf0CjSc6ga4TYUrQj91WG2jnzn8rkhHJKcvgSR8Jj6u7olBAVZWPIEIyobx3AobCKsqZ+u88edx10Uck0EFv5+gDaHQR5s5qVMIZeEweC7v/qV9TIQyg8paptgHSL+CXjcU3zacUaok8gHxDgSk1MFTlSbtThPOYm94gVFIm41Zj+1h9hybv03
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202362>

While walking the revision list in get_patch_ids and cmd_cherry, we
ignore merges by checking if there is more than one parent. However,
since the revision walk was initialized with revs.ignore_merges = 1,
this would never happen. Remove the unnecessary checks.

Also re-initializing rev_info fields to the same values already set in
init_revisions().

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/log.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7a92e3f..8182a18 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -726,10 +726,6 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids)
 		die(_("revision walk setup failed"));
 
 	while ((commit = get_revision(&check_rev)) != NULL) {
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		add_commit_patch_id(commit, ids);
 	}
 
@@ -1509,8 +1505,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&revs, prefix);
 	revs.diff = 1;
-	revs.combine_merges = 0;
-	revs.ignore_merges = 1;
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 
 	if (add_pending_commit(head, &revs, 0))
@@ -1534,10 +1528,6 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
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
