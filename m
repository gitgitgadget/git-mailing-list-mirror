From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 4/5] contrib/subtree/Makefile: Doc-gen rules cleanup
Date: Tue,  6 May 2014 22:41:48 +1000
Message-ID: <1399380109-3805-5-git-send-email-nod.helm@gmail.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:22:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQl-0008Bg-R9
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502AbaEFMm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:29 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:63529 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757498AbaEFMm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:27 -0400
Received: by mail-pd0-f179.google.com with SMTP id g10so7170267pdj.10
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7zjSZ4NmjnBteTIj1rCMZNvWJV1QkBNLT+0xMZcYwc=;
        b=IeuLq3zyX9oGwLD5osIYqyhJxRGQ1eFwUsYhA6AFYg6g5iajy6iuUlkkyak0Ueh2nV
         F8IjVUXdUX1tkpGg42UI9RKqD1ISpdlALSHm46EqAHYin76fdVeybG34cturezaDTH1T
         AuVlYwxrehTIwkI1/xAg+VvwA+pLaigan/C5/a8QpvTU73Yo7LtOSnw0/bZK+oyf+JkJ
         6eb6kaIm/kwdOCEqp0QXCSb7KZZVYJA1XSLUNcwUVww+UX7muVD/ucVBTsq/BOhHSnnL
         vmaZUuR6pYZzVWtnZJXU6mYj0IrmmMQiuw9xgGWQng906+E7vA4PXoLhqisjx0VlrU1M
         U3CA==
X-Received: by 10.66.164.165 with SMTP id yr5mr5989772pab.63.1399380147386;
        Tue, 06 May 2014 05:42:27 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248217>

git:Documentation/Makefile establishes asciidoc/xmlto calls as being
handled through their appropriate variables, Hence, change to bring into
congruency with.

Similarly, MANPAGE_XSL exists in git:Documentation/Makefile, while
MANPAGE_NORMAL_XSL does not outside contrib/subtree. Hence, replace
MANPAGE_NORMAL_XSL with MANPAGE_XSL.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 579bb51..f3834b5 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -14,8 +14,11 @@ man1dir ?= $(mandir)/man1
 # this should be set to a 'standard' bsd-type install program
 INSTALL ?= install
 
-ASCIIDOC_CONF      = ../../Documentation/asciidoc.conf
-MANPAGE_NORMAL_XSL =  ../../Documentation/manpage-normal.xsl
+ASCIIDOC = asciidoc
+XMLTO    = xmlto
+
+ASCIIDOC_CONF = ../../Documentation/asciidoc.conf
+MANPAGE_XSL   = ../../Documentation/manpage-normal.xsl
 
 GIT_SUBTREE_SH := git-subtree.sh
 GIT_SUBTREE    := git-subtree
@@ -43,14 +46,14 @@ install-man: $(GIT_SUBTREE_DOC)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
+	$(XMLTO) -m $(MANPAGE_XSL) man $^
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
-	asciidoc -b docbook -d manpage -f $(ASCIIDOC_CONF) \
+	$(ASCIIDOC) -b docbook -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(GIT_VERSION) $^
 
 $(GIT_SUBTREE_HTML): $(GIT_SUBTREE_TXT)
-	asciidoc -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
+	$(ASCIIDOC) -b xhtml11 -d manpage -f $(ASCIIDOC_CONF) \
 		-agit_version=$(GIT_VERSION) $^
 
 test:
-- 
1.9.2
