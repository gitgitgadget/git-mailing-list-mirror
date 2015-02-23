From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] git-compat-util.h: remove redundant code
Date: Mon, 23 Feb 2015 00:07:14 +0000
Message-ID: <54EA6F32.50301@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 01:07:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPgYX-0003pW-0X
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbbBWAHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2015 19:07:20 -0500
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37925 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752107AbbBWAHT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2015 19:07:19 -0500
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 912AF6F8DA3;
	Mon, 23 Feb 2015 00:07:02 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 4F4E96F8B93;
	Mon, 23 Feb 2015 00:07:02 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Mon, 23 Feb 2015 00:07:01 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264242>


Since commit 3a0a3a89 ("git-compat-util.h: don't define _XOPEN_SOURCE
on cygwin", 23-11-2014) removed the definition of _XOPEN_SOURCE on
cygwin, the code within a pre-processor conditional further down the
file became redundant. Remove the redundant code.

This effectively reverts commit 41b20017 ("Fix an "implicit function
definition" warning", 03-03-2007).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I have a very vague recollection (back in March 2007) of trying to fix
the problem from commit 41b20017 using the solution in commit 3a0a3a89.
However, I can't remember the result! :(

I guess, by implication, there is a chance that it failed because (at
that time) something required _XOPEN_SOURCE to be set on cygwin. It is
clearly not the case for the current version of cygwin (v1.7.34, x86_64).
(I also tested on my old 32-bit laptop with an older cygwin - it's been
about a year since I updated that version of cygwin.)

[Hmm, would it be easier to change the conditional(s) to set _XOPEN_SOURCE
only for systems that require it (rather than avoid setting it for those
that don't)! I suspect only sun, AIX 5.3L and OpenBSD need it set. dunno.]

ATB,
Ramsay Jones

 git-compat-util.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68c07af..49c0637 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -164,16 +164,10 @@
 typedef long intptr_t;
 typedef unsigned long uintptr_t;
 #endif
-#if defined(__CYGWIN__)
-#undef _XOPEN_SOURCE
-#include <grp.h>
-#define _XOPEN_SOURCE 600
-#else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
 #define _ALL_SOURCE 1
 #endif
-#endif
 
 /* used on Mac OS X */
 #ifdef PRECOMPOSE_UNICODE
-- 
2.3.0
