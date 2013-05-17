From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: fixes for older versions of bzr
Date: Fri, 17 May 2013 12:10:19 -0500
Message-ID: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 19:12:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOD8-0006K0-OL
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139Ab3EQRMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:12:51 -0400
Received: from mail-gg0-f176.google.com ([209.85.161.176]:54593 "EHLO
	mail-gg0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab3EQRMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:12:50 -0400
Received: by mail-gg0-f176.google.com with SMTP id b1so155183ggm.7
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=YmDJWqfLyEbTbcUfzGbunlZjGh/zbCgHyBzRtB5ByRY=;
        b=OChuLTmqaEHYlWXeh/WNAb3dl3Eg+wh5O+XnepE0VpzGHwD5MnED9bhN5iuDE0jIkw
         F/bPv2zR2A4a1pMCv+tuACHQKeP8bveUzBGFAgpn/RN9Ioeeu5nWZez14YBcOBUTJT9h
         mDGwgNjuGjI3UKNJfgTr9piuPH+3H+H7Gilpd4+psYdZhn6flYyejXEyJJXX+ZfUlD9c
         5UWwXRXwemBXpC8HYeGmP7BWGZZQ1P/GXce50ZiLj820J+o4udSDFTKc90iVPL944sTC
         bIBcfR5/NskrD5UxcALdlXGTGgYXaSdOjBwn9ZqRlYQfcaa6dqRH4FOErYEc31z9iqMQ
         XAzg==
X-Received: by 10.236.138.79 with SMTP id z55mr26411277yhi.104.1368810769744;
        Fri, 17 May 2013 10:12:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d51sm18652704yho.14.2013.05.17.10.12.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 10:12:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224710>

Up to v2.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index ad42317..51b4a29 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -31,6 +31,7 @@ import bzrlib.transport
 import bzrlib.errors
 import bzrlib.ui
 import bzrlib.urlutils
+import bzrlib.branch
 
 import sys
 import os
@@ -788,7 +789,7 @@ def get_remote_branch(origin, remote_branch, name):
     return branch
 
 def find_branches(repo, wanted):
-    transport = repo.user_transport
+    transport = repo.bzrdir.root_transport
 
     for fn in transport.iter_files_recursive():
         if not fn.endswith('.bzr/branch-format'):
@@ -922,7 +923,8 @@ def main(args):
     if not os.path.exists(dirname):
         os.makedirs(dirname)
 
-    bzrlib.ui.ui_factory.be_quiet(True)
+    if hasattr(bzrlib.ui.ui_factory, 'be_quiet'):
+        bzrlib.ui.ui_factory.be_quiet(True)
 
     repo = get_repo(url, alias)
 
-- 
1.8.3.rc2.542.g24820ba
