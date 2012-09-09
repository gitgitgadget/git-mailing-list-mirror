From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 01/14] t5500: add tests of error output for missing refs
Date: Sun,  9 Sep 2012 08:19:36 +0200
Message-ID: <1347171589-13327-2-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAatT-0002cs-Nm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2IIGUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:20:38 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:47922 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751867Ab2IIGU1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:27 -0400
X-AuditID: 1207440d-b7f236d000000943-d5-504c352a1719
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DC.F1.02371.A253C405; Sun,  9 Sep 2012 02:20:26 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIle029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:25 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqKtl6hNgMHu+rEXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M1p6rjMW/OOuOPd2LUsD4zPOLkYODgkBE4n3DXVdjJxAppjEhXvr2boYuTiEBC4zShye
	d58FwjnDJHGvfQETSBWbgK7Eop5mMFtEQE1iYtshsCJmgS5GieXrfrGBJIQFvCX+/3nJAmKz
	CKhK/P6zmhnE5hVwkdi7/DYbxDpFiR/f14DFOQVcJV7N3M0IYgsB1WzaeY11AiPvAkaGVYxy
	iTmlubq5iZk5xanJusXJiXl5qUW6Rnq5mSV6qSmlmxghIcW7g/H/OplDjAIcjEo8vMx3vAOE
	WBPLiitzDzFKcjApifJqmPgECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhvcoOlONNSaysSi3K
	h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAagwwVLEpNT61Iy8wpQUgzcXCCCC6Q
	DTxAG4JBCnmLCxJzizPTIYpOMSpKifOWgSQEQBIZpXlwA2DR/4pRHOgfYd5akCoeYOKA634F
	NJgJaLDIMw+QwSWJCCmpBsburaafl+c7Nm4yenhEa7LI6TwnKfv9/sFJ6ydxCc07xve7xcfE
	UO6m08Y9G1I3tEcsm+5gkaggf3XFYdXw2gPmblOetH0QCOUOeJ2w+Nx1Z7ElKVraCgKbLH7/
	2Nd59eDLeJm2qskrbq2pef9nVpj3DqfK+T+udF2cdXlu08cbBo0bmJ9VyiYpsRRn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205051>

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
index e80a2af..6fa1cef 100755
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
+		cd client &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy
+	) >/dev/null 2>error-m &&
+	test_cmp expect-error error-m
+'
+
+test_expect_success 'test missing ref after existing' '
+	(
+		cd client &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/A refs/heads/xyzzy
+	) >/dev/null 2>error-em &&
+	test_cmp expect-error error-em
+'
+
+test_expect_success 'test missing ref before existing' '
+	(
+		cd client &&
+		test_must_fail git fetch-pack --no-progress .. refs/heads/xyzzy refs/heads/A
+	) >/dev/null 2>error-me &&
+	test_cmp expect-error error-me
+'
+
 test_done
-- 
1.7.11.3
