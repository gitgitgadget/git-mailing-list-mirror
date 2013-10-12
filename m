From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/5] build: fix installation of scripts
Date: Sat, 12 Oct 2013 02:04:24 -0500
Message-ID: <1381561465-20147-5-git-send-email-felipe.contreras@gmail.com>
References: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtLX-0003hL-6P
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3JLHKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:10:39 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:53425 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab3JLHKh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:10:37 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3187755oag.27
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rI0tl0HYFU9JwiRvzygmzhmgfIaxIA2acrJ+bD/vU/M=;
        b=tv1/6MT6KGeLLcRjIHG7y99N+q/p5LjXwOeISQKc7NwZGmICLFIOf9epEwULdgWun1
         8vRo+zmYtDjMzfpZx6F6LLVf+Aam3B8Rw8pPlJ2DrWhWFGaoMiBFI0yMgdKMkdzqtWN6
         8w9OzaOAQf9/uBYf4+8i4gRNrYYWFsXnOrTRh9MRWbLV1+qOE9YUzsiPLvEfbLpdwQoL
         GadP3Xxlca/OLXum2wP1ifAQ57FyNfU7gfzBq4bA63Z56moc4Qd2KCPUUQYyIhRvZO6F
         D4/kA/xPiSlbH255djFe+0B5POpL+sBU/B5n5jBqmetxy8O8pyhW0FO5RKacxBzO1hWn
         xKhA==
X-Received: by 10.182.237.75 with SMTP id va11mr17904224obc.5.1381561837078;
        Sat, 12 Oct 2013 00:10:37 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101350547oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:10:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561465-20147-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235958>

They need the gitexecdir.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 3588ca1..e51b92e 100644
--- a/Makefile
+++ b/Makefile
@@ -511,12 +511,14 @@ build-perl-script: $(SCRIPT_PERL_GEN)
 build-sh-script: $(SCRIPT_SH_GEN)
 build-python-script: $(SCRIPT_PYTHON_GEN)
 
-.PHONY: install-perl-script install-sh-script install-python-script
-install-sh-script: $(SCRIPT_SH_INS)
+.PHONY: install-gitexecdir install-perl-script install-sh-script install-python-script
+install-gitexecdir:
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+install-sh-script: $(SCRIPT_SH_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-perl-script: $(SCRIPT_PERL_INS)
+install-perl-script: $(SCRIPT_PERL_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-install-python-script: $(SCRIPT_PYTHON_INS)
+install-python-script: $(SCRIPT_PYTHON_INS) | install-gitexecdir
 	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 
 .PHONY: clean-perl-script clean-sh-script clean-python-script
-- 
1.8.4-fc
