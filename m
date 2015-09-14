From: larsxschneider@gmail.com
Subject: [PATCH v5 2/7] git-p4: add gitConfigInt reader
Date: Mon, 14 Sep 2015 15:26:29 +0200
Message-ID: <1442237194-49624-3-git-send-email-larsxschneider@gmail.com>
References: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 15:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbTmP-0002Po-Gv
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 15:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbbINN0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 09:26:41 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38780 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbbINN0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 09:26:40 -0400
Received: by wiclk2 with SMTP id lk2so133036200wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 06:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DAGZPgpx2DGBmKaYp0KoQul4pdm/s0wqeZxmr/l9jBU=;
        b=TrPsEoewFAc9jj+JGPGOdFBuhoTJcnDmvh3DGmv7fJPqryN46jHmJQsfhndmdVWXeZ
         FjY69eb6MXv+SCoFr03H4b3xdUC+UrzxgAbveocAQ7la4HpGJQWv0GC7qcD4R3/mjl4z
         jH0FFBrEVllSDUaL/ljJgMfOlNeO8njVmnSEB0c4JAJrepW6Ofs5VkiVsJF7ZaZiYr1w
         BFJvzu0Cdk77x4VSP6L1g9DIRK7mzC5ghX/AqU9ovAeVqZuq3NQ3D5JsArs/tCUxxT4K
         MzRdRZal3X8cPaWktYxOO5oGGy/stbRFPsp1fyGkNV4Jt9l+Anr+SzuDtUMA81srd7ds
         0sjw==
X-Received: by 10.194.78.34 with SMTP id y2mr28073133wjw.91.1442237199332;
        Mon, 14 Sep 2015 06:26:39 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id xt1sm12578013wjb.32.2015.09.14.06.26.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 06:26:38 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442237194-49624-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277821>

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
