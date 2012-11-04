From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 05/16] remote-hg: make sure the encoding is correct
Date: Sun,  4 Nov 2012 03:13:27 +0100
Message-ID: <1351995218-19889-6-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:14:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjA-0002ES-Hs
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:14:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab2KDCOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:09 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab2KDCOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5O1hX4UP3WUIicU8gRDddnOvG3F/ti7c0jmiUaDEDYA=;
        b=q83rAper3B4xpxLL6yDpWVOenKIL5ziChJClYbkrKuz16wTJRI6pIBVPEfSBJoXQFq
         k8ZpGDjg+ICmRtIem0wEVAHQmdKXov87dLJ8CyAawPm0JTU5QKWHxUwuD7yVNRNdEm7P
         oMYTxEydT1ixvh3akRRk+WN3CJWe/dJC+BLwunNlkL2lLjHbaJhE4oFcBJPCZ8/v0llq
         tnBSPQFioRuGJpm+j5sVKpNvc9hZUFPzEPSBWA5kAlUM/6z0Q6FVNLxqrS61DxFrTYwD
         DhAaB9HOoiv5X+xLSvHjUHzPuNL/PPQ2Sv65jFIDl/Pm+mXBzaT/hfLYCrtibZwbIRgj
         02Og==
Received: by 10.204.147.82 with SMTP id k18mr1388215bkv.48.1351995247014;
        Sat, 03 Nov 2012 19:14:07 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id e3sm7941033bks.7.2012.11.03.19.14.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208992>

Independently of the environment.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a5023c9..503a9fc 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -9,7 +9,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util
+from mercurial import hg, ui, bookmarks, context, util, encoding
 
 import re
 import sys
@@ -391,6 +391,9 @@ def do_import(parser):
     print "feature export-marks=%s" % path
     sys.stdout.flush()
 
+    tmp = encoding.encoding
+    encoding.encoding = 'utf-8'
+
     # lets get all the import lines
     while parser.check('import'):
         ref = parser[1]
@@ -409,6 +412,8 @@ def do_import(parser):
 
         parser.next()
 
+    encoding.encoding = tmp
+
     print 'done'
 
 def parse_blob(parser):
@@ -491,8 +496,13 @@ def parse_commit(parser):
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
