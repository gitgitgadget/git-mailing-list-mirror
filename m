From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/12] repack_without_refs(): make function private
Date: Sat, 13 Jun 2015 16:42:10 +0200
Message-ID: <4857117df34d5d554688cae25a8e005aac20842d.1434206062.git.mhagger@alum.mit.edu>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 16:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3me0-0007iJ-BU
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbbFMOmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:36 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:59754 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752516AbbFMOm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:29 -0400
X-AuditID: 12074411-f796c6d000000bc9-de-557c4153f92c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7F.41.03017.3514C755; Sat, 13 Jun 2015 10:42:27 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpV026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:26 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqBvsWBNqcGSRgUXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4MxpXfmYu+MFT8arlImsD41quLkZODgkBE4mDn2+xQ9hiEhfurWfrYuTiEBK4zCixZPUF
	FgjnBJPEhXlfGEGq2AR0JRb1NDOB2CICahIT2w6BFTELdDBKXFi+DWyUsICbxKQjM8CKWARU
	Jea2XQZr5hWIknh2+SULxDo5ifPHfzJ3MXJwcApYSLxsygQJCwmYS7xd0c46gZF3ASPDKka5
	xJzSXN3cxMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQkBLcwTjjpNwhRgEORiUe3ozY6lAh
	1sSy4srcQ4ySHExKoryRe4BCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgFtWtChXhTEiurUovy
	YVLSHCxK4rx8S9T9hATSE0tSs1NTC1KLYLIyHBxKErzSDkCNgkWp6akVaZk5JQhpJg5OkOFc
	UiLFqXkpqUWJpSUZ8aDYiC8GRgdIigdo70yQdt7igsRcoChE6ylGRSlx3nCQhABIIqM0D24s
	LFG8YhQH+lKY1wOkigeYZOC6XwENZgIa3N5TBTK4JBEhJdXAuDWd91wk++Wdn34ti42rnPx5
	anHJkSkTJ94XNeGJmDThoLh4Mt+8+TOvFT9IPc8ZIKEw5xPPnePLQnbxb5Gd4vNOwHCm7l/Z
	h8XG6VF60cecJJS/XTw3hfHFk/3XLEpb/fU33Vx5aLd5PfO8S9lSkiwLTnVw2Syq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271554>

It is no longer called from outside of the refs module. Also move its
docstring and change it to imperative voice.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |  9 ++++++++-
 refs.h | 11 -----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/refs.c b/refs.c
index 5386077..832d628 100644
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
index 1a5d44a..5f3bea7 100644
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
