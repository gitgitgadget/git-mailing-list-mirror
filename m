Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14167C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E651620767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPZ+oMAg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgDXLuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgDXLt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:49:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CD2C09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:57 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s10so10452568wrr.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jh/TyKdHVyvhSWNQXpsfdU8J5LSRlaHmZJY4sonmRPQ=;
        b=ZPZ+oMAgDbhJYeHo+StRYBJzZopRQuWGV/A903HlaiCXia+jK4LIPF7t1EK/oqVpCT
         puOW4tu4Vj+1XYLNili9r8CIbpSwVGbRZW0g6NrgF/vrmUkfL3fJwUccg/2iii0FTe3H
         uEHCU1jvnZKknCeOjuoDlxUaTZz0cPIt9M2PRn8GU818YOsvUd0HWEXuKD9u5bft/qH+
         iN52kKZzCyhmLrRxlb6mE4bRqekFtVlwM0kXvflKPqRTJXZQJrLzqrioy8+VE0PwdwJh
         vvoOx8BgdxL02PoOfxBI1eQzxgeaGCufNy6EUuuJxtYrer8djJG60Qkz5WW7hm6HiJ9R
         bqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jh/TyKdHVyvhSWNQXpsfdU8J5LSRlaHmZJY4sonmRPQ=;
        b=sZaRY8eCOr+by4jg9N9tgYVw9A9YafEKU7IHHWHwsXGupJRNMafu+qyg6HbXSyc53m
         zYhSwjDD338DkpSZ9yq7Y3dDUp/hUljzNw72980yxtHooJ+y+253/kXxFyOgd5IKwP4M
         /dwZONiRA8yip/f2Y4qvDE4g+c85l3iWAqLKAaq0ha4til3ZstHz5xIvzKm1fF36mBpA
         RdnXN99Yx5hAKMeutumNRTNFZcSJT/5S5t6eSWn2ux64O16H9NX16wxuiWj++uVb7CZZ
         GW/YUKCRb7476t2myGT3a5vLuQbwnLoxPjDcGv1fmMA/Wvy/1da4g/1nvM7KfylV9zvY
         q+Wg==
X-Gm-Message-State: AGi0PuZxg8pEv85krpL1HIoEN/kOdhf3AXYmK7piDfM+Uf0/+QG9C056
        cSj7h8donLXhD87UxvMs6Na+AOfT
X-Google-Smtp-Source: APiQypLKsOk0sachWgt5JPwlLdjeYBxjrdR7Qko1SqBsSOCwK1Hm2WqngL665FnB0zvrUdvgBq78Ag==
X-Received: by 2002:adf:edc6:: with SMTP id v6mr10459284wro.8.1587728995858;
        Fri, 24 Apr 2020 04:49:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n9sm7956194wrx.61.2020.04.24.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:49:55 -0700 (PDT)
Message-Id: <e92f139dfc732720f5819a954c54f2e3c5f7d1c9.1587728992.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
References: <pull.615.v2.git.1587685397.gitgitgadget@gmail.com>
        <pull.615.v3.git.1587728992.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 11:49:51 +0000
Subject: [PATCH v3 2/3] credential: optionally allow partial URLs in
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
index 64a841eddca..7dbbf26f174 100644
--- a/credential.c
+++ b/credential.c
@@ -343,8 +343,31 @@ static int check_url_component(const char *url, int quiet,
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
 
@@ -357,12 +380,12 @@ int credential_from_url_gently(struct credential *c, const char *url,
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
@@ -382,8 +405,10 @@ int credential_from_url_gently(struct credential *c, const char *url,
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
@@ -405,6 +430,11 @@ int credential_from_url_gently(struct credential *c, const char *url,
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

