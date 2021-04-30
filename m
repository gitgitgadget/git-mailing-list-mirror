Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC48C433ED
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF38C613E8
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhD3SiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhD3SiR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 14:38:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6A0C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 11:37:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so2160799wmi.5
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=+diVeRmbSMWB19XpfNjCeQ+19IHQ6bykuYLQI3gwqHM=;
        b=cmDsX/+FXDNVx23fn6JJGTVo0WJwFNcRXrMATx2lZEXGuBy+fothP/cEjk3FTG3jCH
         lXGFjgrVvTED2UkRJTAZjFhWeUgWWubs5KPfFXusRQgCiOmVzi5hG2iROnmEa080CG7r
         GmauT7R6GwLCLHzsF73zBAYobdaMqf5dxzGgBanQHMxUhDYpAnB9BJPv9rCXj5csa/Hp
         Bv937yM4oYLiNczT2NSNfm/KTyY1WiLsq1m8dc8WKpAttiQOz7AfYKU9EYwtI5PbMr43
         5BGaEDNfQySeU9TthdoWC0pOsZas/hpO4W/Uu6/lW1hXlLcaCjxoDEn+E7QNqWKyd1ly
         u+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+diVeRmbSMWB19XpfNjCeQ+19IHQ6bykuYLQI3gwqHM=;
        b=DGy1aT9Q7aLsGIbTB2vd6hgcmA8Mdz/sidoRoQJfADWwIPhJcoYciLJmhQ6z6Wciuk
         OMyKA55MeklwCahvQJj56ZomXmui0nre2VKErJNS+8OvqYzCzchxl3YyBRk5p6sxrcYE
         rtWq5OoGrhPxdwATvFnstGae1ngFOiDMCJ+/KVbIBj8k9CFxUVSOQQa/R8eVl/IT9L9K
         taoI5jo3DFAm/5aLEc7qqxMEj1i2FAePqGELPvkfL6TtaDs3QOfmP3ELu08poGOM+8xd
         oo29myVBIZpuG7Fp2GGeZE/2NtCrIXakdhn0N7Y7s0wyBs3s0If8DC3+vtdOg5h9nBId
         ylVA==
X-Gm-Message-State: AOAM530vGYRnlR/uKCkz9lTgW5Fr6RGS0qlsA1S6BeL/aLnCZPwdlrpC
        I9PR7pW3TrF84l0BAlhE02Iam284UJU=
X-Google-Smtp-Source: ABdhPJxhdWhYUQSvVN1MmBgVdCxPZmdXtOM8dz81dz4b8F3d3ZovujmcV4U6B/ST7Fm3dh8bp9BePA==
X-Received: by 2002:a05:600c:4998:: with SMTP id h24mr16352971wmp.10.1619807846030;
        Fri, 30 Apr 2021 11:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17sm3196751wmq.47.2021.04.30.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 11:37:25 -0700 (PDT)
Message-Id: <pull.945.git.1619807844627.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 30 Apr 2021 18:37:24 +0000
Subject: [PATCH] urlmatch: do not allow passwords in URLs by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Git allows URLs of the following pattern:

  https://username:password@domain/route

These URLs are then parsed to pull out the username and password for use
when authenticating with the URL. Git is careful to anonymize the URL in
status messages with transport_anonymize_url(), but it stores the URL as
plaintext in the .git/config file. The password may leak in other ways.

This is not a recommended way to store credentials, especially
authentication tokens that do more than simply allow access to a
repository.

Users should be aware that when they provide a URL in this form that
they are not being incredibly secure. It is much better to use a
credential manager to securely store passwords. Even better, some
credential managers use more sophisticated authentication strategies
including multi-factor authentication. This does not stop users from
continuing to do this.

Some Git hosting providers are working to completely drop
username/password credential strategies, which will make URLs of this
form stop working. However, that requires certain changes to credential
managers that need to be released and sufficiently adopted before making
such a server-side change.

In the meantime, it might be helpful to alert users that they are doing
something insecure with these URLs.

Create a new config option, core.allowUsernamePasswordUrls, which is
disabled by default. If Git attempts to parse a password from a URL in
this form, it will die() if this config is not enabled. This affects a
few test scripts, but enabling the config in those places is relatively
simple.

This will cause a significant change in behavior for users who rely upon
this username:password pattern. The error message describes the config
that they must enable to continue working with these URLs. This has a
significant chance of breaking some automated workflows that use URLs in
this fashion, but even those workflows would be better off using a
different mechanism for credentials.

I cannot understate the care in which we should consider this change.
The impact of this change in a Git release could be significant. We
should advertise this very clearly in the release notes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
    Reject passwords in URLs
    
    I received multiple messages "alerting" me to the issue of users
    supplying server-side tokens into the username:password field of a URL.
    This is not a secure way to handle these tokens.
    
    On the one hand, this is user error: Users should not supply a token to
    a location where they do not know what will happen to it. In Git's
    defense, its behavior is completely open about storing the URL in the
    .git/config file as a plain-text string and users should know that when
    using this feature.
    
    However, users just. keep. doing it.
    
    There is some expectation that since this portion of the URL is a
    password, then Git is responsible for tracking that password securely.
    I'm not sure we should venture down that road, since we already have a
    pretty good solution by using the credential helper interface.
    
    Here is my best effort to find a compromise here: start failing when
    parsing a password from a URL like this, with a config option to
    re-enable the existing behavior.
    
    I completely understand if this is too much of a breaking change. I
    wonder if there is anything we can do to assist users into being more
    careful with their secrets.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-945%2Fderrickstolee%2Freject-passwords-in-urls-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-945/derrickstolee/reject-passwords-in-urls-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/945

 Documentation/config/core.txt     |  7 +++++++
 t/t0110-urlmatch-normalization.sh |  4 ++++
 t/t5541-http-push-smart.sh        |  9 +++++++--
 t/t5550-http-fetch-dumb.sh        |  3 ++-
 t/t5601-clone.sh                  |  5 +++++
 urlmatch.c                        | 14 ++++++++++++++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c04f62a54a15..807dc30e7321 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -628,3 +628,10 @@ core.abbrev::
 	If set to "no", no abbreviation is made and the object names
 	are shown in their full length.
 	The minimum length is 4.
