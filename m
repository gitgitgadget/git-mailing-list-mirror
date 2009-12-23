From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/2] t7800-difftool: Set a bogus tool for use by tests
Date: Tue, 22 Dec 2009 21:27:13 -0800
Message-ID: <1261546034-7780-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 06:27:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNJlC-0007IQ-Fh
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 06:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbZLWF1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 00:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbZLWF1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 00:27:24 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:59476 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbZLWF1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 00:27:24 -0500
Received: by ywh12 with SMTP id 12so7511788ywh.21
        for <git@vger.kernel.org>; Tue, 22 Dec 2009 21:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=iouBtNqRxnG9h3AUdD0X+K7X77e/J4+iH+k/jFYTDAI=;
        b=jEnjP/pVh8t2G9T+O57pN98sq5qIFUlhIB72z8D1IVTn8b573QigH79ZzxWfbzCE1b
         EiyUPZnjVAWpyVWLAMy1rErZXIx3g/kKfB2PsCSEdBijBwKX9JvvKh769ngoEjGNX2w3
         /fnuKZuop7Yyo4/SlqHJKeYW50Wkd+7QMucfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=uf0w5P6C9IdhPIUnOM4iENCVc0/MAquKM6pYKI7e3nq67rGqzCzohBzHiW0bEHI+po
         PN2j3O5dsVxfLr1OT9T3vxe+QE3FW9Nv+s+/o1axdWohoi4N1HlppAXAAM0nL/3P4ekC
         +iW/lgAzmQz7hF67rlBwHJH/Egokq079cQHAU=
Received: by 10.150.6.33 with SMTP id 33mr14952371ybf.175.1261546042503;
        Tue, 22 Dec 2009 21:27:22 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm3122009yxd.52.2009.12.22.21.27.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Dec 2009 21:27:21 -0800 (PST)
X-Mailer: git-send-email 1.6.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135613>

If a difftool test has an error then running the git test suite
may end up invoking a GUI diff tool.  We now guard against this
by setting a difftool.bogus-tool.cmd variable.

The tests already used --tool=bogus-tool in various places so
this is simply ensuring that nothing ever falls back and
finds a real diff tool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index fff6a6d..707a0f5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -36,6 +36,7 @@ restore_test_defaults()
 	unset GIT_DIFFTOOL_NO_PROMPT
 	git config diff.tool test-tool &&
 	git config difftool.test-tool.cmd 'cat $LOCAL'
+	git config difftool.bogus-tool.cmd false
 }
 
 prompt_given()
@@ -71,7 +72,7 @@ test_expect_success 'custom commands' '
 
 # Ensures that git-difftool ignores bogus --tool values
 test_expect_success 'difftool ignores bad --tool values' '
-	diff=$(git difftool --no-prompt --tool=bogus-tool branch)
+	diff=$(git difftool --no-prompt --tool=bad-tool branch)
 	test "$?" = 1 &&
 	test "$diff" = ""
 '
-- 
1.6.2.5
