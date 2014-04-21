From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/3] remote-helpers: squelch python import exceptions
Date: Mon, 21 Apr 2014 15:37:11 -0500
Message-ID: <1398112633-23604-2-git-send-email-felipe.contreras@gmail.com>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 22:47:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcL80-0000qw-9X
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 22:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbaDUUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 16:47:42 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:41977 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbaDUUrj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 16:47:39 -0400
Received: by mail-yh0-f46.google.com with SMTP id b6so3963431yha.5
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DVY+cWNfKeqKzd9/4FIucHCPSZPFRD6NZSs4YGiDQjg=;
        b=lCHLGlBnUYYf8N1x+PzzgFJXQHY9Cl+jh4N68eQBH3rKyRoVFcaCAMsH9tDekl7aEa
         jXqr1AD+d8D8+9M9kxbykBBC/VRoVeJtLuG8YiZlJTHVuWccVZqZ8oKdcmhIuJVW8EPZ
         QqAf0OSIJGWDW8VqoHKYTaqD02hnou5DiALPHEUxZVU2h9Obxje08rqKPgzebK3P7ziu
         6i/h1DiwFGVLQrgaiWkl6dGb3vetXWrK3OvTpZsDF9DjFeTxEXpRKH0TVmmb7cEqEb7y
         W848Kzz/5awVvTXbzDhZmPQyqCCNFiyCvZQ8ncjBZKgNANG4PkJZPzKZ8sK6/DWUPS4s
         WTFg==
X-Received: by 10.236.44.132 with SMTP id n4mr156848yhb.161.1398113258436;
        Mon, 21 Apr 2014 13:47:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id z4sm26729471yhc.11.2014.04.21.13.47.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 13:47:37 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246634>

When the python modules are not present we get an unwanted message:

    *** prove ***
    test-bzr.sh .. Traceback (most recent call last):
      File "<string>", line 1, in <module>
      File "/usr/local/buildtools/current/sitecustomize/sitecu...
        return real_import(name, globals, locals, fromlist, level)
    ImportError: No module named bzrlib
    test-bzr.sh .. skipped: skipping remote-bzr tests; bzr not available
    Files=1, Tests=0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.02 ...

Squelch that output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh       | 2 +-
 contrib/remote-helpers/test-hg-bidi.sh   | 2 +-
 contrib/remote-helpers/test-hg-hg-git.sh | 4 ++--
 contrib/remote-helpers/test-hg.sh        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index a4656ce..932fe8a 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -14,7 +14,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import bzrlib'
+if ! python -c 'import bzrlib' > /dev/null 2>&1
 then
 	skip_all='skipping remote-bzr tests; bzr not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index d86e147..2b5aa9d 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! python -c 'import mercurial' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index b23909a..456a07f 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -17,13 +17,13 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! python -c 'import mercurial' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
 fi
 
-if ! python -c 'import hggit'
+if ! python -c 'import hggit' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; hg-git not available'
 	test_done
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 7d90056..056940a 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -17,7 +17,7 @@ then
 	test_done
 fi
 
-if ! python -c 'import mercurial'
+if ! python -c 'import mercurial' > /dev/null 2>&1
 then
 	skip_all='skipping remote-hg tests; mercurial not available'
 	test_done
-- 
1.9.2+fc1.1.g5c924db
