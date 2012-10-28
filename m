From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 04/13] remote-hg: add support for remote pushing
Date: Sun, 28 Oct 2012 04:54:04 +0100
Message-ID: <1351396453-29042-5-git-send-email-felipe.contreras@gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJxk-0002zZ-Ap
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754849Ab2J1Dyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:54:45 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1Dyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:54:44 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=JSHIvpRRffWmvbGvgPdTTN7QPWW8uQ+RTBIaXNMLSRQ=;
        b=zevpd2uXWgIkTF+9BUHzWTeRmwAH3WPsdTNupDnPcOrRXkrzHHtI85PyLwr2Tlg1ot
         OJOCjEesKoWF3a0VXgedKbk+1chFx2NdJapWNykmqeMsFiQF1lKgHnvVzbUJ4CT0Pams
         pi9zk+xs3SZ0xBPSBT6bpaxscINDCquu73Kq+YJoDTrCoPHig/acX8EJMZh9eqAVt1Yd
         7BLRATKkHh91v3LzQAynmuIgRRWmDGiffWZ6dzfZY65U7Nnj7m5bnHuhSCxVWmcd36Gy
         JbiQNMkqoTrGwk2WvjVR/RE0mU9y6fUNHQDfC67HiMKnKxghpWWjJS6iBzPZ9UIbq78s
         HHag==
Received: by 10.14.225.71 with SMTP id y47mr33175937eep.0.1351396483967;
        Sat, 27 Oct 2012 20:54:43 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id f3sm13221422eeo.13.2012.10.27.20.54.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:54:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208522>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 4021a7d..b10e7d1 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -180,7 +180,7 @@ def fixup_user(user):
     return '%s <%s>' % (name, mail)
 
 def get_repo(url, alias):
-    global dirname
+    global dirname, peer
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
@@ -508,7 +508,7 @@ def parse_tag(parser):
     # nothing to do
 
 def do_export(parser):
-    global parsed_refs
+    global parsed_refs, peer
 
     parser.next()
 
@@ -539,12 +539,17 @@ def do_export(parser):
 
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
