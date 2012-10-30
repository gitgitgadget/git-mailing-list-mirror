From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 06/14] remote-hg: make sure the encoding is correct
Date: Tue, 30 Oct 2012 05:35:28 +0100
Message-ID: <1351571736-4682-7-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Oct 30 05:36:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT3Z1-00064O-Ff
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 05:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab2J3EgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 00:36:18 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56861 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab2J3EgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 00:36:16 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2268812bkc.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fM4Xy3u9eELCtUXznTrlXcndI4cHz+ekD9pehZyJnU0=;
        b=tJOb5ON/07aqx+fmJCnCGI0ID732W719BpIia7CMLE425dSVHv8ffT1x1g9e6pR/lU
         hmGqz4vWGKM5Z6t76NOJEUiutwSt3GVQdvkDpAkXWjxObkzIm66jMC33x2P8NIcxtkAU
         6rAVcI9/wjjklzdlQSay1tWdWmglSONsKNDvz6fXvyI016yzP1yLL/P8rEHCSF1ylSoA
         zaSb6h/+5G5Dksf6AfjrYNRoZRzLhb8rvY2LprhqSlzwPbrpyqFGJMDuimURdQDXtwl9
         rQQTqNCbOaOVCNfyJXB0mAhb5vh9YsPmYhQmHOKr6nXtSpqo7k+Sr0BqNCxSiJBCQ0es
         8aWg==
Received: by 10.204.150.206 with SMTP id z14mr9984328bkv.105.1351571775436;
        Mon, 29 Oct 2012 21:36:15 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id z13sm5164347bkv.8.2012.10.29.21.36.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 21:36:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351571736-4682-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208669>

Independently of the environment.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index 4d49923..29824be 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util
+from mercurial import hg, ui, bookmarks, context, util, encoding
 
 import re
 import sys
@@ -373,6 +373,9 @@ def do_import(parser):
     print "feature export-marks=%s" % path
     sys.stdout.flush()
 
+    tmp = encoding.encoding
+    encoding.encoding = 'utf-8'
+
     # lets get all the import lines
     while parser.check('import'):
         ref = parser[1]
@@ -391,6 +394,8 @@ def do_import(parser):
 
         parser.next()
 
+    encoding.encoding = tmp
+
     print 'done'
 
 def parse_blob(parser):
@@ -474,8 +479,13 @@ def parse_commit(parser):
             files.keys(), getfilectx,
             user, (date, tz), extra)
 
+    tmp = encoding.encoding
+    encoding.encoding = 'utf-8'
+
     node = repo.commitctx(ctx)
 
+    encoding.encoding = tmp
+
     rev = repo[node].rev()
 
     parsed_refs[ref] = node
-- 
1.8.0
