Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E39AC2BA19
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35B1E2064A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 23:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1lUY7Pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgDWXnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgDWXnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 19:43:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C2C09B042
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e26so8504330wmk.5
        for <git@vger.kernel.org>; Thu, 23 Apr 2020 16:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R4gDeot75hHD78v0gLsfKWn5MS6AIsaMVXHxtn1EQlA=;
        b=l1lUY7PbsD7P7HCK2DHn1BgmeC54uN/kz2/bhb+Q62klQ6etvFSCZPyYOGFXXpp9oy
         1iYiD5EYKvqj6PWDQfr6GjB6Y8JOcPWqosCCwmbe/d5bPdWwaaJOAczcVkSDU6J9mPi5
         w9+Sbj/ZadEqblFzPWv3mHinM5xO8WdYcZNPxUXzgxerOP5Abm2lfgpFJjAMovfEVP+f
         yt6d8qf3LDmVyy737tzdrlwod/npr8WbWv7g7NrVtSOBb4tBUUyFQiBM96tCYf9uquIk
         17WGGpuY6ve3pLm0BnB93CHQny6ItUnvNUaqVV5Qe9KsxVB5yVHNwxu0g8l4jL/WaDVs
         zZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R4gDeot75hHD78v0gLsfKWn5MS6AIsaMVXHxtn1EQlA=;
        b=iz/qS9iHhkQLPn/vZOGCByOOo4sQj+Jwh0Qix71+uX3y2wKxCATO7xTtRfEM1i9wgW
         ZULXB9JlxTdlyJ5cu5T0D6p8ZBq4izNezkAbjGpMmQ6Bd6zklGrpDrAv7tty7UHvewgL
         lR2pAG6zu7phadsouYUCZJ35mHjeCauQwmrE2h+KU28WkHXufyBBvMM1kJQgxuekLKS1
         cvwRfhhppdPYNypFPHmmDRK0rafooyE/iFEZdIvrQKisIuaVzno4tf3JBrrwwrhtzkyf
         GEmRMPeYG0FdzVmycSJonUGglGFW1a9AbKYi9TuiLUDzte57cYOXm0K0QWEZDkx/rcZM
         AaVg==
X-Gm-Message-State: AGi0PubG8aP/7YJPNvvVCQ2X89MeJcGVTxqXBnTNPlglfE5HdTA7HDDg
        m7F6eucUm5SyZQv/U9R+1w0Bkxhp
X-Google-Smtp-Source: APiQypJGJkT6QC7h0SL4JR95mAhORcrNfda1Dgxcd6bLb9D25rPlBzAUHfPkcTd+oQ/UffXt3RchEA==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr6672599wmd.119.1587685400067;
        Thu, 23 Apr 2020 16:43:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m15sm435410wmc.35.2020.04.23.16.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 16:43:19 -0700 (PDT)
Message-Id: <fc772d21b7472afc6ad862ff30ec4be91f0e8d80.1587685397.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
        <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Apr 2020 23:43:16 +0000
Subject: [PATCH v2 2/3] credential: optionally allow partial URLs in
 credential_from_url_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prior to the fixes for CVE-2020-11008, we were _very_ lenient in what we
required from a URL in order to parse it into a `struct credential`.
That led to serious vulnerabilities.

There was one call site, though, that really needed that leniency: when
parsing config settings a la `credential.dev.azure.com.useHTTPPath`.
Settings like this might be desired when users want to use, say, a given
user name on a given host, regardless of the protocol to be used.

In preparation for fixing that bug, let's add a parameter called
`allow_partial_url` to the `credential_from_url_gently()` function and
convert the existing callers to set that parameter to 0, i.e. do not
change the existing behavior, just add the option to be more lenient.

Please note that this patch does more than just reinstating a way to
imitate the behavior before those CVE-2020-11008 fixes: Before that, we
would simply ignore URLs without a protocol. In other words,
misleadingly, the following setting would be applied to _all_ URLs:

	[credential "example.com"]
		username = that-me

