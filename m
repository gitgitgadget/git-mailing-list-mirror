From: Modestas Vainius <modestas@vainius.eu>
Subject: Re: [PATCH] Support FTP-over-SSL/TLS for regular FTP
Date: Sun, 07 Apr 2013 22:10:39 +0300
Message-ID: <2136769.UdkVMxoiv9@mdxdesktop>
References: <1357999192-877-1-git-send-email-modestas@vainius.eu> <7057807.F3QETssImX@mdxdesktop> <7vehg43nb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:45:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5p2-0000sy-2y
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab3DGTnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Apr 2013 15:43:37 -0400
Received: from smtp-q8.skynet.lt ([212.122.94.187]:41312 "EHLO
	smtp-q3.skynet.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932526Ab3DGTng convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Apr 2013 15:43:36 -0400
X-Greylist: delayed 1970 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Apr 2013 15:43:36 EDT
Received: from nd1.smtpcl1.5ci.lt (nd1.smtpcl1.5ci.lt [212.122.94.182])
	by smtp-q3.skynet.lt (Postfix) with ESMTP id 6B69161E97B;
	Sun,  7 Apr 2013 22:09:56 +0300 (EEST)
Received: from [127.0.0.1] (helo=localhost)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.72)
	(envelope-from <modestas@vainius.eu>)
	id 1UOuqY-0004fn-8W; Sun, 07 Apr 2013 22:01:46 +0300
Received: from nd1.smtpcl1.5ci.lt ([127.0.0.1])
	by localhost (nd1.smtpcl1.5ci.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1F6Ct8w5M9w7; Sun,  7 Apr 2013 22:01:46 +0300 (EEST)
Received: from [84.240.22.131] (helo=mdxdesktop.lan.vainius.eu)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.72)
	(envelope-from <modestas@vainius.eu>)
	id 1UOuqY-0004fj-2P; Sun, 07 Apr 2013 22:01:46 +0300
Received: from localhost ([::1] helo=mdxdesktop.localnet)
	by mdxdesktop.lan.vainius.eu with esmtp (Exim 4.80)
	(envelope-from <modestas@vainius.eu>)
	id 1UOuzB-0006Gc-4F; Sun, 07 Apr 2013 22:10:41 +0300
User-Agent: KMail/4.8.4 (Linux/3.2.0-4-amd64; KDE/4.8.5; x86_64; ; )
In-Reply-To: <7vehg43nb5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220373>

Hello,

Sunday 24 February 2013 22:44:14 ra=C5=A1=C4=97:
> Modestas Vainius <modestas@vainius.eu> writes:
> > Hello,
> >=20
> > Saturday 12 January 2013 06:25:21 ra=C5=A1=C4=97:
> >> On Sat, Jan 12, 2013 at 03:59:52PM +0200, Modestas Vainius wrote:
> >> > @@ -306,6 +311,11 @@ static CURL *get_curl_handle(void)
> >> >=20
> >> >  	if (curl_ftp_no_epsv)
> >> >  =09
> >> >  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> >> >=20
> >> > +#ifdef CURLOPT_USE_SSL
> >> > +    if (curl_ssl_try)
> >> > +		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
> >> > +#endif
> >> > +
> >> >=20
> >> >  	if (curl_http_proxy) {
> >> >  =09
> >> >  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> >> >  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> >>=20
> >> It looks like the indentation of the "if" line you added is messed=
 up.
> >=20
> > Yeah, sorry about that. I will fix it.
>=20
> Did anything happen to this topic since then?

I'm very sorry about delay. Fixed patch is below.

=46rom 4f39352fe8dd85aa99f2141baa6a096da727c53e Mon Sep 17 00:00:00 200=
1
=46rom: Modestas Vainius <modestas@vainius.eu>
Date: Sun, 7 Apr 2013 22:08:10 +0300
Subject: [PATCH] Support FTP-over-SSL/TLS for regular FTP

Add a boolean http.sslTry option which allows to enable AUTH SSL/TLS an=
d
encrypted data transfers when connecting via regular FTP protocol.

Default is false since it might trigger certificate verification errors=
 on
misconfigured servers.

Signed-off-by: Modestas Vainius <modestas@vainius.eu>
---
 Documentation/config.txt |    8 ++++++++
 http.c                   |   10 ++++++++++
 http.h                   |    9 +++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f79184c..da30cfd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1447,6 +1447,14 @@ http.sslCAPath::
 	with when fetching or pushing over HTTPS. Can be overridden
 	by the 'GIT_SSL_CAPATH' environment variable.
=20
+http.sslTry::
+	Attempt to use AUTH SSL/TLS and encrypted data transfers
+	when connecting via regular FTP protocol. This might be needed
+	if the FTP server requires it for security reasons or you wish
+	to connect securely whenever remote FTP server supports it.
+	Default is false since it might trigger certificate verification
+	errors on misconfigured servers.
+
 http.maxRequests::
 	How many HTTP requests to launch in parallel. Can be overridden
 	by the 'GIT_HTTP_MAX_REQUESTS' environment variable. Default is 5.
diff --git a/http.c b/http.c
index 8803c70..f791fcb 100644
--- a/http.c
+++ b/http.c
@@ -31,6 +31,7 @@ static CURL *curl_default;
 char curl_errorstr[CURL_ERROR_SIZE];
=20
 static int curl_ssl_verify =3D -1;
+static int curl_ssl_try;
 static const char *ssl_cert;
 #if LIBCURL_VERSION_NUM >=3D 0x070903
 static const char *ssl_key;
@@ -163,6 +164,10 @@ static int http_options(const char *var, const cha=
r *value, void *cb)
 			ssl_cert_password_required =3D 1;
 		return 0;
 	}
+	if (!strcmp("http.ssltry", var)) {
+		curl_ssl_try =3D git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp("http.minsessions", var)) {
 		min_curl_sessions =3D git_config_int(var, value);
 #ifndef USE_CURL_MULTI
@@ -307,6 +312,11 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
=20
+#ifdef CURLOPT_USE_SSL
+	if (curl_ssl_try)
+		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
+#endif
+
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
diff --git a/http.h b/http.h
index 25d1931..097514d 100644
--- a/http.h
+++ b/http.h
@@ -42,6 +42,15 @@
 #define NO_CURL_IOCTL
 #endif
=20
+/*
+ * CURLOPT_USE_SSL was known as CURLOPT_FTP_SSL up to 7.16.4,
+ * and the constants were known as CURLFTPSSL_*
+*/
+#if !defined(CURLOPT_USE_SSL) && defined(CURLOPT_FTP_SSL)
+#define CURLOPT_USE_SSL CURLOPT_FTP_SSL
+#define CURLUSESSL_TRY CURLFTPSSL_TRY
+#endif
+
 struct slot_results {
 	CURLcode curl_result;
 	long http_code;
--=20
1.7.10.4



--=20
Modestas Vainius <modestas@vainius.eu>
