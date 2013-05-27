From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH RESEND v2] path: Fix a sparse warning
Date: Mon, 27 May 2013 20:24:56 +0100
Message-ID: <51A3B308.6000201@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 27 21:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh34E-0000Cx-Qp
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 21:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab3E0T0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 15:26:34 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:49979 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755494Ab3E0T0e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 15:26:34 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 3EF7F1280A6;
	Mon, 27 May 2013 20:26:32 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 7421C1280A3;
	Mon, 27 May 2013 20:26:31 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Mon, 27 May 2013 20:26:30 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225613>


On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
it be static?" warning. The MinGW and MSVC builds do not see the
declaration of this function, within git-compat-util.h, due to its
placement within an preprocessor conditional.

In order to suppress the warning, we simply move the declaration to
the top level of the header.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

Now that v1.8.3 is out, I note that this patch seems to have been
dropped (or did I miss something?).

This used to be

    [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static

but the change in implementation required a change in title.
This version simply moves the declaration so that the MinGW and
MSVC builds can see it.

ATB,
Ramsay Jones

 git-compat-util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e955bb5..0e5e4f8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -163,7 +163,6 @@
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
 #endif
-int get_st_mode_bits(const char *path, int *mode);
 #if defined(__CYGWIN__)
 #undef _XOPEN_SOURCE
 #include <grp.h>
@@ -176,6 +175,8 @@ int get_st_mode_bits(const char *path, int *mode);
 #endif
 #endif
 
+extern int get_st_mode_bits(const char *path, int *mode);
+
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
-- 
1.8.3
