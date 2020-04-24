Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE1C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CDF20728
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1Zp6bKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgDXWfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWfx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:35:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EEAC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:52 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so13117709wrs.9
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7LtebPkKojDeEys8l82oq8tWUZlNvoyAY5nNkJwl0Xk=;
        b=u1Zp6bKUbEWrmicz/WjN8wPb/gmaEcq/KPnTOmov1GVwB627a0YI3WmvrOUwmrErAN
         kyWOpCTzaJ9MG0B0Z+0DAQEH1IO0hN38rf23YP41pb/31Brt7KkGPRtRUGNTGHb8ccWO
         EGflf6ZZVblC2v+vlOOxlMHFHugQBWwaRcwpMuLZK5w1jKLi6c2z2uyhsy4z4XIpA6lb
         WIsJtdewkpu/E99gbu+LMPjV87J37h+egnDk/iBpZWmr46Al4ErT5XcD/GfvxiLwtJO+
         7AO+I2cGLS64LC4QpkxsDTFN0R2e8XxCrd0DGClr2cFG1Ju78Jfu/uiLe3QVzhJOUgnG
         IxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7LtebPkKojDeEys8l82oq8tWUZlNvoyAY5nNkJwl0Xk=;
        b=h7E8wUQyiDkiTTE+zGeAnJ0A6ok8ze7yscBfFtl/KTyOGGrL7O1JDVmsAC3pgce5Pq
         sPudTO+KcBW//T83WGnhIEXa0A8TdjmGEKK210dxKv49umCIB3WaJCf8sJTMVJWEPZA6
         WRmqEZFRDDTTUA76lxMkb4mu0BwtekIOl3oa5KSSwYrxsYV0cBpU4pYu1EQWokga61Gj
         GRXJDwIphyDM0ZrNfSuPGUwsJZR5n7H961d7RZZvrvQt3BgOkUedz7TpdBhCVfXNAp3p
         LlFkQqkwFzsAowpjyR3XWV7SO64yy0BvPGKJD+TFVwYdoaVQTuOR4w3rYkE0PJuw2F/V
         OL6g==
X-Gm-Message-State: AGi0PuZbJ3EDpm6CvQ0v9nrtqSeDvYdzr05mWIb3C3B7RPte+BrBwjG+
        r0Kh6kAwVq3EQDp5Wa4X+URRZS4t
X-Google-Smtp-Source: APiQypIHnJIql4RzVe8AMXQYt1GfvyGGBW9kWSpZoFV6iWbjENDRPt6mI4iCAS5IdE1++AypKLZiDA==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr13716099wrr.68.1587767751285;
        Fri, 24 Apr 2020 15:35:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm4582432wmm.6.2020.04.24.15.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:35:50 -0700 (PDT)
Message-Id: <3653df3fc625caa5e39bbadfdde3ccc074260f5c.1587767749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.620.git.1587767749.gitgitgadget@gmail.com>
References: <pull.620.git.1587767749.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 22:35:48 +0000
Subject: [PATCH 1/2] credential: optionally allow partial URLs in
 credential_from_url_gently()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
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

In preparation for fixing that bug, let's refactor the code to
optionally allow for partial URLs. For the moment, this functionality is
only exposed via the now-renamed function `credential_from_url_1()`, but
it is not used. The intention is to make it easier to verify that this
commit does not change the existing behavior unless explicitly allowing
for partial URLs.

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
 credential.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/credential.c b/credential.c
index 108d9e183a5..b8f693fa288 100644
--- a/credential.c
+++ b/credential.c
@@ -377,8 +377,31 @@ static int check_url_component(const char *url, int quiet,
 	return -1;
 }
 
-int credential_from_url_gently(struct credential *c, const char *url,
-			       int quiet)
+/*
+ * Potentially-partial URLs can, but do not have to, contain
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
+ * Note that an empty host name in an otherwise fully-qualified URL (e.g.
+ * `cert:///path/to/cert.pem`) will be treated as unset if we expect the URL to
+ * be potentially partial, and only then (otherwise, the empty string is used).
+ *
+ * The credential_from_url() function does not allow partial URLs.
+ */
+static int credential_from_url_1(struct credential *c, const char *url,
+				 int allow_partial_url, int quiet)
 {
 	const char *at, *colon, *cp, *slash, *host, *proto_end;
 
@@ -391,12 +414,12 @@ int credential_from_url_gently(struct credential *c, const char *url,
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
@@ -420,8 +443,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
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
@@ -443,6 +468,11 @@ int credential_from_url_gently(struct credential *c, const char *url,
 	return 0;
 }
 
+int credential_from_url_gently(struct credential *c, const char *url, int quiet)
+{
+	return credential_from_url_1(c, url, 0, quiet);
+}
+
 void credential_from_url(struct credential *c, const char *url)
 {
 	if (credential_from_url_gently(c, url, 0) < 0)
-- 
gitgitgadget

