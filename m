From: larsxschneider@gmail.com
Subject: [PATCH v4 2/5] git-p4: add gitConfigInt reader
Date: Wed,  9 Sep 2015 13:59:07 +0200
Message-ID: <1441799950-54633-3-git-send-email-larsxschneider@gmail.com>
References: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZe2P-0001L2-W1
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 13:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbbIIL7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 07:59:40 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34768 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbbIIL7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 07:59:16 -0400
Received: by wicfx3 with SMTP id fx3so153963322wic.1
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 04:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DAGZPgpx2DGBmKaYp0KoQul4pdm/s0wqeZxmr/l9jBU=;
        b=KjZpk2G0TdKaKtWz6isiZNeygXo8ZW5l715FeYUzYMwMONdcfgCs2FkHabAnyPIgl3
         BMa9k5MNgZxLqBwZXs8NgZ0cFnqOUj5AXEyJIN4DVEywJiu5AiOwFMSvJWoNvBFZmvLG
         YUvIxj4bqzxBiTsNpSPElvT7fLIZkZfTY+sKst4V1T1H26tFLGDum8KNvdir+/PqVRq7
         BA3UdlXbOenopCKlSqnN0cFhPgBvcegFZhk5fu5DSDrJcWSn9vUHXsxgY+MIgpKskGVS
         Vv/AXRc3waZX20vZVE4GcmnYVQyWDDwcOdErhTQ7/30pYFymtYBHK/N5g+Xla7NUVIL9
         ksww==
X-Received: by 10.194.105.73 with SMTP id gk9mr61483401wjb.122.1441799954314;
        Wed, 09 Sep 2015 04:59:14 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id u1sm3498338wiz.22.2015.09.09.04.59.13
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2015 04:59:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441799950-54633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277550>

From: Lars Schneider <larsxschneider@gmail.com>

Add a git config reader for integer variables. Please note that the git config implementation automatically supports k, m, and g suffixes.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index c139cab..40ad4ae 100755
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
