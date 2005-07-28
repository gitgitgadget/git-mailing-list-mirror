From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] support older versions of libcurl
Date: Thu, 28 Jul 2005 16:49:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281648390.25783@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 28 16:52:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dy9jI-0000T8-4d
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 16:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVG1Ou4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVG1Ous
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 10:50:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19377 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261501AbVG1OtV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 10:49:21 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3E84DE25B7
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:49:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 1F214913C9
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:49:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 09C8591393
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:49:21 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id E44DFE25B8
	for <git@vger.kernel.org>; Thu, 28 Jul 2005 16:49:20 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Some newer features of libcurl are used which are not strictly necessary
for http-pull. Use them only if libcurl is new enough to know about them.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 http-pull.c |    6 ++++++
 1 files changed, 6 insertions

diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -171,19 +171,25 @@ int main(int argc, char **argv)
 	commit_id = argv[arg];
 	url = argv[arg + 1];

+#if LIBCURL_VERSION_NUM >= 0x070800
 	curl_global_init(CURL_GLOBAL_ALL);
+#endif

 	curl = curl_easy_init();

 	curl_ssl_verify = gitenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+#if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#endif

 	base = url;

 	if (pull(commit_id))
 		return 1;

+#if LIBCURL_VERSION_NUM >= 0x070704
 	curl_global_cleanup();
+#endif
 	return 0;
 }
