From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] Revert "reset: Make reset remove the sequencer state"
Date: Sat, 10 Dec 2011 07:03:48 -0600
Message-ID: <20111210130348.GG22035@elie.hsd1.il.comcast.net>
References: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
 <20111120094650.GB2278@elie.hsd1.il.comcast.net>
 <20111122111207.GA7399@elie.hsd1.il.comcast.net>
 <20111122112001.GF7399@elie.hsd1.il.comcast.net>
 <7vr50zd5x0.fsf@alter.siamese.dyndns.org>
 <20111123012721.GA14217@elie.hsd1.il.comcast.net>
 <4ECCB3A2.5030102@viscovery.net>
 <20111123100452.GA30629@elie.hsd1.il.comcast.net>
 <4ECCC935.7010407@viscovery.net>
 <20111210124644.GA22035@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 14:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZMar-0005Yu-GW
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 14:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab1LJNDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 08:03:53 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52345 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab1LJNDw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 08:03:52 -0500
Received: by iaeh11 with SMTP id h11so204801iae.19
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 05:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X4wkM0xXWluygNvur8+gg+R12/P96lR/0JRaDaQZpMo=;
        b=m/a3Gbk/1BtR3pubwcjHG4W5J6WkYfK3j7ybqATh3WleaJvC+HseLjsakMa3Ke0ptW
         iEjU6NrYKRT87g+ZCp3B+smpI+niNtIGSaTe1Tjp59Zy04rUDF+dXt9bmQwhwm87xyRn
         thFCXACB91Wr1QOYO+2NRotUm7rNUAvYr4wLs=
Received: by 10.50.217.195 with SMTP id pa3mr8243795igc.12.1323522232237;
        Sat, 10 Dec 2011 05:03:52 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b20sm23334582ibj.7.2011.12.10.05.03.51
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 05:03:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210124644.GA22035@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186775>

This reverts commit 95eb88d8ee588d89b4f06d2753ed4d16ab13b39f, which
was a UI experiment that did not reflect how "git reset" actually gets
used.  The reversion also fixes a test, indicated in the patch.

Encouraged-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c                        |    2 -
 t/t3510-cherry-pick-sequence.sh |    2 +-
 t/t7106-reset-sequence.sh       |   52 ---------------------------------------
 3 files changed, 1 insertions(+), 55 deletions(-)
 delete mode 100755 t/t7106-reset-sequence.sh

diff --git a/branch.c b/branch.c
index 025a97be..a6b6722e 100644
--- a/branch.c
+++ b/branch.c
@@ -3,7 +3,6 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
-#include "sequencer.h"
 
 struct tracking {
 	struct refspec spec;
@@ -247,5 +246,4 @@ void remove_branch_state(void)
 	unlink(git_path("MERGE_MSG"));
 	unlink(git_path("MERGE_MODE"));
 	unlink(git_path("SQUASH_MSG"));
-	remove_sequencer_state(0);
 }
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 851b147f..e80050e1 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -353,7 +353,7 @@ test_expect_success '--continue asks for help after resolving patch to nil' '
 	test_i18ngrep "The previous cherry-pick is now empty" msg
 '
 
-test_expect_failure 'follow advice and skip nil patch' '
+test_expect_success 'follow advice and skip nil patch' '
 	pristine_detach conflicting &&
 	test_must_fail git cherry-pick initial..picked &&
 
diff --git a/t/t7106-reset-sequence.sh b/t/t7106-reset-sequence.sh
deleted file mode 100755
index 83f7ea59..00000000
--- a/t/t7106-reset-sequence.sh
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/bin/sh
-
-test_description='Test interaction of reset --hard with sequencer
-
-  + anotherpick: rewrites foo to d
-  + picked: rewrites foo to c
-  + unrelatedpick: rewrites unrelated to reallyunrelated
-  + base: rewrites foo to b
-  + initial: writes foo as a, unrelated as unrelated
-'
-
-. ./test-lib.sh
-
-pristine_detach () {
-	git cherry-pick --quit &&
-	git checkout -f "$1^0" &&
-	git read-tree -u --reset HEAD &&
-	git clean -d -f -f -q -x
-}
-
-test_expect_success setup '
-	echo unrelated >unrelated &&
-	git add unrelated &&
-	test_commit initial foo a &&
-	test_commit base foo b &&
-	test_commit unrelatedpick unrelated reallyunrelated &&
-	test_commit picked foo c &&
-	test_commit anotherpick foo d &&
-	git config advice.detachedhead false
-
-'
-
-test_expect_success 'reset --hard cleans up sequencer state, providing one-level undo' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	test_path_is_dir .git/sequencer &&
-	git reset --hard &&
-	test_path_is_missing .git/sequencer &&
-	test_path_is_dir .git/sequencer-old &&
-	git reset --hard &&
-	test_path_is_missing .git/sequencer-old
-'
-
-test_expect_success 'cherry-pick --abort does not leave sequencer-old dir' '
-	pristine_detach initial &&
-	test_must_fail git cherry-pick base..anotherpick &&
-	git cherry-pick --abort &&
-	test_path_is_missing .git/sequencer &&
-	test_path_is_missing .git/sequencer-old
-'
-
-test_done
-- 
1.7.8.rc3
