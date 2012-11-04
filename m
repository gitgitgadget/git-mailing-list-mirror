From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 03/16] remote-hg: add support for remote pushing
Date: Sun,  4 Nov 2012 03:13:25 +0100
Message-ID: <1351995218-19889-4-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpj9-0002ES-Hk
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2KDCOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:01 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab2KDCN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:13:59 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EvWiFOAB2JbEKn+WRoZxv0dShCPNpGrz0Dmxq5SY+ks=;
        b=LM1ZjEEntPX3If0CTOhQUzKlh+1At0HvkQ6y2uXTuttU6CXtWrviPvILyDrSJHdIHN
         AWkn4mqfF6hRSyTCIcuxTFT96SbUUrCN3naVTWV/ZSghzaA36IQJTcofFu7MUBrCk3vT
         PAI0+p93ZGshcuWSl9kYFcLheAbVx5BEGN8FtD/mAl8L2orZatBamdpI9tjCpInCMsPn
         soefpA7+5k0BaCKeHrOEnABENIhu6rxggFLRstCh0jS8hhqgfYo7XAfjo9AymGqXaDGE
         KgQyfWC7fK9cw3XZzSmXgY7BmRjhPMuVX9ZoaDAfVNkNuFCu1MV4tM8iEM7jciaZpx9O
         VeXw==
Received: by 10.204.11.207 with SMTP id u15mr1434047bku.40.1351995239109;
        Sat, 03 Nov 2012 19:13:59 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id 9sm7946373bkq.13.2012.11.03.19.13.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:13:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208988>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index fcceede..45629e0 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -197,7 +197,7 @@ def fixup_user(user):
     return '%s <%s>' % (name, mail)
 
 def get_repo(url, alias):
-    global dirname
+    global dirname, peer
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
@@ -526,7 +526,7 @@ def parse_tag(parser):
     # nothing to do
 
 def do_export(parser):
-    global parsed_refs, bmarks
+    global parsed_refs, bmarks, peer
 
     parser.next()
 
@@ -562,12 +562,17 @@ def do_export(parser):
 
     print
 
+    if peer:
+        parser.repo.push(peer, force=False)
+
 def main(args):
     global prefix, dirname, branches, bmarks
     global marks, blob_marks, parsed_refs
+    global peer
 
     alias = args[1]
     url = args[2]
+    peer = None
 
     gitdir = os.environ['GIT_DIR']
     dirname = os.path.join(gitdir, 'hg', alias)
-- 
1.8.0
