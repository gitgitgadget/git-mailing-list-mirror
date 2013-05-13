From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 02/10] remote-hg: get rid of unused exception checks
Date: Mon, 13 May 2013 18:11:52 -0500
Message-ID: <1368486720-2716-3-git-send-email-felipe.contreras@gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 01:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc1ws-0007Jj-NH
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 01:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab3EMXN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 19:13:58 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:44910 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755557Ab3EMXN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 19:13:57 -0400
Received: by mail-ob0-f175.google.com with SMTP id wd6so2693002obb.20
        for <git@vger.kernel.org>; Mon, 13 May 2013 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=O3iC5wLGb79rxmUOAxapebK2DeAVHQSAb890sYUVJK8=;
        b=aUvlqSZhgge0CjTLihiZsWiNj0i/ouF2YUd3607CLpEVRrsYXt4bIsC5JauilskB+0
         PyTsbIJqHwvd6ryqR65jjDwnqc+qcacAD1kglGvzGnHtQ3j/WOZaU7HFpoNO2w7r+5CE
         c++4dD5uUKkrXuBkEyZ8lQhPmu1GUH3KiCMcTRwVSTPjL/dfdGFtJ914Qs0uXq4J+7aF
         6SlA9u1hfK02bw9HfHNUQz2DvQCssOXhAl4moK4QRwSYL8zlLhEU6kDNk+Lf3XxANUzW
         EsrCavV0Y9zSVxV6BJdbv/FmwJyeuRa661EvvDFg1cZXhiBF4NFo5ANRViD/AZPDwilK
         W3GQ==
X-Received: by 10.60.83.103 with SMTP id p7mr14452882oey.130.1368486837252;
        Mon, 13 May 2013 16:13:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm18802987obg.3.2013.05.13.16.13.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 16:13:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224220>

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
