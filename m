From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Tue,  6 May 2014 22:41:49 +1000
Message-ID: <1399380109-3805-6-git-send-email-nod.helm@gmail.com>
References: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 19:57:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQm-0008Bg-C5
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498AbaEFMmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:32 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35413 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757503AbaEFMmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:31 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so463327pad.2
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3Ud3JwF8XwBP/3+QmPsT4lw3IW6sQWUD8l3iUck6AA=;
        b=IShgNm7bf8jK6tyC/rO2Fn5DWODYVi3MJI+B3llrDV6eKK0gJlDKAMoIZGrPymwg8h
         /HSvkzj2eK2ls9vfzVeRdqdLumshEV2QrvMaPDgAQK5Yv8vPBPWx60bWVdXqeO4sL6rZ
         MdLiiQBghECi0voNkj83Gvdi80c4+QSpYtFOWsPpSpBI6D55EkK65Rj03vHjwND35C1U
         EMInuLUwriOsSCw1G31h8OpJ+1uGSSld2VkDrJOr+QV0ned4qcbvxOdTfPHyd41+rBjU
         HOqdJkJ1YMPNMqKvkInMAmxwydfFRySMXemiwq0dKfrZXpeV51kx5P1GxcRjdMCycS7C
         x2dw==
X-Received: by 10.66.155.102 with SMTP id vv6mr5960981pab.89.1399380150710;
        Tue, 06 May 2014 05:42:30 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248197>

git:Documentation/Makefile and others establish "RM ?= rm -f" as a
convention for rm calls in clean rules, hence follow this convention
instead of simply forcing clean to use rm.

subproj and mainline no longer need to be removed in clean, as they are
no longer created in git:contrib/subtree by "make test". Hence, remove
the rm call for those folders.

Other makefiles don't remove "*~" files, remove the rm call to prevent
unexpected behaviour in the future. Similarly, clean doesn't remove the
installable file, so rectify this.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: James Denholm <nod.helm@gmail.com>
---
 contrib/subtree/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index f3834b5..d888d45 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -12,7 +12,8 @@ man1dir ?= $(mandir)/man1
 -include ../../GIT-VERSION-FILE
 
 # this should be set to a 'standard' bsd-type install program
-INSTALL ?= install
+INSTALL  ?= install
+RM       ?= rm -f
 
 ASCIIDOC = asciidoc
 XMLTO    = xmlto
@@ -60,7 +61,7 @@ test:
 	$(MAKE) -C t/ test
 
 clean:
-	rm -f *~ *.xml *.html *.1
-	rm -rf subproj mainline
+	$(RM) $(GIT_SUBTREE)
+	$(RM) *.xml *.html *.1
 
 .PHONY: FORCE
-- 
1.9.2
