From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/6] remote-hg: disable forced push by default
Date: Fri, 10 May 2013 15:59:21 -0500
Message-ID: <1368219566-1399-2-git-send-email-felipe.contreras@gmail.com>
References: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 23:01:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauR2-0000dT-TV
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab3EJVA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 17:00:57 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:52305 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab3EJVA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 17:00:56 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so4465398oag.18
        for <git@vger.kernel.org>; Fri, 10 May 2013 14:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0nWaqNKY6cb9kIsj12jpbu5ZEo8rrZnwyaZ4GzfVN00=;
        b=PZtc9YRqBkBVEm6D6NfVPMr9SY94sExeOx2xLO74WPgkpYrqmt9/hmzMuXvk+S/ui+
         RYUnFTvlXFrRMkD0FzxHovhHAWRGnyPdEGrL6143rkYgCl8jwtWyW09KQ2eMcckPH+ow
         NAS7oB7rTW7e/5XGEJPf+a4t8KqR3bWAJ+oV/JuWCKN6YFib4m36CUlwkNxUGNg/Kge1
         olO7CnCTTdVaoIsQs8cIBBs3gdjNn3Jfykr1cCgs5PglrobWlG71bFL+xZSJ9w0oxgS0
         vCeIK1q+6Ys0t9iYw6sC6ggLY1wU/rrdYyxx2TJcMDimTbhx375elG5JKuUheIL3CnoG
         p7wQ==
X-Received: by 10.60.155.209 with SMTP id vy17mr8184521oeb.83.1368219656113;
        Fri, 10 May 2013 14:00:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h8sm4570543obk.10.2013.05.10.14.00.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 14:00:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368219566-1399-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223907>

In certain situations we might end up pushing garbage revisions (e.g. in
a rebase), and the patches to deal with that haven't been merged yet.

So let's disable forced pushes by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 96ad30d..84901e9 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -908,7 +908,7 @@ def main(args):
 
     hg_git_compat = False
     track_branches = True
-    force_push = True
+    force_push = False
 
     try:
         if get_config('remote-hg.hg-git-compat') == 'true\n':
@@ -916,8 +916,8 @@ def main(args):
             track_branches = False
         if get_config('remote-hg.track-branches') == 'false\n':
             track_branches = False
-        if get_config('remote-hg.force-push') == 'false\n':
-            force_push = False
+        if get_config('remote-hg.force-push') == 'true\n':
+            force_push = True
     except subprocess.CalledProcessError:
         pass
 
-- 
1.8.3.rc1.579.g184e698
