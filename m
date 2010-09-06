From: Thiago Farina <tfransosi@gmail.com>
Subject: [Patch v2] Add test-string-list.c
Date: Mon,  6 Sep 2010 20:43:23 -0300
Message-ID: <1283816603-12156-1-git-send-email-tfransosi@gmail.com>
Cc: gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 07 01:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OslLr-0002aX-VV
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 01:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab0IFXne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 19:43:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47725 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0IFXnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 19:43:32 -0400
Received: by gxk23 with SMTP id 23so1763637gxk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=UqIUWpLrbUmcj26omfvEue/cytMrW/gk7XBO+P1zcj0=;
        b=khGJRvN8cm5HJc988ZSBhd2Odm+cKPce0bC0ma2+vgB+yRqZirxZ1d84imDX1k6WlS
         qWQLsw7DnDOty2WcgrrGqnRSZBGcv0JydLaVt/PVDC7EbWJ7zmuEriGTvQJOcjzm3xIY
         7sMsfsq3mQBiq3q8mSG8z9M+o/dzKd43cNtpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=on6HcbNy3moU6sI2IWTS5g6Y32SUEE0LBe9fAwhkpLlPn1UjGelKvzzmB6PKKH2lky
         FTEWEsHwXNM5TxlnAQJHC3BnQxucRK8cDPxNsrddzSe+2b16jojvET1F1i0qBf7/FX7n
         ums1XLig0PaJMS6nvHPPP7+w7PSD4Ni4cSXvI=
Received: by 10.100.197.7 with SMTP id u7mr2308505anf.104.1283816612016;
        Mon, 06 Sep 2010 16:43:32 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id x19sm10149683anc.5.2010.09.06.16.43.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 16:43:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155642>

Add a simple test that demonstrates how to create and manipulate
a list of strings using the string-list.h API.

To see the test, call it by:
./bin-wrappers/test-string-list.c

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Makefile           |    1 +
 test-string-list.c |   27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)
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
index 0000000..267db4c
--- /dev/null
+++ b/test-string-list.c
@@ -0,0 +1,27 @@
+#include "git-compat-util.h"
+#include "string-list.h"
+
+int main(int argc, const char **argv)
+{
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	int i;
+	int has_foo;
+
+	string_list_append(&list, "foo");
+	string_list_append(&list, "bar");
+
+	for (i = 0; i < list.nr; i++)
+		printf("%s\n", list.items[i].string);
+
+	print_string_list(&list, "");
+
+	has_foo = string_list_has_string(&list, "foo");
+	if (has_foo != 1)
+		return error("List doesn't have foo.");
+
+	string_list_clear(&list, 0);
+	if (list.nr > 0)
+		return error("List is not clear.");
+
+	return 0;
+}
-- 
1.7.2.3.313.gcd15
