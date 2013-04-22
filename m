From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/16] remote-hg: add support for schemes extension
Date: Mon, 22 Apr 2013 16:55:19 -0500
Message-ID: <1366667724-567-12-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOm6-0004l9-KH
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab3DVV7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:59:46 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:59348 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3DVV7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:59:45 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so6555671oag.13
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=GOdpGzM/buk0X3fyluLIHNVFdmOrDiwsNYxP23X6Gsc=;
        b=S1RuhO1Pa90c6u/+zi28YLfhdA4wg2STr/E/+y5JKm+oLkm44NbnHCuJa9TLF3mzHw
         Lid12fNxu0eZQa0INiEroGtqVtyLsmzsEvKzK9yVNrN4bu+T4/mRgu8wUpcefnYacc8P
         GtgIwPVIO6g+1Z3RQe7ix7TDGh/epdRImG2jUd2Z1mNRDu3f33z1j795ucsK+4oTty+R
         sQpKAgFD422UDOSmLzuesg7f/oMOcFDsG2PGAa4eZbcbIDzl3QU8nzU7fB0BTChQ6bP6
         Y6YAILiJeeNl4/jEyzYJX5QM+eqPUbNJHNXa3xIyf5tr7Hx8uDvXEY4JYBryXCiplN4Q
         95MQ==
X-Received: by 10.60.121.70 with SMTP id li6mr11928208oeb.16.1366667984914;
        Mon, 22 Apr 2013 14:59:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm20875557oee.8.2013.04.22.14.59.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:59:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222108>

So that we can use shortened URLs, for example 'bb:://felipec/repo'
(Bitbucket).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0084709..4f6c7b7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, util, encoding, node, error
+from mercurial import hg, ui, bookmarks, context, util, encoding, node, error, extensions
 
 import re
 import sys
@@ -305,6 +305,12 @@ def get_repo(url, alias):
     except subprocess.CalledProcessError:
         pass
 
+    try:
+        mod = extensions.load(myui, 'hgext.schemes', None)
+        mod.extsetup(myui)
+    except ImportError:
+        pass
+
     if hg.islocal(url):
         repo = hg.repository(myui, url)
     else:
-- 
1.8.2.1.790.g4588561
