From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 8/8] remote-bzr: add fallback check for a partial clone
Date: Thu, 16 May 2013 03:36:47 -0500
Message-ID: <1368693407-21267-9-git-send-email-felipe.contreras@gmail.com>
References: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 10:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctiM-0000iO-Dp
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab3EPIix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:38:53 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:60401 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763Ab3EPIiv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:38:51 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so3148858obb.32
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=z5gqvcCkWbUdji0fqaN6i7B3QbPg+5XXAL5Xr9kp138=;
        b=UmXfD/lNlHCD8GN+DXNG1k65Sxc0gJ5r+NkKmrOzmgNE+XAV9R7bfkBmeKmDJv3IMg
         zAdcIMmn83O6nvoU5fnBaVMKHLl/JF/xJMHR3dWQQtHs9KPsO3ta3KBmI3OmGOkeRsqL
         7HLebEFxDI90oQCGhHkfsg0n7ePzaZ/TL8SIXZ26WRLPn/PQdOynvBP1bKH62T549cKS
         NUO/93fZWOE21NLHIkzTGJLB7njSiW89qKRhYi1pn3euG5296VDrv371Q0ufHqbW6Ijv
         rP2Cdmpgs2NiA5+u+6dP2J58lDOkY+7a70wCoJJemacCbNC+bhnP+kjHJQxBKcu5wY/h
         vt4g==
X-Received: by 10.60.41.232 with SMTP id i8mr20876142oel.129.1368693530323;
        Thu, 16 May 2013 01:38:50 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm7130165oez.4.2013.05.16.01.38.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 16 May 2013 01:38:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368693407-21267-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224509>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 434e613..acc0dc9 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -765,7 +765,10 @@ def do_list(parser):
     print
 
 def clone(path, remote_branch):
-    bdir = bzrlib.bzrdir.BzrDir.create(path)
+    try:
+        bdir = bzrlib.bzrdir.BzrDir.create(path)
+    except bzrlib.errors.AlreadyControlDirError:
+        bdir = bzrlib.bzrdir.BzrDir.open(path)
     repo = bdir.find_repository()
     repo.fetch(remote_branch.repository)
     return remote_branch.sprout(bdir, repository=repo)
-- 
1.8.3.rc2.542.g24820ba
