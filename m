From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/8] remote-bzr: make bzr branches configurable per-repo
Date: Wed, 28 Aug 2013 14:23:07 -0500
Message-ID: <1377717793-27170-3-git-send-email-felipe.contreras@gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 28 21:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VElPc-0003YT-Ps
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 21:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812Ab3H1T2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 15:28:08 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:52300 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3H1T2F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 15:28:05 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so8236308oah.6
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t2xSAzigguoj8HgvgDUZJp6gc5H+w5OC9XBXjS/gnQM=;
        b=ArsJKhjGXafjLerBVGoGvwOl2YV5ci0jLH+YE5xHlkR6kj5EEkWX4nuPiNrSYb2w5b
         csLLduVDKbujJ0bfH1Q9C08paSd9Pn+BMbFv/UVm54fbWZOgG92y3doI9QHI59Nj0c0O
         YTvfbss+OuVe3O/KAW0S32C37nHKslXbFl2GKAFPhFwcYpi5uQMiuBZfXX3FEgiscJp4
         JMlHKH9Ur3na4lxaI/Tr2TLxOK45d8cks3fbp0MByfoLLir7Whl8YX/87hdT424LRJ9Q
         /gC43eYUtIdyTCujcjiZr1zIycfuraWcOO6q91F4fG//6RcU5l1a+T/4w8BgNahKh2RS
         w8ng==
X-Received: by 10.182.230.163 with SMTP id sz3mr7477168obc.81.1377718085216;
        Wed, 28 Aug 2013 12:28:05 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qi5sm27507546obb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 12:28:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233197>

Different repositories have different branches, some are are even
branches themselves.

Reported-by: Peter Niederlag <netservice@niekom.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 08b0b61..a7d2ac9 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -13,8 +13,11 @@
 # or
 # % git clone bzr::lp:myrepo
 #
-# If you want to specify which branches you want track (per repo):
-# git config remote-bzr.branches 'trunk, devel, test'
+# If you want to specify which branches you want to track (per repo):
+# % git config remote.origin.bzr-branches 'trunk, devel, test'
+#
+# Where 'origin' is the name of the repository you want to specify the
+# branches.
 #
 
 import sys
@@ -852,9 +855,13 @@ def get_repo(url, alias):
             except bzrlib.errors.NoRepositoryPresent:
                 pass
 
-    wanted = get_config('remote-bzr.branches').rstrip().split(', ')
+    wanted = get_config('remote.%s.bzr-branches' % alias).rstrip().split(', ')
     # stupid python
     wanted = [e for e in wanted if e]
+    if not wanted:
+        wanted = get_config('remote-bzr.branches').rstrip().split(', ')
+        # stupid python
+        wanted = [e for e in wanted if e]
 
     if not wanted:
         try:
-- 
1.8.4-fc
