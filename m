From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 17/21] remote-hg: add 'insecure' option
Date: Thu, 11 Apr 2013 07:23:13 -0500
Message-ID: <1365682997-11329-18-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZJ-0008La-MB
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161543Ab3DKMZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:27 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56463 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161510Ab3DKMZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:19 -0400
Received: by mail-qa0-f44.google.com with SMTP id o13so235657qaj.3
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=CARfQOvZKi4C6wqu179HT2iQnO5OtTFAV9EU1fgQgqo=;
        b=e6WM6E2tNotfsoGHuCixuyZGPhvuJn/nE3yryJc4IRMYC4hsg3ximggfrc2wKYHPoe
         h+n+GLHLPp5ejFvSN4LiJwgPWqabp4pTcGTayNGuGvuqUECjQ5mF6BMww9b4f3hLKmpW
         Nfc61EQiuDk39kjtcA7WAC/jGYKQgNTQFXgDtYwmK0fRqLYLxBnLJ50p56Ljds9OQYmO
         kdujTJEp4dLTB5CTe2vMtstBaSNS9kO53ZplWOYX4erfho7lUvyDf+JQVKT5GprOapVK
         WaosTPO+aFAjrMCkZXGd31BcO5/NaeFeqCsCTw4wqDh/0dvYl3SOcjGBMYxqizW1ZGt5
         O4Kw==
X-Received: by 10.49.5.232 with SMTP id v8mr7509382qev.24.1365683119051;
        Thu, 11 Apr 2013 05:25:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n14sm7008211qaq.3.2013.04.11.05.25.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220869>

From: Simon Ruderich <simon@ruderich.org>

If set to true acts as hg's clone/pull --insecure option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3ae3598..3eb07dc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -30,6 +30,9 @@ import urllib
 # If you don't want to force pushes (and thus risk creating new remote heads):
 # git config --global remote-hg.force-push false
 #
+# If you want the equivalent of hg's clone/pull--insecure option:
+# git config remote-hg.insecure true
+#
 # git:
 # Sensible defaults for git.
 # hg bookmarks are exported as git branches, hg branches are prefixed
@@ -279,6 +282,12 @@ def get_repo(url, alias):
     myui.setconfig('ui', 'interactive', 'off')
     myui.fout = sys.stderr
 
+    try:
+        if get_config('remote-hg.insecure') == 'true\n':
+            myui.setconfig('web', 'cacerts', '')
+    except subprocess.CalledProcessError:
+        pass
+
     if hg.islocal(url):
         repo = hg.repository(myui, url)
     else:
-- 
1.8.2.1
