From: mhagger@alum.mit.edu
Subject: [PATCH 08/17] Pass nr_heads to everything_local() by reference
Date: Thu, 23 Aug 2012 10:10:33 +0200
Message-ID: <1345709442-16046-9-git-send-email-mhagger@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:19:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sdm-0001fQ-Nz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933729Ab2HWITb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:19:31 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:57764 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933726Ab2HWITG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 04:19:06 -0400
X-AuditID: 12074412-b7f216d0000008e3-35-5035e5aad833
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8F.B8.02275.AA5E5305; Thu, 23 Aug 2012 04:11:22 -0400 (EDT)
Received: from michael.fritz.box (p57A2588E.dip.t-dialin.net [87.162.88.142])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7N8AkV8030408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 23 Aug 2012 04:11:21 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqLvqqWmAwepZ5hZdV7qZLBp6rzBb
	3F4xn9niR0sPswOLx9/3H5g8nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujN2P/zEX
	zOKqWLbgB3MD4yqOLkZODgkBE4mrkxYwQdhiEhfurWfrYuTiEBK4zChxumEllHOWSWL1xddg
	VWwCUhIvG3vYQWwRATWJiW2HWEBsZoEUiY7n3YwgtrCAu8SV3zeAajg4WARUJfYvAyvnFXCR
	aLzxlAVimaLEj+9rmEFsTgFXiQXfN4G1CgHVfGy8yTyBkXcBI8MqRrnEnNJc3dzEzJzi1GTd
	4uTEvLzUIl0zvdzMEr3UlNJNjJDwEdrBuP6k3CFGAQ5GJR7eF+amAUKsiWXFlbmHGCU5mJRE
	ef89AgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Q2fB5TjTUmsrEotyodJSXOwKInz/lys7ick
	kJ5YkpqdmlqQWgSTleHgUJLglQTGiZBgUWp6akVaZk4JQpqJgxNEcIFs4AHaoAhSyFtckJhb
	nJkOUXSKUVFKnNcEJCEAksgozYMbAIv0V4ziQP8I87qDVPEAkwRc9yugwUxAg9WuGoMMLklE
	SEk1MO6R8p4Q0nDqWwdTfKHD2WDW344BCn/dDyRXH/BPvnuxoeFKhEzyohJ55o5NOg/asu5s
	9J34YrX85LKtExYL7cyq5TztdDpzQkvRmtPLjDXLEmTUjrxsSxDvENZ++TJw2uz/xyd4pzoc
	iG7PcUmYKsEqffva8WDxbfmhig+2Pux/UX1QULnwtxJLcUaioRZzUXEiANpkM1XP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204130>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index d3ff166..5905dae 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -595,7 +595,7 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
 
-static int everything_local(struct ref **refs, int nr_heads, char **heads)
+static int everything_local(struct ref **refs, int *nr_heads, char **heads)
 {
 	struct ref *ref;
 	int retval;
@@ -646,7 +646,7 @@ static int everything_local(struct ref **refs, int nr_heads, char **heads)
 		}
 	}
 
-	filter_refs(refs, nr_heads, heads);
+	filter_refs(refs, *nr_heads, heads);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -818,7 +818,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, *nr_heads, heads)) {
+	if (everything_local(&ref, nr_heads, heads)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-- 
1.7.11.3
