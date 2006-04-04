From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH] Set HTTP user agent to git/GIT_VERSION
Date: Tue, 4 Apr 2006 10:11:29 -0700
Message-ID: <20060404171128.GD14967@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 04 19:11:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQp48-00062H-9L
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 19:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWDDRLe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 13:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDDRLe
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 13:11:34 -0400
Received: from 241.37.26.69.virtela.com ([69.26.37.241]:37437 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750762AbWDDRLe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 13:11:34 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k34HBTeL032539
	for <git@vger.kernel.org>; Tue, 4 Apr 2006 10:11:29 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k34HBT03032537
	for git@vger.kernel.org; Tue, 4 Apr 2006 10:11:29 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18396>

Useful for diagnostics/troubleshooting to know which client versions are
hitting your server.

Signed-off-by: Nick Hengeveld <nickh@reactrix.com>


---

 Makefile |    3 +++
 http.c   |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

468d4d4ac3cbdb0757a7cc1c207ca379ce3a5d56
diff --git a/Makefile b/Makefile
index 19ce42c..c7d5ecf 100644
--- a/Makefile
+++ b/Makefile
@@ -510,6 +510,9 @@ git$X git.spec \
 exec_cmd.o: exec_cmd.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 
+http.o: http.c
+	$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
+
 ifdef NO_EXPAT
 http-fetch.o: http-fetch.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_EXPAT $<
diff --git a/http.c b/http.c
index 9604e33..0cb42a8 100644
--- a/http.c
+++ b/http.c
@@ -195,6 +195,8 @@ #endif
 	if (getenv("GIT_CURL_VERBOSE"))
 		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
 
+	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
+
 	return result;
 }
 
-- 
1.3.0.rc1.g9aef-dirty
