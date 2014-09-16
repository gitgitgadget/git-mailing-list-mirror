From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 26/35] try_merge_strategy(): use a statically-allocated lock_file object
Date: Tue, 16 Sep 2014 21:33:47 +0200
Message-ID: <1410896036-12750-27-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTye3-0003pZ-QN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200AbaIPTmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:42:23 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:60020 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755150AbaIPTmU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:42:20 -0400
X-AuditID: 1207440d-f797f6d000000a4a-75-541890dfd15c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 01.91.02634.FD098145; Tue, 16 Sep 2014 15:34:55 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcU001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:54 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqHt/gkSIwf4TahZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLf5NqLHo7PjK6MDu8ff9ByaPBZtKPR6+6mL3eNa7h9Hj4iVlj8+b
	5DxuP9vGEsAexW2TlFhSFpyZnqdvl8Cd8fRRB3vBYv6Kh5/vsjcwHuHpYuTgkBAwkdizX7yL
	kRPIFJO4cG89WxcjF4eQwGVGiV/TbjJDOCeYJF70L2MDqWIT0JVY1NPMBJIQEWhjlNh1cTMr
	iMMs0M0o8f7EaSaQKmGBaImT554zg9gsAqoSn8+tA7N5BVwl9u3dxwqxT05iw+7/jCBncALF
	v+4rADGFBFwkDt71m8DIu4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZG
	SNjx7mD8v07mEKMAB6MSD6/HI/EQIdbEsuLK3EOMkhxMSqK8/7olQoT4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8P7wBcrxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGanphakFsFkZTg4lCR4
	+YDxJSRYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPioz4YmBsgKR4gPZqg7TzFhck
	5gJFIVpPMepyrOv81s8kxJKXn5cqJc5r0w9UJABSlFGaB7cClmReMYoDfSwMMYoHmKDgJr0C
	WsIEtORsjxjIkpJEhJRUA2O7p1cY3/2HrudE7ZQ1nFyE3l54ldRTIlfzVfCUn0Tf8mzjqm+X
	9oo23Hi0wPTG4X4V4R+mOh7W0TGuE4UfuDpNtbbw7l1nWfC3NC5TSjWkT/Djp+pe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257176>

Even the one lockfile object needn't be allocated each time the
function is called.  Instead, define one statically-allocated
lock_file object and reuse it for every call.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 6b430f0..1a5a5f2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -656,14 +656,14 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			      struct commit_list *remoteheads,
 			      struct commit *head, const char *head_arg)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	static struct lock_file lock;
 
-	hold_locked_index(lock, 1);
+	hold_locked_index(&lock, 1);
 	refresh_cache(REFRESH_QUIET);
 	if (active_cache_changed &&
-	    write_locked_index(&the_index, lock, COMMIT_LOCK))
+	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return error(_("Unable to write index."));
-	rollback_lock_file(lock);
+	rollback_lock_file(&lock);
 
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
@@ -695,13 +695,13 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		for (j = common; j; j = j->next)
 			commit_list_insert(j->item, &reversed);
 
-		hold_locked_index(lock, 1);
+		hold_locked_index(&lock, 1);
 		clean = merge_recursive(&o, head,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
-		    write_locked_index(&the_index, lock, COMMIT_LOCK))
+		    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 			die (_("unable to write %s"), get_index_file());
-		rollback_lock_file(lock);
+		rollback_lock_file(&lock);
 		return clean ? 0 : 1;
 	} else {
 		return try_merge_command(strategy, xopts_nr, xopts,
-- 
2.1.0
