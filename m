From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/6] build: trivial simplification
Date: Fri, 24 May 2013 21:41:01 -0500
Message-ID: <1369449666-18879-2-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:42:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4RZ-0000Du-G7
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab3EYCms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:42:48 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:39835 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab3EYCmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:47 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so6947989oag.28
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bPGyHmkRhRsftFuH4Hi/Vul+yNR9hJn+XUBEKu8HXiw=;
        b=kytaLRIVnr/Py0W645XhTeA7xSZNOzYfT4tb9lV9N1qbPE0Hjn38YPJrB3iB6NXK4l
         dZ9wc+WMWmswpJR120SW4w4/hsEoQ46HivqP4kV8xO+VtYwOrcwqeASndXhp23UAWFgo
         QhYAqOY80zuAb0KGc4y/j4Ko/7Rbb4clIXHZDV7Xj5LtpnmwlpI4QFrStDrO5jFGaNXd
         nYBdLuGMAssxfimwNaeLfRMwYkB+4Sv6uBIoYdatijkecmIrDEbC26/LUqyjryG+ZHV7
         AR294T2X+bqQ7wm3/rmpOTxhxUB3e4ibgKbwS6PIescHxK+6NSZHsOxbAlQZWOJSLlQc
         3nvQ==
X-Received: by 10.60.173.208 with SMTP id bm16mr13245712oec.92.1369449766749;
        Fri, 24 May 2013 19:42:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id ns4sm20147206obc.2.2013.05.24.19.42.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225469>

SCRIPT_PYTHON_GEN is '$(patsubst %.py,%,$(SCRIPT_PYTHON))', so replace
'$(patsubst %.py,%,$(SCRIPT_PYTHON))' with it

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 985598b..2704df4 100644
--- a/Makefile
+++ b/Makefile
@@ -1822,8 +1822,8 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)) git-instaweb: % : unimplemented.sh
 endif # NO_PERL
 
 ifndef NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
+$(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
+$(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C git_remote_helpers -s \
 		--no-print-directory prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' \
@@ -1835,7 +1835,7 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)): % : %.py
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
-$(patsubst %.py,%,$(SCRIPT_PYTHON)): % : unimplemented.sh
+$(SCRIPT_PYTHON_GEN): % : unimplemented.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@@REASON@@|NO_PYTHON=$(NO_PYTHON)|g' \
-- 
1.8.3.rc3.312.g47657de
