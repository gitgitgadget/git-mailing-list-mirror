From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] remote-hg: always normalize paths
Date: Wed,  9 Apr 2014 13:50:01 -0500
Message-ID: <1397069404-7451-3-git-send-email-felipe.contreras@gmail.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxjU-0006K8-Nq
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934119AbaDITAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:19 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43307 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITAR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:17 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so3233709obc.12
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jq5HBpxw5XKcTxtSsZNtfkjJqJsPaF723Dh2o/iiT48=;
        b=O4HlYK5y60OOlyfe9oGQgwzijZbAkerWDnYV3BQ2pzIe7gD7T6AV5CJgoqOHWDOgYD
         dlKNKNLq2aWMp5RlCYxFYQjIP2LNmuWPG3qHsBSQDwffE9fGUP8nOjAVkmWYHOug86lk
         yZjYiNCr5U9THDW4o5LNuPpd22EbAbcKpWM+Bz9bk7FSOczR9Z34OCTCxpaNzkPc6f6m
         nxoP1Qz0PHTYIr+IU+nOz581L0AZRDefhmkGpgOLpPWQcF+DWeg+VLJOHJYASFt9HXiQ
         0ImOvL2VBGViqJKHYvrkwd7pdQOcV2Q4VHh4qh2eM1nEb3Q6XLnVjw/ELd5YatZEp00s
         IsLA==
X-Received: by 10.60.74.195 with SMTP id w3mr10130585oev.28.1397070017057;
        Wed, 09 Apr 2014 12:00:17 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id np9sm2253239obc.12.2014.04.09.12.00.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:14 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245990>

Apparently Mercurial can have paths such as 'foo//bar', so normalize all
paths.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index eb89ef6..84e3872 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -260,6 +260,7 @@ class Parser:
         return (user, int(date), -tz)
 
 def fix_file_path(path):
+    path = os.path.normpath(path)
     if not os.path.isabs(path):
         return path
     return os.path.relpath(path, '/')
-- 
1.9.1+fc1
