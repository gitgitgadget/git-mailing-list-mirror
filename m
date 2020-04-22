Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EB8C55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7A52077D
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgZ3vGiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDVUvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDVUvK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:51:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B385C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so4049840wmk.5
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9XVx+wWZNt5Mof2ESKJ4JgS7Tv7HHKMdOTL01Ias09E=;
        b=XgZ3vGiVXBHqtbqQ791LQjm1ZaRqkkUEYdWOeBDahzgEbI/fYziDqD7FbroazwP5md
         HhR+lQs/jl3DV2FB1SBxNnrcjVQTmydKhaOgTphZn0vR8DhOn+KPLsFdfzUegvDJemmV
         W9WWk0VaDGzy/MzlTZLxGwJRp1dmqCIHAvyuiI76PcMPSD+e/jz7hMLfJfPwLon+WdPq
         GWxg/u6JKEDvf4gcRVaw1yka4ufID8zBFypm5Zmd6xuR8PrGaPFLPh23RZbZ/+WB7+r5
         7RLzgqsPVz3585CNHwHgNXopIpTnO6rw8hdXBICapisGY8J/t6bt4HaMPIn+ecMqohdm
         jbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9XVx+wWZNt5Mof2ESKJ4JgS7Tv7HHKMdOTL01Ias09E=;
        b=l2d8wYTlOdqrWz/9nhFOlDDCHSpg2xi7JvjGn6ow3xJUCf3HPVWFVfCCD1gYDWWkb+
         Irmxsbao2smW8Lva5eZV2kjsdojers8nmffNkG2gzNVguSVat02h0wG6FcNuKMVNGaEo
         WslI7aQuA1K+TvKYmEGN5HPTabiB/ytg279CVy1W1pmRKsz2yrkaEWlhkgS5V52+MMW7
         97tRBP0M83/sXnzv1da+uH5F+Qv3fkvq1nUoAxwaZFDKDDSHgzULOXaFSJ15JB7/eq/Y
         rl6hJtXNpPjH8uPWwN/CMFcnuDCnwglzbVEglf8F5k90OjqKC9lmjrjLJYItGA34Qerp
         Fo+Q==
X-Gm-Message-State: AGi0PuZapEahqkILtfetkjfsZBrnZnfv+ZdAeLVYnTQXN7wLTx0klWDA
        JQUnV0wf4NVwIyEuXCXkQOLzVgpG
X-Google-Smtp-Source: APiQypJ2UZRbgU6t/kleA87vM2D9zoSmQrMBGBZk74XmyEYh7lywjf6u03/dEiXkrHCNqinObzr9bw==
X-Received: by 2002:a1c:a344:: with SMTP id m65mr381337wme.20.1587588667944;
        Wed, 22 Apr 2020 13:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o129sm619084wme.16.2020.04.22.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:51:07 -0700 (PDT)
Message-Id: <1081841b16de31693473e72ff817bed5f0064dda.1587588665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.git.1587588665.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Apr 2020 20:51:04 +0000
Subject: [PATCH 2/3] credential: teach `credential_from_url()` a non-strict
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
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

In preparation for fixing that regression, let's add a parameter called
`strict` to the `credential_from_url()` function and convert the
existing callers to enforce that strict mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c | 14 ++++++++------
 credential.h |  6 +++++-
 fsck.c       |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/credential.c b/credential.c
index 64a841eddca..c73260ac40f 100644
--- a/credential.c
+++ b/credential.c
@@ -344,7 +344,7 @@ static int check_url_component(const char *url, int quiet,
 }
 
 int credential_from_url_gently(struct credential *c, const char *url,
-			       int quiet)
+			       int strict, int quiet)
 {
 	const char *at, *colon, *cp, *slash, *host, *proto_end;
 
@@ -357,12 +357,12 @@ int credential_from_url_gently(struct credential *c, const char *url,
 	 *   (3) proto://<user>:<pass>@<host>/...
 	 */
 	proto_end = strstr(url, "://");
-	if (!proto_end || proto_end == url) {
+	if (strict && (!proto_end || proto_end == url)) {
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
+	if (slash - url > 0)
+		c->host = url_decode_mem(host, slash - host);
 	/* Trim leading and trailing slashes from path */
 	while (*slash == '/')
 		slash++;
@@ -407,6 +409,6 @@ int credential_from_url_gently(struct credential *c, const char *url,
 
 void credential_from_url(struct credential *c, const char *url)
 {
-	if (credential_from_url_gently(c, url, 0) < 0)
+	if (credential_from_url_gently(c, url, 1, 0) < 0)
 		die(_("credential url cannot be parsed: %s"), url);
 }
diff --git a/credential.h b/credential.h
index 5a86502d95c..823ec2caf35 100644
--- a/credential.h
+++ b/credential.h
@@ -41,9 +41,13 @@ void credential_write(const struct credential *, FILE *);
  * an error but leave the broken state in the credential object for further
  * examination.  The non-gentle form will issue a warning to stderr and return
  * an empty credential.
+ *
+ * In strict mode, an empty protocol or an empty host name are not allowed.
+ * The credential_from_url() function enforces strict mode.
  */
 void credential_from_url(struct credential *, const char *url);
-int credential_from_url_gently(struct credential *, const char *url, int quiet);
+int credential_from_url_gently(struct credential *, const char *url,
+			       int strict, int quiet);
 
 int credential_match(const struct credential *have,
 		     const struct credential *want);
diff --git a/fsck.c b/fsck.c
index 31b5be05f54..aa66dc1e742 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1076,7 +1076,7 @@ static int check_submodule_url(const char *url)
 	else if (url_to_curl_url(url, &curl_url)) {
 		struct credential c = CREDENTIAL_INIT;
 		int ret = 0;
-		if (credential_from_url_gently(&c, curl_url, 1) ||
+		if (credential_from_url_gently(&c, curl_url, 1, 1) ||
 		    !*c.host)
 			ret = -1;
 		credential_clear(&c);
-- 
gitgitgadget

