From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 03/23] contrib/subtree: Teach add to store repository & branch in .gittrees
Date: Sun, 10 Mar 2013 23:41:11 +0000
Message-ID: <1362958891-26941-4-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpuN-0003dv-R3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab3CJXnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:43:37 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:39933 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXng (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:43:36 -0400
Received: by mail-wi0-f173.google.com with SMTP id hq4so608185wib.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=or8ilZVZ7DPGCZWwFFaS0YN6qe+wKcfpvhO6btz2sWQ=;
        b=XP4pXvNRBAHWMJi4LgnRC7vVow2omZt0LxdMIHOI1rBQxQu0Y/hhU26bcIPn3iZcaJ
         VlHcZ8VhDI+O+mWD+wsjVBoqDiit2fe2QR/bndAWnxPB524qEeCebwhcXJQp1BzqrzoL
         GE3yTYaUEg7QrD7ZpHon3C4M/kfG2X+zKPJvyVcyHX6uhPWhb11uDXHR3pBRphc1lxGt
         eMdh3BrKsYkszqllDTwRowyTwbDs9OX7NXOGMj5AYuhaCdOoP+J2sviXqolQ1kfJK3re
         BYGY+BtiD5u5g+SgfxOVpOMPGWRUZ6EY2hPyw2sBKB/jYvU3kD+XMTt4EScqPrINokIh
         xFwQ==
X-Received: by 10.194.57.137 with SMTP id i9mr15652907wjq.18.1362959015333;
        Sun, 10 Mar 2013 16:43:35 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.43.30
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:43:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQmgzvb6u6k9fazYY4Bu8gr0kTFtWwtB5DJ7UWnOVEvUArw/y+0ODezJqiCZ4Jnirapm7UDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217823>

From: Matt Hoffman <matt.hoffman@quantumretail.com>

The repository and branch of a subtree added with the add command is
stored in the .gittrees file.

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index caf4988..7b70251 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -528,6 +528,14 @@ cmd_add_repository()
 	revs=FETCH_HEAD
 	set -- $revs
 	cmd_add_commit "$@"
+  
+  # now add it to our list of repos 
+  git config -f .gittrees --unset subtree.$dir.url
+  git config -f .gittrees --add subtree.$dir.url $repository
+  git config -f .gittrees --unset subtree.$dir.path
+  git config -f .gittrees --add subtree.$dir.path $dir
+  git config -f .gittrees --unset subtree.$dir.branch
+  git config -f .gittrees --add subtree.$dir.branch $refspec
 }
 
 cmd_add_commit()
-- 
1.8.2.rc1
