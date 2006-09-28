From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: [PATCH] http/ftp: optionally ask curl to not use EPSV command
Date: Thu, 28 Sep 2006 22:26:05 +0300
Message-ID: <20060928192605.GD10617@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:21:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1RV-0002Xs-7Q
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWI1TVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWI1TVA
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:21:00 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:4280 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1030380AbWI1TU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 15:20:59 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Sep 2006 22:20:56 +0300
Received: by sashak (sSMTP sendmail emulation); Thu, 28 Sep 2006 22:26:05 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 28 Sep 2006 19:20:56.0869 (UTC) FILETIME=[392C7550:01C6E333]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28040>

If GIT_CURL_FTP_NO_EPSV environment variable is defined, disable using
of EPSV ftp command (PASV will be used instead). This is helpful with
some "poor" ftp servers which doesn't support EPSV mode.

Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
---
 http.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/http.c b/http.c
index 6c1937b..a966e6d 100644
--- a/http.c
+++ b/http.c
@@ -196,6 +196,9 @@ #endif
 
 	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
 
+	if (getenv("GIT_CURL_FTP_NO_EPSV"))
+		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
+
 	return result;
 }
 
-- 
1.4.2.1
