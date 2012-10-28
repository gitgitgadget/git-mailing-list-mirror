From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 06/13] remote-hg: make sure the encoding is correct
Date: Sun, 28 Oct 2012 04:54:06 +0100
Message-ID: <1351396453-29042-7-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Oct 28 04:55:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSJyC-0003Mp-TC
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 04:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754873Ab2J1DzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 23:55:13 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38829 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab2J1DzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 23:55:11 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1585004eek.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 20:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pJG200E5VEILbLnxhGCPirN7q505Exmr4ZhU/mS8xzI=;
        b=LvJ0q7Ywg8xGY0HNfo0ADXArrDmaKo+ePcrvsfiVizH3YDA6u1TYGWDiDRIq6nOfJV
         ubrIktSVaQM1Elcwz6V7Z1NBQm3+mrgFofKWXo9aJrBHAvoJ4IgmcWDHjbdIxv4GwAHd
         WisEbGCGCJzGN7JompNFg6VBPjgMoNIAuXNvEg4Hjnl7cXx4Vf4K/tW9aocJgKpg+6oo
         tOFqUPzxzgNICUc1gaMBEM0201sRgwvMlhk5x8tuJKjmRGZZ254WTPzdmHaY204yNOjc
         pcQIh9sAldTDlpJHPr31LuJF1uRZWK1COP7aCuy7RVlqmmC1zMuZFBk87qKowOt8KqmJ
         k54g==
Received: by 10.14.214.2 with SMTP id b2mr48163901eep.32.1351396510989;
        Sat, 27 Oct 2012 20:55:10 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id i1sm13227645eeo.8.2012.10.27.20.55.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 20:55:10 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208524>

Independently of the environment.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-hg/git-remote-hg | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-hg/git-remote-hg b/contrib/remote-hg/git-remote-hg
index c96e1a8..1689573 100755
--- a/contrib/remote-hg/git-remote-hg
+++ b/contrib/remote-hg/git-remote-hg
@@ -6,7 +6,7 @@
 # Then you can clone with:
 # git clone hg::/path/to/mercurial/repo/
 
-from mercurial import hg, ui, bookmarks, context, util
+from mercurial import hg, ui, bookmarks, context, util, encoding
 
 import re
 import sys
@@ -370,6 +370,9 @@ def do_import(parser):
     print "feature export-marks=%s" % path
     sys.stdout.flush()
 
+    tmp = encoding.encoding
+    encoding.encoding = 'utf-8'
+
     # lets get all the import lines
     while parser.check('import'):
         ref = parser[1]
@@ -388,6 +391,8 @@ def do_import(parser):
 
         parser.next()
 
+    encoding.encoding = tmp
+
     print 'done'
 
 def parse_blob(parser):
@@ -471,8 +476,13 @@ def parse_commit(parser):
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
