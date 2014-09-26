From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 13/39] prepare_index(): declare return value to be (const char *)
Date: Fri, 26 Sep 2014 12:08:13 +0200
Message-ID: <1411726119-31598-14-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSt-0003oZ-UR
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755739AbaIZKJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:09:16 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:63115 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755685AbaIZKJM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:09:12 -0400
X-AuditID: 1207440c-f79036d000005e77-f5-54253b474b02
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 42.55.24183.74B35245; Fri, 26 Sep 2014 06:09:12 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLw013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:09:10 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42IRYndR1PWwVg0xaF7GaNF1pZvJoqH3CrPF
	k7l3mS3e3lzCaHF7xXxmix8tPcwW/ybUWHR2fGV04PD4+/4Dk8fOWXfZPRZsKvV4+KqL3eNZ
	7x5Gj4uXlD0+b5LzuP1sG0sARxS3TVJiSVlwZnqevl0Cd8aW5YtZCiZzVLxtb2dsYLzK1sXI
	ySEhYCLxtOs1M4QtJnHh3nqgOBeHkMBlRoldt94wQTibmCSeHV/HAlLFJqArsainmQnEFhFQ
	k5jYdogFpIhZYDGTxIRDm8DGCguESGzq2w9WxCKgKrH6+g6wZl4BV4nTrzazQKyTk9iw+z8j
	iM0JFG/cfg3MFhJwkWhZP5llAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6
	qSmlmxgh4cizg/HbOplDjAIcjEo8vA1rVEKEWBPLiitzDzFKcjApifJ+sVANEeJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCe8cIKMebklhZlVqUD5OS5mBREudVXaLuJySQnliSmp2aWpBaBJOV
	4eBQkuC1sgJqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFR3wxMD5AUjxAez1A
	2nmLCxJzgaIQracYdTnWdX7rZxJiycvPS5US5z1iCVQkAFKUUZoHtwKWfF4xigN9LMwrAjKK
	B5i44Ca9AlrCBLRE6YgyyJKSRISUVAOj1J85LAtaTr2ye5omsvn9vz8NRRkzXUQd1t19dvm6
	542r7RUrWZp996RuCDG2PXFShaV5j138Xl++bcWcemHHtlxzMvwr4RZ5udTmWWde 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257510>

Declare the return value to be const to make it clear that we aren't
giving callers permission to write over the string that it points at.
(The return value is the filename field of a struct lock_file, which
can be used by a signal handler at any time and therefore shouldn't be
tampered with.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b0fe784..70f5935 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -315,8 +315,8 @@ static void refresh_cache_or_die(int refresh_flags)
 		die_resolve_conflict("commit");
 }
 
-static char *prepare_index(int argc, const char **argv, const char *prefix,
-			   const struct commit *current_head, int is_status)
+static const char *prepare_index(int argc, const char **argv, const char *prefix,
+				 const struct commit *current_head, int is_status)
 {
 	struct string_list partial;
 	struct pathspec pathspec;
-- 
2.1.0
