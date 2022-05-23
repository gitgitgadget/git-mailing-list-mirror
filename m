Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B54C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 18:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiEWSaL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 14:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbiEWSaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 14:30:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A3E64F9
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:04:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n124-20020a1c2782000000b003972dfca96cso32734wmn.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Nt89pR3LFDbok7uBfKDgvDIQ4tx80L66t3sCFkf5E+M=;
        b=nXzbDIpZCok7dg8t3HvSp+ZOyjYhX5l6+sCz4sUX7+6b0Do6IvquXMu/b34QMHo+xt
         3DjO/DadMS2K0d4i2hy9mhtmXCDS82TSnC0nEUEEummwSTgIJE8q0kL89E8Tz+9rwzL1
         mTMqj/+2XTMfKzP/PY8Rn8E3pN0sm9PruOP8opfHXXfp+uJlEQZ5RPhlSdUAWLSev5m1
         hNzGg4adUOcb4G0wOpuQgSOKkBOqjIaDheHHz/4joLjr/6f6FQwxUXLG0Ipl8azg2GdG
         JBpnKkwb+d8KBceBbJNWCVfGkhIjCG6XjgVgooevUERNYCW3Uj4rrKnudKcUqhYcpruG
         qWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Nt89pR3LFDbok7uBfKDgvDIQ4tx80L66t3sCFkf5E+M=;
        b=zUzM2T1yk5QRFGt5r0M0/iAbcCXB5rtttNacTBn2RCOwf0S5LWwfUn51u632nAgmsQ
         OYln4rYqlEL8n1DkLkcIfa8eQOVzdIKTJEUEe2epu4ILQvCCWYFVEvNOM4y/2DzT3u9Q
         u5h3dw7YD5INqamCIreaIiBfdW1iT5fzKnp/mgndSrX6yFd6Mk5bFb3R07d3vsCb4pCN
         aLN8se13/WXAAxE/oloS+dH1TF0HRd2vsmfxGNCZ8Tl/u9NeZ8n3WgTzmGnLKeYYdd6C
         qalRLhZWKarn9jxQn7Kus66lrr1ooBBeJrPCbPNmHRxQOtyv+pmtvFgnYxS1IeVhhbvb
         ht4w==
X-Gm-Message-State: AOAM531/ngZBBrbQeN4I3qV/Vi+crPHkKpbkV6zjWsxShN5+bDMqapGs
        pjqQ6iBDQHOF90i/bdqydUMbOP/7CQc=
X-Google-Smtp-Source: ABdhPJwMOVhK7PuAuhkV2Jk+O+s7jbEWDryhfO+Apd/fyXPIJtdpNCMGntzA2EargkevHTLfrGWedA==
X-Received: by 2002:a05:600c:19c8:b0:394:7cb0:717b with SMTP id u8-20020a05600c19c800b003947cb0717bmr218455wmq.136.1653329047337;
        Mon, 23 May 2022 11:04:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b0039747cf8354sm4866578wms.39.2022.05.23.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 11:04:06 -0700 (PDT)
Message-Id: <pull.1237.git.1653329044940.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 18:04:04 +0000
Subject: [PATCH] urlmatch: create fetch.credentialsInUrl config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Users sometimes provide a "username:password" combination in their
plaintext URLs. Since Git stores these URLs in plaintext in the
.git/config file, this is a very insecure way of storing these
credentials. Credential managers are a more secure way of storing this
information.

System administrators might want to prevent this kind of use by users on
their machines.

Create a new "fetch.credentialsInUrl" config option and teach Git to
warn or die when seeing a URL with this kind of information. The warning
anonymizes the sensitive information of the URL to be clear about the
issue.

This change currently defaults the behavior to "ignore" which does
nothing with these URLs. We can consider changing this behavior to
"warn" by default if we wish. At that time, we may want to add some
advice about setting fetch.credentialsInUrl=ignore for users who still
want to follow this pattern (and not receive the warning).

