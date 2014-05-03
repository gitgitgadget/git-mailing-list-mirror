From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 2/5] contrib/subtree/Makefile: Use GIT-VERSION-FILE
Date: Sat,  3 May 2014 22:49:32 +1000
Message-ID: <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOf-0002ev-UJ
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbaECMuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:17 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61783 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECMuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:16 -0400
Received: by mail-pd0-f175.google.com with SMTP id fp1so577138pdb.34
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXEMSYUVJ4d/Y00+4wi4wT3KnPO/exi91GRTa62nGEw=;
        b=sv+bOFf7LebggbDDf9P7JY1RVN0bItTYWUf84otFh/+aFIMoH2005kGfxNRV6QU6zB
         UVHaUNUZUf7Z3kzE9yoTZQMSgP0DAsD4+S6iIsxh3MGIBov1iYZ3UCXMl7ageCk0wcUB
         caGmJrY4lbnoc2exwRoc05igO83DDoH7Ef2MePkwCjSUKUIbSs+CoCiXkAfpfqX233me
         75NrANbvrRhyNEscFpoVWgTtcQirJx9ZAVPWszQy7eX8e0Djs9JSN8sZTQ1m4tSZLNZN
         bksSsl/1xn1flMYIYDcMR4zbzmzuG44XnugYWKZtwasgOkj4/ecnSPJVa1xY08tbshjX
         k8rg==
X-Received: by 10.66.141.165 with SMTP id rp5mr48200280pab.90.1399121415963;
        Sat, 03 May 2014 05:50:15 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.50.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248041>

GVF is already being used in most/all other makefiles in the project,
and has been for _quite_ a while. Hence, drop file-unique gitver and
replace with GIT_VERSION.

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
