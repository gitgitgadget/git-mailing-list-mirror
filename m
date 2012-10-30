From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 04/14] remote-hg: add support for remote pushing
Date: Tue, 30 Oct 2012 05:35:26 +0100
Message-ID: <1351571736-4682-5-git-send-email-felipe.contreras@gmail.com>
References: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Yu-0005xW-0p
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab2J3EgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:07 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3EgG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:06 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6rpBDfZ3F0vgBYt/u3bcYzofB3QN9r7DDsz3iNyqeg0=;
        b=BPm4153uqCgwH1AbJWB6WxZ91L5/mlAye9VRuh6wqI+rdF1l1AJBsmmUD1AQXg5Tj8
         8tFYh9cz42wDTB1LrIWBTIMqC5Ti24py0m4hxzWYjgZhZXTY08uYo8sYtb0cvgALiZAQ
         PRpV+q9BUsxoFUxgcDs1UjXZTFdpOdEhVSND6yvBFsGF0ExayBl4gFizpwR4UbroEyU3
         3p6mHMN7MAK4akf+J52a+Eam5rJXtX+gjghagWHoc3o9lzZkepswEeYUuaQDonOPjaUs
         3PgXD/w2GyCo3dmgoyJE3boYOwnuTJzkj4qqs+wft/D410sajwsBwpUOYgijLc8kl6fx
         EbSQ==
Received: by 10.204.149.10 with SMTP id r10mr9673538bkv.61.1351571765416;
        Mon, 29 Oct 2012 21:36:05 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id z13sm5164273bkv.8.2012.10.29.21.36.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208667>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 337ba40..959ab80 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -183,7 +183,7 @@ def fixup_user(user):
     return '%s <%s>' % (name, mail)
 
 def get_repo(url, alias):
-    global dirname
+    global dirname, peer
 
     myui = ui.ui()
     myui.setconfig('ui', 'interactive', 'off')
@@ -511,7 +511,7 @@ def parse_tag(parser):
     # nothing to do
 
 def do_export(parser):
-    global parsed_refs
+    global parsed_refs, peer
 
     parser.next()
 
@@ -542,12 +542,17 @@ def do_export(parser):
 
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
