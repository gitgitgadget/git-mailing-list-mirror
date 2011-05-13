From: Osamu OKANO <okano.osamu@gmail.com>
Subject: [PATCH 2/7] add make(shell) scripts
Date: Fri, 13 May 2011 22:14:13 +0900
Message-ID: <1305292458-3920-3-git-send-email-okano.osamu@gmail.com>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Cc: Osamu OKANO <okano.osamu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 15:14:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKsCc-0006cz-Qo
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 15:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314Ab1EMNOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 09:14:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59378 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759201Ab1EMNOj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 09:14:39 -0400
Received: by pwi15 with SMTP id 15so1169903pwi.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=FR9DEKE3aQIs3c+yoR9lNvsH7MYC45LYRTj7icbEsyg=;
        b=AuzUAY6mvFasRa7A0ER14M2p0gpzPwTOYsbHyGRHlx8urtzmHopZ1qLEQ8t9hfhQuY
         UFuqCjj/l0Wyhgm2Kzk9/MAxhOp+ue8TziIq1N86lo1jOsfDrAu9UmD8gWDd1x/Bdxkz
         fhAH4Fpf1DKl9C9mDyzMo/EdJcgC6G7NXnrjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=r0SV8wvsrET1rq30SBLG0jGraNKqmRmLJdf0re4uR+TyYjFU8fLDQJ0KpsAvLNZ6xI
         hoabH7s7w7QDv9XPSBK9LGdLGqGT1b0/2n429RHj9HrO8lGU2pcQlG1+2O0xbwr7SFKc
         ODNfj4YG2x7IBMEi1PpjoBnanNYmc0f+N4198=
Received: by 10.68.10.98 with SMTP id h2mr2086800pbb.372.1305292478829;
        Fri, 13 May 2011 06:14:38 -0700 (PDT)
Received: from localhost.localdomain (i118-20-60-90.s04.a013.ap.plala.or.jp [118.20.60.90])
        by mx.google.com with ESMTPS id q20sm1358319pbt.72.2011.05.13.06.14.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 May 2011 06:14:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.169.g505a1.dirty
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173530>

---
 Documentation/make_html   |   10 ++++++++++
 Documentation/make_txt    |   13 +++++++++++++
 Documentation/make_update |   13 +++++++++++++
 3 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/make_html
 create mode 100644 Documentation/make_txt
 create mode 100644 Documentation/make_update

diff --git a/Documentation/make_html b/Documentation/make_html
new file mode 100644
index 0000000..cbd0a69
--- /dev/null
+++ b/Documentation/make_html
@@ -0,0 +1,10 @@
+#!/bin/sh
+for t in *.txt
+do
+  asciidoc \
+  -b xhtml11 \
+  -d manpage \
+  -f ../asciidoc.conf \
+  -o `basename $t .txt`.html \
+  $t
+done
diff --git a/Documentation/make_txt b/Documentation/make_txt
new file mode 100644
index 0000000..8fd6ab7
--- /dev/null
+++ b/Documentation/make_txt
@@ -0,0 +1,13 @@
+#!/bin/sh
+for t in *.po
+do
+  po4a-translate \
+  --keep 0 \
+  --format text \
+  --option asciidoc \
+  --master-charset UTF8 \
+  --localized-charset UTF8 \
+  --master ../`basename $t .po`.txt \
+  --po $t \
+  --localized `basename $t .po`.txt
+done
diff --git a/Documentation/make_update b/Documentation/make_update
new file mode 100644
index 0000000..59322d2
--- /dev/null
+++ b/Documentation/make_update
@@ -0,0 +1,13 @@
+#!/bin/sh
+for t in *.po
+do
+  lang=`basename $PWD`
+  cd ..
+  po4a-updatepo \
+  --master-charset UTF8 \
+  --format text \
+  --master `basename $t .po`.txt \
+  --po $lang/$t \
+  --option asciidoc
+  cd $lang
+done
-- 
1.7.5.1.169.g505a1.dirty
