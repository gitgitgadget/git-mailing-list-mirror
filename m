From: Tordek <kedrot@gmail.com>
Subject: Re: [PATCH (try 3)] http.c: 'use_git_config_string' on configuration options.
Date: Sun, 20 Apr 2008 04:10:26 -0300
Message-ID: <b362b0fe0804200010t465b49absba03102cb1364021@mail.gmail.com>
References: <480A7499.1040705@gmail.com>
	 <20080420060629.38407fe1.chriscool@tuxfamily.org>
	 <b362b0fe0804192335v6486fe0cs5e5c0bf1609e3524@mail.gmail.com>
	 <b362b0fe0804192354x2e91e45asca5dc74208e7be68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 09:11:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnThy-00055O-PN
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 09:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbYDTHKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 03:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYDTHKb
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 03:10:31 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:58358 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbYDTHKa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 03:10:30 -0400
Received: by py-out-1112.google.com with SMTP id u52so1800277pyb.10
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CU4eSvYNRvrPjPELXn12tX9yQcRbY39hBA6jtfWmDP8=;
        b=XZrTizNSLKk7qd67NtvZFnlNaUaK3fkf/zrSckBd6sCyyR+u8RkA0c8pyx9CWV4dNnnhDdSMOWfOeMcerBzjH8r/WB3RAhB3DNsgidqNdzft9VDJl6dDonDe6WGsGJ5MvOHe4DMzYi7Ohxf4OaLj8brBLJlrTUdvRksQer3GJZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AKCWIDTwbK+JaWNHYUyzTwaIc0VbTtWOcd4nuoW2H0fA6WmTEDpayQpCXoQhtawBx6XZmMe/qv1R8LgQd00uh/OrjLRpp1fuXOBduzYpiE21Zi+cSJYNAdfzc2Uyt4AW9gvBpLFFeqXkFzdJDyKaUlx7XOMlQ7F0WayncfgiPj0=
Received: by 10.142.43.7 with SMTP id q7mr1231129wfq.328.1208675426432;
        Sun, 20 Apr 2008 00:10:26 -0700 (PDT)
Received: by 10.143.166.17 with HTTP; Sun, 20 Apr 2008 00:10:26 -0700 (PDT)
In-Reply-To: <b362b0fe0804192354x2e91e45asca5dc74208e7be68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79952>

Signed-off-by: Guillermo O. Freschi <tordek@tordek.com.ar>
---
Okay, I'm skipping the middleman this time; Thunderbird mangles patches...
 http.c |   36 ++++++++++++------------------------
 1 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/http.c b/http.c
index 256a5f1..8ae6432 100644
--- a/http.c
+++ b/http.c
@@ -13,14 +13,14 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];

 static int curl_ssl_verify = -1;
-static char *ssl_cert = NULL;
+static const char *ssl_cert = NULL;
 #if LIBCURL_VERSION_NUM >= 0x070902
-static char *ssl_key = NULL;
+static const char *ssl_key = NULL;
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
-static char *ssl_capath = NULL;
+static const char *ssl_capath = NULL;
 #endif
-static char *ssl_cainfo = NULL;
+static const char *ssl_cainfo = NULL;
 static long curl_low_speed_limit = -1;
 static long curl_low_speed_time = -1;
 static int curl_ftp_no_epsv = 0;
@@ -100,39 +100,27 @@ static int http_options(const char *var, const
char *value)
 	}

 	if (!strcmp("http.sslcert", var)) {
-		if (ssl_cert == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cert = xstrdup(value);
-		}
+		if (ssl_cert == NULL)
+			return git_config_string(&ssl_cert, var, value);
 		return 0;
 	}
 #if LIBCURL_VERSION_NUM >= 0x070902
 	if (!strcmp("http.sslkey", var)) {
-		if (ssl_key == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_key = xstrdup(value);
-		}
+		if (ssl_key == NULL)
+			return git_config_string(&ssl_key, var, value);
 		return 0;
 	}
 #endif
 #if LIBCURL_VERSION_NUM >= 0x070908
 	if (!strcmp("http.sslcapath", var)) {
-		if (ssl_capath == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_capath = xstrdup(value);
-		}
+		if (ssl_capath == NULL)
+			return git_config_string(&ssl_capath, var, value);
 		return 0;
 	}
 #endif
 	if (!strcmp("http.sslcainfo", var)) {
-		if (ssl_cainfo == NULL) {
-			if (!value)
-				return config_error_nonbool(var);
-			ssl_cainfo = xstrdup(value);
-		}
+		if (ssl_cainfo == NULL)
+			return git_config_string(&ssl_cainfo, var, value);
 		return 0;
 	}

-- 
1.5.2.2
