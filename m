From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Mon, 21 Apr 2014 15:37:12 -0500
Message-ID: <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 22:47:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcL80-0000qw-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbaDUUrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:47:43 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:35699 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaDUUrm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:47:42 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so3990109yho.18
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vMyqQycVG9EpoVMIodr/slKScUwh4jnQYIGfEtrOhCY=;
        b=tuCeIGTzUibcPpEVYngacT3ysOp630ru9KXH7g0t7I/TIpNe+I4tK3j/NrXXrfYGnq
         zDWWPEMhw5r1WZUpyiSoQLlrnwtjVEfH3eNaaacpAaLcnGgjJiCf/7Q/M3XJBlrzC29e
         IG6xWbfk08mxEBjuMwVFbGlf/SuJtQl2x0pTYfPjJ4Y1JTiFlQ9iFo3tsg7Mu+JIex9p
         ICWG58gvvTBZPx29ogqdnzVF6SyhosU6NJ56ttXtp0y4fVPHbdYJTWP6+Rv5KVwJVRfa
         W2H2a2c4OzpUtEGKKfoTSg89Sy2KhYjIN6T8W0gW+0+w6E36yepFpbrKiIX32zd30WkH
         5Gng==
X-Received: by 10.236.129.43 with SMTP id g31mr5549189yhi.115.1398113261972;
        Mon, 21 Apr 2014 13:47:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id f68sm72939081yhd.21.2014.04.21.13.47.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:47:40 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246635>

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
index 932fe8a..a656571 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -14,7 +14,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import bzrlib' > /dev/null 2>&1
+if ! "$PYTHON_PATH" -c 'import bzrlib' > /dev/null 2>&1
 then
 	skip_all='skipping remote-bzr tests; bzr not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index 2b5aa9d..d44ec92 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial' > /dev/null 2>&1
+if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 456a07f..d0d186c 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -17,13 +17,13 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial' > /dev/null 2>&1
+if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
 fi
 
-if ! python -c 'import hggit' > /dev/null 2>&1
+if ! "$PYTHON_PATH" -c 'import hggit' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; hg-git not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 056940a..214c548 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial' > /dev/null 2>&1
+if ! "$PYTHON_PATH" -c 'import mercurial' > /dev/null 2>&1
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
1.9.2+fc1.1.g5c924db
