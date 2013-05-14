From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/47] remote-hg: get rid of unused exception checks
Date: Mon, 13 May 2013 23:36:25 -0500
Message-ID: <1368506230-19614-3-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:38:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc70m-0003jN-NF
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab3ENEiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:38:46 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34637 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab3ENEiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:38:46 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so101283oah.21
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=O3iC5wLGb79rxmUOAxapebK2DeAVHQSAb890sYUVJK8=;
        b=D2rVaQIqe/NyjV124Nt7YahGUI5J4vSbo0cNgQskmsNNB6FClMw24Ckqs9zza441b/
         jSsU+ETdPIMDniW3bMSXEiW0OPuuY3ZTHTe37f9DXmVFJ2DJR+7eQqvWNI9zEFiiT6gw
         uLCnNK9OaQfwx30NavocHXEBJKSkxSE9syFuo7eckCAU6IWnPgx15qbwMdY/Tl0D5VaG
         YyYlBmrXS9ZJStSV1n4Wrk8QL7xnSiKI3i2CVI82HcHYWA2YLZWyOOE1hQtI9cVTKfN7
         HfN7R6kXYLoWk+X3YvTz+yVdHr/Ag4/xjXPub3Y35lSo4qKSHHl8xEk9sURHuzGxM5pD
         aBoA==
X-Received: by 10.60.80.197 with SMTP id t5mr12753662oex.1.1368506325493;
        Mon, 13 May 2013 21:38:45 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id yx4sm9273868obb.11.2013.05.13.21.38.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:38:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224237>

We are not calling check_output() anymore.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index d33c7ba..9d6940b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -327,11 +327,8 @@ def get_repo(url, alias):
     myui.setconfig('ui', 'interactive', 'off')
     myui.fout = sys.stderr
 
-    try:
-        if get_config('remote-hg.insecure') == 'true\n':
-            myui.setconfig('web', 'cacerts', '')
-    except subprocess.CalledProcessError:
-        pass
+    if get_config('remote-hg.insecure') == 'true\n':
+        myui.setconfig('web', 'cacerts', '')
 
     try:
         mod = extensions.load(myui, 'hgext.schemes', None)
@@ -910,16 +907,13 @@ def main(args):
     track_branches = True
     force_push = True
 
-    try:
-        if get_config('remote-hg.hg-git-compat') == 'true\n':
-            hg_git_compat = True
-            track_branches = False
-        if get_config('remote-hg.track-branches') == 'false\n':
-            track_branches = False
-        if get_config('remote-hg.force-push') == 'false\n':
-            force_push = False
-    except subprocess.CalledProcessError:
-        pass
+    if get_config('remote-hg.hg-git-compat') == 'true\n':
+        hg_git_compat = True
+        track_branches = False
+    if get_config('remote-hg.track-branches') == 'false\n':
+        track_branches = False
+    if get_config('remote-hg.force-push') == 'false\n':
+        force_push = False
 
     if hg_git_compat:
         mode = 'hg'
-- 
1.8.3.rc1.579.g184e698
