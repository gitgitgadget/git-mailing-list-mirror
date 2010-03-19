From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3] t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
Date: Fri, 19 Mar 2010 18:36:36 -0500
Message-ID: <CxNG4R6Vr07DvPgqJe5msXiOdQxDJcRUCjzNf-LPJNy2ozwVv3sxeG9yEQRNflvd8iDQ_qNtsIU@cipher.nrlssc.navy.mil>
References: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil>
Cc: ilari.liusvaara@elisanet.fi, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 20 01:24:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsmU8-0005Yn-3f
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 01:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590Ab0CTAYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 20:24:06 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:52973 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583Ab0CTAYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 20:24:05 -0400
Received: by mail.nrlssc.navy.mil id o2JNas4N010289; Fri, 19 Mar 2010 18:36:54 -0500
In-Reply-To: <CxNG4R6Vr07DvPgqJe5msRW43WBM-kHscjWMfuzYM-XxJsVlLbOmNz_AdlMU4gEIvpsxQfdo7fc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Mar 2010 23:36:53.0793 (UTC) FILETIME=[0E681910:01CAC7BD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142666>

From: Brandon Casey <drafnel@gmail.com>

This test is supposed to check that git-remote correctly refuses to delete
all non-push URLS when the all-encompassing '.*' regular expression is given.
Since the '*' was not protected, it was interpreted by the shell as a file
glob and expanded before being passed to git-remote.  The call to
git-remote still exited non-zero in this case, and the overall test still
passed, but it exited non-zero because git-remote was passed the incorrect
number of arguments, not for the reason it was supposed to fail.

Correct the test by escaping the '*'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t5505-remote.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e7afe9e..acfea06 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -662,7 +662,7 @@ test_expect_success 'remote set-url --add bbb' '
 '
 
 test_expect_success 'remote set-url --delete .*' '
-	test_must_fail git remote set-url --delete someremote .* &&
+	test_must_fail git remote set-url --delete someremote .\* &&
 	echo "YYY" >expect &&
 	echo baz >>expect &&
 	echo bbb >>expect &&
-- 
1.6.6.2
