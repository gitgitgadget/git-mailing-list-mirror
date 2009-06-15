From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 2/2] http.c: add http.sslCertType and http.sslKeyType
Date: Sun, 14 Jun 2009 22:39:01 -0400
Message-ID: <1245033541-15558-2-git-send-email-lodatom@gmail.com>
References: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 04:45:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG2CZ-0007to-3x
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 04:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbZFOCo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 22:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZFOCo4
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 22:44:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:23006 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754402AbZFOCoy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 22:44:54 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2149358qwd.37
        for <git@vger.kernel.org>; Sun, 14 Jun 2009 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ume6y0MEF3h0QecyF3GVh3fyi/PJG6cAUr2Bxt8EnIo=;
        b=nU1HizifM95MVMkSDsYb70+1kfRpi9ClCv7UVLQJboz5Mf9ejNzEqbIL5f9La6Df56
         LQ7Tcm2a+ND2Pbm2zrv+ur6lHw4rRUNnZliEgDH/Lktv1a7QlrqdDBW/HxHSDuFcjUVF
         UVpVnjXCGaLaLURYW+zwRhHuYUBFHe6UaTLR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dSFB+HonZkD0JKf5K73W+lp87S09Uuz68QZssOFV4u6llUT8AMujMD/zaa1BsZ7cl/
         WEzBp6PXv+MffuMOP+770ib43syZb5NWt6K3b0QkVe2avGXDaQzqE1x6NEHOIgi23u0X
         XVctlJTK53d5CGzU/uuExEIDm+iFCeerawB7M=
Received: by 10.224.19.143 with SMTP id a15mr6749521qab.60.1245033575859;
        Sun, 14 Jun 2009 19:39:35 -0700 (PDT)
Received: from localhost.localdomain ([68.33.182.150])
        by mx.google.com with ESMTPS id 2sm1001101qwi.13.2009.06.14.19.39.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 19:39:35 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2
In-Reply-To: <1245033541-15558-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121575>

Add two new configuration variables, http.sslCertType and
http.sslKeyType, which tell libcurl the filetype for the SSL client
certificate and private key, respectively.  The main benefit is to allow
PKCS12 certificates for users with libcurl >= 7.13.0.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

Unfortunately, P12 support in libcurl is not great, so encrypted P12
certificates do not work at all.  At least now unencrypted certificates
are possible.  Hopefully, my password prompting patch series (once I
finish it) will resolve this issue.

As always, any feedback on this patch is appreciated.  In particular, I
welcome suggestions for improving the documentation phrasing.

 Documentation/config.txt |   10 ++++++++++
 http.c                   |   12 ++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2fecbe3..b19a923 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1038,11 +1038,21 @@ http.sslCert::
 	over HTTPS. Can be overridden by the 'GIT_SSL_CERT' environment
 	variable.
 
+http.sslCertType::
+	Filetype for SSL certificate.  Must be "PEM" (default), "DER", or
+	(if libcurl >= 7.13.0) "P12".  Can be overridden by the
+	'GIT_SSL_CERT_TYPE' environment variable.
+
 http.sslKey::
 	File containing the SSL private key when fetching or pushing
 	over HTTPS. Can be overridden by the 'GIT_SSL_KEY' environment
 	variable.
 
+http.sslKeyType::
+	Filetype for SSL private key.  Must be "PEM" (default), "DER", or
+	(if libcurl >= 7.13.0) "P12".  Can be overridden by the
+	'GIT_SSL_CERT_TYPE' environment variable.
+
 http.sslCAInfo::
 	File containing the certificates to verify the peer with when
 	fetching or pushing over HTTPS. Can be overridden by the
diff --git a/http.c b/http.c
index b049948..5716e4e 100644
--- a/http.c
+++ b/http.c
@@ -22,6 +22,8 @@ static int curl_ssl_verify = -1;
 static const char *ssl_cert;
 #if LIBCURL_VERSION_NUM >= 0x070903
 static const char *ssl_key;
+static const char *ssl_cert_type;
+static const char *ssl_key_type;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 static const char *ssl_capath;
@@ -129,6 +131,10 @@ static int http_options(const char *var, const char *value, void *cb)
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (!strcmp("http.sslkey", var))
 		return git_config_string(&ssl_key, var, value);
+	if (!strcmp("http.sslcerttype", var))
+		return git_config_string(&ssl_cert_type, var, value);
+	if (!strcmp("http.sslkeytype", var))
+		return git_config_string(&ssl_key_type, var, value);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var))
@@ -199,6 +205,10 @@ static CURL *get_curl_handle(void)
 #if LIBCURL_VERSION_NUM >= 0x070903
 	if (ssl_key != NULL)
 		curl_easy_setopt(result, CURLOPT_SSLKEY, ssl_key);
+	if (ssl_cert_type != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_type);
+	if (ssl_key_type != NULL)
+		curl_easy_setopt(result, CURLOPT_SSLKEYTYPE, ssl_key_type);
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (ssl_capath != NULL)
@@ -315,6 +325,8 @@ void http_init(struct remote *remote)
 	set_from_env(&ssl_cert, "GIT_SSL_CERT");
 #if LIBCURL_VERSION_NUM >= 0x070903
 	set_from_env(&ssl_key, "GIT_SSL_KEY");
+	set_from_env(&ssl_cert, "GIT_SSL_CERT_TYPE");
+	set_from_env(&ssl_key, "GIT_SSL_KEY_TYPE");
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	set_from_env(&ssl_capath, "GIT_SSL_CAPATH");
-- 
1.6.3.2
