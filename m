From: mhagger@alum.mit.edu
Subject: [PATCH v2 01/17] t5500: add tests of error output for missing refs
Date: Sat, 25 Aug 2012 08:44:11 +0200
Message-ID: <1345877067-11841-2-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7E-00029J-3D
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab2HYGo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:44:59 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:50437 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab2HYGo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:44:57 -0400
X-AuditID: 12074414-b7f846d0000008b8-d4-5038746861fc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AB.16.02232.86478305; Sat, 25 Aug 2012 02:44:56 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSc011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:44:54 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqJtRYhFgsPSdjEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M5rO72MqWMlTseP+efYGxglcXYycHBICJhIf2rYyQdhiEhfurWfrYuTiEBK4zCjxt7WX
	BcI5yyRx/fprRpAqNgEpiZeNPewgtoiAmsTEtkNgRcwCXYwSy9f9YgNJCAt4Szx6+o0VxGYR
	UJXYOXEZC4jNK+AiMfv7AXaIdYoSP76vYQaxOQVcJSb8uggWFwKqaTp2hWUCI+8CRoZVjHKJ
	OaW5urmJmTnFqcm6xcmJeXmpRboWermZJXqpKaWbGCFBJbKD8chJuUOMAhyMSjy8N86YBwix
	JpYVV+YeYpTkYFIS5RUrtAgQ4kvKT6nMSCzOiC8qzUktPsQowcGsJML7nQEox5uSWFmVWpQP
	k5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEkwVtbDNQoWJSanlqRlplTgpBm4uAEEVwg
	G3iANiSDFPIWFyTmFmemQxSdYlSUEuc1AEkIgCQySvPgBsDi/xWjONA/wrwzi4CqeICpA677
	FdBgJqDB5a7mIINLEhFSUg2M03uqD6RMt+292jfxVWXtlesvI5eJSPY9jHkw5esv31nc+z+9
	z18RsTBe+l6L8vqKTbJvm497ZaXpmaaIMpqLKR/5Ka3h4HBQ4ez3l9xRX/p9RdZwO29ovKI1
	OfoAc+i/Z7XnQ03Vt3Xl+r79/VNe5tD37lo9kwOv+L/Un7W/7MD87l/Oxpc3lViK 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204249>

From: Michael Haggerty <mhagger@alum.mit.edu>

If "git fetch-pack" is called with reference names that do not exist
on the remote, then it should emit an error message

    error: no such remote ref refs/heads/xyzzy

This is currently broken if *only* missing references are passed to
"git fetch-pack".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5500-fetch-pack.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index e80a2af..3cc3346 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -397,4 +397,34 @@ test_expect_success 'test duplicate refs from stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up tests of missing reference' '
+	cat >expect-error <<-\EOF
+	error: no such remote ref refs/heads/xyzzy
+	EOF
+'
+
+test_expect_failure 'test lonely missing ref' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
+	) >/dev/null 2>error-m &&
+	test_cmp expect-error error-m
+'
+
+test_expect_success 'test missing ref after existing' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy
+	) >/dev/null 2>error-em &&
+	test_cmp expect-error error-em
+'
+
+test_expect_success 'test missing ref before existing' '
+	(
+	cd client &&
+	test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A
+	) >/dev/null 2>error-me &&
+	test_cmp expect-error error-me
+'
+
 test_done
-- 
1.7.11.3
