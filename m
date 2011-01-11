From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] svndump.c: Fix a printf format compiler warning
Date: Tue, 11 Jan 2011 18:17:21 +0000
Message-ID: <4D2C9EB1.2050100@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:35:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcj3b-0007NR-LU
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab1AKSez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:34:55 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:40947 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777Ab1AKSey (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 13:34:54 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Pcj3U-0006K5-pR; Tue, 11 Jan 2011 18:34:53 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164967>


In particular, on systems that define uint32_t as an unsigned long,
gcc complains as follows:

        CC vcs-svn/svndump.o
    vcs-svn/svndump.c: In function `svndump_read':
    vcs-svn/svndump.c:215: warning: int format, uint32_t arg (arg 2)

In order to suppress the warning we use the C99 format specifier
macro PRIu32 from <inttypes.h>.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 vcs-svn/svndump.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index fa580e6..2ad2c30 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -211,7 +211,7 @@ void svndump_read(const char *url)
 		if (key == keys.svn_fs_dump_format_version) {
 			dump_ctx.version = atoi(val);
 			if (dump_ctx.version > 2)
-				die("expected svn dump format version <= 2, found %d",
+				die("expected svn dump format version <= 2, found %"PRIu32,
 				    dump_ctx.version);
 		} else if (key == keys.uuid) {
 			dump_ctx.uuid = pool_intern(val);
-- 
1.7.3
