From: mhagger@alum.mit.edu
Subject: [PATCH 2/7] absolute_path(): reject the empty string
Date: Tue,  4 Sep 2012 10:14:25 +0200
Message-ID: <1346746470-23127-3-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oIE-0007XV-FU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab2IDIPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:15:21 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:58284 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000Ab2IDIPL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:15:11 -0400
X-AuditID: 12074413-b7f786d0000008bb-0e-5045b88e6995
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 84.03.02235.E88B5405; Tue,  4 Sep 2012 04:15:10 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSW025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:09 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqNu3wzXAYP8dPouuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGUv/HmMt
	uMBR0ffxJFsD4w+2LkZODgkBE4kXDyYxQthiEhfurQeKc3EICVxmlDi5fBoLhHOaSeLG1ktg
	HWwCUhIvG3vYQWwRATWJiW2HWEBsZoF0iRML2sFsYQFbiTu3vzKB2CwCqhK923eCbeAVcJE4
	fOI9C8Q2RYkf39cwg9icAq4Srz68BprPAbTMReLjA+cJjLwLGBlWMcol5pTm6uYmZuYUpybr
	Ficn5uWlFuma6+VmluilppRuYoSEj/AOxl0n5Q4xCnAwKvHwVn1yCRBiTSwrrsw9xCjJwaQk
	ymu32TVAiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv7dVAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/
	IYH0xJLU7NTUgtQimKwMB4eSBO++7UCNgkWp6akVaZk5JQhpJg5OEMEFsoEHaMMjkELe4oLE
	3OLMdIiiU4yKUuK8N0ASAiCJjNI8uAGwSH/FKA70jzDva5AqHmCSgOt+BTSYCWiw63sXkMEl
	iQgpqQZG3/tPAjKU57C4FlfECe46vFxnEePDzNDmf32W6WrpR7ccVWNeedZSPfWhW+DmAMei
	Pc1bQhp/WsWdn8ZqckU45NOff49Olm3pUu4Icb9+/9ZpyxXRLjcm6jI0Tk0KLlLk8lDr/18i
	JnqLWeVF8ZG3h/Zd+qvk8uj3GSbnf1eTCjWy/hauZWxTYinOSDTUYi4qTgQAW5zi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204721>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c        | 4 +++-
 t/t0000-basic.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index f04ac18..5d62430 100644
--- a/abspath.c
+++ b/abspath.c
@@ -123,7 +123,9 @@ const char *absolute_path(const char *path)
 {
 	static char buf[PATH_MAX + 1];
 
-	if (is_absolute_path(path)) {
+	if (!*path) {
+		die("The empty string is not a valid path");
+	} else if (is_absolute_path(path)) {
 		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
 			die("Too long path: %.*s", 60, path);
 	} else {
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 7347fb8..5963a6c 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -450,7 +450,7 @@ test_expect_success 'update-index D/F conflict' '
 	test $numpath0 = 1
 '
 
-test_expect_failure 'absolute path rejects the empty string' '
+test_expect_success 'absolute path rejects the empty string' '
 	test_must_fail test-path-utils absolute_path ""
 '
 
-- 
1.7.11.3
