From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/2] Add new 'git stage' script
Date: Sun,  5 Apr 2009 16:48:51 +0300
Message-ID: <1238939331-10152-3-git-send-email-felipe.contreras@gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <1238939331-10152-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 15:50:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqSkH-0004wg-JP
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 15:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZDENtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755236AbZDENtM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 09:49:12 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:39746 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbZDENtI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 09:49:08 -0400
Received: by bwz17 with SMTP id 17so1527804bwz.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 06:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=nU6vAmEssSQQ48N8r6dvHLvfMBrJMc0y0q+suEDJjns=;
        b=UJGkZXWL+dXtc2Q51or69WG1270Tw3GPRqvztP8PolNYmFUZq7aRSoDgr6pd1Fi/qT
         4xwHxXjvg/eQOYO7Kg2lDRdWhG6SPcXKr3sdvOPZyDBb3piq0M1bs/7DWxVaU5csLNzk
         jbcL3BqgZLuAhaKB7Qk/i3NtA5q4QAhOYPmgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uIa9W+owYMkWNOnQbHn+Av9udll0nQn1ZkBGyXVB5r4RJ5tGKLzn1Zvn+qGG8xPlK5
         d0h5RX99qFG4gNpOLai0vUf9LlxVGr5TaOXTR+MG5c7acXk5lLi40K1dUi+A19vQHtka
         g1JvKHaVyssH2lHa7eNAKSc6P5ouZYLj3KKlw=
Received: by 10.223.114.68 with SMTP id d4mr2726338faq.86.1238939345722;
        Sun, 05 Apr 2009 06:49:05 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id f31sm798067fkf.15.2009.04.05.06.49.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Apr 2009 06:49:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.406.g45db3f
In-Reply-To: <1238939331-10152-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115665>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile     |    1 +
 git-stage.sh |   28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 git-stage.sh

diff --git a/Makefile b/Makefile
index 0c3de6b..a1837fc 100644
--- a/Makefile
+++ b/Makefile
@@ -291,6 +291,7 @@ SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
 SCRIPT_SH += git-request-pull.sh
 SCRIPT_SH += git-sh-setup.sh
+SCRIPT_SH += git-stage.sh
 SCRIPT_SH += git-stash.sh
 SCRIPT_SH += git-submodule.sh
 SCRIPT_SH += git-web--browse.sh
diff --git a/git-stage.sh b/git-stage.sh
new file mode 100644
index 0000000..a5b3ad8
--- /dev/null
+++ b/git-stage.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+case "$1" in
+add)
+        shift
+        git add $@
+        ;;
+rm)
+        shift
+        git rm --cached $@
+        ;;
+diff)
+        shift
+        git diff --cached $@
+        ;;
+import)
+        shift
+        git ls-files --modified --others --exclude-standard -z | \
+        git update-index --add --remove -z --stdin
+        ;;
+ls)
+        shift
+        git ls-files --stage $@
+        ;;
+*)
+        git add $@
+        ;;
+esac
-- 
1.6.2.2.406.g45db3f
