Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA613D61E
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467141; cv=none; b=iqMTQBuQo5cD1VgLCFGj+RZfvHRfhNOJiA3W/axz1LccLc/DSjSwhwfE/wu+/ixIitLt7+Hq2iNulBsl6zjf/w52vILlbH/67OMq8yxP2PzZQeN8bLsDREw+GOVBRHt1sU8fBksfGsNvM8ZzznjGg86FpllabHMXOh2tU3Q8LV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467141; c=relaxed/simple;
	bh=zaKitAUMwJ9FIKrbL06C6dhAKfs8J0HdsZlBYOYXqBM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juX2yU1uKGkVJQMXvuC05bBU7x1ialp+r08iOLN/+2+fkHBLz/G801x0oeorbvEzDZ7bgEKBTNedTuD5IMZ5p7+0VTbbqsoL/Igt1d+x1dY4HHCj2SQc5k30CyM24Sx4IPsHGcL0+7w1+vrDnu+JgIFvI0hPez8BsNFHuwxLe7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hZGBKQsW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtbOCZzH; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hZGBKQsW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtbOCZzH"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 737A61C0012D
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 May 2024 08:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467139; x=1716553539; bh=royfV/Ww2b
	Vb6Au65xiYXh7aoYo+Fw4XVvpQ9JcbOJQ=; b=hZGBKQsWzf7NNDao2mcTGJnNEn
	c464xIAa5bh0/nineQtBCkCQ9/ufyFa2mQNyPqowplYXnE+9scWCHPrIYrT+Fu+M
	Foas8ckDP3IXscuHXswoDCOXZkx2CfK02XGUTgypUPyv69qwSkxQKq4TGlmXfasV
	UIibREdL45ogSFiZe+sThPMTrzhtkDs2Hi4Bnd4XP3SSF34woQubU4hi17hsKKj4
	COq6vVlORnUKcwUeFyabmzhsqABkh7uu/xiGVgUzLrDGboJ4uW4FB1dWi7nvvRSl
	N8iM401nxONxurhhhEmt6dvbtwcPhqioKW1SR+vuQSze3o5RW9P7tfeQS1sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467139; x=1716553539; bh=royfV/Ww2bVb6Au65xiYXh7aoYo+
	Fw4XVvpQ9JcbOJQ=; b=HtbOCZzHEp1+ZbHh85seRQcp9jGcDjsWpCZhqq7z1cmH
	N/3syAMfMsMN06sjfN+Kjep6C/v4+qyZQsu2foi55tXBhCaNf7aF5/Rb1ixrnCeE
	iz3qn8gODzdPj8hqFylVcqtYTmwtQXU3KcyesQg93165/mDkz6LO6yy/PkktPBFp
	ZyPyW5BZFGM3vEWzRLGTYkBsTQj4WsOs61pEhdsWTdWnn98hnuq7uRmzDUYdKUJu
	VOR3WmlcGzXRBtSeo7wlLpm3CJJ6KbSe+fonzPE2Pj4zdt5Wf7ECKcXut5KNlBce
	8VegOsw+1+buMXR2k65YXTdLzx1nsTSD3X87p8cNmg==
X-ME-Sender: <xms:wjVPZh88X56_poB3QY2uwQKbt74cUfCH7mfsM5BTBYjJaCw-G8amzQ>
    <xme:wjVPZluPGpWjRajZIr-7pX9MXUNSLqhNQYK2rYb_uKt5UFr6_olDM-yhhmLCgKRyT
    aCfr1oq-m9HfRQhRA>
