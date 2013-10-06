From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/6] wrapper.c: Fix a sparse warning
Date: Sun, 06 Oct 2013 21:50:00 +0100
Message-ID: <5251CCF8.3070207@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 06 22:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSvHG-0006ta-KF
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab3JFUuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 16:50:04 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:37982 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754480Ab3JFUuD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Oct 2013 16:50:03 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 146106FBB19;
	Sun,  6 Oct 2013 21:50:02 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id D81BA6FB8C8;
	Sun,  6 Oct 2013 21:50:01 +0100 (BST)
Received: from [192.168.254.7] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sun,  6 Oct 2013 21:50:01 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235747>


When the NO_MKSTEMPS build variable is not set, sparse issues an
"'gitmkstemps' was not declared. Should it be static?" warning.
The 'gitmkstemps' function definition is only required when the
NO_MKSTEMPS variable is set. In order to suppress the warning,
use a preprocessor conditional to include the definition only
when needed.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 wrapper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index f92b147..9a6aaaf 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -360,10 +360,12 @@ int git_mkstemp_mode(char *pattern, int mode)
 	return git_mkstemps_mode(pattern, 0, mode);
 }
 
+#ifdef NO_MKSTEMPS
 int gitmkstemps(char *pattern, int suffix_len)
 {
 	return git_mkstemps_mode(pattern, suffix_len, 0600);
 }
+#endif
 
 int xmkstemp_mode(char *template, int mode)
 {
-- 
1.8.4
