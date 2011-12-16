From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] grep.h: Fix compilation error on mingw
Date: Fri, 16 Dec 2011 22:56:22 +0000
Message-ID: <4EEBCC96.3010901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Fri Dec 16 23:58:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbgjk-0001nx-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760943Ab1LPW6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:58:40 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:38729 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752634Ab1LPW6j (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:58:39 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Rbgjc-00042K-ek; Fri, 16 Dec 2011 22:58:38 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187332>


In particular, gcc complains as follows:

        CC bisect.o
    In file included from revision.h:5,
                     from bisect.c:4:
    grep.h:138: error: expected '=', ',', ';', 'asm' or \
        '__attribute__' before 'grep_attr_mutex'
    make: *** [bisect.o] Error 1

In order to fix the error, we include the 'thread-utils.h' header
file in grep.h, since it provides a definition of pthread_mutex_t
(indirectly via compat/win32/pthread.h).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Thomas,

If you need to re-roll your grep-threading series, could you please
squash this patch into your commit 53f4b6f7 (grep: enable threading
with -p and -W using lazy attribute lookup, 12-12-2011).

[Note: you could also remove the '#include "thread-utils.h"' in both
grep.c and builtin/grep.c, since it is now included from grep.h.]

Thanks!

ATB,
Ramsay Jones

 grep.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/grep.h b/grep.h
index 15d227c..b6f06cb 100644
--- a/grep.h
+++ b/grep.h
@@ -8,6 +8,7 @@ typedef int pcre;
 typedef int pcre_extra;
 #endif
 #include "kwset.h"
+#include "thread-utils.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
-- 
1.7.8
