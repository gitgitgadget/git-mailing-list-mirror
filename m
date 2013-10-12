From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 02/15] contrib: related: add tests
Date: Sat, 12 Oct 2013 02:06:13 -0500
Message-ID: <1381561584-20529-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNW-00052U-K9
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148Ab3JLHMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:40 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36924 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744Ab3JLHMh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:37 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so3462414obc.17
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQXqxAACCjvngDw9dDLKvDQUmbSp1pUaolB76P8jlS4=;
        b=lh+2tcMGaUBdSg9bNDOHD6b5sXD/aBQ3fnuF1t+YPIwMdpES2tf6WNU/KrwncsgnxE
         L1EB2ihkuyqRvGnxs84jczxi7TrdHcCbh82sjsYjCnERnBEqd+/llrkuoCwVELd9Dyhk
         nLZz6r1aXlMXAVXGARePav8uirZSGsxF3Qa/vZPDG7GjTmzRDezJ7jMt0kfKfanCk0b6
         nawsQViXsIg2EEvgCVFCoo08z22bqIsj8fdGff4wu2l9oG9YalsQXBYiS5ngnL9crXE2
         TkTScbZtIwy1Q3TjrCaF9uLsfvmsm4U81CXSuXlZ1F05H1X1xuC/oGj0m3tv6UUjd25n
         VnOA==
X-Received: by 10.182.242.11 with SMTP id wm11mr17971603obc.26.1381561956360;
        Sat, 12 Oct 2013 00:12:36 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm101394466oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235994>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/Makefile       | 17 +++++++++++++
 contrib/related/test-related.t | 54 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 contrib/related/Makefile
 create mode 100755 contrib/related/test-related.t

diff --git a/contrib/related/Makefile b/contrib/related/Makefile
new file mode 100644
index 0000000..1224fce
--- /dev/null
+++ b/contrib/related/Makefile
@@ -0,0 +1,17 @@
+TESTS := $(wildcard test-*.t)
+
+export T := $(addprefix $(CURDIR)/,$(TESTS))
+export MAKE := $(MAKE) -e
+export PATH := $(CURDIR):$(PATH)
+export TEST_LINT := test-lint-executable test-lint-shell-syntax
+export TEST_DIRECTORY := $(CURDIR)/../../t
+
+all:
+
+test:
+	$(MAKE) -C ../../t $@
+
+$(TESTS): all
+	$(MAKE) -C ../../t $(CURDIR)/$@
+
+.PHONY: all test $(TESTS)
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
new file mode 100755
index 0000000..b69684d
--- /dev/null
+++ b/contrib/related/test-related.t
@@ -0,0 +1,54 @@
+#!/bin/sh
+
+test_description="Test git related"
+
+test -z "$TEST_DIRECTORY" && TEST_DIRECTORY="$PWD/../../t"
+. "$TEST_DIRECTORY"/test-lib.sh
+
+setup() {
+	git init &&
+	echo one > content &&
+	git add content &&
+	git commit -q -m one --author='Pablo Escobar <pablo@escobar.com>' &&
+	echo two >> content &&
+	git commit -q -a -m one --author='Jon Stewart <jon@stewart.com>' &&
+	echo three >> content &&
+	git commit -q -a -m three --author='John Doe <john@doe.com>' &&
+	echo four >> content &&
+	git branch basic &&
+	git commit -q -a -F - --author='John Poppins <john@doe.com>' <<-EOF &&
+	four
+
+	Reviewed-by: Jon Stewart <jon@stewart.com>
+	EOF
+	echo five >> content &&
+	git commit -q -a -m five --author='Mary Poppins <mary@yahoo.com.uk>'
+	git checkout -b next &&
+	echo six >> content &&
+	git commit -q -a -m six --author='Ocatio Paz <octavio.paz@gmail.com>'
+}
+
+setup
+
+test_expect_success "basic" "
+	git format-patch --stdout -1 basic > patch &&
+	git related patch | sort > actual &&
+	cat > expected <<-EOF &&
+	Jon Stewart <jon@stewart.com>
+	Pablo Escobar <pablo@escobar.com>
+	EOF
+	test_cmp expected actual
+"
+
+test_expect_success "others" "
+	git format-patch --stdout -1 master > patch &&
+	git related patch | sort > actual &&
+	cat > expected <<-EOF &&
+	John Doe <john@doe.com>
+	John Poppins <john@doe.com>
+	Jon Stewart <jon@stewart.com>
+	EOF
+	test_cmp expected actual
+"
+
+test_done
-- 
1.8.4-fc
