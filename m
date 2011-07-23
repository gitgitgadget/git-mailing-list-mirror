From: John Szakmeister <john@szakmeister.net>
Subject: [PATCH] Stop hiding the error message within 'git submodule add'
Date: Sat, 23 Jul 2011 07:17:28 -0400
Message-ID: <1311419848-79652-1-git-send-email-john@szakmeister.net>
Cc: John Szakmeister <john@szakmeister.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 13:20:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkaFj-0004K5-Ei
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 13:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab1GWLUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 07:20:00 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52567 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab1GWLT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 07:19:59 -0400
Received: by vws1 with SMTP id 1so2145360vws.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=X/uBSa8b0M59XWAnOkSVIZmc+GKPJwEjjrLwQgnfikE=;
        b=lLLCsxEB93TytY7/KTiZJ50o5NzdGCaQWm2W4CTo/Zo0l7vu2UvQJt3zzYDFpqflp4
         +mcJOoOG5XtCJfvoy2KUSIPzjy4mKcW+9YpHhGvAPCDgVvPKYvX7/GYnbh7AOcYuFuxK
         G8pTgmRw17PbVq7ynz11mTocvImSyxf6JTgV0=
Received: by 10.52.28.40 with SMTP id y8mr2468767vdg.136.1311419998154;
        Sat, 23 Jul 2011 04:19:58 -0700 (PDT)
Received: from localhost.localdomain (pool-74-103-61-146.bltmmd.fios.verizon.net [74.103.61.146])
        by mx.google.com with ESMTPS id n21sm300605vcn.31.2011.07.23.04.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 04:19:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.134.gcf13f6.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177686>

git-submodule.sh was incorrectly assuming that the only reason
'git add --dry-run' would fail was due to ignored paths.  However,
when trying add a submodule inside of another, the original error
message was being lost, and leaves a user confused.  Simply
re-run 'git add --dry-run' and allow the error message emitted.

Signed-off-by: John Szakmeister <john@szakmeister.net>
---
 git-submodule.sh |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bc1d3fa..056abd4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -223,12 +223,7 @@ cmd_add()
 
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" > /dev/null 2>&1
 	then
-		(
-			eval_gettext "The following path is ignored by one of your .gitignore files:
-\$path
-Use -f if you really want to add it." &&
-			echo
-		) >&2
+		git add --dry-run --ignore-missing "$path"
 		exit 1
 	fi
 
-- 
1.7.6.134.gcf13f6.dirty
