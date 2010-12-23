From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] msvc: Fix compilation error due to missing mktemp() declaration
Date: Thu, 23 Dec 2010 19:05:53 +0000
Message-ID: <4D139D91.8080503@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, kusmabite@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 23 20:07:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVqVi-0005fY-LZ
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 20:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0LWTHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Dec 2010 14:07:20 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:54767 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266Ab0LWTHT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Dec 2010 14:07:19 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1PVqVQ-0005yz-bn; Thu, 23 Dec 2010 19:07:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164137>


Commit d1b6e6e (win32: use our own dirent.h, 2010-11-23) removed
the compat/vcbuild/include/dirent.h compatibility header file.
This file, among other things, included the <io.h> system header
file which provides the declaration of the mktemp() function.

In order to fix the compilation error, we add an include directive
for <io.h> to the compat/vcbuild/include/unistd.h header. (The
MinGW build includes <io.h> from it's <unistd.h> header too.)

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/vcbuild/include/unistd.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/compat/vcbuild/include/unistd.h b/compat/vcbuild/include/unistd.h
index b14fcf9..a61160f 100644
--- a/compat/vcbuild/include/unistd.h
+++ b/compat/vcbuild/include/unistd.h
@@ -1,6 +1,8 @@
 #ifndef _UNISTD_
 #define _UNISTD_
 
+#include <io.h>
+
 /* Win32 define for porting git*/
 
 #ifndef _MODE_T_
-- 
1.7.3
