From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/3] t5501-*.sh: Fix url passed to clone in setup test
Date: Sat, 19 Nov 2011 19:38:54 +0000
Message-ID: <4EC805CE.10203@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 21:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRr7q-0000Vw-7S
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 21:02:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab1KSUCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 15:02:54 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:34108 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752831Ab1KSUCx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2011 15:02:53 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RRr7D-0006NZ-eJ; Sat, 19 Nov 2011 20:02:51 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185701>


In particular, the url passed to git-clone has an extra '/' given
after the 'file://' schema prefix, thus:

    git clone --reference=original "file:///$(pwd)/original one

Once the prefix is removed, the remainder of the url looks something
like "//home/ramsay/git/t/...", which is then interpreted as an
network path. This then results in a "Permission denied" error, like
so:

    ramsay $ ls //home
    ls: cannot access //home: No such host or network path
    ramsay $ ls //home/ramsay
    ls: cannot access //home/ramsay: Permission denied
    ramsay $

In order to fix the problem, we simply remove the extraneous '/'
character from the url.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t5501-fetch-push-alternates.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5501-fetch-push-alternates.sh b/t/t5501-fetch-push-alternates.sh
index b5ced84..1bc57ac 100755
--- a/t/t5501-fetch-push-alternates.sh
+++ b/t/t5501-fetch-push-alternates.sh
@@ -28,7 +28,7 @@ test_expect_success setup '
 		done
 	) &&
 	(
-		git clone --reference=original "file:///$(pwd)/original" one &&
+		git clone --reference=original "file://$(pwd)/original" one &&
 		cd one &&
 		echo Z >count &&
 		git add count &&
-- 
1.7.7
