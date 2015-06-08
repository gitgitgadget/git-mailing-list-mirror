From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/13] repack_without_refs(): make function private
Date: Mon,  8 Jun 2015 13:45:42 +0200
Message-ID: <7140f87b1c1d42108e875163344bdec668d221fa.1433763494.git.mhagger@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 13:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1vVt-0005gt-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 13:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbbFHLqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 07:46:40 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:58253 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436AbbFHLqG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 07:46:06 -0400
X-AuditID: 12074413-f79386d000000d23-3b-5575807aa9b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 37.32.03363.A7085755; Mon,  8 Jun 2015 07:46:02 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t58Bjop5017042
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 07:46:01 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433763494.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqFvVUBpq8HqzsUXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M6bMecdU8IOn4sn7a8wNjGu5uhg5OSQETCTev21nhbDFJC7cW8/WxcjFISRwmVHiUPtD
	KOcEk8T+9QvYQKrYBHQlFvU0M4HYIgJqEhPbDrGAFDELdDBKXFi+jR0kISzgLHHv7ElmEJtF
	QFWi4dpjsAZegSiJQ48fs0Osk5M4f/wnWA2ngIXE3f8XwBYICZhLfNzWzjiBkXcBI8MqRrnE
	nNJc3dzEzJzi1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJCgEt7BuOuk3CFGAQ5GJR7eA4tKQoVY
	E8uKK3MPMUpyMCmJ8naVlYYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFlsgDK8aYkVlalFuXD
	pKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeD/WATUKFqWmp1akZeaUIKSZODhBhnNJ
	iRSn5qWkFiWWlmTEg6IjvhgYHyApHqC9KvUge4sLEnOBohCtpxgVpcR5H4PMFQBJZJTmwY2F
	pYpXjOJAXwrz6oK08wDTDFz3K6DBTECDv38tBhlckoiQkmpg3PA8eE3AZmFGwaSaGZahP2ee
	i+SVLcuYzL/p4BKJF6H7F/TxR55b2znl+cJ1G5g+7LVRny2gkF0jIpvh/ElTz1Oqd56PX6Je
	woPXpp89/01R3hTZfm7tDh3ZC926kv8TjCfM/GVtzLRcbgpjdyPrrErfDZz+pqKS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271025>

It is no longer called from outside of the refs module. Also move its
docstring and change it to imperative voice.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  9 ++++++++-
 refs.h | 11 -----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index a10aba8..dc17984 100644
--- a/refs.c
+++ b/refs.c
@@ -2724,7 +2724,14 @@ int pack_refs(unsigned int flags)
 	return 0;
 }
 
-int repack_without_refs(struct string_list *refnames, struct strbuf *err)
+/*
+ * Rewrite the packed-refs file, omitting any refs listed in
+ * 'refnames'. On error, leave packed-refs unchanged, write an error
+ * message to 'err', and return a nonzero value.
+ *
+ * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
+ */
+static int repack_without_refs(struct string_list *refnames, struct strbuf *err)
 {
 	struct ref_dir *packed;
 	struct string_list_item *refname;
diff --git a/refs.h b/refs.h
index 9b75b9f..3420c98 100644
--- a/refs.h
+++ b/refs.h
@@ -154,17 +154,6 @@ extern void rollback_packed_refs(void);
  */
 int pack_refs(unsigned int flags);
 
-/*
- * Rewrite the packed-refs file, omitting any refs listed in
- * 'refnames'. On error, packed-refs will be unchanged, the return
- * value is nonzero, and a message about the error is written to the
- * 'err' strbuf.
- *
- * The refs in 'refnames' needn't be sorted. `err` must not be NULL.
- */
-extern int repack_without_refs(struct string_list *refnames,
-			       struct strbuf *err);
-
 extern int ref_exists(const char *);
 
 extern int is_branch(const char *refname);
-- 
2.1.4
