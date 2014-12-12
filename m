From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 15/24] expire_reflog(): pass flags through to expire_reflog_ent()
Date: Fri, 12 Dec 2014 09:56:54 +0100
Message-ID: <1418374623-5566-16-git-send-email-mhagger@alum.mit.edu>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 09:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzM3B-00052F-O1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 09:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965448AbaLLI6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 03:58:06 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43826 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934040AbaLLI5c (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Dec 2014 03:57:32 -0500
X-AuditID: 1207440f-f792a6d000001284-e7-548aadfc3bcc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 4C.47.04740.CFDAA845; Fri, 12 Dec 2014 03:57:32 -0500 (EST)
Received: from michael.fritz.box (p5DDB074C.dip0.t-ipconnect.de [93.219.7.76])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBC8v9nP023104
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 12 Dec 2014 03:57:31 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPtnbVeIwf7DIhZdV7qZLBp6rzBb
	vL25hNHi9or5zBa9fZ9YLTZvbmdxYPP4+/4Dk8fOWXfZPRZsKvW4eEnZ4/MmuQDWKG6bpMSS
	suDM9Dx9uwTujLPte1gKfrJVLLn/iqmB8TJrFyMnh4SAicS9g1fZIGwxiQv31gPZXBxCApcZ
	JTYffMII4Rxjkvg6+TRYB5uArsSinmYmEFtEQE1iYtshFhCbWeAEo8TshhAQW1ggRKL1ewsz
	iM0ioCqx8/Y2MJtXwEWi9csToHoOoG1yElvXeYOEOYHCF1uegI0REnCW2Lqik3UCI+8CRoZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCGhxb+DsWu9zCFGAQ5GJR7eF6ld
	IUKsiWXFlbmHGCU5mJREeb9PBgrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4f0bBZTjTUmsrEot
	yodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwxq0BahQsSk1PrUjLzClBSDNxcIIM
	55ISKU7NS0ktSiwtyYgHRUZ8MTA2QFI8QHvZ1oLsLS5IzAWKQrSeYtTlWNC+fyaTEEtefl6q
	lDhvK8gOAZCijNI8uBWwRPKKURzoY2HeOpAqHmASgpv0CmgJE9CS5Vs6QJaUJCKkpBoYk4oV
	uPmY05XK+h5NaLdJYrqyYHqQ8mujB4XTCyY2LhG7OUuqN5rP+Yf6yoq1z9bf27+6wnv9wdiA
	0lnXf10PecKsNW/buq2662TdVv5ba8nIvXeC68YNat5S/pkHPtUHF8cfLZjyNelo 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261336>

Add a flags field to "struct expire_reflog_cb", and pass the flags
argument through to expire_reflog_ent(). In a moment we will start
using it to pass through flags that expire_reflog_ent() needs.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9ee66d4..08867a2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -51,6 +51,7 @@ struct expire_reflog_policy_cb {
 };
 
 struct expire_reflog_cb {
+	unsigned int flags;
 	void *policy_cb;
 };
 
@@ -435,6 +436,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 
 	memset(&cb, 0, sizeof(cb));
 	memset(&policy_cb, 0, sizeof(policy_cb));
+	cb.flags = flags;
 	cb.policy_cb = &policy_cb;
 
 	/*
-- 
2.1.3
