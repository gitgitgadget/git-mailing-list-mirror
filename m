From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/2] checkout_entry(): use the strbuf throughout the function
Date: Thu, 13 Mar 2014 10:19:07 +0100
Message-ID: <1394702348-6433-2-git-send-email-mhagger@alum.mit.edu>
References: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 10:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO1nS-00022b-4n
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 10:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510AbaCMJTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 05:19:18 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:52300 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753481AbaCMJTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2014 05:19:16 -0400
X-AuditID: 12074412-f79d46d000002e58-c8-53217814f426
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.50.11864.41871235; Thu, 13 Mar 2014 05:19:16 -0400 (EDT)
Received: from michael.fritz.box (p57A24737.dip0.t-ipconnect.de [87.162.71.55])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2D9JA4R018940
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 13 Mar 2014 05:19:14 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394702348-6433-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqCtSoRhscPUru0XXlW4mi4beK8wW
	t1fMZ7bonvKW0eJHSw+zA6vH3/cfmDx2zrrL7vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGdsmDaDtWCNcMWnZ9dZGxjP8HcxcnJICJhIbLq/mhXCFpO4cG89WxcjF4eQwGVGidZp
	U5ggnONMElO2tzGCVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhbYxyix/eA6sCJhAV+JlxenM4PY
	LAKqEg92bQeL8wo4S+zZ3sMCsU5OYsrvBexdjBwcnAIuEme2SYCEhYBKFizZxzaBkXcBI8Mq
	RrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0zvdzMEr3UlNJNjJCgEtrBuP6k3CFGAQ5GJR7ehzcU
	goVYE8uKK3MPMUpyMCmJ8uqUKwYL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE1LwDK8aYkVlal
	FuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8GaXAjUKFqWmp1akZeaUIKSZODhB
	hnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC93CA38RYXJOYCRSFaTzEqSonzqpQBJQRAEhml
	eXBjYaniFaM40JfCvGIg7TzANAPX/QpoMBPQ4B8B8iCDSxIRUlINjBIzGbaavxO4vHZzbFjB
	spy+RV0rG82qPPnUu0oP7mf7kXl/5rF07SOnlja/PSpXP5ezZF/97d93tReErvj+cJ6e1NyI
	i50rJHm4px78vWmrH18kW5y8y7mIkoM346ZmF9YuFVA7G90rxTE/K0HnwRQLx4l3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244023>

There is no need to break out the "buf" and "len" members into
separate temporary variables.  Rename path_buf to path and use
path.buf and path.len directly.  This makes it easier to reason about
the data flow in the function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 entry.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/entry.c b/entry.c
index 7b7aa81..9adddb6 100644
--- a/entry.c
+++ b/entry.c
@@ -245,27 +245,25 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
 int checkout_entry(struct cache_entry *ce,
 		   const struct checkout *state, char *topath)
 {
-	static struct strbuf path_buf = STRBUF_INIT;
-	char *path;
+	static struct strbuf path = STRBUF_INIT;
 	struct stat st;
-	int len;
 
 	if (topath)
 		return write_entry(ce, topath, state, 1);
 
-	strbuf_reset(&path_buf);
-	strbuf_add(&path_buf, state->base_dir, state->base_dir_len);
-	strbuf_add(&path_buf, ce->name, ce_namelen(ce));
-	path = path_buf.buf;
-	len = path_buf.len;
+	strbuf_reset(&path);
+	strbuf_add(&path, state->base_dir, state->base_dir_len);
+	strbuf_add(&path, ce->name, ce_namelen(ce));
 
-	if (!check_path(path, len, &st, state->base_dir_len)) {
+	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
 		if (!changed)
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
-				fprintf(stderr, "%s already exists, no checkout\n", path);
+				fprintf(stderr,
+					"%s already exists, no checkout\n",
+					path.buf);
 			return -1;
 		}
 
@@ -280,12 +278,14 @@ int checkout_entry(struct cache_entry *ce,
 			if (S_ISGITLINK(ce->ce_mode))
 				return 0;
 			if (!state->force)
-				return error("%s is a directory", path);
-			remove_subtree(path);
-		} else if (unlink(path))
-			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
+				return error("%s is a directory", path.buf);
+			remove_subtree(path.buf);
+		} else if (unlink(path.buf))
+			return error("unable to unlink old '%s' (%s)",
+				     path.buf, strerror(errno));
 	} else if (state->not_new)
 		return 0;
-	create_directories(path, len, state);
-	return write_entry(ce, path, state, 0);
+
+	create_directories(path.buf, path.len, state);
+	return write_entry(ce, path.buf, state, 0);
 }
-- 
1.9.0
