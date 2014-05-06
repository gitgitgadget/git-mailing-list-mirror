From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 2/5] contrib/subtree/Makefile: Use GIT-VERSION-FILE
Date: Tue,  6 May 2014 22:41:46 +1000
Message-ID: <1399380109-3805-3-git-send-email-nod.helm@gmail.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:48:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQk-0008Bg-3E
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756446AbaEFMmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:22 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:61605 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260AbaEFMmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id y10so5670052pdj.32
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v80sIK/oXFow+VdagJPN8rDbQO4rE7lgGIsKYo8za5M=;
        b=MZZAbKJm1LwPgEbk+XubawHQuqTfudIaSTkNt8wqfSIVQDG2Ux2Od7zz1Nr4Cuay8B
         CvsEW+zxnabPVaiSdBfi2xYaNOO1kFSyGrB7VT1U3HBR/o+zn5c9vDj6W5VCs4pEKFLX
         1z7fTD/aOJ7YD2HY8Btg30nV5n6Qkq5MFpXORSZvKX/UR82iTwfstrlsuvT2E9uzSOku
         7sg2s5o8NVz1ZWLb6CTP80IY/2zl0IZCbhMW7lMGbQUcF1m1u+W0QrvYX8kgbwz/LRCk
         QKBwwbeNIMOn5qJZi40ZcYJ5tQHeuyCBvrIqR1uH/+Qi4YvAjDvxFtDjrdC0KPL8nYeL
         sEVw==
X-Received: by 10.66.149.37 with SMTP id tx5mr5939938pab.81.1399380140752;
        Tue, 06 May 2014 05:42:20 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248192>

GVF is already being used in most/all other makefiles in the project,
and has been for _quite_ a while. Hence, drop file-unique gitver and
replace with GIT_VERSION.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 87797ed..f63334b 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -6,7 +6,10 @@ mandir ?= $(prefix)/share/man
 libexecdir ?= $(prefix)/libexec/git-core
 man1dir ?= $(mandir)/man1
 
-gitver ?= $(word 3,$(shell git --version))
+../../GIT-VERSION-FILE: FORCE
+	$(MAKE) -C ../../ GIT-VERSION-FILE
+
+-include ../../GIT-VERSION-FILE
 
 # this should be set to a 'standard' bsd-type install program
 INSTALL ?= install
@@ -44,11 +47,11 @@ $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
 	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
-		-agit_version=$(gitver) $^
+		-agit_version=$(GIT_VERSION) $^
 
 $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
 	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
-		-agit_version=$(gitver) $^
+		-agit_version=$(GIT_VERSION) $^
 
 test:
 	$(MAKE) -C t/ test
@@ -56,3 +59,5 @@ test:
 clean:
 	rm -f *~ *.xml *.html *.1
 	rm -rf subproj mainline
+
+.PHONY: FORCE
-- 
1.9.2
