From: Tordek <kedrot@gmail.com>
Subject: [PATCH] http.c: use 'git_config_string' on configuration options.
Date: Fri, 18 Apr 2008 10:17:30 -0300
Message-ID: <48089F6A.3040102@tordek.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 14:54:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmqTt-0003Gn-MG
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 15:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYDRNRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 09:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbYDRNRf
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 09:17:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:42485 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbYDRNRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 09:17:34 -0400
Received: by wr-out-0506.google.com with SMTP id c48so327029wra.1
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=IPfJKNN6upqc3U9UyYjn1eFaQqcjhbcPus06aQ13nwk=;
        b=xCyi+KXPJG4EwX1Ptv4wsDm7lvalVj4uEyRCYNkXdrQ5cIK2DjAmH26mhucUpN+7PaOWMd8UjMyemfPrSEoEca1Q/WlV2cq9Uu52OyfThbeuOw7ZE9Fomqwjrt7hawoD+8+4qU/Ccu6AD0wDsXCjCw/ir//OYqwC9bjveneFY7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=a1YIoDCCS9r+qwM2Oy17BFlLWiTJP1n8YfQeEuBY1GsIOhs1BGkUOKAo7DbBl0zuI36eJojbdZs7WeTe4om+5j1UZ6YnMPfFe9SnM/eqEUBf2H1kRQJkLynOTdEcZGKuKeI4yUNpdzSKezIqPlYC2wADDirmYnZCT50KbNikrtc=
Received: by 10.114.106.13 with SMTP id e13mr2441027wac.157.1208524652824;
        Fri, 18 Apr 2008 06:17:32 -0700 (PDT)
Received: from ?192.168.0.101? ( [190.137.195.23])
        by mx.google.com with ESMTPS id 7sm21166887ywo.1.2008.04.18.06.17.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 18 Apr 2008 06:17:31 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79883>

Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
---
 http.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/http.c b/http.c
index 256a5f1..cadc1bf 100644
--- a/http.c
+++ b/http.c
@@ -100,39 +100,27 @@ static int http_options(const char *var, const
char *value)
        }

        if (!strcmp("http.sslcert", var)) {
-               if (ssl_cert == NULL) {
-                       if (!value)
-                               return config_error_nonbool(var);
-                       ssl_cert = xstrdup(value);
-               }
+               if (ssl_cert == NULL)
+                       return git_config_string(&ssl_cert, var, value);
                return 0;
        }
 #if LIBCURL_VERSION_NUM >= 0x070902
        if (!strcmp("http.sslkey", var)) {
-               if (ssl_key == NULL) {
-                       if (!value)
-                               return config_error_nonbool(var);
-                       ssl_key = xstrdup(value);
-               }
+               if (ssl_key == NULL)
+                       return git_config_string(&ssl_key, var, value);
                return 0;
        }
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
        if (!strcmp("http.sslcapath", var)) {
-               if (ssl_capath == NULL) {
-                       if (!value)
-                               return config_error_nonbool(var);
-                       ssl_capath = xstrdup(value);
-               }
+               if (ssl_capath == NULL)
+                       return git_config_string(&ssl_capath, var, value);
                return 0;
        }
 #endif
        if (!strcmp("http.sslcainfo", var)) {
-               if (ssl_cainfo == NULL) {
-                       if (!value)
-                               return config_error_nonbool(var);
-                       ssl_cainfo = xstrdup(value);
-               }
+               if (ssl_cainfo == NULL)
+                       return git_config_string(&ssl_cainfo, var, value);
                return 0;
        }

@@ -160,11 +148,8 @@ static int http_options(const char *var, const char
*value)
                return 0;
        }
        if (!strcmp("http.proxy", var)) {
-               if (curl_http_proxy == NULL) {
-                       if (!value)
-                               return config_error_nonbool(var);
-                       curl_http_proxy = xstrdup(value);
-               }
+               if (curl_http_proxy == NULL)
+                       return git_config_string(&curl_http_proxy, var,
value);
                return 0;
        }

--
1.5.2.2