The obvious intention is to match the host name only. With this patch,
we allow precisely that: when parsing the URL with non-zero
`allow_partial_url`, we do not simply return success if there was no
protocol, but we simply leave the protocol unset and continue parsing
the URL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c | 14 ++++++++------
 credential.h | 26 +++++++++++++++++++++++++-
 fsck.c       |  2 +-
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/credential.c b/credential.c
index 64a841eddca..52965a5122c 100644
--- a/credential.c
+++ b/credential.c
@@ -344,7 +344,7 @@ static int check_url_component(const char *url, int quiet,
 }
 
 int credential_from_url_gently(struct credential *c, const char *url,
-			       int quiet)
+			       int allow_partial_url, int quiet)
 {
 	const char *at, *colon, *cp, *slash, *host, *proto_end;
 
@@ -357,12 +357,12 @@ int credential_from_url_gently(struct credential *c, const char *url,
 	 *   (3) proto://<user>:<pass>@<host>/...
 	 */
 	proto_end = strstr(url, "://");
-	if (!proto_end || proto_end == url) {
+	if (!allow_partial_url && (!proto_end || proto_end == url)) {
 		if (!quiet)
 			warning(_("url has no scheme: %s"), url);
 		return -1;
 	}
-	cp = proto_end + 3;
+	cp = proto_end ? proto_end + 3 : url;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
@@ -382,8 +382,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
 		host = at + 1;
 	}
 
-	c->protocol = xmemdupz(url, proto_end - url);
-	c->host = url_decode_mem(host, slash - host);
+	if (proto_end && proto_end - url > 0)
+		c->protocol = xmemdupz(url, proto_end - url);
+	if (!allow_partial_url || slash - host > 0)
+		c->host = url_decode_mem(host, slash - host);
 	/* Trim leading and trailing slashes from path */
 	while (*slash == '/')
 		slash++;
@@ -407,6 +409,6 @@ int credential_from_url_gently(struct credential *c, const char *url,
 
 void credential_from_url(struct credential *c, const char *url)
 {
-	if (credential_from_url_gently(c, url, 0) < 0)
+	if (credential_from_url_gently(c, url, 0, 0) < 0)
 		die(_("credential url cannot be parsed: %s"), url);
 }
diff --git a/credential.h b/credential.h
index 5a86502d95c..5abc865b95d 100644
--- a/credential.h
+++ b/credential.h
@@ -41,9 +41,33 @@ void credential_write(const struct credential *, FILE *);
  * an error but leave the broken state in the credential object for further
  * examination.  The non-gentle form will issue a warning to stderr and return
  * an empty credential.
+ *
+ * If allow_partial_url is non-zero, partial URLs are allowed, i.e. it can, but
+ * does not have to, contain
+ *
+ * - a protocol (or scheme) of the form "<protocol>://"
+ *
+ * - a host name (the part after the protocol and before the first slash after
+ *   that, if any)
+ *
+ * - a user name and potentially a password (as "<user>[:<password>]@" part of
+ *   the host name)
+ *
+ * - a path (the part after the host name, if any, starting with the slash)
+ *
+ * Missing parts will be left unset in `struct credential`. Thus, `https://`
+ * will have only the `protocol` set, `example.com` only the host name, and
+ * `/git` only the path.
+ *
+ * Note that an empty host name in an otherwise fully-qualified URL will be
+ * treated as unset when allow_partial_url is non-zero (and only then,
+ * otherwise it is treated as the empty string).
+ *
+ * The credential_from_url() function does not allow partial URLs.
  */
 void credential_from_url(struct credential *, const char *url);
-int credential_from_url_gently(struct credential *, const char *url, int quiet);
+int credential_from_url_gently(struct credential *, const char *url,
+			       int allow_partial_url, int quiet);
 
 int credential_match(const struct credential *have,
 		     const struct credential *want);
diff --git a/fsck.c b/fsck.c
index 31b5be05f54..cec97b63901 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1076,7 +1076,7 @@ static int check_submodule_url(const char *url)
 	else if (url_to_curl_url(url, &curl_url)) {
 		struct credential c = CREDENTIAL_INIT;
 		int ret = 0;
-		if (credential_from_url_gently(&c, curl_url, 1) ||
+		if (credential_from_url_gently(&c, curl_url, 0, 1) ||
 		    !*c.host)
 			ret = -1;
 		credential_clear(&c);
-- 
gitgitgadget

