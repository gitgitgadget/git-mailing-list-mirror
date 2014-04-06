From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 16/25] commit_lock_file(): inline temporary variable
Date: Mon,  7 Apr 2014 01:33:58 +0200
Message-ID: <1396827247-28465-17-git-send-email-mhagger@alum.mit.edu>
References: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 01:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWwc3-00074B-Fa
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 01:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbaDFXgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 19:36:02 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46560 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754649AbaDFXfN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 19:35:13 -0400
X-AuditID: 1207440c-f79656d000003eba-43-5341e4b02d9d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A3.41.16058.0B4E1435; Sun,  6 Apr 2014 19:35:12 -0400 (EDT)
Received: from michael.fritz.box (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36NYbX3011578
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 19:35:11 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396827247-28465-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsUixO6iqLvhiWOwwdYDehZdV7qZLBp6rzBb
	3F4xn9ni1+En7BY/WnqYLc68aWS06Oz4yujA7vH3/Qcmj52z7rJ7POvdw+hx8ZKyx+IHXh6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO+P5+lusBf9ZK3729bI3ML5j6WLk5JAQMJE4Pv0f
	O4QtJnHh3nq2LkYuDiGBy4wS/1afhXKOM0ksbX3EBlLFJqArsainmQnEFhFQk5jYdogFpIhZ
	4AajxLt9h8HGCgu4S/yd+wOogYODRUBV4uXCdBCTV8BV4vKuOIhlchInj01mBbE5gcLrJs8F
	6xQScAGaco9tAiPvAkaGVYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxghgcez
	g/HbOplDjAIcjEo8vCsOOQYLsSaWFVfmHmKU5GBSEuV98BgoxJeUn1KZkVicEV9UmpNafIhR
	goNZSYT3wA2gHG9KYmVValE+TEqag0VJnFd1ibqfkEB6YklqdmpqQWoRTFaGg0NJgrcPZKhg
	UWp6akVaZk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KDLii4GxAZLiAdo7HaSdt7ggMRcoCtF6
	ilFRSpx35iOghABIIqM0D24sLJ28YhQH+lKYdxlIOw8wFcF1vwIazAQ0uCHMDmRwSSJCSqqB
	sVjox6zmZpNdAiv8Tucz+VZFWHAG7RPb+Sl4mfly24+P9tvZ13zyjux54qL0cqHiQTuXqW+t
	99jOk1hT+j0kw0r8hudTLQeNi2LhE7qYp3xwiv584OWuuM2OAg5GWTpT1B/khE/V 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245815>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 lockfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index f6bee35..47762c6 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -297,12 +297,14 @@ int close_lock_file(struct lock_file *lk)
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
-	size_t i;
+
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
+
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
-	result_file[i] = 0;
+	/* remove ".lock": */
+	result_file[strlen(result_file) - LOCK_SUFFIX_LEN] = 0;
+
 	if (rename(lk->filename, result_file))
 		return -1;
 	lk->filename[0] = 0;
-- 
1.9.1
