From: larsxschneider@gmail.com
Subject: [PATCH v3 2/5] git-p4: add gitConfigInt reader
Date: Mon,  7 Sep 2015 14:21:15 +0200
Message-ID: <1441628478-86503-3-git-send-email-larsxschneider@gmail.com>
References: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:21:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvQd-0000L3-Qi
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbbIGMV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:21:27 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36193 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbbIGMVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:21:25 -0400
Received: by wicgb1 with SMTP id gb1so43890501wic.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DAGZPgpx2DGBmKaYp0KoQul4pdm/s0wqeZxmr/l9jBU=;
        b=reVw3wMZbtIaGiZ3asXC9lST0qFkFGlyPGa2p2mtkgnLUj0QxHRWVtg33usfAb2j72
         eicGMIJjpK+rUDmViiYkrvQFG7lUVZ0ldk2VbPT/+DVm4HV2q5SOeZZq28wRlqXctZDG
         n/hxKDHW0qvT2s0EPth/xC3VhlQonETIcyhJs6Vcbz+fDr+Ws5W4L8pFxyB8PSsKO++Z
         9Dsxu3j1bbavW+Wyt9f7pGBbMGBsYPzCvYGIGvNQgr9Wcou0YDVYCp+U/U3Rh5PBAUmg
         BAzbMcZwt6M0AwwtcSP+d22IAZDNZ5Lsj6lQZQLk1tl2dFZsaw0cyFnbJgpa1CjeVaHh
         xgIA==
X-Received: by 10.180.84.131 with SMTP id z3mr35087090wiy.9.1441628484492;
        Mon, 07 Sep 2015 05:21:24 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id gc19sm2441591wic.19.2015.09.07.05.21.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:21:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441628478-86503-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277452>

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
