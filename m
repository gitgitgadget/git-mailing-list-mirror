From: Matt Arsenault <arsenm2@gmail.com>
Subject: [PATCH] Fix git p4 sync errors
Date: Sat, 20 Oct 2012 18:59:29 -0700
Message-ID: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 21 03:59:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPkpO-0000zX-OK
	for gcvg-git-2@plane.gmane.org; Sun, 21 Oct 2012 03:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2JUB7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 21:59:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43094 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab2JUB7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Oct 2012 21:59:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1244674pbb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:content-type:content-transfer-encoding:subject
         :message-id:date:to:mime-version:x-mailer;
        bh=ncf1IjcbrkxswTP1CoqjJfv1szFKKJpULZUwJ/AEUlU=;
        b=IpYrwbrTzTI00dDXoY9UyDxo3iCp2XsiphbhviE4ZCtMFc4RTVbTdgDxdu7ApOB7tq
         yPcfsvSMZIxnfB7qdAVQ/bhyv2a0Sco8ohKPLGSTgbDdizUrnHYYO6ezhMwtakR8fcYN
         hYZF6MefqF8GUVYIhXMzkuljBrrtuSles/yfBsVCs8pH5c4RlQK3SA/vmC1cyxiqEkBN
         jfdQo93JBp8fiDY7/C2CFXYnfEEh+3BVwLd+KkZhQdoYdizCdNr/fM+w1PF4m8lvicnb
         CAlf1vUss6W2Cp3legcZf4QSGBSnUdLwN1KSK+oX07KcJICttVxc9x6c5gbH9KsnzOCH
         /TjA==
Received: by 10.66.73.226 with SMTP id o2mr15653640pav.83.1350784774751;
        Sat, 20 Oct 2012 18:59:34 -0700 (PDT)
Received: from [192.168.1.13] (c-76-102-117-203.hsd1.ca.comcast.net. [76.102.117.203])
        by mx.google.com with ESMTPS id y5sm3510767pav.36.2012.10.20.18.59.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Oct 2012 18:59:34 -0700 (PDT)
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208098>

>From 425e4dc6992d07aa00039c5bb8e8c76def591fd3 Mon Sep 17 00:00:00 2001
From: Matt Arsenault <arsenm2@gmail.com>
Date: Sat, 20 Oct 2012 18:48:45 -0700
Subject: [PATCH] git-p4: Fix not using -s option to describe

This solves errors in some cases when syncing renamed files.
Other places where describe is used use the -s, except this one.

Signed-off-by: Matt Arsenault <arsenm2@gmail.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 882b1bb..e203508 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2543,7 +2543,7 @@ class P4Sync(Command, P4UserMap):
     def importChanges(self, changes):
         cnt = 1
         for change in changes:
-            description = p4Cmd(["describe", str(change)])
+            description = p4Cmd(["describe", "-s", str(change)])
             self.updateOptionDict(description)
 
             if not self.silent:
-- 
1.7.12.2
