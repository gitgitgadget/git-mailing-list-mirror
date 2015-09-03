From: larsxschneider@gmail.com
Subject: [PATCH v2 1/4] git-p4: add optional type specifier to gitConfig reader
Date: Thu,  3 Sep 2015 18:35:45 +0200
Message-ID: <1441298148-63885-2-git-send-email-larsxschneider@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:36:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXUY-0000FZ-Tf
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbbICQfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:35:54 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36036 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883AbbICQfx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:35:53 -0400
Received: by wibz8 with SMTP id z8so105124376wib.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+7Qo1g4DUEK+8gmyDh5Ezqs2WKpPLIU4Nia+K7TXzHA=;
        b=YKOKi2b9bKssZ9YFp+kvybPIfXzwKC8JHnyoJnHtVKY0ILKt5fq3a/bL2hBHbFtyLP
         xKhiWD7aW5Qgn0L9Q7xM3NB3vCDQnu1QQFEFwytSRo9gBiyf8SLuiJnauefjZZliZGSO
         oGI4YHlGMhjVoSzTs8UD9a9tekLOqGoo2DpadMyuarKVoZG+P3OuV9a3wTRthkiprMPE
         vhrwyxi+etBSHYElZwqMI5Nd68hR8SuPoSZ2QRhi97m/JoLVnhV8A69IQxQCty8uO4Pu
         gpZL6NfhWK05SGgIrFjSh7i83ZxiSWLLe+h6PpADOEzra0t88iMhbUusv7/uv2E4vtYy
         Ge9A==
X-Received: by 10.194.81.169 with SMTP id b9mr20332791wjy.3.1441298152395;
        Thu, 03 Sep 2015 09:35:52 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id sd14sm20446876wjb.36.2015.09.03.09.35.51
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 09:35:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277224>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 073f87b..c139cab 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -604,9 +604,12 @@ def gitBranchExists(branch):
 
 _gitConfig = {}
 
-def gitConfig(key):
+def gitConfig(key, typeSpecifier=None):
     if not _gitConfig.has_key(key):
-        cmd = [ "git", "config", key ]
+        cmd = [ "git", "config" ]
+        if typeSpecifier:
+            cmd += [ typeSpecifier ]
+        cmd += [ key ]
         s = read_pipe(cmd, ignore_error=True)
         _gitConfig[key] = s.strip()
     return _gitConfig[key]
@@ -617,10 +620,7 @@ def gitConfigBool(key):
        in the config."""
 
     if not _gitConfig.has_key(key):
-        cmd = [ "git", "config", "--bool", key ]
-        s = read_pipe(cmd, ignore_error=True)
-        v = s.strip()
-        _gitConfig[key] = v == "true"
+        _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
 def gitConfigList(key):
-- 
1.9.5 (Apple Git-50.3)
