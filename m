Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD6C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 17:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFF2207A1
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 17:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhABRk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 12:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhABRk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 12:40:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344E2C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 09:40:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c124so13361654wma.5
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 09:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=eJ/owh4HzDI2vNcSUqtu+/lqeKKXItlXp1kNLkJwGxk=;
        b=iGTxbZGLcf7XeM7jUSokv04IfOAiUrjB5G6tNRgCQKVdf6wwjXtFOoieK7FxGMCygB
         s95s7mZAHg29FdDYD16o7NfoXhjB0XNEmsDIksfva9d7KrFGPN1W2nOd9IY9ecFXpuk6
         uYOrUdDjFNMzeO19UxYwJWiHgBJ2zf3LVCzR3B5Nm49UqHYFQUssfok+ov0ryG78YZ11
         /4ri5tMHTKthPA2xYrnT6wLcD3/pooBvz6kLpwmor3i37kwjtgthK0Vaep5lYytGeBsu
         8CNsJuhOF1wHWYYlegCX9dF79DMV0QbiUEHXDyGkCIWTeo7RiztiNQQSH0JMYd6heu/D
         kehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eJ/owh4HzDI2vNcSUqtu+/lqeKKXItlXp1kNLkJwGxk=;
        b=mk2bo22WSBnt9t2QwLzq9+ZUJd5HDB9Nyz99YJUR54sZxly4ZllCqpSJWn34WZL6Ra
         RRQMwuc2HgpdtKYNiPNM1JqQY9CsX4iS4EGgS/6Z+MLOWCpUL1TzuopGyWZ6T/etzKxo
         +6JOKL4c13JbvYIl8ALKppXLONVPg1I/5udwO1MDpMM3Tgfm7KMk7gaM+1weRXEik6xc
         Iu7r2VSEqutTbSN20Y9VhzjTuO5XDKOhpaZwjwixA1u/CSC8o2My8hZJ4YQJBh4oMsCk
         uWOyGbcWjL38BRoh1Amq/TR7c/X1DnZPqGb7jduS80xxojWhZlZlkp9HCJri9xbQj0BH
         JMfg==
X-Gm-Message-State: AOAM532Bj5rUfuawNlZ6o1+lbvbcfYcG5VRNXxMkA7HqrbneaqaiV60X
        DSkXlkfjhjCi6+SIpWg52QjaiwdV1ls=
X-Google-Smtp-Source: ABdhPJxAuyFmZFd/Rw/XAiV/fOSNKEaBft0okNog14sPaNNpjjxrL6tXHUEvJSW/olwG1q+9zuKfSg==
X-Received: by 2002:a1c:65d4:: with SMTP id z203mr20257019wmb.65.1609609215409;
        Sat, 02 Jan 2021 09:40:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8sm79812497wrm.17.2021.01.02.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 09:40:14 -0800 (PST)
Message-Id: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 02 Jan 2021 17:40:13 +0000
Subject: [PATCH] doc: fix some typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
    doc: fix some typos
    
    Signed-off-by: Thomas Ackermann th.acker@arcor.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-831%2Ftacker66%2Ffix_some_typos-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-831/tacker66/fix_some_typos-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/831

 Documentation/config/http.txt        | 4 ++--
 Documentation/config/trace2.txt      | 2 +-
 Documentation/git-maintenance.txt    | 2 +-
 Documentation/git-p4.txt             | 2 +-
 Documentation/githooks.txt           | 2 +-
 Documentation/technical/reftable.txt | 2 +-
 contrib/buildsystems/CMakeLists.txt  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 3968fbb697a..7003661c0db 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -42,12 +42,12 @@ http.proxySSLKey::
 http.proxySSLCertPasswordProtected::
 	Enable Git's password prompt for the proxy SSL certificate.  Otherwise OpenSSL
 	will prompt the user, possibly many times, if the certificate or private key
-	is encrypted. Can be overriden by the `GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED`
+	is encrypted. Can be overridden by the `GIT_PROXY_SSL_CERT_PASSWORD_PROTECTED`
 	environment variable.
 
 http.proxySSLCAInfo::
 	Pathname to the file containing the certificate bundle that should be used to
-	verify the proxy with when using an HTTPS proxy. Can be overriden by the
+	verify the proxy with when using an HTTPS proxy. Can be overridden by the
 	`GIT_PROXY_SSL_CAINFO` environment variable.
 
 http.emptyAuth::
diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
index 01d3afd8a8b..fe1642f0d40 100644
--- a/Documentation/config/trace2.txt
+++ b/Documentation/config/trace2.txt
@@ -54,7 +54,7 @@ trace2.envVars::
 	`GIT_HTTP_USER_AGENT,GIT_CONFIG` would cause the trace2 output to
 	contain events listing the overrides for HTTP user agent and the
 	location of the Git configuration file (assuming any are set).  May be
-	overriden by the `GIT_TRACE2_ENV_VARS` environment variable.  Unset by
+	overridden by the `GIT_TRACE2_ENV_VARS` environment variable.  Unset by
 	default.
 
 trace2.destinationDebug::
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index d1f9b5172df..6fe1e5e1055 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -38,7 +38,7 @@ register::
 	for running in the background without disrupting foreground
 	processes.
 +
-The `register` subcomand will also set the `maintenance.strategy` config
+The `register` subcommand will also set the `maintenance.strategy` config
 value to `incremental`, if this value is not previously set. The
 `incremental` strategy uses the following schedule for each maintenance
 task:
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index ec233ac0c1c..f89e68b424c 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -397,7 +397,7 @@ changelist text. Exiting with a non-zero status from the script
 will abort the process.
 
 The purpose of the hook is to edit the message file in place,
-and it is not supressed by the `--no-verify` option. This hook
+and it is not suppressed by the `--no-verify` option. This hook
 is called even if `--prepare-p4-only` is set.
 
 p4-changelist
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ffccfc77608..1f3b57d04db 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -644,7 +644,7 @@ changelist text. Exiting with a non-zero status from the script
 will abort the process.
 
 The purpose of the hook is to edit the message file in place,
-and it is not supressed by the `--no-verify` option. This hook
+and it is not suppressed by the `--no-verify` option. This hook
 is called even if `--prepare-p4-only` is set.
 
 Run `git-p4 submit --help` for details.
diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 2951840e9c9..8095ab2590c 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -446,7 +446,7 @@ especially if readers will not use the object name to ref mapping.
 Object blocks use unique, abbreviated 2-32 object name keys, mapping to
 ref blocks containing references pointing to that object directly, or as
 the peeled value of an annotated tag. Like ref blocks, object blocks use
-the file's standard block size. The abbrevation length is available in
+the file's standard block size. The abbreviation length is available in
 the footer as `obj_id_len`.
 
 To save space in small files, object blocks may be omitted if the ref
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index c151dd7257f..8f77baa678f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -442,7 +442,7 @@ endif()
 check_c_source_compiles("
 #include <regex.h>
 #ifndef REG_STARTEND
-#error oops we dont have it
+#error oops we don't have it
 #endif
 
 int main(void)

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
