From: larsxschneider@gmail.com
Subject: [PATCH v8 2/7] git-p4: add gitConfigInt reader
Date: Sat, 26 Sep 2015 09:54:59 +0200
Message-ID: <1443254104-14966-3-git-send-email-larsxschneider@gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 09:56:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfkKr-0007TH-O7
	for gcvg-git-2@plane.gmane.org; Sat, 26 Sep 2015 09:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbbIZHzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2015 03:55:46 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33661 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751591AbbIZHzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2015 03:55:25 -0400
Received: by wiclk2 with SMTP id lk2so47305460wic.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2015 00:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a/RJKaK8OVtLO/AMLaBMQKIaLGqyYinr3N5h6mt+k2E=;
        b=hL/zJMGnturMoj9W0sU6iSALpuEJm/6gi30iTxdP7HI3r5J+8EuXNzopmGkRtGWiiZ
         bYoRH9+LUmNVf9SXYGrhg3hJxcW00G/xxD23t8IGuVq4DU3as/eaA95PmI5AslDnE9Xe
         jD2jnFMTPmoUZI+hq7W+vQO9Avj1Uep4uFD0urxtazKPqx3FKYVZfUbOIvioMBknfreL
         /eVEx5CRjSdTiTkQDINmeeUcdG9fdOQ4VCOC8pevvREXSkAL/gn6VZCKsxZXYOCCjArx
         dg02ZEMocB3TEIZ+cvP/eFx/NpAOuPjo193B9W9CRVXpqsSiDAmGe4dclDzu89lyHHZB
         0gcg==
X-Received: by 10.194.77.4 with SMTP id o4mr12029562wjw.4.1443254124859;
        Sat, 26 Sep 2015 00:55:24 -0700 (PDT)
Received: from localhost.localdomain (tmo-102-235.customers.d1-online.com. [80.187.102.235])
        by smtp.gmail.com with ESMTPSA id it4sm7176613wjb.0.2015.09.26.00.55.22
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 26 Sep 2015 00:55:24 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278688>

From: Lars Schneider <larsxschneider@gmail.com>

Add a git config reader for integer variables. Please note that the
git config implementation automatically supports k, m, and g suffixes.

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
