From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] remote-bzr: avoid unreferred tags
Date: Fri,  5 Apr 2013 21:49:21 -0600
Message-ID: <1365220163-13581-6-git-send-email-felipe.contreras@gmail.com>
References: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSF-0001b9-Iy
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163225Ab3DFDwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 23:52:41 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42292 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759Ab3DFDwk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 23:52:40 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so3324610obc.18
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 20:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Fe5hYTs7PBOR3Icw6XVNee+kSNXz8kXu8fn66MiaaDc=;
        b=0lo8dns9STAkZ8QRGOO8mY7ZUnwgZjVwnU0zLdtRrdTxDr2/sFnPm0YAR/tOZO/Sfs
         Enmp9bhaa4RI2uSAlDFcIXiMwu6Vm+xGZqxDKmhYnd9S2ktvFhjLvxUtIUehnFq76nIB
         IK/y3+SFh74Bf4pSaT5jhUxdQDwewT8e0gHX1Cjpw/l25k9XblA04o2WcdUtwxhw0Jjp
         dMSXGB3aDH84EFYij8ntFjDLtATbnbLPT3EIuGXDOMCiE+0QkvCF+fhUFor3YH0DohSa
         A98DiffLu0nNxLsNGkW9uUcl4w8xjkeZ3FQMCIqf94F7v1B9ABrMl1lrBEfumSQtuYXZ
         BXPA==
X-Received: by 10.182.105.2 with SMTP id gi2mr555982obb.15.1365220360491;
        Fri, 05 Apr 2013 20:52:40 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id m7sm14678041obk.2.2013.04.05.20.52.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 20:52:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365220163-13581-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220227>

They have no content, there's nothing we can do with them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9466cb9..0bcf8c5 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -654,7 +654,11 @@ def do_capabilities(parser):
 def do_list(parser):
     global tags
     print "? refs/heads/%s" % 'master'
+
+    history = parser.repo.revision_history()
     for tag, revid in parser.repo.tags.get_tag_dict().items():
+        if revid not in history:
+            continue
         print "? refs/tags/%s" % tag
         tags[tag] = revid
     print "@refs/heads/%s HEAD" % 'master'
-- 
1.8.2
