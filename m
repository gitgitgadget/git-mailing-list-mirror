Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378DCC55191
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A4420767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 22:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKoaTJQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgDXWfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 18:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDXWfy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 18:35:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BFC09B049
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z6so13127113wml.2
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CKWKRmOJlJgHSsjfYuLW06gd1KuHFHesDPEajGOXtdQ=;
        b=jKoaTJQZqIvCXKaho7ROKC30gF69XefqFzxOLLy4iTU9RAQI3Hlp7fbs9WhslAFQIL
         DXwOiSSSOsFVXdPs+PYLkhItaOUrdC4SCOr4j9Bm/cKSMuquAG3tS1fV93hjAYdUQi0W
         e9ohEhsn5iNha7ai60/tLKOJy2nqgPwT+92rymPIJJlnfjWphdrJPNxFyxp9OVIXSPj6
         wRQJpaAOewEuyYF4C610o3QaMYZplgHc1By8DmybOJ9uq2/q2DfNhzfDu5oaMNZJf7v9
         f/e+GPAR2r/nY3t9BEC0dMRE9k2cGQ6DyyBa3SLUSlGUfe3PpySEqT75jSTzhMk3MypB
         slbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CKWKRmOJlJgHSsjfYuLW06gd1KuHFHesDPEajGOXtdQ=;
        b=tzQsP1juPbmNYVmzgLGrzFpvuf8QYA5FUwNw+Drt2zOo4rSvrzDgbf1V1Arc3XGsQd
         JzMECQDVGS3ZLsfPTy3mf9dvH/ea2gli31GFvu9ZEy1Xci66GfTyjuoB0DT129+GzcQF
         DzWZw9Y54Tp2cI2ANR3HbhL7L/ENw6cuf1hodevChhtqavmMMfUHV3mxJ+EZDwOPckhI
         6Lr9hU3/MXMQz8AmtmBFfSlEwtws4/LcnSQHG2EFQmIhjOowCM/jpDUGF8O/cnG6lAJ+
         1eKirxI6Mad9ITXA4i6XxNZd7sZ3K+fcTBVoOFi/td+U8jNdAqFS11ecL1lDGT3lROGd
         D2ng==
X-Gm-Message-State: AGi0Pubws47SKlX49AczSk3hXi72KQJVdpi7kK/khMhzWbnoavMnNHN6
        it8i9OMGUuDjDko+EiQFsiB5z8Bc
X-Google-Smtp-Source: APiQypL99rc/8lNQoJPEpEi8urhNu+8tQ66V2wUojKTowiKbDiN4Iu3RDktAK4eWm6LRkGObiz/XFg==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr11960286wmt.129.1587767752195;
        Fri, 24 Apr 2020 15:35:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l5sm10096157wrm.66.2020.04.24.15.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 15:35:51 -0700 (PDT)
Message-Id: <46ed1596f91222edeed6258a95ae8f68e3b4993f.1587767749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.620.git.1587767749.gitgitgadget@gmail.com>
References: <pull.620.git.1587767749.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 22:35:49 +0000
Subject: [PATCH 2/2] credential: handle `credential.<partial-URL>.<key>` again
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

In the patches for CVE-2020-11008, the ability to specify credential
settings in the config for partial URLs got lost. For example, it used
to be possible to specify a credential helper for a specific protocol:

	[credential "https://"]
		helper = my-https-helper

Likewise, it used to be possible to configure settings for a specific
host, e.g.:

	[credential "dev.azure.com"]
		useHTTPPath = true

Let's reinstate this behavior.

While at it, increase the test coverage to document and verify the
behavior with a couple other categories of partial URLs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.c           | 27 +++++++++++++++++++++++++++
 t/t0300-credentials.sh | 38 ++++++++++++++++++++++++++++++++++++++
 urlmatch.c             | 10 +++++++---
 urlmatch.h             |  5 +++++
 4 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/credential.c b/credential.c
index b8f693fa288..4e7197d97a9 100644
--- a/credential.c
+++ b/credential.c
@@ -37,6 +37,10 @@ int credential_match(const struct credential *want,
 #undef CHECK
 }
 
