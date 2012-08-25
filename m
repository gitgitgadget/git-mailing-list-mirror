From: mhagger@alum.mit.edu
Subject: [PATCH v2 14/17] Report missing refs even if no existing refs were received
Date: Sat, 25 Aug 2012 08:44:24 +0200
Message-ID: <1345877067-11841-15-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7q-0002ps-9y
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2HYGpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:36 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:62816 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752941Ab2HYGp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:29 -0400
X-AuditID: 1207440f-b7fde6d00000095c-f5-5038748864d4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id DC.C4.02396.88478305; Sat, 25 Aug 2012 02:45:28 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSp011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:27 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqNtZYhFgsDraoutKN5NFQ+8VZovb
	K+YzW/xo6WG26Jwq68Dq8ff9ByaP5UvXMXo8693D6HHxkrLH501yAaxR3DZJiSVlwZnpefp2
	CdwZOzekFszirFjX9Y+pgXEPexcjJ4eEgInEg88zoWwxiQv31rN1MXJxCAlcZpS4+6WDFcI5
	yyRxYO8vRpAqNgEpiZeNPWAdIgJqEhPbDrGAFDELdDFKLF/3iw0kISwQInFi6lFmEJtFQFVi
	16t9QDYHB6+Aq8St+1oQ2xQlfnxfA1bCCRSe8Osi2EwhAReJpmNXWCYw8i5gZFjFKJeYU5qr
	m5uYmVOcmqxbnJyYl5dapGuil5tZopeaUrqJERJO/DsYu9bLHGIU4GBU4uG9ccY8QIg1say4
	MvcQoyQHk5Ior1ihRYAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7vDEA53pTEyqrUonyYlDQH
	i5I4r/oSdT8hgfTEktTs1NSC1CKYrAwHh5IErxEwboQEi1LTUyvSMnNKENJMHJwgggtkAw/Q
	hrvFIBuKCxJzizPTIYpOMSpKifNygkwQAElklObBDYBF/itGcaB/hHlnFgFV8QCTBlz3K6DB
	TECDy13NQQaXJCKkpBoYxX8f/3Z7o16Ml5jldQMXh697Aw10ucP312gkNTSGnoq42sAiUykg
	tLjsWpeoh5xQ9Z7XQl2rNn1YY/Bb70mC6YKVyd2urYWMyxVLTkffrd8hvFSzanV79rucledZ
	7Kr57vTPFLv1/tFxY965E89nve+ZPL9xf1iqZ8/BRSXrdwUqFflP1LyqxFKckWio 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204257>

From: Michael Haggerty <mhagger@alum.mit.edu>

This fixes a test in t5500.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 2 +-
 t/t5500-fetch-pack.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f04fd59..00ac3b1 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1028,7 +1028,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	ret = !ref;
-	if (ref && nr_heads) {
+	if (nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 0d4edcb..f78a118 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -403,7 +403,7 @@ test_expect_success 'set up tests of missing reference' '
 	EOF
 '
 
-test_expect_failure 'test lonely missing ref' '
+test_expect_success 'test lonely missing ref' '
 	(
 	cd client &&
 	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
-- 
1.7.11.3
