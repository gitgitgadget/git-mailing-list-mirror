Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244BCC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9D061207
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 01:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhKJBqy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 20:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhKJBqs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 20:46:48 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4A3C061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 17:44:01 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o8so4012300edc.3
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 17:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GHVpC2dlokfOuvR2KzJbRif1JbqDDdAra5IGKMFnbDw=;
        b=ANLvTU85O7kB+1YkRZ7FttuCNSqwOdUzPWRMd4ZC5rxylLVHEf6MmL28lGLOz4QJlz
         qtI0siJWgMZ78Ov6bv+pPwPK2NbmYqpQ1trOPkZzUVxOS2+0r6umi2h4spU64fl84Ksk
         DzaY/EDV8Io7rIqgHsMWwRKdeWO3O70z4vLkka5lupdZvkXz+GcVBs6vDkw7VrXtfYEq
         dhOge8WKKSrPhQz8Lmohy+3xrZeEKHL9mEvEM31LRDLBpfQeUP6njonFLGq/dC3BNUmT
         dCjWnhH3wRFHpLRfdwtbffqvpoNpy5f7a5fluXpOuWPFcrPaOolU4E135Y95P+mCgk+1
         wkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GHVpC2dlokfOuvR2KzJbRif1JbqDDdAra5IGKMFnbDw=;
        b=xCTMbargMEUVEtzkTHlxHgzUcoShX+DvupBAMRhkMofQiOLRmZVLZplRueydJheJfi
         s0OBJmPQCt8X3mN3mHBGcrop3HXw9cnsV5nq5dTcOHnBXQA+/WioYUW+HwT0dYK1gawG
         E8ibrVX2L4gCIlvL1JK0ORKzaA/hnegCP6VhBpRgXuAZ5nTFaFs3R9l7/UEbQihh9Eq1
         XD8zCgIeKPjugaGp4jGb94SHNVkmPjHTWJqkAnz+2D1eawgwWL62fsyPa5FdoOkooVUJ
         GGnSDfypmhnzTbAr77LvT6nsRjceoRThwSw01Nsq8PtfEIecYdmyCbcsOY4smwmQYURA
         6SeA==
X-Gm-Message-State: AOAM530YHqeDh8lGOX72kvrLWEJ8bzvtSnjLpapGB6f9vHYH+Qu4oUF4
        8p0TjR9ZSZphTgc6vQ+qT83md88qHe4I5g==
X-Google-Smtp-Source: ABdhPJx3BHB7XvsS4u/1hlY2rwFY4CssfVC+S0iB+r4XMayZWF1cUx9UAETneDJOqCNlSsSaxEJH9Q==
X-Received: by 2002:a17:906:15d0:: with SMTP id l16mr15692957ejd.462.1636508639990;
        Tue, 09 Nov 2021 17:43:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id qf8sm9369252ejc.8.2021.11.09.17.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:43:59 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/8] grep: make "extendedRegexp=true" the same as "patternType=extended"
Date:   Wed, 10 Nov 2021 02:43:50 +0100
Message-Id: <patch-v2-8.8-cc904d93b26-20211110T013632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.791.gdbfcf909579
In-Reply-To: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding commit we changed how a "grep.patternType=default"
set after "grep.extendedRegexp=true" would be handled so that the last
set would win, but a "grep.extendedRegexp=true" would only be used if
"grep.patternType" was set to a value other than "default".

Thus a user who had old config and set "grep.extendedRegexp=true" in
their ~/.gitconfig expecting ERE behavior would be opted-in to say
"perl" regexes if a system "/etc/gitconfig" started setting
"grep.patternType=perl".

These funny semantics of only paying attention to a set if another key
is not set to a given value aren't how we treat other config keys, so
let's do away with this caveat for consistency.

The new semantics are simple, a "grep.extendedRegexp=true" is an exact
synonym for specifying "grep.patternType=extended" in the
config. We'll keep ignoring ""grep.extendedRegexp=false", although
arguably we could treat it as a "grep.patternType=basic".

As argued in the preceding commit I think this behavior came about
because we were conflating the state of our code's own internal
"default" value with what we found in explicit user config. See
84befcd0a4a (grep: add a grep.patternType configuration setting,
2012-08-03) for that past behavior.

Let's further change the documentation to note that
"grep.extendedRegexp" is a deprecated synonym, perhaps we'll be able
to remove it at some point in the future and do away with this
special-case entirely.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/grep.txt | 3 +--
 grep.c                        | 8 +++-----
 grep.h                        | 4 +---
 t/t7810-grep.sh               | 2 +-
 4 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index f4b7d3041fb..33e5f3827bc 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -11,8 +11,7 @@ grep.patternType::
 	value 'default' will return to the default matching behavior.
 
 grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set.
+	Deprecated synonym for 'grep.patternType=extended`.
 
 grep.threads::
 	Number of grep worker threads to use. If unset (or set to 0), Git will
diff --git a/grep.c b/grep.c
index dda8e536fe3..ef8746d85f0 100644
--- a/grep.c
+++ b/grep.c
@@ -33,9 +33,8 @@ static const char *color_grep_slots[] = {
 
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
-	if (!strcmp(arg, "default"))
-		return GREP_PATTERN_TYPE_UNSPECIFIED;
-	else if (!strcmp(arg, "basic"))
+	if (!strcmp(arg, "basic") ||
+	    !strcmp(arg, "default"))
 		return GREP_PATTERN_TYPE_BRE;
 	else if (!strcmp(arg, "extended"))
 		return GREP_PATTERN_TYPE_ERE;
@@ -60,8 +59,7 @@ int grep_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED &&
-	    !strcmp(var, "grep.extendedregexp") &&
+	if (!strcmp(var, "grep.extendedregexp") &&
 	    git_config_bool(var, value)) {
 		opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
 		return 0;
diff --git a/grep.h b/grep.h
index e4e548aed90..8ef70d125ff 100644
--- a/grep.h
+++ b/grep.h
@@ -94,8 +94,7 @@ enum grep_expr_node {
 };
 
 enum grep_pattern_type {
-	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
-	GREP_PATTERN_TYPE_BRE,
+	GREP_PATTERN_TYPE_BRE = 0,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
 	GREP_PATTERN_TYPE_PCRE
@@ -179,7 +178,6 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
 		[GREP_COLOR_FILENAME] = "", \
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a59a9726357..afca938a4d0 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -461,7 +461,7 @@ do
 	'
 
 	test_expect_success "grep $L with grep.patternType=basic and grep.extendedRegexp=true" '
-		echo "${HC}ab:a+bc" >expected &&
+		echo "${HC}ab:abc" >expected &&
 		git \
 			-c grep.patternType=basic \
 			-c grep.extendedRegexp=true \
-- 
2.34.0.rc1.741.gab7bfd97031

