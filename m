From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 44/48] remote-helpers: improve marks usage
Date: Fri, 24 May 2013 21:30:00 -0500
Message-ID: <1369449004-17981-45-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4J0-0002wk-2Z
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872Ab3EYCd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:59 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:57753 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab3EYCd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:58 -0400
Received: by mail-ob0-f179.google.com with SMTP id wo10so2800232obc.38
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LXVlvG/zW+Mi/JXMs8lsL1oAMFO99UOLnLghCY8t2sQ=;
        b=pvVz6xAmGcsWrf+IA8p1OwaWAT9c+U/QJn649YmzxDtaIqLeTKbXOR96nQUxonGPQ8
         Z4ExW+VM/y7g5wJQ9vhXzDRdUi22X1J1v/7PM8mCXEeGzXmcae684xwubyaQsw/avAdJ
         gMjM+++0/DElxtF9OSglLPgBxkT82DWtQq55mE1W1gvt5E0h7AcEIf4ZMxoTLT82nemQ
         LdegJAfGpQaggrp5y40zWDIcByIocLclhFLeVdOvGGYJEq6FWjNa8IAY2X60SAtarP0W
         2M5OQvP1bVYIfeEpbuGdSMSn75l68wXUvzN0RSebuaXMBk9IV2uokGwZLMvkG704CeZ5
         Hn2w==
X-Received: by 10.60.17.198 with SMTP id q6mr13171912oed.131.1369449237967;
        Fri, 24 May 2013 19:33:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9146088oeo.8.2013.05.24.19.33.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225456>

Always convert to strings (they are unicode because they come from JSON).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 5 ++++-
 contrib/remote-helpers/git-remote-hg  | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 10300c6..f0e5be1 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -116,7 +116,10 @@ class Marks:
         self.last_mark = mark
 
     def get_tip(self, branch):
-        return self.tips.get(branch, None)
+        try:
+            return str(self.tips[branch])
+        except KeyError:
+            return None
 
     def set_tip(self, branch, tip):
         self.tips[branch] = tip
diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index bd545aa..1e61f43 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -165,7 +165,7 @@ class Marks:
         return self.marks[rev]
 
     def to_rev(self, mark):
-        return self.rev_marks[mark]
+        return str(self.rev_marks[mark])
 
     def next_mark(self):
         self.last_mark += 1
@@ -185,7 +185,10 @@ class Marks:
         return rev in self.marks
 
     def get_tip(self, branch):
-        return self.tips.get(branch, None)
+        try:
+            return str(self.tips[branch])
+        except KeyError:
+            return None
 
     def set_tip(self, branch, tip):
         self.tips[branch] = tip
-- 
1.8.3.rc3.312.g47657de
