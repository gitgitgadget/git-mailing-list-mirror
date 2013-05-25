From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] build: cleanup using $<
Date: Fri, 24 May 2013 21:41:03 -0500
Message-ID: <1369449666-18879-4-git-send-email-felipe.contreras@gmail.com>
References: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:43:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Rg-0000H0-Jh
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab3EYCmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:42:54 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:51441 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab3EYCmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:42:53 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so6879180oag.4
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4DRn1Y6+nlmudB51CVo3yqjR5nAcA6jIzDIikkkTi/c=;
        b=mHYN2vVOUII4sjokthZ0YdNemYRLpsYlVuuBaAxnNvuE4kxSGFUs7VfTapbhIgTpYK
         SVJQ1mXJ4DbmWKy77a7itvo43la2IcT97PtouXCrRI1y2XvJpei8bISLenlB3JqkKFkP
         MzJPq8jub43470Mx1XDintDNk34T1pYHtQARMcCc4VLA9cUkqRUSJUUzPu9dcWdb033J
         uu5QRDJ5Qu6m3Bc5HNZAe9oZGrVo3QHaHCP3E/S0gJAhiBBrVBx38nTGFNxt2zEJNNwf
         MfNhskaW/b62HB13xYnVtPDeqXv7FhxAwQY09sI4vqnP0Lb/yPu2cF7zJcJTe4GM4R/t
         3f2g==
X-Received: by 10.60.116.138 with SMTP id jw10mr13238969oeb.64.1369449773144;
        Fri, 24 May 2013 19:42:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9177887oeo.8.2013.05.24.19.42.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:42:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449666-18879-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225471>

No need to list the first prerequisite. No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 1ac52dd..28b6117 100644
--- a/Makefile
+++ b/Makefile
@@ -1731,9 +1731,9 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
-	ln git$X $@ 2>/dev/null || \
-	ln -s git$X $@ 2>/dev/null || \
-	cp git$X $@
+	ln $< $@ 2>/dev/null || \
+	ln -s $< $@ 2>/dev/null || \
+	cp $< $@
 
 common-cmds.h: ./generate-cmdlist.sh command-list.txt
 
@@ -1798,7 +1798,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl GIT-VERSION-FILE
 	    -e '	x' \
 	    -e '}' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
@@ -1831,7 +1831,7 @@ $(SCRIPT_PYTHON_GEN): % : %.py
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    $@.py >$@+ && \
+	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 else # NO_PYTHON
-- 
1.8.3.rc3.312.g47657de