As an attempt to ensure the parsing logic did not catch any
unintentional cases, I modified this change locally to to use the "die"
option by default. Running the test suite succeeds except for the
explicit username:password URLs used in t5550-http-fetch-dumb.s and
t5541-http-push-smart.sh. This means that all other tested URLs did not
trigger this logic.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    urlmatch: create fetch.credentialsInUrl config
    
    This is a modified version of the patch I submitted a while ago [1].
    
    Based on the feedback, changing the behavior to fail by default was not
    a good approach. Further, the idea to stop storing the credentials in
    config and redirect them to a credential manager was already considered
    by Peff [2] but not merged.
    
    This patch does what should be the simplest thing we can do: create a
    config option that will cause the user to get a warning or a failure,
    depending on its value. The default is to ignore the setting, identical
    to the current behavior. We can talk about changing this default to
    "warn" in the future, but it would be safest to release with ignore as
    the default until we are sure that we are not going to start warning on
    false positives.
    
    This patch would be sufficient for the interested internal parties that
    want to prevent users from storing credentials this way. System
    administrators can modify system-level Git config into "die" mode to
    prevent this behavior.
    
    [1]
    https://lore.kernel.org/git/pull.945.git.1619807844627.gitgitgadget@gmail.com
    Reject passwords in URLs (April 2021).
    
    [2]
    https://lore.kernel.org/git/20190519050724.GA26179@sigill.intra.peff.net/
    Re: Git ransom campaign incident report - May 2019
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1237%2Fderrickstolee%2Fcreds-in-url-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1237/derrickstolee/creds-in-url-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1237

 Documentation/config/fetch.txt | 13 ++++++++++
 t/t5601-clone.sh               |  7 ++++++
 urlmatch.c                     | 43 ++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index cd65d236b43..6aa2a0bec19 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,3 +96,16 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
+
+fetch.credentialsInUrl::
+	A URL can contain plaintext credentials in the form
+	`protocol://<user>:<password>@domain/path`. Using such URLs is not
+	recommended as it exposes the password in multiple ways. The
+	`fetch.credentialsInUrl` option provides instruction for how Git
+	should react to seeing such a URL, with these values:
++
+* `ignore` (default): Git will proceed with its activity without warning.
+* `warn`: Git will write a warning message to `stderr` when parsing a URL
+  with a plaintext credential.
+* `die`: Git will write a failure message to `stderr` when parsing a URL
+  with a plaintext credential.
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 4a61f2c901e..34be520b783 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,6 +71,13 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
+test_expect_success 'clone warns or fails when using username:password' '
+	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt1 2>err &&
+	grep "warning: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err &&
+	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt2 2>err &&
+	grep "fatal: URL '\''https://username:\*\*\*\*\*\*\*\*@localhost/'\'' uses plaintext credentials" err
+'
+
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&
diff --git a/urlmatch.c b/urlmatch.c
index b615adc923a..6b91fb648a7 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "urlmatch.h"
+#include "config.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -106,6 +107,46 @@ static int match_host(const struct url_info *url_info,
 	return (!url_len && !pat_len);
 }
 
+static void detected_credentials_in_url(const char *url, size_t scheme_len)
+{
+	char *value = NULL;
+	const char *at_ptr;
+	const char *colon_ptr;
+	struct strbuf anonymized = STRBUF_INIT;
+
+	/* "ignore" is the default behavior. */
+	if (git_config_get_string("fetch.credentialsinurl", &value) ||
+	    !strcasecmp("ignore", value))
+		goto cleanup;
+
+	at_ptr = strchr(url, '@');
+	colon_ptr = strchr(url + scheme_len + 3, ':');
+
+	if (!colon_ptr)
+		BUG("failed to find colon in url '%s' with scheme_len %"PRIuMAX,
+		    url, (uintmax_t) scheme_len);
+
+	/* Include everything including the colon. */
+	colon_ptr++;
+	strbuf_add(&anonymized, url, colon_ptr - url);
+
+	while (colon_ptr < at_ptr) {
+		strbuf_addch(&anonymized, '*');
+		colon_ptr++;
+	}
+
+	strbuf_addstr(&anonymized, at_ptr);
+
+	if (!strcasecmp("warn", value))
+		warning(_("URL '%s' uses plaintext credentials"), anonymized.buf);
+	if (!strcasecmp("die", value))
+		die(_("URL '%s' uses plaintext credentials"), anonymized.buf);
+
+cleanup:
+	free(value);
+	strbuf_release(&anonymized);
+}
+
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
@@ -144,6 +185,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 	 */
 
 	size_t url_len = strlen(url);
+	const char *orig_url = url;
 	struct strbuf norm;
 	size_t spanned;
 	size_t scheme_len, user_off=0, user_len=0, passwd_off=0, passwd_len=0;
@@ -191,6 +233,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 			}
 			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
 			if (colon_ptr) {
+				detected_credentials_in_url(orig_url, scheme_len);
 				passwd_off = (colon_ptr + 1) - norm.buf;
 				passwd_len = norm.len - passwd_off;
 				user_len = (passwd_off - 1) - (scheme_len + 3);

base-commit: f9b95943b68b6b8ca5a6072f50a08411c6449b55
-- 
gitgitgadget
