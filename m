From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v3] path: Fix a sparse warning
Date: Thu, 30 May 2013 00:53:28 +0100
Message-ID: <51A694F8.9090302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 01:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhqH8-0000Ap-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 01:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967267Ab3E2X7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 19:59:21 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:41739 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967257Ab3E2X7T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 19:59:19 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 06112384081;
	Thu, 30 May 2013 00:59:19 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 58E84384080;
	Thu, 30 May 2013 00:59:18 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Thu, 30 May 2013 00:59:17 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225901>


On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
it be static?" warning. The MinGW and MSVC builds do not see the
declaration of this function, within git-compat-util.h, due to its
placement within an preprocessor conditional.

In order to suppress the warning, we simply move the declaration to
the top level of the header.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

As promised, this fixes the build on cygwin. (tested on cygwin
and MinGW. I have not tested on Linux, because I would have to
re-boot twice, and I wanted to send this out tonight).

Again, sorry for breaking the build.

ATB,
Ramsay Jones

 git-compat-util.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 660b7f0..aa0404e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,9 @@
 #else
 #include <poll.h>
 #endif
+
+extern int get_st_mode_bits(const char *path, int *mode);
+
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
@@ -163,7 +166,6 @@
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
 #endif
-int get_st_mode_bits(const char *path, int *mode);
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
-- 
1.8.3
