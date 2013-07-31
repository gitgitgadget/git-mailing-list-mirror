From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH ALTERNATIVE v6 0/2] http.<url>.<key> and friends
Date: Wed, 31 Jul 2013 13:51:59 -0700
Message-ID: <72dacc4d84caf9831f5e12ece7f38f2@f74d39fa044aa309eaea14b9f57fe79>
References: <1375298768-7740-1-git-send-email-gitster@pobox.com> <1375298768-7740-3-git-send-email-gitster@pobox.com> <1375298768-7740-5-git-send-email-gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 22:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dNZ-0001kN-1x
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 22:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760772Ab3GaUwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 16:52:13 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49348 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209Ab3GaUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 16:52:12 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so694146pbc.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 13:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yOnetWI7wbwi7xJfY24paubOauGd9IAawcLPDE7Z370=;
        b=zSiWE3XC4D124wg1n3vFaiYsg7vKJiaCLR4ZoA+LjVnjn2kJik/95bZQBOH++yAR89
         8tCa2jLmghDskpvHYppR3+KXMVao0MSPVGO3v4gnpGokkbiEp974WXKEeAySW/6eN3fA
         cScRr6Fsyeknq1uFAtlPUbFeM8AMntIvNar64cic7K1QhOXacDx8FdTggS96r3x7dXyg
         +/DDHGAP2A3OnHh7uZmaXCGIDJTfWilqMtSxtYbt1EX0LzLOkGZFIPGVLG+eN5r5BIMD
         pioQpgzK1r/tIL6ZdrTTqAt0CZIEIEY//EBvvBkEGLdV0xPlf6tmzU4903XzFTCcMIuG
         wolg==
X-Received: by 10.67.22.99 with SMTP id hr3mr260606pad.12.1375303931617;
        Wed, 31 Jul 2013 13:52:11 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ys4sm92445pbb.9.2013.07.31.13.52.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 13:52:10 -0700 (PDT)
In-Reply-To: <1375298768-7740-3-git-send-email-gitster@pobox.com> <1375298768-7740-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231458>

This patch simply provides two alternative versions of the 2/6 and 4/6
patches previously sent as part of the:

  [PATCH v6 0/6] http.<url>.<key> and friends

series.  They are intended simply as complete alternatives to parts 2 and 4
that include the following changes:

2/4 - Include 1-line documentation update in log comment and rename static
      function from http_options_url_match_prefix to url_match_prefix.
      
4/4 - Include 1-line documentation update together with Peff's previously
      provided Signed-off-by for the copious amount of documentation text he
      has provided that has been included verbatim.  Also include the minor
      fixes from Ramsay Jones for compilation of test-url-normalize when
      NO_CURL is defined.

If simply squashing the patches in instead is desired, here's the patch for
part 2/4:

diff --git a/urlmatch.c b/urlmatch.c
index e1b03ee7..4f38cc7b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -376,9 +376,9 @@ char *url_normalize(const char *url, struct url_info *out_info)
 	return result;
 }
 
-static size_t http_options_url_match_prefix(const char *url,
-					    const char *url_prefix,
-					    size_t url_prefix_len)
+static size_t url_match_prefix(const char *url,
+			       const char *url_prefix,
+			       size_t url_prefix_len)
 {
 	/*
 	 * url_prefix matches url if url_prefix is an exact match for url or it
@@ -457,7 +457,7 @@ int match_urls(const struct url_info *url,
 		return 0; /* host names and/or ports do not match */
 
 	/* check the path */
-	pathmatchlen = http_options_url_match_prefix(
+	pathmatchlen = url_match_prefix(
 		url->url + url->path_off,
 		url_prefix->url + url_prefix->path_off,
 		url_prefix->url_len - url_prefix->path_off);
---

And here's the patch for part 4/4:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 60c140f1..8cc0fd78 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1542,6 +1542,8 @@ http.<url>.*::
   the config key has a user name it must match the user name in the
   URL exactly. If the config key does not have a user name, that
   config key will match a URL with any user name (including none).
+  config key will match a URL with any user name (including none),
+  but at a lower precedence than a config key with a user name.
 --
 +
 The list above is ordered by decreasing precedence; a URL that matches
diff --git a/test-url-normalize.c b/test-url-normalize.c
index 81d3da90..80437217 100644
--- a/test-url-normalize.c
+++ b/test-url-normalize.c
@@ -1,6 +1,6 @@
 #ifdef NO_CURL
 
-int main()
+int main(void)
 {
 	return 125;
 }
@@ -52,8 +52,10 @@ static int run_http_options(const char *file,
 		printf("%s\n", curl_ssl_try ? "true" : "false");
 	else if (!strcmp("minsessions", opt_lc.buf))
 		printf("%d\n", min_curl_sessions);
+#ifdef USE_CURL_MULTI
 	else if (!strcmp("maxrequests", opt_lc.buf))
 		printf("%d\n", max_requests);
+#endif
 	else if (!strcmp("lowspeedlimit", opt_lc.buf))
 		printf("%ld\n", curl_low_speed_limit);
 	else if (!strcmp("lowspeedtime", opt_lc.buf))
---
