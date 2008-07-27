From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Sat, 26 Jul 2008 23:53:30 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807262343510.426@harper.uchicago.edu>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
 <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
 <200807270519.41441.chriscool@tuxfamily.org> <200807270604.16581.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 06:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMyHD-0005bU-Ec
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 06:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbYG0Exf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 00:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYG0Exf
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 00:53:35 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:59760 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYG0Exe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 00:53:34 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6R4rVob024592;
	Sat, 26 Jul 2008 23:53:31 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6R4rVoC000720;
	Sat, 26 Jul 2008 23:53:31 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <200807270604.16581.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90310>

t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
status when asked to list nonexistent files.  Unfortunately,
/bin/ls on Mac OS X 10.3 exits with exit code 0.  So look at
its output instead.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
Acked-by: Christian Couder <chriscool@tuxfamily.org>
---
On Sun, 27 Jul 2008, Christian Couder wrote:

> It seems that there is a problem with the message itself though. When I "git 
> am" it, I get:
> 
> fatal: cannot convert from x-unknown to utf-8

Hmm, not sure what happened.  Maybe resending it will work...

 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..244fda6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk instead of revs' '
 	test_must_fail git bisect start foo $HASH1 -- &&
 	test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
 	test -z "$(git for-each-ref "refs/bisect/*")" &&
-	test_must_fail ls .git/BISECT_* &&
+	test -z "$(ls .git/BISECT_* 2>/dev/null)" &&
 	git bisect start &&
 	test_must_fail git bisect good foo $HASH1 &&
 	test_must_fail git bisect good $HASH1 bar &&
-- 
1.5.5.1.328.gbfcc6
