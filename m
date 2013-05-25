From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 45/48] remote-hg: trivial cleanup
Date: Fri, 24 May 2013 21:30:01 -0500
Message-ID: <1369449004-17981-46-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4J9-00036S-Bx
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab3EYCeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:34:04 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:62950 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab3EYCeB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:34:01 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so2936379obc.6
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=h6lQrbR8N1NZbkH6idkH/vBhZriCv0cW60Hb/9KxesA=;
        b=cehzHYRScrroYTJdRexAjH5Z/5LM/jj+ebe4JoWhIEtvzr2LcL1Fav0H21qETYaWHx
         GuTE+/TpuT9clxKCYwZzABsq4Ec9mAydkdvjg6fu1Z9olUCxIsMM+UizYpENeVSpD24e
         XKnhTJiYT2jO6J0M0YnE6vHyoSWflMWllfEIGsVQJJCJzUYVrXID+VD09s+ICmiZwJCM
         IaXKH4Re6UDlGrGKLQw8DtDCgf2SENmxEHDYd1g7qh2KIJLvA3HRP2yfvrB/bwvh/buh
         BZb+2QgJ33Z4tw+SqcewP7/YG4mLD319G0SacIkEvAFVT8idh3515zj6gPZL+OIb3fas
         9bTw==
X-Received: by 10.60.59.74 with SMTP id x10mr13325540oeq.48.1369449240861;
        Fri, 24 May 2013 19:34:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id jt9sm20134431obc.0.2013.05.24.19.33.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:34:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225460>

It's better to catch the exception later on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 1e61f43..b08f909 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -185,10 +185,7 @@ class Marks:
         return rev in self.marks
 
     def get_tip(self, branch):
-        try:
-            return str(self.tips[branch])
-        except KeyError:
-            return None
+        return str(self.tips[branch])
 
     def set_tip(self, branch, tip):
         self.tips[branch] = tip
@@ -433,10 +430,10 @@ def export_ref(repo, name, kind, head):
     global prefix, marks, mode
 
     ename = '%s/%s' % (kind, name)
-    tip = marks.get_tip(ename)
-    if tip and tip in repo:
+    try:
+        tip = marks.get_tip(ename)
         tip = repo[tip].rev()
-    else:
+    except:
         tip = 0
 
     revs = xrange(tip, head.rev() + 1)
-- 
1.8.3.rc3.312.g47657de
