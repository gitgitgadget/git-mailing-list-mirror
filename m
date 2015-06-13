From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 05/12] delete_refs(): improve error message
Date: Sat, 13 Jun 2015 16:42:08 +0200
Message-ID: <64949bba1031b19abf86629267b8bc40666a4631.1434206062.git.mhagger@alum.mit.edu>
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
	id 1Z3me2-0007iJ-E8
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 16:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbbFMOml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 10:42:41 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59715 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753294AbbFMOm3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 10:42:29 -0400
X-AuditID: 12074414-f79ed6d000000cef-8c-557c41515e75
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 6B.C6.03311.1514C755; Sat, 13 Jun 2015 10:42:25 -0400 (EDT)
Received: from michael.fritz.box (p5DDB10EE.dip0.t-ipconnect.de [93.219.16.238])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5DEgGpT026136
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 13 Jun 2015 10:42:24 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434206062.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqBvoWBNq8HGfoEXXlW4mi4beK8wW
	t1fMZ7b40dLDbLF5czuLA6vH3/cfmDwWbCr1eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/b3vmIveMRW8W7ZVZYGxqWsXYycHBICJhIHW1cwQthiEhfurWfrYuTiEBK4zCgx/fBR
	VgjnBJPEn/37mUCq2AR0JRb1NIPZIgJqEhPbDrGAFDELdDBKXFi+jb2LkYNDWMBOYuLtIhCT
	RUBV4tX6YpByXoEoiV9L/zFDLJOTOH/8JzNICaeAhcTLpkyQsJCAucTbFe2sExh5FzAyrGKU
	S8wpzdXNTczMKU5N1i1OTszLSy3StdDLzSzRS00p3cQICSeRHYxHTsodYhTgYFTi4c2IrQ4V
	Yk0sK67MPcQoycGkJMobuQcoxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXULsmVIg3JbGyKrUo
	HyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoNDSYJX2gGoUbAoNT21Ii0zpwQhzcTBCTKc
	S0qkODUvJbUosbQkIx4UF/HFwMgASfEA7ZUHaectLkjMBYpCtJ5i1OVY8OP2WiYhlrz8vFQp
	cV4JkCIBkKKM0jy4FbDk8YpRHOhjYV4PkCoeYOKBm/QKaAkT0JL2niqQJSWJCCmpBkZFkfDL
	zSnsxptXv1vPlxMrWqD6sPfNqv+bogrWlfQGznnBnFsqEKDBu8hGaNKxXaEVzbM7j67sYJmV
	YHgn74VtnfWC+wo7dLRr5tW+zan8Ol2fjWNmpx/vnrt/VzVU9AR36zDE6e36ULGv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271551>

Change the error message from

    Could not remove branch %s

to

    could not remove reference %s

* s/branch/reference/. This change makes sense even for the existing
  caller, which uses the function to delete remote-tracking
  branches.

* Convert it to lower case, as per our usual convention.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6f62bd1..5386077 100644
--- a/refs.c
+++ b/refs.c
@@ -2831,7 +2831,7 @@ int delete_refs(struct string_list *refnames)
 		const char *refname = refnames->items[i].string;
 
 		if (delete_ref(refname, NULL, 0))
-			result |= error(_("Could not remove branch %s"), refname);
+			result |= error(_("could not remove reference %s"), refname);
 	}
 
 	return result;
-- 
2.1.4