+
+static int credential_from_potentially_partial_url(struct credential *c,
+						   const char *url);
+
 static int credential_config_callback(const char *var, const char *value,
 				      void *data)
 {
@@ -82,6 +86,22 @@ static int select_all(const struct urlmatch_item *a,
 	return 0;
 }
 
+static int match_partial_url(const char *url, void *cb)
+{
+	struct credential *c = cb;
+	struct credential want = CREDENTIAL_INIT;
+	int matches = 0;
+
+	if (credential_from_potentially_partial_url(&want, url) < 0)
+		warning(_("skipping credential lookup for key: credential.%s"),
+			url);
+	else
+		matches = credential_match(&want, c);
+	credential_clear(&want);
+
+	return matches;
+}
+
 static void credential_apply_config(struct credential *c)
 {
 	char *normalized_url;
@@ -101,6 +121,7 @@ static void credential_apply_config(struct credential *c)
 	config.collect_fn = credential_config_callback;
 	config.cascade_fn = NULL;
 	config.select_fn = select_all;
+	config.fallback_match_fn = match_partial_url;
 	config.cb = c;
 
 	credential_format(c, &url);
@@ -468,6 +489,12 @@ static int credential_from_url_1(struct credential *c, const char *url,
 	return 0;
 }
 
+static int credential_from_potentially_partial_url(struct credential *c,
+						   const char *url)
+{
+	return credential_from_url_1(c, url, 1, 0);
+}
+
 int credential_from_url_gently(struct credential *c, const char *url, int quiet)
 {
 	return credential_from_url_1(c, url, 0, quiet);
diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 5555a1524f1..c6643288ed6 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -575,4 +575,42 @@ test_expect_success 'credential system refuses to work with missing protocol' '
 	test_i18ncmp expect stderr
 '
 
+test_expect_success 'credential config with partial URLs' '
+	echo "echo password=yep" | write_script git-credential-yep &&
+	test_write_lines url=https://user@example.com/repo.git >stdin &&
+	for partial in \
+		example.com \
+		user@example.com \
+		https:// \
+		https://example.com \
+		https://example.com/ \
+		https://user@example.com \
+		https://user@example.com/ \
+		https://example.com/repo.git \
+		https://user@example.com/repo.git \
+		/repo.git
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <stdin >stdout &&
+		grep yep stdout ||
+		return 1
+	done &&
+
+	for partial in \
+		dont.use.this \
+		http:// \
+		/repo
+	do
+		git -c credential.$partial.helper=yep \
+			credential fill <stdin >stdout &&
+		! grep yep stdout ||
+		return 1
+	done &&
+
+	git -c credential.$partial.helper=yep \
+		-c credential.with%0anewline.username=uh-oh \
+		credential fill <stdin >stdout 2>stderr &&
+	test_i18ngrep "skipping credential lookup for key" stderr
+'
+
 test_done
diff --git a/urlmatch.c b/urlmatch.c
index 29272a5c4f4..33a2ccd306b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -572,10 +572,14 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 
 		config_url = xmemdupz(key, dot - key);
 		norm_url = url_normalize_1(config_url, &norm_info, 1);
+		if (norm_url)
+			retval = match_urls(url, &norm_info, &matched);
+		else if (collect->fallback_match_fn)
+			retval = collect->fallback_match_fn(config_url,
+							    collect->cb);
+		else
+			retval = 0;
 		free(config_url);
-		if (!norm_url)
-			return 0;
-		retval = match_urls(url, &norm_info, &matched);
 		free(norm_url);
 		if (!retval)
 			return 0;
diff --git a/urlmatch.h b/urlmatch.h
index 2407520731f..6ff42f81b0c 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -59,6 +59,11 @@ struct urlmatch_config {
 	 * specificity rules) than existing.
 	 */
 	int (*select_fn)(const struct urlmatch_item *found, const struct urlmatch_item *existing);
+	/*
+	 * An optional callback to allow e.g. for partial URLs; it shall
+	 * return 1 or 0 depending whether `url` matches or not.
+	 */
+	int (*fallback_match_fn)(const char *url, void *cb);
 };
 
 int urlmatch_config_entry(const char *var, const char *value, void *cb);
-- 
gitgitgadget
