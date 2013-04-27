From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/6] compat/unsetenv.c: Fix a sparse warning
Date: Sat, 27 Apr 2013 20:15:38 +0100
Message-ID: <517C23DA.8020308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB54-0008N7-62
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab3D0Tqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:44 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33115 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756325Ab3D0Tqn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:43 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 674CA384081;
	Sat, 27 Apr 2013 20:46:42 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 5746C38407C;
	Sat, 27 Apr 2013 20:46:41 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:40 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222671>


The gitunsetenv function includes an (redundant) declaration of the
'environ' symbol, which is a pointer to the table of environment
variables. Unfortunately, on MinGW, this provokes sparse to issue
the following warning:

    compat/unsetenv.c:5:20: warning: non-ANSI function declaration of \
    function '__p__environ'

On MinGW, the <stdlib.h> header defines the 'environ' symbol as a
preprocessor macro (via _environ) which obtains the environ table
pointer via a call to the __p__environ() function.

In order to suppress the warning, we simply remove the redundant
declaration of the 'environ' symbol, since the symbol is already
declared correctly in <stdlib.h> (included via git-compat-util.h).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/unsetenv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index eb29f5e..4ea1856 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -2,7 +2,6 @@
 
 void gitunsetenv (const char *name)
 {
-     extern char **environ;
      int src, dst;
      size_t nmln;
 
-- 
1.8.2
