From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-helpers: move out of contrib
Date: Sun, 20 Apr 2014 16:39:30 -0500
Message-ID: <1398029971-1396-2-git-send-email-felipe.contreras@gmail.com>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 23:50:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbzdS-0008AP-5m
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbaDTVum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:50:42 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:61463 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaDTVtz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:49:55 -0400
Received: by mail-yh0-f41.google.com with SMTP id i57so3042187yha.0
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yvaT8JUivPYTT5q9pzoDSKKYULYo9VEMtzdoXU5x3pE=;
        b=KvCrigGo7DI8/XkCXnZGhYj8f7AQiTF4eBy/U33xHC6TQU8nFycaTeqwYusRo7Hfa3
         bsl+5HOQM+T4DNxDvURpTzuI9VBbOKfWuwCw5h7Y8si4A9y6a9pp/hLEsEehQXTVgMSb
         93hhqn93iUk3g49mB+s8rBjE14fn0LhnJmZ5ZCyHc5Q7vboSiNJayUlybW5NpE488QY5
         AlVv2HUIDMoof5cAAdHjPN620HzQlRxH4W8WR5PvKTpxuElBYwJipjD6uJtOB+0UOI7G
         35RbhGYqFbVvpBNS0UwOuzgMbYmKlY0Ko3lCNa5vKeWV6ZablLAqfpRNP5Bum8woFdhw
         fcTg==
X-Received: by 10.236.53.5 with SMTP id f5mr48118888yhc.53.1398030594827;
        Sun, 20 Apr 2014 14:49:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id t42sm66017036yhn.12.2014.04.20.14.49.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 14:49:53 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
In-Reply-To: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246591>

The remote-helpers in contrib/remote-helpers have proved to work, be
reliable, and stable. It's time to move them out of contrib, and be
distributed by default.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 .gitignore                                                 | 2 ++
 Makefile                                                   | 2 ++
 contrib/remote-helpers/test-bzr.sh                         | 2 +-
 contrib/remote-helpers/test-hg-bidi.sh                     | 2 +-
 contrib/remote-helpers/test-hg-hg-git.sh                   | 4 ++--
 contrib/remote-helpers/test-hg.sh                          | 2 +-
 contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py | 0
 contrib/remote-helpers/git-remote-hg => git-remote-hg.py   | 0
 8 files changed, 9 insertions(+), 5 deletions(-)
 rename contrib/remote-helpers/git-remote-bzr => git-remote-bzr.py (100%)
 rename contrib/remote-helpers/git-remote-hg => git-remote-hg.py (100%)

diff --git a/.gitignore b/.gitignore
index dc600f9..db5f15e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,11 +119,13 @@
 /git-reflog
 /git-relink
 /git-remote
+/git-remote-bzr
 /git-remote-http
 /git-remote-https
 /git-remote-ftp
 /git-remote-ftps
 /git-remote-fd
+/git-remote-hg
 /git-remote-ext
 /git-remote-testgit
 /git-remote-testpy
diff --git a/Makefile b/Makefile
index 2128ce3..fda4567 100644
--- a/Makefile
+++ b/Makefile
@@ -483,6 +483,8 @@ SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-p4.py
+SCRIPT_PYTHON += git-remote-hg.py
+SCRIPT_PYTHON += git-remote-bzr.py
 
 NO_INSTALL += git-remote-testgit
 
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index a4656ce..330b147 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -14,7 +14,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import bzrlib'
+if ! "$PYTHON_PATH" -c 'import bzrlib'
 then
 	skip_all='skipping remote-bzr tests; bzr not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index d86e147..e963745 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! "$PYTHON_PATH" -c 'import mercurial'
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index b23909a..c6b4541 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -17,13 +17,13 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! "$PYTHON_PATH" -c 'import mercurial'
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
 fi
 
-if ! python -c 'import hggit'
+if ! "$PYTHON_PATH" -c 'import hggit'
 then
 	skip_all='skipping remote-hg tests; hg-git not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 7d90056..00b7dde 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! "$PYTHON_PATH" -c 'import mercurial'
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
diff --git a/contrib/remote-helpers/git-remote-bzr b/git-remote-bzr.py
similarity index 100%
rename from contrib/remote-helpers/git-remote-bzr
rename to git-remote-bzr.py
diff --git a/contrib/remote-helpers/git-remote-hg b/git-remote-hg.py
similarity index 100%
rename from contrib/remote-helpers/git-remote-hg
rename to git-remote-hg.py
-- 
1.9.1+fc3.9.gc73078e