X-ME-Received: <xmr:wjVPZvAjX2J8k7DvRgtn2AUuIkl0enjPv6IqXvW-OqFVvQipIKn1y73UlaBr6a7PFxId4qlPiRn1322gViuTxfPVsRul0Z_YunqlJUrW0hzUS6G4dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wjVPZldZ7-KAofWVeFXWTqsiYGC-SKS9n_WtfGK1Y_HiwQS24iD5fw>
    <xmx:wjVPZmP4pLQoMqoF02WEr9bnr5nskENiIb8lhFZ8qlqHC0BKI7jOkg>
    <xmx:wjVPZnlQkXeuqwiN1s_uFcAxPo85V5mgErJ6v8QX1NCWbGkk_imACA>
    <xmx:wjVPZguLVQeezaXLtwUhY0uwOaoI1p5xIddNvKkNFDOsGUG_gwcZIA>
    <xmx:wzVPZo2YQfcj5svYWAH8r6twEj7y3EL0uS5cH5tMJxiIrWU3-Y2hdVll>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b77ea22a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:31 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/20] http: refactor code to clarify memory ownership
Message-ID: <d4bf3c1f9566f34751eb5669e66e9c100ece02b3.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dn0DFmx0/j/waHvB"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--Dn0DFmx0/j/waHvB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are various variables assigned via `git_config_string()` and
`git_config_pathname()` which are never free'd. This bug is relatable
because the out parameter of those functions are a `const char **`, even
though memory ownership is transferred to the caller.

We're about to adapt the functions to instead use `char **`. Prepare the
code accordingly. Note that the `(const char **)` casts will go away
once we have adapted the functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 62 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/http.c b/http.c
index 752c879c1f..db2e2f1d39 100644
--- a/http.c
+++ b/http.c
@@ -39,8 +39,8 @@ char curl_errorstr[CURL_ERROR_SIZE];
 static int curl_ssl_verify =3D -1;
 static int curl_ssl_try;
 static const char *curl_http_version =3D NULL;
