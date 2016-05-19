From: larsxschneider@gmail.com
Subject: [PATCH v1 2/2] travis-ci: enable sequential test execution for t9113 and 9126
Date: Thu, 19 May 2016 11:10:09 +0200
Message-ID: <1463649009-56941-3-git-send-email-larsxschneider@gmail.com>
References: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
Cc: e@80x24.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 11:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3JyP-00049S-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 11:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbcESJKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 05:10:19 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32957 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcESJKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 05:10:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so19251478wme.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziimu1Qb72gKBHDY1Oznee+ENrZfgfuTDTxqscOfIsA=;
        b=AvrjBgj173GAtipbtd2BcQzRwmHWbq0EWXbCKVo+NN16VR0NG5G89Vqc7ofXoOMyyd
         LMMnMdQP2MGHQkCZcvlFM85mwYK3JkR8ZyAtZBHoyXy2kR1ed0mnYL5G51lehBf41Xuz
         HZFaX7YCo1oRVppwwApFYMEqIc9gVQnQKhk9EMpZaqpqXLy7DRCwXYO5sspK1xytCDFQ
         y4IOWENIOLl8Gxjm4wC7O5s7fbsr/8MSmnpiz3HNBD32i+YxD+avF++aXM76Vn1F2nVg
         BBS1hsgkJ5121pvfdDgD8wqJXLIJaJ7qsDuEwN3OdtniflFDgBxnQdzRqLxJIxOLkAKr
         l8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ziimu1Qb72gKBHDY1Oznee+ENrZfgfuTDTxqscOfIsA=;
        b=R28E+N4J3XOwVNwBAyRXwOI1rcAjp7D63yUWVbTds6Fr9SpWDJ5fzdIC2lbYasABXr
         U1dR/LA9uDnfz0XY/iqm17abGqn/xDJPYIC91lxewcTKHB9m1rD/hQv/FHxIj2fj4Y3c
         6Of229wavyX8dnJlpXeI7nKFP1xEjHM8KGPrBHTl+so5yHSuwWB+YWDcW72sZOeUISdi
         dcPdNZPe2tcj6qSmESIeNFR6xdnCkV4Pw2hW0Npq1BRJlZvOjOGTJXDp1pduglcgckDw
         In8M0+DE+z+WOg30QHfTIdM2CmFPVSSdApbjVtSAUCSVw+2AjlOEpUkpbcqPmG8dxHeq
         /csQ==
X-Gm-Message-State: AOPr4FUsIKgKUb5af/QIKQ2ZyZJL0LfsPrtGDSfjYrlqzwM/0Y+4fJLuytk55MVmLOvcTg==
X-Received: by 10.28.29.147 with SMTP id d141mr35291316wmd.91.1463649013856;
        Thu, 19 May 2016 02:10:13 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB7732.dip0.t-ipconnect.de. [93.219.119.50])
        by smtp.gmail.com with ESMTPSA id n66sm13716029wmf.6.2016.05.19.02.10.13
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 19 May 2016 02:10:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1463649009-56941-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295050>

From: Lars Schneider <larsxschneider@gmail.com>

Enable t9113 and 9126 by defining the SVNSERVER_PORT. Since both tests
open the same port during execution, they cannot run in parallel. Add
a ".seq.sh" suffix to the test files and teach "prove" to run them
sequentially.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml                                                            | 3 ++-
 ...t-svn-dcommit-new-file.sh => t9113-git-svn-dcommit-new-file.seq.sh} | 0
 ...ectory.sh => t9126-git-svn-follow-deleted-readded-directory.seq.sh} | 0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename t/{t9113-git-svn-dcommit-new-file.sh => t9113-git-svn-dcommit-new-file.seq.sh} (100%)
 rename t/{t9126-git-svn-follow-deleted-readded-directory.sh => t9126-git-svn-follow-deleted-readded-directory.seq.sh} (100%)

diff --git a/.travis.yml b/.travis.yml
index c20ec54..605ced1 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -29,9 +29,10 @@ env:
     - LINUX_P4_VERSION="16.1"
     - LINUX_GIT_LFS_VERSION="1.2.0"
     - DEFAULT_TEST_TARGET=prove
-    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
+    - GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save --rules='seq=*.seq.*' --rules='par=**'"
     - GIT_TEST_OPTS="--verbose --tee"
     - GIT_TEST_CLONE_2GB=YesPlease
+    - SVNSERVE_PORT=3690
     # t9810 occasionally fails on Travis CI OS X
     # t9816 occasionally fails with "TAP out of sequence errors" on Travis CI OS X
     - GIT_SKIP_TESTS="t9810 t9816"
diff --git a/t/t9113-git-svn-dcommit-new-file.sh b/t/t9113-git-svn-dcommit-new-file.seq.sh
similarity index 100%
rename from t/t9113-git-svn-dcommit-new-file.sh
rename to t/t9113-git-svn-dcommit-new-file.seq.sh
diff --git a/t/t9126-git-svn-follow-deleted-readded-directory.sh b/t/t9126-git-svn-follow-deleted-readded-directory.seq.sh
similarity index 100%
rename from t/t9126-git-svn-follow-deleted-readded-directory.sh
rename to t/t9126-git-svn-follow-deleted-readded-directory.seq.sh
-- 
2.5.1
