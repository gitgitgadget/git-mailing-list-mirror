From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Add test-string-list.c
Date: Sat,  4 Sep 2010 23:34:21 -0300
Message-ID: <4f798daaf4631e00927b455b77919d5bb8fade03.1283653854.git.tfransosi@gmail.com>
Cc: gister@pobox.com, Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 04:34:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os54H-0007Cp-21
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 04:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab0IECef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 22:34:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57561 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab0IECee (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 22:34:34 -0400
Received: by gyd8 with SMTP id 8so1296038gyd.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 19:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=T6na4cIBCFTl0nkAbyzXXzQvKPU6dpNHu6v00O4ltUs=;
        b=UOuZWVpkClJZUOXoD8Sr5s3w3KRNjnjty+lwpEOgqWW6cD98Dq5cPbpWS3qvvAo4XR
         EPCySX/kjnCZrmOPeFct2w3wgC+q83yjJGp0QMYnm3yXbUwCT2B18jed8uSwZDg+zDzn
         7ifG9k5FC35nc0rhMYiIwf4PY/b7HXNVb3Ubs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=pvmLFCdzE8RAUq2MggEDAUoETLpX82onp36xAsjgA8oblqUZN7Mboh3vdFQVrvK8pa
         4XWFe46xNI1cPv0JT0jzVWoHN4GFhfa7vmfHJWLKqpW495NR3tJgKc61P75iT+USz6MY
         kHMF17/QJfyArlwOmOonJlmH8Eq8r0rYAsTIc=
Received: by 10.150.50.7 with SMTP id x7mr686328ybx.432.1283654073687;
        Sat, 04 Sep 2010 19:34:33 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id t20sm1974267ybm.17.2010.09.04.19.34.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 19:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155412>

Add a simple test that demonstrates how to create and manipulate
a list of strings using the string-list.h API.

To see the test, call it by:
./bin-wrappers/test-string-list.c

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Makefile           |    1 +
 test-string-list.c |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 test-string-list.c

diff --git a/Makefile b/Makefile
index 40fbcae..287bc2c 100644
--- a/Makefile
+++ b/Makefile
@@ -422,6 +422,7 @@ TEST_PROGRAMS_NEED_X += test-string-pool
 TEST_PROGRAMS_NEED_X += test-svn-fe
 TEST_PROGRAMS_NEED_X += test-treap
 TEST_PROGRAMS_NEED_X += test-index-version
+TEST_PROGRAMS_NEED_X += test-string-list
 
 TEST_PROGRAMS = $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
 
diff --git a/test-string-list.c b/test-string-list.c
new file mode 100644
index 0000000..11b8a7f
--- /dev/null
+++ b/test-string-list.c
@@ -0,0 +1,29 @@
+#include <stdio.h>
+#include <string.h>
+#include "string-list.h"
+
+int main(int argc, const char **argv)
+{
+	struct string_list list;
+	int i;
+
+	memset(&list, 0, sizeof(struct string_list));
+
+	string_list_append(&list, "foo");
+	string_list_append(&list, "bar");
+
+	for (i = 0; i < list.nr; i++)
+		printf("%s\n", list.items[i].string);
+
+	print_string_list(&list, "");
+
+        int has_foo = string_list_has_string(&list, "foo");
+	if (has_foo != 1)
+		error("List doesn't have foo.");
+
+	string_list_clear(&list, 0);
+	if (list.nr > 0)
+		error("List is not clear.");
+
+	return 0;
+}
-- 
1.7.2.3.313.gcd15
