From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/3 resend] t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
Date: Fri, 19 Mar 2010 19:10:20 -0500
Message-ID: <bpVNzWf2wr6FTgNS3ckeC63TJuoZPSe1-UW05J-nQIW6zoMM-wtBYuL5L8itveO523UwTqQt1bg@cipher.nrlssc.navy.mil>
References: <CxNG4R6Vr07DvPgqJe5msbiN0-7URObSdLhedqTJLYFpvj_BbRYts-mzQj8AH3AhwPzM5USx71g@cipher.nrlssc.navy.mil>
Cc: ilari.liusvaara@elisanet.fi, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 20 01:35:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsmfQ-0001fT-CH
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 01:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab0CTAfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 20:35:48 -0400
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:36981 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158Ab0CTAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 20:35:47 -0400
X-Greylist: delayed 1413 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Mar 2010 20:35:47 EDT
Received: by mail.nrlssc.navy.mil id o2K0AkKR003114; Fri, 19 Mar 2010 19:11:01 -0500
In-Reply-To: <CxNG4R6Vr07DvPgqJe5msbiN0-7URObSdLhedqTJLYFpvj_BbRYts-mzQj8AH3AhwPzM5USx71g@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Mar 2010 00:10:29.0913 (UTC) FILETIME=[C01B9890:01CAC7C1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142668>

From: Brandon Casey <drafnel@gmail.com>

This test is supposed to check that git-remote correctly refuses to delete
all URLS for the specified remote which match the '.*' regular expression.
Since the '*' was not protected, it was interpreted by the shell as a file
glob and expanded before being passed to git-remote.  The call to
git-remote still exited non-zero in this case, and the overall test still
passed, but it exited non-zero because git-remote was passed the incorrect
number of arguments, not for the reason it was supposed to fail.

Correct the test by escaping the '*'.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Well, since I don't know if the origin 3/3 was lost or whether I
accidentally hit 'n' when git-send-email prompted me for whether to send
it, here it is again.

-brandon


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
