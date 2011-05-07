From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 02/02] Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
Date: Sat,  7 May 2011 14:45:21 +0200
Message-ID: <1304772321-22687-3-git-send-email-jnareb@gmail.com>
References: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 14:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIgwq-0001Tl-Gz
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 14:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803Ab1EGMtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 08:49:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64060 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab1EGMtX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 08:49:23 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2841785fxm.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 05:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=izdiiqT9ox3+fre7reMNnUug8QDc7zcYc5Qx//Cr1m4=;
        b=PPwyGfYCQ3cAKOVRVC59SpPJVsBLQ07hGWwEXUN3C+fko9nZKSeWEcCooUffJC/2Yc
         as2e0SSmXWpIpp8WvztcMib/C5cIxl/VMrMN2vcd5fvAukP8M5WYpiiRSF6w0b7PlZOM
         4CVgA1ShxzFes0NIhb6jt/dvewDXuksL/ltlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gU02XWgjFnnSerfq/PKPFQtOKca98oNbMDcrcfWiZl0Pta7T2WQ8GXXmrFOmIlKYdU
         4bJDurkU3huk1dEmOkiAeen7bBc31wJ9rHDRv67caiNgIx6KWifqOiCilQ6o7HE8MMRT
         +1/Ak3LUHczEnQ1LoG/aUdMY8X/px6QD4D9Xk=
Received: by 10.223.159.134 with SMTP id j6mr462171fax.74.1304772562460;
        Sat, 07 May 2011 05:49:22 -0700 (PDT)
Received: from localhost.localdomain (abwd142.neoplus.adsl.tpnet.pl [83.8.227.142])
        by mx.google.com with ESMTPS id j11sm1375094faa.20.2011.05.07.05.49.20
        (version=SSLv3 cipher=OTHER);
        Sat, 07 May 2011 05:49:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.189.gcec93
In-Reply-To: <1304772321-22687-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173050>

Now that there is gitweb/Makefile, let's leave only "gitweb" and
"install-gitweb" targets in main Makefile.  Those targets just
delegate to gitweb's Makefile.

Requested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is part of 'jn/gitweb-js' (a76424e) in 'pu', and was sent
to git mailing list as part of the following series:

  [PATCHv3 00/13] gitweb: Change timezone in dates using JavaScript
  http://thread.gmane.org/gmane.comp.version-control.git/172384

I think this simplification (straighforward deletion of duplicated
code) is worth on its own.

 Makefile |   26 --------------------------
 1 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/Makefile b/Makefile
index 8960cee..d0c577b 100644
--- a/Makefile
+++ b/Makefile
@@ -1747,32 +1747,6 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 gitweb:
 	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) all
 
-ifdef JSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.js
-GITWEB_JS = gitweb/static/gitweb.min.js
-else
-GITWEB_JS = gitweb/static/gitweb.js
-endif
-ifdef CSSMIN
-GITWEB_PROGRAMS += gitweb/static/gitweb.min.css
-GITWEB_CSS = gitweb/static/gitweb.min.css
-else
-GITWEB_CSS = gitweb/static/gitweb.css
-endif
-OTHER_PROGRAMS +=  gitweb/gitweb.cgi  $(GITWEB_PROGRAMS)
-gitweb/gitweb.cgi: gitweb/gitweb.perl $(GITWEB_PROGRAMS)
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-
-ifdef JSMIN
-gitweb/static/gitweb.min.js: gitweb/static/gitweb.js
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # JSMIN
-ifdef CSSMIN
-gitweb/static/gitweb.min.css: gitweb/static/gitweb.css
-	$(QUIET_SUBDIR0)gitweb $(QUIET_SUBDIR1) $(patsubst gitweb/%,%,$@)
-endif # CSSMIN
-
-
 git-instaweb: git-instaweb.sh gitweb
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-- 
1.7.3
