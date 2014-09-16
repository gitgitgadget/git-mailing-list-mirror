From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 25/35] try_merge_strategy(): remove redundant lock_file allocation
Date: Tue, 16 Sep 2014 21:33:46 +0200
Message-ID: <1410896036-12750-26-git-send-email-mhagger@alum.mit.edu>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Ronnie Sahlberg <sahlberg@google.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTyWf-0000NU-OO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 21:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbaIPTez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 15:34:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52831 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755051AbaIPTey (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Sep 2014 15:34:54 -0400
X-AuditID: 12074413-f79ed6d000002501-d8-541890ddcbda
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E6.BC.09473.DD098145; Tue, 16 Sep 2014 15:34:53 -0400 (EDT)
Received: from michael.fritz.box (p5DDB27D9.dip0.t-ipconnect.de [93.219.39.217])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8GJYBcT001163
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Sep 2014 15:34:52 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IRYndR1L07QSLE4OpdG4uuK91MFg29V5gt
	nsy9y2xxe8V8ZosfLT3MFv8m1Fh0dnxldGD3+Pv+A5PHgk2lHg9fdbF7POvdw+hx8ZKyx+dN
	ch63n21jCWCP4rZJSiwpC85Mz9O3S+DO2Pj7DXvBOfaKNZPaWRsYZ7B1MXJySAiYSGz4cZEJ
	whaTuHBvPVCci0NI4DKjxMS2NhYI5wSTxJOr58Gq2AR0JRb1NDOBJEQE2hgldl3czAriMAt0
	M0q8P3EarEpYIFRiZ/tpsB0sAqoSd1a1MHYxcnDwCrhKzNuiCrFOTmLD7v9gYU6g8Nd9BSCm
	kICLxMG7fhMYeRcwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXXy80s0UtNKd3ECAk74R2M
	u07KHWIU4GBU4uH1eCQeIsSaWFZcmXuIUZKDSUmU91+3RIgQX1J+SmVGYnFGfFFpTmrxIUYJ
	DmYlEd4fvkA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IELx8wvoQE
	i1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQZERXwyMDZAUD9BebZB23uKCxFygKETr
	KUZjjpamt71MHOs6v/UzCbHk5eelSonz2vQDlQqAlGaU5sEtgiWcV4ziQH8LQwzkASYruHmv
	gFYxAa062yMGsqokESEl1cDIqRW8ozSi5OL2hhLBlevj2jWcFeedtH3In7+OxTlzb4drjoBP
	9r9zNrkPdZ/U3mvfuvxgj6JWZN0rXdfFXFW3v53Qe7ZQiHHzz+Oq6mkSS+T/p37i 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257154>

By the time the "if" block is entered, the lock_file instance from the
main function block is no longer in use, so re-use that one instead of
allocating a second one.

Note that the "lock" variable in the "if" block shadowed the "lock"
variable at function scope, so the only change needed is to remove the
inner definition.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/merge.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 9da9e30..6b430f0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -668,7 +668,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
 		int clean, x;
 		struct commit *result;
-		struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
 		struct commit_list *reversed = NULL;
 		struct merge_options o;
 		struct commit_list *j;
-- 
2.1.0
