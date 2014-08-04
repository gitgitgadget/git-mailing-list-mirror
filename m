From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 1/2] t5704: Complement annotated tag exclusion test
Date: Mon,  4 Aug 2014 22:57:02 +0200
Message-ID: <1407185823-9950-1-git-send-email-git@cryptocrack.de>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 22:57:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPJm-000888-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbaHDU5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:57:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:60586 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbaHDU5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:57:06 -0400
Received: from localhost ([87.180.47.94]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MSuYT-1X48Jx1WSb-00Rm9R for <git@vger.kernel.org>; Mon,
 04 Aug 2014 22:57:04 +0200
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
X-Provags-ID: V03:K0:lWU7W7DL2hSn0Nk3jLnQd8cfauBKulDTrpkfC6dVgzbJCkd5LnD
 +0Vjc0C9+ngfxRaitQeiskTx15fDROLfVOFr0Vw7OE5MSRBmP5yY0BaqHUsInVrwsiWdr9X
 a6KQaLyx9f4dKigR3yRevIAOtKLseX5LR51r/WqV6BTEVxP630EQdoTURycUGICaU5NiLxs
 7dtsCR0sUZZLfdL60ErUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254783>

In c9a42c4 (bundle: allow rev-list options to exclude annotated tags,
2009-01-02), we added a test to check whether annotated tags, which fall
outside the specified date range, are excluded from bundles. Complement
this test by also checking whether tags inside the date range are
included. Since this addition reveals that the annotated tag exclusion
is flawed, mark the test expect-failure for now.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
I decided that it is still worthwhile to have this in a separate patch.
Feel free to squash 1/2 and 2/2 or let me know that they should be
merged if you prefer that.

 t/t5704-bundle.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index a45c316..2d53388 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -14,7 +14,10 @@ test_expect_success 'setup' '
 	git tag -d third
 '
 
-test_expect_success 'tags can be excluded by rev-list options' '
+test_expect_failure 'tags can be excluded by rev-list options' '
+	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
+	git ls-remote bundle > output &&
+	grep tag output &&
 	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
 	git ls-remote bundle > output &&
 	! grep tag output
-- 
2.0.4
