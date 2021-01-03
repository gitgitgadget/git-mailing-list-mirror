Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A3DC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 14:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0422078D
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 14:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhACO0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 09:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhACO0e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 09:26:34 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC786C0613C1
        for <git@vger.kernel.org>; Sun,  3 Jan 2021 06:25:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n16so6576377wmc.0
        for <git@vger.kernel.org>; Sun, 03 Jan 2021 06:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jmv7hGBKzWH4coldVdUPyXBJSFmJiziXvd0OotCltlU=;
        b=gkuvWjFvQM2ODccnoxa+H2daZ5yrjaA0coR4sNiQcz7IgHhWTc2mZAzGsTEj1XZOzz
         KAUjjD4KO0hPVbrI6leZKFiPVUs92uf4QN5POPWwRYiF+rZthDYEvZfLRY/eDRpWfOG7
         0x+NhfJfRqWjjr5iiu8JunyqinBGveLVUdpiLn2AxPSZI7isW15tO+/tO2RLt5RfBo4b
         e6+TdmAnMNNJqH9GDvq1IPhe/DBIVw/xq9h7LvJheGfF4B+X1mssPaHr/AukJIJZGzYo
         zNNJKRuqjxDHwOjuXkqokYTJobSAGIyQYy58qkXb0ZRmhKsCjtoMBYpjJcxO+Byz3CVw
         S9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jmv7hGBKzWH4coldVdUPyXBJSFmJiziXvd0OotCltlU=;
        b=sdsyIwnfjHqU5bbei0U3nJvcFVdJlMBDex+YV0xwxfJoh1NAp8w/FNA57wrjcE1NOp
         +9GulamfWA2j0RnN6KxhbwBOeAwNnJR9mopnwji3w0oKGl13w+dNynosfHZVI06Xx6+0
         PGeEW10QiVYALcMM189Pwnz1wTiNpDWHscWK6+A390YUrxsfSSWyUUIZ5d4wNfa/nKFd
         tWezTyY7RqoCnV6Kx0arya1t+YtCe6exfv2Nu85gDlgFk85waX1Fh0iUaHuvExsSnlgC
         7doyeFdk0VYHbGd03xvhdgo+zc52ZPI6uszsKdIZl4jpvT/2J4IvOpGSN2Iz7sfSlfnP
         hPhA==
X-Gm-Message-State: AOAM532eco/iVPBBQMbpUMb5Kz//3Jx+busNYE8+iUHoWF21iCI/49or
        mNlLg/jMj3TjjWNEY7ybu6IhW7ed5nw=
X-Google-Smtp-Source: ABdhPJxIDNTlXqPsPekcnV1TGR/b/Wum9xepPHG+PJnErPhKQp63xGuMaSb+jR0+aRDWzzkIl+LiIQ==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr22746465wmc.40.1609683952314;
        Sun, 03 Jan 2021 06:25:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h83sm29652581wmf.9.2021.01.03.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 06:25:51 -0800 (PST)
Message-Id: <pull.831.v2.git.1609683950823.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
References: <pull.831.git.1609609214040.gitgitgadget@gmail.com>
From:   "Thomas Ackermann via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 03 Jan 2021 14:25:50 +0000
Subject: [PATCH v2] doc: fix some typos
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Thomas Ackermann <th.acker@arcor.de>,
        Thomas Ackermann <th.acker@arcor.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Thomas Ackermann <th.acker@arcor.de>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
    doc: fix some typos
    
    Changed since v1:
    
     * Removed changes in non-doc file contrib/buildsystems/CMakeLists.txt
       from the patch. Thanks to Martin and Felipe for pointing this out.
    
    Signed-off-by: Thomas Ackermann th.acker@arcor.de

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-831%2Ftacker66%2Ffix_some_typos-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-831/tacker66/fix_some_typos-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/831

Range-diff vs v1:

 1:  7016f417044 ! 1:  67e26552cb6 doc: fix some typos
     @@ Documentation/technical/reftable.txt: especially if readers will not use the obj
       the footer as `obj_id_len`.
       
       To save space in small files, object blocks may be omitted if the ref
     -
     - ## contrib/buildsystems/CMakeLists.txt ##
     -@@ contrib/buildsystems/CMakeLists.txt: endif()
     - check_c_source_compiles("
     - #include <regex.h>
     - #ifndef REG_STARTEND
     --#error oops we dont have it
     -+#error oops we don't have it
     - #endif
     - 
     - int main(void)


 Documentation/config/http.txt        | 4 ++--
 Documentation/config/trace2.txt      | 2 +-
 Documentation/git-maintenance.txt    | 2 +-
 Documentation/git-p4.txt             | 2 +-
 Documentation/githooks.txt           | 2 +-
 Documentation/technical/reftable.txt | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

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

base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
-- 
gitgitgadget
