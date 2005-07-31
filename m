From: barkalow@iabervon.org
Subject: [PATCH 1/3] Fix support for old libcurl
Date: Sun, 31 Jul 2005 15:59:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0507311530210.23721@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 21:59:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzJxe-0007yE-OP
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 21:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVGaT6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVGaT6j
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 15:58:39 -0400
Received: from iabervon.org ([66.92.72.58]:18188 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261886AbVGaT42 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 15:56:28 -0400
Received: (qmail 24036 invoked by uid 1000); 31 Jul 2005 15:59:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 31 Jul 2005 15:59:20 -0400
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Old libcurl has curl_easy_setopt(), and http-pull requires it; it just
doesn't have one of the options.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

  http-pull.c |    5 ++---
  1 files changed, 2 insertions(+), 3 deletions(-)

9c32b0230180d507b4429fb35432bc404a89e637
diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -12,9 +12,6 @@
  #if LIBCURL_VERSION_NUM < 0x070800
  #define curl_global_init(a) do { /* nothing */ } while(0)
  #endif
-#if LIBCURL_VERSION_NUM < 0x070907
-#define curl_easy_setopt(a, b, c) do { /* nothing */ } while(0)
-#endif

  static CURL *curl;

@@ -187,7 +184,9 @@ int main(int argc, char **argv)

  	curl_ssl_verify = gitenv("GIT_SSL_NO_VERIFY") ? 0 : 1;
  	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, curl_ssl_verify);
+#if LIBCURL_VERSION_NUM >= 0x070907
  	curl_easy_setopt(curl, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
+#endif

  	base = url;
