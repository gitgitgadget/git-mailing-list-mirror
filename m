From: larsxschneider@gmail.com
Subject: [PATCH v7 2/7] git-p4: add gitConfigInt reader
Date: Tue, 22 Sep 2015 00:41:08 +0200
Message-ID: <1442875273-48610-3-git-send-email-larsxschneider@gmail.com>
References: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 22 00:41:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze9mH-0000o4-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 00:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbbIUWlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 18:41:24 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34390 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbbIUWlV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 18:41:21 -0400
Received: by wicfx3 with SMTP id fx3so167503550wic.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1VpY8NtWWhyQTqQUGdG7aHpgHamd87faxW+ZKhcUsE=;
        b=fcGt5v/sXUzlQg832Vt4QmDrLw2VhcJOc+9jRAXVaed/9eBiUh9rM1W+BSHfCFDVk7
         dXkqYqsmEs7LbPcYMCV7gMiqyyVjy2OaDTc/MUeJNYo5O6zTELV9DAVbf7Kp+1FM+uW3
         Wape83ewTLKQmHjeYOn72zOj3xMMcEnJJpc9RAbCSOUPzbBAh2TOt2kxc+M/e56lHrNC
         eZ7KIdxwJPDEENh+m+YmNkyCw8mJKhJ6WijODbFhgxriB69l00HqFjPTWkFtet17lSlL
         PBpbfxrNs8K+LJMnjOj1ERyJ7mn4m5aPBM8v8OrX2q8YFVd8BjoipC/E47PvHnsTaRP3
         AIFA==
X-Received: by 10.194.176.6 with SMTP id ce6mr12421257wjc.101.1442875280353;
        Mon, 21 Sep 2015 15:41:20 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s16sm121516wik.13.2015.09.21.15.41.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2015 15:41:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442875273-48610-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278353>

From: Lars Schneider <larsxschneider@gmail.com>

Add a git config reader for integer variables. Please note that the git config implementation automatically supports k, m, and g suffixes.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 2659079..2715895 100755
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
+        except ValueError:
+            _gitConfig[key] = None
+    return _gitConfig[key]
+
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
-- 
2.5.1
