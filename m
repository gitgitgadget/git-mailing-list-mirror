From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 6/8] t9500: Add basic sanity tests for side-by-side diff in gitweb
Date: Mon, 31 Oct 2011 00:36:25 +0100
Message-ID: <1320017787-18048-7-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf2A-0006mk-Fk
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810Ab1J3XnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:43:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39759 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1J3XnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:43:16 -0400
Received: by mail-fx0-f46.google.com with SMTP id n17so5069535faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nfFsTwpe0T4MlxtcbcImCkObrFSscb63UnvKD8W39jg=;
        b=nS3FpAdq81BJpIcly5kwcz3e1++bSdSJTFVuFCcjdIbCjqLUZFZXkkUFKQnw+ykznp
         2VexlxqZlEtl5959JPpSmjDSzwK846SQzCdrHxOlZ72341KdpvRSSUHnUPPxuh8joRWb
         KsmI1f0h+TziKmbnhfvEN6KFT/bLndZIC7ULU=
Received: by 10.223.5.66 with SMTP id 2mr24746419fau.26.1320018196306;
        Sun, 30 Oct 2011 16:43:16 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.43.14
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:43:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184485>

Test that side-by-side diff can deal with incomplete lines (and while
at it with pure addition, pure removal, and change), and with merge
commits, producing no errors or warnings.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is new in this version.

Note this while it does not check if the output is sane, it can help
with manual check; just run test with `--debug' option, and point
gitweb to "t/trash\ directory.t9500-gitweb-standalone-no-errors/.git/"
repository.

 t/t9500-gitweb-standalone-no-errors.sh |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index c731507..ab24917 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -329,7 +329,8 @@ test_expect_success \
 	 git add b &&
 	 git commit -a -m "On branch" &&
 	 git checkout master &&
-	 git pull . b'
+	 git pull . b &&
+	 git tag merge_commit'
 
 test_expect_success \
 	'commit(0): merge commit' \
@@ -379,6 +380,29 @@ test_expect_success \
 	'gitweb_run "p=.git;a=commitdiff;h=b"'
 
 # ----------------------------------------------------------------------
+# side-by-side diff
+
+test_expect_success 'side-by-side: addition of incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_add;ds=sidebyside"
+'
+
+test_expect_success 'side-by-side: incomplete line as context line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_ctx;ds=sidebyside"
+'
+
+test_expect_success 'side-by-side: changed incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_chg;ds=sidebyside"
+'
+
+test_expect_success 'side-by-side: removal of incomplete line' '
+	gitweb_run "p=.git;a=commitdiff;h=incomplete_lines_rem;ds=sidebyside"
+'
+
+test_expect_success 'side-by-side: merge commit' '
+	gitweb_run "p=.git;a=commitdiff;h=merge_commit;ds=sidebyside"
+'
+
+# ----------------------------------------------------------------------
 # tags testing
 
 test_expect_success \
-- 
1.7.6
