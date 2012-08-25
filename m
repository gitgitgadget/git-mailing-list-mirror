From: mhagger@alum.mit.edu
Subject: [PATCH v2 15/17] cmd_fetch_pack(): simplify computation of return value
Date: Sat, 25 Aug 2012 08:44:25 +0200
Message-ID: <1345877067-11841-16-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A82-00031W-3r
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab2HYGpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:41 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:42292 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752994Ab2HYGpb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:31 -0400
X-AuditID: 1207440c-b7f616d00000270b-5b-5038748b59ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D9.E4.09995.B8478305; Sat, 25 Aug 2012 02:45:31 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSq011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:29 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsUixO6iqNtdYhFg8H85t0XXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4MxpfPWIpeMtV8ebKW+YGxoMcXYycHBICJhLzv65nhLDFJC7cW88GYgsJXGaUaF9a3cXI
	BWSfZZK4vnANWIJNQEriZWMPO4gtIqAmMbHtEAtIEbNAF6PE8nW/wIqEBQIk3vRdAJvKIqAq
	0Xa4nxnE5hVwlVj/4i3UNkWJH9/XgMU5geITfl1kh9jsItF07ArLBEbeBYwMqxjlEnNKc3Vz
	EzNzilOTdYuTE/PyUot0DfVyM0v0UlNKNzFCQopnB+O3dTKHGAU4GJV4eG+cMQ8QYk0sK67M
	PcQoycGkJMorVmgRIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE9zsDUI43JbGyKrUoHyYlzcGi
	JM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMG7pxioUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUv
	JbUosbQkIx4UG/HFwOgASfEA7Z0P0s5bXJCYCxSFaD3FqMvx/+TJu4xCLHn5ealS4ryzQYoE
	QIoySvPgVsASyCtGcaCPhXlnFgFV8QCTD9ykV0BLmICWlLuagywpSURISTUw2ieols7cvnIt
	p8O/N7VC10PPGO2UmHabaXPrUVWthE4WnsiVcbP6gjI0FqZ8VT2wKFovadebyUwr5zyd4JA+
	uVNgtWblkx9RYm++u/44yKSw6sgeu/69RhI6R6bv+zspYFrWVWbJ2wu11l1jPxaU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204258>

From: Michael Haggerty <mhagger@alum.mit.edu>

Set the final value at initialization rather than initializing it then
sometimes changing it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 00ac3b1..c49dadf 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1027,17 +1027,16 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	if (finish_connect(conn))
 		return 1;
 
-	ret = !ref;
-	if (nr_heads) {
-		/* If the heads to pull were given, we should have
-		 * consumed all of them by matching the remote.
-		 * Otherwise, 'git fetch remote no-such-ref' would
-		 * silently succeed without issuing an error.
-		 */
-		for (i = 0; i < nr_heads; i++)
-			error("no such remote ref %s", heads[i]);
-		ret = 1;
-	}
+	ret = !ref || nr_heads;
+
+	/*
+	 * If the heads to pull were given, we should have consumed
+	 * all of them by matching the remote.  Otherwise, 'git fetch
+	 * remote no-such-ref' would silently succeed without issuing
+	 * an error.
+	 */
+	for (i = 0; i < nr_heads; i++)
+		error("no such remote ref %s", heads[i]);
 	while (ref) {
 		printf("%s %s\n",
 		       sha1_to_hex(ref->old_sha1), ref->name);
-- 
1.7.11.3