+
+core.allowUsernamePasswordUrls::
+	If enabled, allow parsing URLs that contain plain-text usernames
+	and passwords using `username:password@<url>` text. Defaults to
+	`false`, and will cause Git to fail when parsing such a URL.
+	*WARNING:* Storing passwords and tokens in plaintext is insecure
+	and should be avoided if at all possible.
diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index f99529d83853..66352775497a 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -6,6 +6,10 @@ test_description='urlmatch URL normalization'
 # The base name of the test url files
 tu="$TEST_DIRECTORY/t0110/url"
 
+test_expect_success 'enable username:password urls' '
+	git config --global core.allowUsernamePasswordUrls true
+'
+
 # Note that only file: URLs should be allowed without a host
 
 test_expect_success 'url scheme' '
diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index c024fa281831..3ffc367bae43 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -460,6 +460,7 @@ test_expect_success GPG 'push with post-receive to inspect certificate' '
 
 test_expect_success 'push status output scrubs password' '
 	cd "$ROOT_PATH/test_repo_clone" &&
+	git config core.allowUsernamePasswordUrls true &&
 	git push --porcelain \
 		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
 		+HEAD:scrub >status &&
@@ -469,9 +470,11 @@ test_expect_success 'push status output scrubs password' '
 
 test_expect_success 'clone/fetch scrubs password from reflogs' '
 	cd "$ROOT_PATH" &&
-	git clone "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
+	git -c core.allowUsernamePasswordUrls=true clone \
+		"$HTTPD_URL_USER_PASS/smart/test_repo.git" \
 		reflog-test &&
 	cd reflog-test &&
+	git config core.allowUsernamePasswordUrls true &&
 	test_commit prepare-for-force-fetch &&
 	git switch -c away &&
 	git fetch "$HTTPD_URL_USER_PASS/smart/test_repo.git" \
@@ -484,8 +487,10 @@ test_expect_success 'clone/fetch scrubs password from reflogs' '
 
 test_expect_success 'Non-ASCII branch name can be used with --force-with-lease' '
 	cd "$ROOT_PATH" &&
-	git clone "$HTTPD_URL_USER_PASS/smart/test_repo.git" non-ascii &&
+	git -c core.allowUsernamePasswordUrls=true clone \
+		"$HTTPD_URL_USER_PASS/smart/test_repo.git" non-ascii &&
 	cd non-ascii &&
+	git config core.allowUsernamePasswordUrls true &&
 	git checkout -b rama-de-árbol &&
 	test_commit F &&
 	git push --force-with-lease origin rama-de-árbol &&
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d9142afc3b2..342538e85e60 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -81,7 +81,8 @@ test_expect_success 'cloning password-protected repository can fail' '
 
 test_expect_success 'http auth can use user/pass in URL' '
 	set_askpass wrong &&
-	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
+	git -c core.allowUsernamePasswordUrls=true clone \
+		"$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
 	expect_askpass none
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 329ae599fd3c..fd7cabbafa53 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -71,6 +71,11 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 '
 
+test_expect_success 'clone fails when using username:password' '
+	test_must_fail git clone https://username:password@bogus.url 2>err &&
+	test_i18ngrep "attempted to parse a URL with a plain-text username and password" err
+'
+
 test_expect_success 'clone from hooks' '
 
 	test_create_repo r0 &&
diff --git a/urlmatch.c b/urlmatch.c
index 33a2ccd306b6..e81ec9e1fc0b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "urlmatch.h"
+#include "config.h"
 
 #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
 #define URL_DIGIT "0123456789"
@@ -106,6 +107,18 @@ static int match_host(const struct url_info *url_info,
 	return (!url_len && !pat_len);
 }
 
+static void die_if_username_password_not_allowed(void)
+{
+	int opt_in = 0;
+	if (!git_config_get_bool("core.allowusernamepasswordurls", &opt_in) &&
+	    opt_in)
+		return;
+
+	die(_("attempted to parse a URL with a plain-text username and password! "
+	      "This is insecure! "
+	      "Enable core.allowUsernamePasswordUrls to avoid this error"));
+}
+
 static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
 {
 	/*
@@ -191,6 +204,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 			}
 			colon_ptr = strchr(norm.buf + scheme_len + 3, ':');
 			if (colon_ptr) {
+				die_if_username_password_not_allowed();
 				passwd_off = (colon_ptr + 1) - norm.buf;
 				passwd_len = norm.len - passwd_off;
 				user_len = (passwd_off - 1) - (scheme_len + 3);

base-commit: 7e391989789db82983665667013a46eabc6fc570
-- 
gitgitgadget
