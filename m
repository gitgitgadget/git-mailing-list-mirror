From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] t9157-git-svn-fetch-merge.sh: remove dependency on subversion 1.5
Date: Fri, 22 Oct 2010 21:55:58 -0400
Message-ID: <1287798958-22549-1-git-send-email-stevenrwalter@gmail.com>
References: <1287737937.3785.15.camel@balanced-tree>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: gitster@pobox.com, normalperson@yhbt.net, git@vger.kernel.org,
	andersk@mit.edu
X-From: git-owner@vger.kernel.org Sat Oct 23 03:56:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9TLX-0004O4-IQ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 03:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab0JWB4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 21:56:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:65268 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840Ab0JWB4U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 21:56:20 -0400
Received: by yxn35 with SMTP id 35so1150847yxn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=iOaUSkjftewzOn2d/VhBIEmcC5EhVaZLf3Ruz97h+GA=;
        b=LCkb2b5e2Pk+IGfwiZh8TiqjVfDQoWaVoc+/4xjeLvLITD2+yezY+RPzHMNmIxIQz+
         x9/LuYLtry9WKVEByX7+6fdcI+7uxcUKcwbURmU1XqdBJ9ha8vBk5zugrs6Y97FuMYLm
         IhyzVhRUeJ8fG3LxVybtmw85itl6V7S8kPdac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OlHmTY93SsVwb8ZYlKGXJ5sM8YNRMGsqynhUjXMmHp+CzQdOrnf40iY0u1HIGPGtzx
         mQUjh2B3DXqsR1zCtVUvg10zatfn6iUDhJxNHxfXPtEPyIkaV0EqA96UQrcR8DkShm0Z
         vGl6648Xz4FRCS5U2yGx0OgusIyuDeZmKtUjY=
Received: by 10.151.40.14 with SMTP id s14mr7294701ybj.57.1287798980253;
        Fri, 22 Oct 2010 18:56:20 -0700 (PDT)
Received: from brock (adsl-234-144-207.bgk.bellsouth.net [74.234.144.207])
        by mx.google.com with ESMTPS id c4sm2980453yha.40.2010.10.22.18.56.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 18:56:19 -0700 (PDT)
Received: from srwalter by brock with local (Exim 4.72)
	(envelope-from <srwalter@dervierte>)
	id 1P9TLE-0005sK-Dz; Fri, 22 Oct 2010 21:56:16 -0400
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1287737937.3785.15.camel@balanced-tree>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159771>

Specify a revision range to "merge" and manually set the svn:mergeinfo
property.
---
 t/t9157-git-svn-fetch-merge.sh |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-merge.sh
index da582c5..424e1fa 100755
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -25,15 +25,19 @@ test_expect_success 'initialize source svn repo' '
 		svn add baz &&
 		svn commit -m x &&
 		svn switch "$svnrepo"/trunk &&
-		svn merge "$svnrepo"/branches/branch1 &&
+		svn merge -r3:7 "$svnrepo"/branches/branch1 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-7" . &&
 		svn commit -m "merge" &&
 		svn switch "$svnrepo"/branches/branch1 &&
 		svn commit -m x &&
 		svn switch "$svnrepo"/branches/branch2 &&
-		svn merge "$svnrepo"/branches/branch1 &&
+		svn merge -r3:8 "$svnrepo"/branches/branch1 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-8" . &&
 		svn commit -m "merge branch1" &&
 		svn switch "$svnrepo"/trunk &&
-		svn merge "$svnrepo"/branches/branch2 &&
+		svn merge -r5:9 "$svnrepo"/branches/branch2 &&
+		svn propset svn:mergeinfo "/branches/branch1:4-8
+/branches/branch2:6-9" . &&
 		svn resolved baz &&
 		svn commit -m "merge branch2"
 	) &&
-- 
1.6.3.3
