From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] configure.ac: properly unset NEEDS_SSL_WITH_CRYPTO when sha1 func is missing
Date: Wed, 22 Jul 2009 17:20:03 -0500
Message-ID: <fXvtyZqTXuIladfxuwXdIfda7yrkxDlOZjc2eF5mi-ghnq1WUYZyXUmYBktl6Gq67H5ttK6JmaQ@cipher.nrlssc.navy.mil>
References: <7vk521g9c6.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, jnareb@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 23 00:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkLO-0006JO-0g
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbZGVWbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbZGVWbT
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:31:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50414 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZGVWbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:31:18 -0400
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jul 2009 18:31:18 EDT
Received: by mail.nrlssc.navy.mil id n6MMKRmQ011336; Wed, 22 Jul 2009 17:20:27 -0500
In-Reply-To: <7vk521g9c6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123806>

From: Brandon Casey <drafnel@gmail.com>

The empty assignment NEEDS_SSL_WITH_CRYPTO= was mistakenly paired with the
assignment NEEDS_SSL_WITH_CRYPTO=YesPlease in the "action-if-found"
parameter of the AC_CHECK_LIB macro.  The empty assignment was intended for
the "action-if-not-found" section, since in that case, the necessary sha1
hash function was not found and the internal sha1 implementation will be
used instead.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


If you haven't already fixed this, here's a patch to do so.

-brandon


 configure.ac |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index ba44cf2..3f1922d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -342,9 +342,8 @@ GIT_STASH_FLAGS($OPENSSLDIR)
 AC_CHECK_LIB([crypto], [SHA1_Init],
 [NEEDS_SSL_WITH_CRYPTO=],
 [AC_CHECK_LIB([ssl], [SHA1_Init],
- [NEEDS_SSL_WITH_CRYPTO=YesPlease
-  NEEDS_SSL_WITH_CRYPTO=],
- [NO_OPENSSL=YesPlease])])
+ [NEEDS_SSL_WITH_CRYPTO=YesPlease],
+ [NEEDS_SSL_WITH_CRYPTO= NO_OPENSSL=YesPlease])])
 
 GIT_UNSTASH_FLAGS($OPENSSLDIR)
 
-- 
1.6.3.1.24.g152f4
