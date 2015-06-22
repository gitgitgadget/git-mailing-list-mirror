From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 05/19] delete_refs(): make error message more generic
Date: Mon, 22 Jun 2015 16:02:56 +0200
Message-ID: <feb52672f14a4c664478ac65664c3bfd6405e3a8.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:03:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72K5-0005Z7-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933599AbbFVODg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:03:36 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50088 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756323AbbFVOD0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:26 -0400
X-AuditID: 1207440c-f79e16d000002a6e-e3-558815a9599c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.D4.10862.9A518855; Mon, 22 Jun 2015 10:03:21 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3Cc3030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:20 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtStCPU4OghXYuuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ0xaPY+5YAdnxe72f6wNjIfZuxg5OSQETCTuvbnDAmGLSVy4t54NxBYSuMwo8WZqUBcj
	F5B9kkni0rrTYA1sAroSi3qamUBsEQE1iYlth1hAipgFOhglLizfBlYkLOAh8elWCzOIzSKg
	KjHzfDfYVF6BKInvr45CbZaTOH/8J1gNp4CFxPx9/9khNptLTJz5iGUCI+8CRoZVjHKJOaW5
	urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCEhxbOD8ds6mUOMAhyMSjy8DrbtoUKsiWXF
	lbmHGCU5mJREeQ+8BgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4W05C5TjTUmsrEotyodJSXOw
	KInzqi5R9xMSSE8sSc1OTS1ILYLJynBwKEnw+ol0hAoJFqWmp1akZeaUIKSZODhBhnNJiRSn
	5qWkFiWWlmTEg2IjvhgYHSApHqC9S0HaeYsLEnOBohCtpxgVpcR5/UESAiCJjNI8uLGwRPGK
	URzoS2Hen8JAVTzAJAPX/QpoMBPQ4C+5bSCDSxIRUlINjNO9e7x+nOb4v9G72kde3vNZ8n8u
	I8lO1aRJi7qlWK5/9ZaMefc83Li97MFW7jlX7L+Xnix89PZBRUfk5orp/ziTXs/Pb7R4wJcY
	MKP4HYvnwtBNDQV2rHKLwprr9mafE3jqNYVpz3a/NfvjuyJDLfh3H4rbdebA2f4q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272346>

Change the error message from

    Could not remove branch %s

to

    could not remove reference %s

First of all, the old error message referred to "branch
refs/remotes/origin/foo", which was awkward even for the existing
caller. Normally we would refer to a reference like that as either
"remote-tracking branch origin/foo" or "reference
refs/remotes/origin/foo". Here I take the lazier alternative.

Moreover, now that this function is part of the refs API, it might be
called for refs that are neither branches nor remote-tracking
branches.

While we're at it, convert the error message to lower case, as per our
usual convention.

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
