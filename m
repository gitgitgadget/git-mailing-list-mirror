From: larsxschneider@gmail.com
Subject: [PATCH] travis-ci: run previously failed tests first, then slowest to fastest
Date: Tue, 19 Jan 2016 10:24:29 +0100
Message-ID: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
Cc: peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 10:24:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLSWq-0008VE-MN
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 10:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501AbcASJYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 04:24:35 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36344 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322AbcASJYd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 04:24:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id l65so129742663wmf.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 01:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=koTEoBPzQTYyGkMgTyPgoCvfZ2PI/MRUPHAgjGGcE+k=;
        b=cZ3VLQGtFoltqckEL9smkqeGcLoSglpEIKKBpjo7A8IR8ok1/od/wGp79SZBPHZlt0
         j/3KjbNanyBmwDISfvihKciyyt7WnNexYtCAqG+30qfrCEBFcugAcqfiFUKgDfuuUjba
         g9kh3jwclWYLoAcT6gv68L3Qpw6gYmU9fF99H9odBFjJm3NR7mX1J1fyVPROsjfBldeM
         McSPkX2VeAupLZtEdkYC58t5XgZcf2gnoIJxrQMLqkgWb2Zz8q0DHM4ZBqCGDAKBub6g
         N7WflRC0z9c2zgvGkgwrCJcTCfHaGgCMlA0YEmfynNLR/OtkscOMqok26ckDNwvJ4TyN
         DsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=koTEoBPzQTYyGkMgTyPgoCvfZ2PI/MRUPHAgjGGcE+k=;
        b=F/ncJv12M4PxnyOl/9P+cArCijZgYvLD2XNhYTB2h48/PnJj/kmULgdvIwgeje77as
         CLnksZsLgFGQMG6j9iOjY84pJM2A0ElwDkzk7YGKJjiwNXATs9Zf1smBEXuOc/Ksi77O
         NTOQhWOTjJfzwGjiwLvAiqLCaXex45t0avO/xY/fKW46iyeNjpS0FC2u739CcW58bkB6
         jsnKaUWX6O/UOW3Zvd1/7VsDUGVUJ35tI/Uj6DjERnC/PmcSg1b66Lcldf2iMytRrWHs
         lIN3bDgNRLsTKl6l74nxoBbOzxPZ84v8S9iiqcfCb9YBv8D3yRaullcRoYAWaqA5Ewgw
         1hbg==
X-Gm-Message-State: ALoCoQn+I5KfcmslrchVt6Bf+vMIh2M9IIBL0HteOJT6Czr5kxrImn7dBo11Ad0G5eFJlalMh9gAYq6rzfZleQaQvs5YQrSi2g==
X-Received: by 10.194.23.232 with SMTP id p8mr33620255wjf.80.1453195471937;
        Tue, 19 Jan 2016 01:24:31 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA6D2.dip0.t-ipconnect.de. [80.139.166.210])
        by smtp.gmail.com with ESMTPSA id di8sm27511832wjc.34.2016.01.19.01.24.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jan 2016 01:24:31 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284352>

From: Lars Schneider <larsxschneider@gmail.com>

Use the Travis-CI cache feature to store prove test results and make them
available in subsequent builds. This allows to run previously failed tests
first and run remaining tests in slowest to fastest order. As a result it
is less likely that Travis-CI needs to wait for a single test at the end
which speeds up the test suite execution by ~2 min.

Unfortunately the cache feature is only available (for free) on the
Travis-CI Linux environment.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c3bf9c6..f34726b 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,9 @@
 language: c

+cache:
+  directories:
+    - $HOME/.prove-cache
+
 os:
   - linux
   - osx
@@ -18,7 +22,7 @@ env:
     - P4_VERSION="15.2"
     - GIT_LFS_VERSION="1.1.0"
     - DEFAULT_TEST_TARGET=prove
-    - GIT_PROVE_OPTS="--timer --jobs 3"
+    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
     - GIT_TEST_OPTS="--verbose --tee"
     - CFLAGS="-g -O2 -Wall -Werror"
     - GIT_TEST_CLONE_2GB=YesPlease
@@ -67,6 +71,8 @@ before_install:
     p4 -V | grep Rev.;
     echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
     git-lfs version;
+    mkdir -p $HOME/.prove-cache;
+    ln -s $HOME/.prove-cache/.prove t/.prove;

 before_script: make --jobs=2

--
2.5.1
