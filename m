From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] t5541: test more combinations of --progress
Date: Tue, 1 May 2012 11:35:01 +0200
Message-ID: <20120501093501.GB22633@ecki.lan>
References: <20120501084048.GA21904@sigill.intra.peff.net>
 <20120501084307.GC4998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, dfowler <davidfowl@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com,
	Paul Betts <paul@github.com>, David Ebbo <david.ebbo@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 01 11:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP9UH-0005lR-4c
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 11:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2EAJfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 05:35:06 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:40513 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab2EAJfF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 05:35:05 -0400
Received: from [127.0.0.1] (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 1E9F1CDF87;
	Tue,  1 May 2012 11:35:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120501084307.GC4998@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196675>

Can we add this on top or squashed in? I regret using tee when I
originally wrote the test.

--8<--
Subject: [PATCH] t5541: check return codes

By piping output to tee, the return code of the command is hidden.
Instead, redirect output to a file directly.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t5541-http-push.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 986210a..c07973e 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -218,21 +218,21 @@ test_expect_success 'push --mirror to repo with alternates' '
 test_expect_success TTY 'push shows progress when stderr is a tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit noisy &&
-	test_terminal git push 2>&1 | tee output &&
+	test_terminal git push >output 2>&1 &&
 	grep "^Writing objects" output
 '
 
 test_expect_success TTY 'push --quiet silences status and progress' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit quiet &&
-	test_terminal git push --quiet 2>&1 | tee output &&
+	test_terminal git push --quiet >output 2>&1 &&
 	test_cmp /dev/null output
 '
 
 test_expect_success TTY 'push --no-progress silences progress but not status' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit no-progress &&
-	test_terminal git push --no-progress 2>&1 | tee output &&
+	test_terminal git push --no-progress >output 2>&1 &&
 	grep "^To http" output &&
 	! grep "^Writing objects"
 '
@@ -240,7 +240,7 @@ test_expect_success TTY 'push --no-progress silences progress but not status' '
 test_expect_success 'push --progress shows progress to non-tty' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	test_commit progress &&
-	git push --progress 2>&1 | tee output &&
+	git push --progress >output 2>&1 &&
 	grep "^To http" output &&
 	grep "^Writing objects" output
 '
-- 
1.7.10
