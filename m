From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] git-submodule - Fix bugs in adding an existing repo as a module
Date: Mon,  7 Jul 2008 22:36:40 -0400
Message-ID: <1215484600-2660-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 04:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG35t-0003H0-QI
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbYGHChI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbYGHChI
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:37:08 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:22542 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754113AbYGHChG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:37:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1095276ywe.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 19:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=K6DfBBM5PYugWEG4oTJU+hE55NftZlozoHpry4pWd3s=;
        b=jUpnFk62sDAXQTvz4oEP5GSHuhokFRM1PQsTdrBRaVIxQoFDH82xIoXF80q+asU6kI
         EkJ10IdSIVSkOvE0H8K/yepzTIFHhE69vzaO7/ivwOq39i3lZmzVYGL5xzj7vMyuiloU
         qB0HrHyJ4G8PS8h76VkECaC+uiGkS5x4w5BWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=a+plTEA9nfxaiQ2Wvko5LKo9tGy9cVCCw5s6N1gFbCTQzsCP21nX4sKjyvKaNq8zZO
         DLdf6I913AtoQ5urM1fdJfxVrQJ9GHq7FYintr7j8bw+K87OgIXnLFCuK9ZDID94OsXk
         tz/S+tQHngK2S+dvzXTGlNoY9MfSu00gTJTz8=
Received: by 10.150.202.14 with SMTP id z14mr9398737ybf.95.1215484604852;
        Mon, 07 Jul 2008 19:36:44 -0700 (PDT)
Received: from localhost.localdomain ( [71.246.235.165])
        by mx.google.com with ESMTPS id 5sm189873ywd.8.2008.07.07.19.36.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 19:36:44 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.271.g73ad8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87687>

git-submodule add would trip if path to the submodule included a space,
or if its .git was a gitdir: link to a GIT_DIR kept elsewhere. Fix both.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-submodule.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3eb78cc..099a7d7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -167,8 +167,7 @@ cmd_add()
 	# perhaps the path exists and is already a git repo, else clone it
 	if test -e "$path"
 	then
-		if test -d "$path/.git" &&
-		test "$(unset GIT_DIR; cd $path; git rev-parse --git-dir)" = ".git"
+		if test -d "$path"/.git -o -f "$path"/.git
 		then
 			echo "Adding existing repo at '$path' to the index"
 		else
-- 
1.5.6.2.271.g73ad8
