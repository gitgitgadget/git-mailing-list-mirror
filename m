From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] t/test-lib: print pretty msg when git isn't built
Date: Mon, 17 Sep 2012 22:36:19 +0530
Message-ID: <1347901579-5545-2-git-send-email-artagnon@gmail.com>
References: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDemZ-0007aY-2r
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab2IQRGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:06:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56647 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab2IQRG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:06:29 -0400
Received: by dady13 with SMTP id y13so1016162dad.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pIUbl2J5yF837LQeEmKAEjsEGUito66luHs6BdPzR9w=;
        b=gFkDte1v1ceolnjvqajiZoVQxm8xa82F34sZRSZeAWxV97Bc/Z1FnUr0gOx7jI8eiR
         DhyJiqxGpvN+6hDs/nzCqNlPyR1avNB2A32M1E3BDnXyqiOIwuVl2VGF2vXgZAgEZfkk
         nSPfRXvbHKuJl5qqh+1j5V51FUYtMoVDQhiAns/J/oPduBKLJZ5WhD71NdYBaGBQQ6Fn
         lUzqTJTumx3xo/wFFnuReoaTKAzR2d2W7k2fnEoc5Ml9c9dNhzKC6sXq356nTBqGDHFj
         1ALZz4+dqiCMEVEjIKt6pHGkr7L2PWEsHeH5L6GM4GBHniW5Au0EifiaWqMar1Mo4RBo
         0yqQ==
Received: by 10.68.228.100 with SMTP id sh4mr23527451pbc.45.1347901588729;
        Mon, 17 Sep 2012 10:06:28 -0700 (PDT)
Received: from localhost.localdomain ([49.206.170.14])
        by mx.google.com with ESMTPS id te6sm2196915pbc.29.2012.09.17.10.06.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 10:06:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.8.1.362.g5d6df.dirty
In-Reply-To: <1347901579-5545-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205712>

When tests were run without building git, the following error message
was displayed:

    .: 54: Can't open /path/to/git/source/t/../GIT-BUILD-OPTIONS

Change this to display a more user-friendly error message:

     error: you do not seem to have built git yet.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t0000-basic.sh |   10 ----------
 t/test-lib.sh    |    6 ++++++
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ae6a3f0..08677df 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -18,16 +18,6 @@ swapping compression and hashing order, the person who is making the
 modification *should* take notice and update the test vectors here.
 '
 
-################################################################
-# It appears that people try to run tests without building...
-
-../git >/dev/null
-if test $? != 1
-then
-	echo >&2 'You do not seem to have built git yet.'
-	exit 1
-fi
-
 . ./test-lib.sh
 
 ################################################################
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f8e3733..c00452a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -51,6 +51,12 @@ then
 fi
 GIT_BUILD_DIR="$TEST_DIRECTORY"/..
 
+if ! test -r "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
+then
+	echo 'error: you do not seem to have built git yet.' >&2
+	exit 1
+fi
+
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
-- 
1.7.8.1.362.g5d6df.dirty
