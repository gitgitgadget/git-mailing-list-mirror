From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/16] remote-hg: write tags in the appropriate branch
Date: Mon, 22 Apr 2013 16:55:16 -0500
Message-ID: <1366667724-567-9-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOlJ-0003Hk-Ts
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab3DVV65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:58:57 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38585 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3DVV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:58:57 -0400
Received: by mail-ob0-f176.google.com with SMTP id wd20so5917993obb.35
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ItVEiMemUWYltXT7f5OsiTKDQQfe01eZViHicQVJbXo=;
        b=S14K9M3pb54lpcGVtvxEayADOghpO+vlS+iQKefBmDzuxH/xVXXzkDRBAdjHV3Q5zu
         bgCjAdgJO9ndM8fNn+L/RgFasbI6e1/mTYNsUTDvMGIQfpDCAWs2Z075V5Kx/nnxfWLc
         uzg52Gtm74lm7MJhwzWXNJ7+hBrw2xpmnJM886ft9EbAQ1sPubqfB1oD9pEQ0gFc+NLQ
         WX4DbeNUuxQRFR7C/ToVXRHINDUppVq7H9CrLwSR5viL4rbIqtevDtL/tAAemAKLfDoe
         +PCExHrC965B9EeC+7evIOWFoZv0txywTLL2KPu0UDY0hD4V7GcSIZqAfWX3+r9h90RN
         0YCw==
X-Received: by 10.182.44.227 with SMTP id h3mr13331215obm.16.1366667936427;
        Mon, 22 Apr 2013 14:58:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id fl7sm19115935obb.0.2013.04.22.14.58.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:58:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222105>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index f5e4ba7..f685990 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -725,7 +725,9 @@ def parse_tag(parser):
     parsed_tags[name] = (tagger, data)
 
 def write_tag(repo, tag, node, msg, author):
-    tip = repo['tip']
+    branch = repo[node].branch()
+    tip = branch_tip(repo, branch)
+    tip = repo[tip]
 
     def getfilectx(repo, memctx, f):
         try:
@@ -744,7 +746,7 @@ def write_tag(repo, tag, node, msg, author):
 
     ctx = context.memctx(repo, (p1, p2), msg,
             ['.hgtags'], getfilectx,
-            user, (date, tz), {})
+            user, (date, tz), {'branch' : branch})
 
     tmp = encoding.encoding
     encoding.encoding = 'utf-8'
-- 
1.8.2.1.790.g4588561
