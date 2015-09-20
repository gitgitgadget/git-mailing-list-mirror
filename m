From: larsxschneider@gmail.com
Subject: [PATCH v6 2/7] git-p4: add gitConfigInt reader
Date: Sun, 20 Sep 2015 22:26:22 +0200
Message-ID: <1442780787-65166-3-git-send-email-larsxschneider@gmail.com>
References: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 22:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdlCQ-0003Z3-3X
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 22:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbbITU0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 16:26:38 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38383 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298AbbITU0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 16:26:33 -0400
Received: by wiclk2 with SMTP id lk2so87352950wic.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DAGZPgpx2DGBmKaYp0KoQul4pdm/s0wqeZxmr/l9jBU=;
        b=Xx11Lt3m36bpWyF53KQHqUlsrRM9XNSpdot/8o2Z0LHqOpC3LfTkTpGKgLZ9QpCf61
         l6r9bWNW+GqQpxVGfDg9FudeWQY3bUGQOfZBxpSD5bL5ukK4tuCTOTi7uZqwa6on8K4J
         fLONFvv36EArOqsJtZZRlx9yzQiuh5yrFTpePhjbE9TA4Vi7KJoZDE3bB1XOw8JJKkKg
         /SaTb52wSpN/3jqy7sHLZNRT3HN9fID8YunrnEplvkAK2pMqOAfDiU6jKoGTvYajqekV
         I7yEnDVPXgHwfBJuNK5vfO9+GFia0tVenjcM/uEKfkgwVYcAa1yeNXPkQcWOYlfJ7K08
         gaOw==
X-Received: by 10.194.47.161 with SMTP id e1mr21570203wjn.1.1442780792275;
        Sun, 20 Sep 2015 13:26:32 -0700 (PDT)
Received: from slxBook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id go2sm9869879wib.20.2015.09.20.13.26.31
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Sep 2015 13:26:31 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442780787-65166-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278264>

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
