From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/16] remote-hg: add branch_tip() helper
Date: Mon, 22 Apr 2013 16:55:13 -0500
Message-ID: <1366667724-567-6-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:58:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOkc-0002E7-7L
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab3DVV6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:58:13 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:63462 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878Ab3DVV6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:58:10 -0400
Received: by mail-oa0-f45.google.com with SMTP id o17so6431717oag.18
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LNlo55RZDMLbR/0TKPCxOdXNuemX0G34wjKM8pPqQ2g=;
        b=Qyr05OzNvyIY6Y8uASKViQM8m0h8/eiFkzvQp28EJGLvjUAEqxoFO9vEIHB4s1+l/p
         H3/219GmpOWbUUbA3hKFT8GURlwhDTcu4tWXYNencRqYr23rxzqdafzQdNszZMazkEPF
         THPAQNnrVB8xnk98BVDydtZmGJL2zkNSJB/wVr08Zaf7IiUxMezhA6IFJZbvIVSIPfok
         csXOX5SV0B+W2n0LThKEwrk8fdOqyvbsx2+SxiIf0yKxIA+bVpDLZJM4poPTv7RPTIwH
         62TnAN9w4SLyFQtaWdZ9ksDfaooZTIH1thJ0/iO8hRQL/85sZsqR668fOBUm0KmaB5Vh
         wDEA==
X-Received: by 10.60.17.105 with SMTP id n9mr15915816oed.64.1366667890610;
        Mon, 22 Apr 2013 14:58:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t9sm20053417obk.13.2013.04.22.14.58.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:58:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222101>

Idea from gitifyhg, the backwards compatibility is how Mercurial used to
do it.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a4db5b0..bd93f82 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -457,6 +457,13 @@ def do_capabilities(parser):
 
     print
 
+def branch_tip(repo, branch):
+    # older versions of mercurial don't have this
+    if hasattr(repo, 'branchtip'):
+        return repo.branchtip(branch)
+    else:
+        return repo.branchtags()[branch]
+
 def get_branch_tip(repo, branch):
     global branches
 
@@ -467,9 +474,7 @@ def get_branch_tip(repo, branch):
     # verify there's only one head
     if (len(heads) > 1):
         warn("Branch '%s' has more than one head, consider merging" % branch)
-        # older versions of mercurial don't have this
-        if hasattr(repo, "branchtip"):
-            return repo.branchtip(branch)
+        return branch_tip(repo, branch)
 
     return heads[0]
 
-- 
1.8.2.1.790.g4588561
