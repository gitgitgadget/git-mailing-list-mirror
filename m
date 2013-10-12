From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/5] remote-helpers: add exec-path links
Date: Sat, 12 Oct 2013 02:04:21 -0500
Message-ID: <1381561465-20147-2-git-send-email-felipe.contreras@gmail.com>
References: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLV-0003hL-DG
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209Ab3JLHKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:32 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:40364 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3JLHK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:29 -0400
Received: by mail-oa0-f43.google.com with SMTP id i3so3162500oag.30
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6y2P3vF5msB2KBwLNLIF/kKnVSsfLac8Q3Aq5S6MBA=;
        b=M44PndgoRpaRztMmFEyR7N2M0mntV1RMA1pA/UmGUgRHLszHrhZSmNXwxE9OLo3h5Z
         gBFw/e7DYM9DqQTTmE6U0EPOAF2sPc1jYCFIokHiHvpxaIThXEqruJKouL4wR5ilUuY4
         7tSGqzA/jQ5IDCpu+C3YOyUawgkoexYRN9RHg+MhnEjmFcv7cdVhTHPPadGqrRh+12Ko
         57muDzSQDOGkfeLvv7Ei9fqzbuWmDenMgEjiKv5CH1/LAIf4rYquUu51FVsIwBvkVbk8
         aeaZN//y1HQ7VkICN44KrPYtf3AhlYHAkcqqeIBeMeKN6luI2dZfGwWinCKr5pj0zt++
         NORw==
X-Received: by 10.182.22.5 with SMTP id z5mr24699obe.42.1381561828948;
        Sat, 12 Oct 2013 00:10:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id wd7sm28627504obc.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235959>

This way we don't have to modify the PATH ourselves and it's easier to
test without 'make'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
index 8799c77..2e14b65 100644
--- a/contrib/remote-helpers/Makefile
+++ b/contrib/remote-helpers/Makefile
@@ -1,15 +1,15 @@
 TESTS := $(wildcard test-*.t)
 SCRIPTS := $(wildcard git-remote-*.py)
+LINKS := $(addprefix ../../,$(patsubst %.py,%,$(SCRIPTS)))
 
 export T := $(addprefix $(CURDIR)/,$(TESTS))
 export MAKE := $(MAKE) -e
-export PATH := $(CURDIR):$(PATH)
 export TEST_LINT := test-lint-executable test-lint-shell-syntax
 export TEST_DIRECTORY := $(CURDIR)/../../t
 
 export SCRIPT_PYTHON := $(addprefix $(CURDIR)/,$(SCRIPTS))
 
-all: $(SCRIPTS)
+all: $(LINKS)
 	$(MAKE) -C ../.. build-python-script
 
 install:
@@ -17,10 +17,14 @@ install:
 
 clean:
 	$(MAKE) -C ../.. clean-python-script
+	$(RM) $(LINKS)
 
 test: all
 	$(MAKE) -C ../../t $@
 
+$(LINKS):
+	ln -sf contrib/remote-helpers/$(notdir $@) ../..
+
 $(TESTS): all
 	$(MAKE) -C ../../t $(CURDIR)/$@
 
-- 
1.8.4-fc
