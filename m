From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/2] Add an option for using any HTTP authentication scheme,
 not only basic
Date: Fri, 27 Nov 2009 23:43:08 +0800
Message-ID: <20091127234308.81046118.rctay89@gmail.com>
References: <20091127234226.8b158336.rctay89@gmail.com>,
 <20091127234110.7b7e9993.rctay89@gmail.com>,
 <Pine.LNX.4.64.0904150054470.7479@localhost.localdomain>,
 <Pine.LNX.4.64.0904142350140.7479@localhost.localdomain>,
 <1254510286-23155-1-git-send-email-nmiell@gmail.com>,
 <25718488.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 16:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE2yf-0001Ag-RI
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 16:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbZK0PnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 10:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbZK0PnJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 10:43:09 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:50870 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZK0PnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 10:43:08 -0500
Received: by yxe26 with SMTP id 26so1394752yxe.4
        for <git@vger.kernel.org>; Fri, 27 Nov 2009 07:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=1JhDbiKmOnexDg7ngOvQ2Ivu/AJEvDK5qvlxAbUa6eA=;
        b=p0nYf2GMHy9FmcX39YfX2MRsw0CkUUmED394kpp0UAGBNe1CxuevwJwB4P5o0ed7Yy
         q8O31UtiflrNoznWzYTdCsjNy1ROxPY4rYIw5RFzQBgE0LrSjSHrmctn02BWxzTA8ArC
         CwuRrhyeI7ISws5YveTb2gg5cMO/Q8rLWMPuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=ccB160FVp0tnjxO3j/wTaneqeEg5DXUYXXLtBdPg1FwcBg3N62wp19WD1UlVn+reMX
         eN6oZ/LEDW8vtl6W5RkoAQE9AFq/KO6KXbI0930HYQmMT0HO7MNY9ZzN69QlTugGyFb3
         5mf68jCDVksgman34eamd7yliAKPmhzYTnIeU=
Received: by 10.150.103.1 with SMTP id a1mr1914243ybc.198.1259336594337;
        Fri, 27 Nov 2009 07:43:14 -0800 (PST)
Received: from your-cukc5e3z5n (cm164.zeta152.maxonline.com.sg [116.87.152.164])
        by mx.google.com with ESMTPS id 4sm636887ywd.44.2009.11.27.07.43.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Nov 2009 07:43:12 -0800 (PST)
In-Reply-To: <20091127234226.8b158336.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133905>

From:	=?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>

This adds the configuration option http.authAny (overridable with
the environment variable GIT_HTTP_AUTH_ANY), for instructing curl
to allow any HTTP authentication scheme, not only basic (which
sends the password in plaintext).

When this is enabled, curl has to do double requests most of the time,
in order to discover which HTTP authentication method to use, which
lowers the performance slightly. Therefore this isn't enabled by default.

One example of another authentication scheme to use is digest, which
doesn't send the password in plaintext, but uses a challenge-response
mechanism instead. Using digest authentication in practice requires
at least curl 7.18.1, due to bugs in the digest handling in earlier
versions of curl.

Signed-off-by: Martin Storsjo <martin@martin.st>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  Martin, I've not made any changes, except to make it apply cleanly.

 Documentation/config.txt |    7 +++++++
 http.c                   |   22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b77d66d..a54ede3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1158,6 +1158,13 @@ http.noEPSV::
 	support EPSV mode. Can be overridden by the 'GIT_CURL_FTP_NO_EPSV'
 	environment variable. Default is false (curl will use EPSV).

+http.authAny::
+	Allow any HTTP authentication method, not only basic. Enabling
+	this lowers the performance slightly, by having to do requests
+	without any authentication to discover the authentication method
+	to use. Can be overridden by the 'GIT_HTTP_AUTH_ANY'
+	environment variable. Default is false.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/http.c b/http.c
index fb0a97b..aeb69b3 100644
--- a/http.c
+++ b/http.c
@@ -7,6 +7,10 @@ int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;

+#if LIBCURL_VERSION_NUM >= 0x070a06
+#define LIBCURL_CAN_HANDLE_AUTH_ANY
+#endif
+
 static int min_curl_sessions = 1;
 static int curl_session_count;
 #ifdef USE_CURL_MULTI
@@ -36,6 +40,9 @@ static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv;
 static const char *curl_http_proxy;
 static char *user_name, *user_pass;
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+static int curl_http_auth_any = 0;
+#endif

 #if LIBCURL_VERSION_NUM >= 0x071700
 /* Use CURLOPT_KEYPASSWD as is */
@@ -190,6 +197,12 @@ static int http_options(const char *var, const char *value, void *cb)
 			http_post_buffer = LARGE_PACKET_MAX;
 		return 0;
 	}
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	if (!strcmp("http.authany", var)) {
+		curl_http_auth_any = git_config_bool(var, value);
+		return 0;
+	}
+#endif

 	/* Fall back on the default ones */
 	return git_default_config(var, value, cb);
@@ -240,6 +253,10 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070907
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	if (curl_http_auth_any)
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+#endif

 	init_curl_http_auth(result);

@@ -391,6 +408,11 @@ void http_init(struct remote *remote)
 	if (getenv("GIT_CURL_FTP_NO_EPSV"))
 		curl_ftp_no_epsv = 1;

+#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+	if (getenv("GIT_HTTP_AUTH_ANY"))
+		curl_http_auth_any = 1;
+#endif
+
 	if (remote && remote->url && remote->url[0]) {
 		http_auth_init(remote->url[0]);
 		if (!ssl_cert_password_required &&
--
1.6.4.4