-static const char *ssl_cert;
-static const char *ssl_cert_type;
+static char *ssl_cert;
+static char *ssl_cert_type;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
 static struct {
@@ -59,23 +59,23 @@ static struct {
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
-static const char *ssl_key;
-static const char *ssl_key_type;
-static const char *ssl_capath;
-static const char *curl_no_proxy;
+static char *ssl_key;
+static char *ssl_key_type;
+static char *ssl_capath;
+static char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 static const char *ssl_pinnedkey;
 #endif
-static const char *ssl_cainfo;
+static char *ssl_cainfo;
 static long curl_low_speed_limit =3D -1;
 static long curl_low_speed_time =3D -1;
 static int curl_ftp_no_epsv;
-static const char *curl_http_proxy;
-static const char *http_proxy_authmethod;
+static char *curl_http_proxy;
+static char *http_proxy_authmethod;
=20
-static const char *http_proxy_ssl_cert;
-static const char *http_proxy_ssl_key;
-static const char *http_proxy_ssl_ca_info;
+static char *http_proxy_ssl_cert;
+static char *http_proxy_ssl_key;
+static char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth =3D CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
=20
@@ -112,7 +112,7 @@ static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth =3D CREDENTIAL_INIT;
 static int http_proactive_auth;
-static const char *user_agent;
+static char *user_agent;
 static int curl_empty_auth =3D -1;
=20
 enum http_follow_config http_follow_config =3D HTTP_FOLLOW_INITIAL;
@@ -381,17 +381,17 @@ static int http_options(const char *var, const char *=
value,
 	if (!strcmp("http.sslversion", var))
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
-		return git_config_pathname(&ssl_cert, var, value);
+		return git_config_pathname((const char **)&ssl_cert, var, value);
 	if (!strcmp("http.sslcerttype", var))
-		return git_config_string(&ssl_cert_type, var, value);
+		return git_config_string((const char **)&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
-		return git_config_pathname(&ssl_key, var, value);
+		return git_config_pathname((const char **)&ssl_key, var, value);
 	if (!strcmp("http.sslkeytype", var))
-		return git_config_string(&ssl_key_type, var, value);
+		return git_config_string((const char **)&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
-		return git_config_pathname(&ssl_capath, var, value);
+		return git_config_pathname((const char **)&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
-		return git_config_pathname(&ssl_cainfo, var, value);
+		return git_config_pathname((const char **)&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required =3D git_config_bool(var, value);
 		return 0;
@@ -440,19 +440,19 @@ static int http_options(const char *var, const char *=
value,
 		return 0;
 	}
 	if (!strcmp("http.proxy", var))
-		return git_config_string(&curl_http_proxy, var, value);
+		return git_config_string((const char **)&curl_http_proxy, var, value);
=20
 	if (!strcmp("http.proxyauthmethod", var))
-		return git_config_string(&http_proxy_authmethod, var, value);
+		return git_config_string((const char **)&http_proxy_authmethod, var, val=
ue);
=20
 	if (!strcmp("http.proxysslcert", var))
-		return git_config_string(&http_proxy_ssl_cert, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_cert, var, value=
);
=20
 	if (!strcmp("http.proxysslkey", var))
-		return git_config_string(&http_proxy_ssl_key, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_key, var, value);
=20
 	if (!strcmp("http.proxysslcainfo", var))
-		return git_config_string(&http_proxy_ssl_ca_info, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_ca_info, var, va=
lue);
=20
 	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
 		proxy_ssl_cert_password_required =3D git_config_bool(var, value);
@@ -476,7 +476,7 @@ static int http_options(const char *var, const char *va=
lue,
 	}
=20
 	if (!strcmp("http.useragent", var))
-		return git_config_string(&user_agent, var, value);
+		return git_config_string((const char **)&user_agent, var, value);
=20
 	if (!strcmp("http.emptyauth", var)) {
 		if (value && !strcmp("auto", value))
@@ -592,10 +592,10 @@ static void init_curl_http_auth(CURL *result)
 }
=20
 /* *var must be free-able */
-static void var_override(const char **var, char *value)
+static void var_override(char **var, char *value)
 {
 	if (value) {
-		free((void *)*var);
+		free(*var);
 		*var =3D xstrdup(value);
 	}
 }
@@ -1233,11 +1233,13 @@ static CURL *get_curl_handle(void)
 	return result;
 }
=20
-static void set_from_env(const char **var, const char *envname)
+static void set_from_env(char **var, const char *envname)
 {
 	const char *val =3D getenv(envname);
-	if (val)
-		*var =3D val;
+	if (val) {
+		FREE_AND_NULL(*var);
+		*var =3D xstrdup(val);
+	}
 }
=20
 void http_init(struct remote *remote, const char *url, int proactive_auth)
--=20
2.45.1.216.g4365c6fcf9.dirty


--Dn0DFmx0/j/waHvB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNb4ACgkQVbJhu7ck
PpQnUw//aRKYQRy0oS4B2Qjhbkw/+VOrotsJ86zbpeQV+5zq8G9BQ5f3AtO+yMU4
qRR7e77vD5XU7dgnCTPuZrDQ6QDXRry438NhHsfVaV3+CC1UAOprCiMVGTSInrur
hYH3DYk9pbQW8b+8ksPDcVJXiivdkNOOm0kggZJ6cKSy4wc62MvodGXzd0TT1z+2
sWagvhLIUGq+g7N1vBzGR0Yf+Z7QMe/b0oyYpo1ipnHqbOYWg8njMPW7Ob538v1M
PXZVKe0KarNR1GrL8nwMG4HZHEe3YAinfmptnJQjbK1OqwehMXCVr33DJsjueeK4
DPygTI7OWvZWaxBuEuNOzW+xhlFU599qOSsJhgQIa/PedYEx5lsnB9UWrg8FSUG6
syyEWg8ABxrnZbkRx0uiB/x3jdmJRQWfpD2/0w4N6fn+RxQ1I+8UV+ozy/SPr5f4
8w42Jsm3/kg1sWP3WaqCimvOaPuq+m/QD30ngsvSkTGlUnpDBisNlCd1WLHpwEu+
UBYOoRJklRJpPy5/petWIolfhhJL5+r25ptl0ZCY8JKuFosxo18+zq/+bOx3X4R2
vqZ8rRh5jiH5psnBLhXb/LGxyUcJZferlY7Hkkz6DpJAnW56Qv37K2ukoUsIm1JG
S4UDbHUNfCWskfnHNWVnMDCOYmMtlJkwz30dtVCqjlCg9BBTu6c=
=DQ2O
-----END PGP SIGNATURE-----

--Dn0DFmx0/j/waHvB--
