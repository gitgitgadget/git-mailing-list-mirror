From: larsxschneider@gmail.com
Subject: [PATCH v2 2/4] git-p4: add gitConfigInt reader
Date: Thu,  3 Sep 2015 18:35:46 +0200
Message-ID: <1441298148-63885-3-git-send-email-larsxschneider@gmail.com>
References: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 18:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXUT-0000Ah-MA
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbbICQfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:35:55 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34562 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbbICQfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:35:54 -0400
Received: by wicfx3 with SMTP id fx3so25974467wic.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KjDyBFkjGoLEk2Ak+m61p/HyEWfozHQFwAtSMtxhALw=;
        b=dhhz80VCJ5awiVgZscv5fGFQlFP45/bDj24uTrpBymvrqArw+jKli9YhrlL9Tp976l
         ZLAUYJ3vXThcRPqEpep+4OClRKpQlruU9NsHy4L+Vdi50S+RDMK79cGVqoiU+py4oAMz
         cPciZt7ergv1nxjBvnPz9numA4hXIY+/gtFkX9S4AKPhQeWxTio/5x7T/OWAN03R42FC
         xMtoIf7CKW6DU91F9RIgTHuswYDLabPIsY99S5ZOpYtDhmr0YQefBi+eL3bvq1LLbO6N
         /c3J2h2gWbJVPTjvLgGN1dohyB8R0eYwXVKyRJu21nFbxMsCp8PLDKTrxgo8I0l42Jec
         ulMA==
X-Received: by 10.194.86.72 with SMTP id n8mr56018110wjz.119.1441298153412;
        Thu, 03 Sep 2015 09:35:53 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id sd14sm20446876wjb.36.2015.09.03.09.35.52
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 09:35:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441298148-63885-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277223>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index c139cab..ae1a4d3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -623,6 +623,17 @@ def gitConfigBool(key):
         _gitConfig[key] = gitConfig(key, '--bool') == "true"
     return _gitConfig[key]
 
+def gitConfigInt(key):
+    if not _gitConfig.has_key(key):
+        cmd = [ "git", "config", "--int", key ]
+        s = read_pipe(cmd, ignore_error=True)
+        v = s.strip()
+        try:
+            _gitConfig[key] = int(gitConfig(key, '--int'))
+        except Exception, e:
+            _gitConfig[key] = None
+    return _gitConfig[key]
+
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
-- 
1.9.5 (Apple Git-50.3)
