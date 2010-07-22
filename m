From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH] t2017: redo physical reflog existance check
Date: Wed, 21 Jul 2010 22:46:30 -0300
Message-ID: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 03:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obksw-0004ug-Nb
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 03:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620Ab0GVBrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 21:47:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32968 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab0GVBrg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 21:47:36 -0400
Received: by gyg10 with SMTP id 10so251506gyg.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 18:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=moelYe/+UTd7y2IwUJZ596rupYid7VPMcKMW3Bi214M=;
        b=BEV3PROJqFr7Ce+TCizYcJhPYxr8sMro9K7SllBB1M75a1K5X0SXNLHjnTUWj6rppm
         nK9G05ynEhfZQ32RLkXrw2UEC17WpQnAPuzNyQHGtAhLjFKA7BufipPELmkqZvtsuUhb
         vwxR1mOF2WIShUtAZDMn/w+YodDA/1/siD2ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=c8+yGXrIC6hTM15h1CjZ0D7qjn7PAvlIHb2CJY9V4rFMeKLUyIGd6LGTSpmAoaxZQc
         AEhPWbzBl6L7/N8Sd9fa4gBi6S8FmI8jHFc1qLZXGCNdN08sWWwNoZrGP0qG85DisHNx
         cbHAu3wRN2FZcgke3IAlv3OYGWD6vauYoidoc=
Received: by 10.100.214.6 with SMTP id m6mr1162819ang.218.1279763255107;
        Wed, 21 Jul 2010 18:47:35 -0700 (PDT)
Received: from localhost.localdomain ([187.15.0.26])
        by mx.google.com with ESMTPS id l6sm84574613ang.38.2010.07.21.18.47.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 18:47:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.ga86e3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151440>

Commit 6e6842e wiped out physical reflog checks of tests because of
redundancy and to hide low level detail of the implementation.

Although this is not a problem to all the other changes, it is laming to
the tenth test.  The implementation of the correspondent problem creates
a "touch" reflog that must be wiped out if not used by committing the
new branch.

Signed-off-by: Erick Mattos <erick.mattos@gmail.com>
---
 t/t2017-checkout-orphan.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 2d2f63f..0d5d0a0 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -93,8 +93,10 @@ test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates =
 test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
 	git checkout master &&
 	git checkout -l --orphan eta &&
+	test -f .git/logs/refs/heads/eta &&
 	test_must_fail git rev-parse --verify eta@{0} &&
 	git checkout master &&
+	! test -f .git/logs/refs/heads/eta &&
 	test_must_fail git rev-parse --verify eta@{0}
 '
 
-- 
1.7.2.1.ga86e3
