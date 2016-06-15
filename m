From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-hg: fix commit messages
Date: Thu, 18 Apr 2013 01:06:31 -0500
Message-ID: <1366265191-20815-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 08:07:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USi0Z-00027K-68
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab3DRGHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:07:42 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:61433 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3DRGHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:07:42 -0400
Received: by mail-yh0-f44.google.com with SMTP id m1so399591yhg.31
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 23:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=kqv8djyY+YP56Q19SXpJWQUtHwK5+JYWmyR1Kao8JT8=;
        b=ZnrL32FqcXpJxQzeuBaiKxS4U4XAZE9/CEc6WHEB4sGjCmZVHmKKstJPHg4t2IfFgT
         hWAl2a11thD4BFd6YcGauEW2sfSLw9ElCfpBCQBC+gYyrM+0rzXLlWnsO/NCqdnk/Qxk
         rDiphFy1YSS8ZOf82donYAsslPguNFwLA5ETq+oaSA5afTzoEfCq8mKj1DnAoQwPEawN
         5OHzWEpnG3HPhdT6jv0aMy7tsUjlforRiNTt0aj7ad8tWS7kAAT4QHXAcLYX7ycOYaRE
         LIjqieiZed1O2TgecxHQu70JzXNpYok/02t7l+WoCWMeTIEp+x/ypOYJufJwpthRmNh6
         eZJg==
X-Received: by 10.236.147.75 with SMTP id s51mr6529717yhj.33.1366265261581;
        Wed, 17 Apr 2013 23:07:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id v48sm15021836yhi.26.2013.04.17.23.07.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 23:07:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221610>

git fast-import expects an extra newline after the commit message data,
but we are adding it only on hg-git compat mode, which is why the
bidirectionality tests pass.

We should add it unconditionally.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a5f0013..5481331 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -362,6 +362,8 @@ def export_ref(repo, name, kind, head):
         else:
             modified, removed = get_filechanges(repo, c, parents[0])
 
+        desc += '\n'
+
         if mode == 'hg':
             extra_msg = ''
 
@@ -385,7 +387,6 @@ def export_ref(repo, name, kind, head):
                 else:
                     extra_msg += "extra : %s : %s\n" % (key, urllib.quote(value))
 
-            desc += '\n'
             if extra_msg:
                 desc += '\n--HG--\n' + extra_msg
 
-- 
1.8.2.1.679.g509521a
