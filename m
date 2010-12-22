From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/3] test-lib.sh/test_decode_color(): use octal not hex in awk script
Date: Wed, 22 Dec 2010 15:58:52 -0800
Message-ID: <jpN7nm-rtl4sNXi5qt9pXMHyBTgpDCv8-V01kCtiJEBPqOcDSM23hxN4tPbRHKxs9OccFdSHwdWDxm1VEOf_Ag@cipher.nrlssc.navy.mil>
References: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 23 01:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYwR-0002g6-4q
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 01:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330Ab0LWAVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 19:21:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57131 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab0LWAVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 19:21:51 -0500
X-Greylist: delayed 1339 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2010 19:21:50 EST
Received: by mail.nrlssc.navy.mil id oBMNxPpC032012; Wed, 22 Dec 2010 17:59:25 -0600
In-Reply-To: <jpN7nm-rtl4sNXi5qt9pXMafcDOI0AxF95o77x_r5JQwZeaH94BApUuIwonUaYfzmYTgqeFNpSm6S7VFnIZVag@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Dec 2010 23:59:25.0222 (UTC) FILETIME=[42C24C60:01CBA234]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164113>

From: Brandon Casey <drafnel@gmail.com>

POSIX awk seems to explicitly not support hexadecimal escape sequences.

>From http://pubs.opengroup.org/onlinepubs/009695399/:

   Regular expressions in awk have been extended somewhat...
   One sequence that is not supported is hexadecimal value escapes
   beginning with '\x'.

This affects the awk on IRIX 6.5, and causes t4015.56 to fail.
Use octal instead.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 48fa516..cb1ca97 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -260,7 +260,7 @@ test_decode_color () {
 			if (n == 47) return "BWHITE";
 		}
 		{
-			while (match($0, /\x1b\[[0-9;]*m/) != 0) {
+			while (match($0, /\033\[[0-9;]*m/) != 0) {
 				printf "%s<", substr($0, 1, RSTART-1);
 				codes = substr($0, RSTART+2, RLENGTH-3);
 				if (length(codes) == 0)
-- 
1.7.3.1
