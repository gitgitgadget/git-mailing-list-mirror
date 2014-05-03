From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 5/5] contrib/subtree/Makefile: clean rule cleanup
Date: Sat,  3 May 2014 22:49:35 +1000
Message-ID: <1399121375-14727-6-git-send-email-nod.helm@gmail.com>
References: <1399121375-14727-1-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-2-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-3-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-4-git-send-email-nod.helm@gmail.com>
 <1399121375-14727-5-git-send-email-nod.helm@gmail.com>
Cc: greend@obbligato.org, apenwarr@gmail.com, gpmcgee@gmail.com,
	peff@peff.net, mmogilvi_git@miniinfo.net,
	James Denholm <nod.helm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 03 14:50:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgZOn-0003hD-J9
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 14:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbaECMuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 08:50:32 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41722 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbaECMuc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 08:50:32 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so1533131pad.32
        for <git@vger.kernel.org>; Sat, 03 May 2014 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZDmfirlwG5e9uRtL4Ly4zCOqK1o2oqx7W/wdEQwKqsw=;
        b=grhNnPP4PfWm3pQI0v3qXXXLgM8bBxQHftYsk9Bgy2DH1nH+4d7R+BRkf4QUKAU3KF
         EqS87oMuPe1U6E/ylwieUjC8Oy1DmKLBxgmHb3G0/R9WSfBiV+d9GphHBfZ6pwiRydaN
         LsF4+cJ7XJvPrALKYmoc3cw3X9xmSUSHmsb45Z/MXRkwgYbaFK8+VD1NaVIgVOAW46uJ
         SduZyIUPt/l5pd6rWATBtaFMCZtRK+vG5Hzbwv4KD4bG6gjo/NjfVgLNmCcWeIxcH9uf
         CzN4VHKBFWKMAZWI0DusqmbJFO9D5OrVfNiHgWq7Yhizv9Lr6YauRxfBWx6YwYo0+sb7
         jXag==
X-Received: by 10.66.141.165 with SMTP id rp5mr48202865pab.90.1399121431444;
        Sat, 03 May 2014 05:50:31 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.56])
        by mx.google.com with ESMTPSA id lr3sm18047379pab.4.2014.05.03.05.50.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 May 2014 05:50:30 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
In-Reply-To: <1399121375-14727-5-git-send-email-nod.helm@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248043>

git:Documentation/Makefile and others establish "RM ?= rm -f" as a
convention for rm calls in clean rules, hence follow this convention
instead of simply forcing clean to use rm.

subproj and mainline no longer need to be removed in clean, as they are
no longer created in git:contrib/subtree by "make test". Hence, remove
the rm call for those folders.

Other makefiles don't remove "*~" files, remove the rm call to prevent
unexpected behaviour in the future. Similarly, clean doesn't remove the
installable file, so rectify this.

Signed-off-by: James Denholm <nod.helm@gmail.com>
---

Admittedly, git:Makefile does not itself follow the "RM ?= rm -f"
setup, instead using "RM = rm -f", but I felt that there were probably
$ARCANE_REASONS for this.

Also, Peff, you were right about the dirs.

 contrib/subtree/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index f3834b5..4f96a24 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -11,8 +11,9 @@ man1dir ?= $(mandir)/man1
 
 -include ../../GIT-VERSION-FILE
 
-# this should be set to a 'standard' bsd-type install program
-INSTALL ?= install
+# These should be set to 'standard' bsd-type programs
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
