Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022CC2BAEE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC920719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="i8KbFbgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgCXGLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:11:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38079 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgCXGLa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:11:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so18194132qke.5
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SaVuKuO7gfN6WfAzt9SMOLO+UJO1qr67FxdnoxNW53Y=;
        b=i8KbFbgYB6oy40AMJUfl2xfe/JN2MaRJaUAjwNFJuixxMZAJwzYPwcXLTVFjFyv7QD
         bfj6cWlRbZh0y9n+WZJJ7aq1u/r3z4zaJ5FaFkzdzfWvxWAbK7ZkJIKgulSrhSL2Lw8D
         lft52RbI4VvNdFUlKSZCCsACSZFT2aMr1ZnJsF8yMn1hEL2+wPycJVnuJz3n2fPl4JI+
         TrT3IUSXNGkgyaLt51gTcRLzhrcxSlNO8aJI02AMaCemiVDB+LLitgdD0nBvitzEm3WA
         llxqb3r6h++xOrfg9jYzyWNgfhCab5ih+kk82xi6DqVP5ZiDOd7cA451CuNozz43QbQW
         KFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SaVuKuO7gfN6WfAzt9SMOLO+UJO1qr67FxdnoxNW53Y=;
        b=F89p99W8YPqggrCixtQx40ShLIM4rRgc/mU5Zx/l2fVzklIL3oSsJKF/KqiHnoLrBP
         Fjuowc4P10hY72yEP9Og1Ku+GhfLmC1pjXk89izh90qfMCadIMjnXY0D6cktab0DZU6Z
         3Chx3Q1CCC8/7thmPDiXZmjU0DHxR4GZmTZJC7eilxsfetXVP61HmW3DjW5jsya4WvMJ
         xIupi+akbj7zSRExnu6+fnx0AkDt9ClDQzzPoEk8mcpYx6NVhBcEEv/XrLfB6CllqCyd
         srp6niezhtG2FNAD+N4fKgoheZ1ktGyDTtmmG1qC7NEmh4SH/s/H4uHQ0apGqkRJSqCC
         jP8Q==
X-Gm-Message-State: ANhLgQ20CeczvdJ63gXdczrEUw+Lg7s4akv+LIuHsrijc4c5iiQjkBKy
        /FxSrGJ0UgQGZ4WvEWkztgemOOQ3Isk=
X-Google-Smtp-Source: ADFU+vv4QZrdpUVpdVyuU1Oehf/XdnTWZtxLBYQESyB0RbJS0Z+WAC3mDZ2cy5c23wqKaltm5uzJjw==
X-Received: by 2002:a37:4c0a:: with SMTP id z10mr25085758qka.408.1585030288584;
        Mon, 23 Mar 2020 23:11:28 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id m10sm13669164qte.71.2020.03.23.23.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:11:27 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, newren@gmail.com,
        sandals@crustytoothpaste.net
Subject: [RFC PATCH 1/3] doc: grep: unify info on configuration variables
Date:   Tue, 24 Mar 2020 03:11:20 -0300
Message-Id: <7ba5caf10de75a2e0909318b04c62f5827a3fa56.1585027716.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585027716.git.matheus.bernardino@usp.br>
References: <cover.1585027716.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Explanations about the configuration variables for git-grep are
duplicated in "Documentation/git-grep.txt" and
"Documentation/config/grep.txt". Let's unify the information in the
second file and include it in the first.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/config/grep.txt |  7 +++++--
 Documentation/git-grep.txt    | 35 +++++------------------------------
 2 files changed, 10 insertions(+), 32 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7c..76689771aa 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -16,8 +16,11 @@ grep.extendedRegexp::
 	other than 'default'.
 
 grep.threads::
-	Number of grep worker threads to use.
-	See `grep.threads` in linkgit:git-grep[1] for more information.
+	Number of grep worker threads to use. See `--threads` in
+	linkgit:git-grep[1] for more information.
+
+grep.fullName::
+	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
 	If set to true, fall back to git grep --no-index if git grep
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ddb6acc025..97e25d7b1b 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -41,34 +41,7 @@ characters.  An empty string as search expression matches all lines.
 CONFIGURATION
 -------------
 
-grep.lineNumber::
-	If set to true, enable `-n` option by default.
-
-grep.column::
-	If set to true, enable the `--column` option by default.
-
-grep.patternType::
-	Set the default matching behavior. Using a value of 'basic', 'extended',
-	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
-	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
-
-grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
-
-grep.threads::
-	Number of grep worker threads to use. If unset (or set to 0), Git will
-	use as many threads as the number of logical cores available.
-
-grep.fullName::
-	If set to true, enable `--full-name` option by default.
-
-grep.fallbackToNoIndex::
-	If set to true, fall back to git grep --no-index if git grep
-	is executed outside of a git repository.  Defaults to false.
-
+include::config/grep.txt[]
 
 OPTIONS
 -------
@@ -267,8 +240,10 @@ providing this option will cause it to die.
 	found.
 
 --threads <num>::
-	Number of grep worker threads to use.
-	See `grep.threads` in 'CONFIGURATION' for more information.
+	Number of grep worker threads to use. If not provided (or set to
+	0), Git will use as many worker threads as the number of logical
+	cores available. The default value can also be set with the
+	`grep.threads` configuration (see linkgit:git-config[1]).
 
 -f <file>::
 	Read patterns from <file>, one per line.
-- 
2.25.1

