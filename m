Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A733C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302C561165
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbhKFVNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhKFVNt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20691C061714
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d27so19542522wrb.6
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhxrf0TmybwKLhz0v7loHxJpXckYT1urNNigKVRPoNc=;
        b=FLr97JkCBFS/zodoSAT3uO45yHkl06u+coZCh5gQ+ScI5MY1efNWUDhI/4xUdPJ2a5
         NWpmwk6hq+2PUkOlMC2QXm2fK5QEBLPkIcpxDY943/9iUDWBNlEs7tENRkhLbVP99RWm
         3he/cCcDa2IoZgEbPO2vPuNG06HSvz1kdvC+l9Zb1OkDu8pQZVrIvXicE8Whvi3yv6Ea
         0Lq2qf9fdtM5JUUTB1oK4qlV3fGZDvi05TD6iRAhCEaZkxQJEGe06mAa9zlcCy5eFluP
         ZE0G5CnBG3t5VMSUkVkqnDOiKBYs3eh49oIfzgOskmkR6zsdstjNUSFInZi6DY5LYWHY
         yknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhxrf0TmybwKLhz0v7loHxJpXckYT1urNNigKVRPoNc=;
        b=uVX33Dc4GZKZ9SIQyqXKzFPiSiQSu55AJjHSWTvkvniRq3d7R9L9HmalBYq+aWDrBz
         hotnA5b0RH90PcjHCIMVsWqwPDIlUqRSGwhQBIWKyXp5MvzODni+KiwAnCqs0Z5bVpJe
         03D/mEjhFCOLN830njJKvV4+zAMkkbApYZqdBmaP7IdevtzuAW7HraA7oBwUN+3tagpN
         CCRNqpgDDRKMABe9tg7c+Wttbia2rdx0X9wxCqLhMdoPp5xHibNYaltuCkBgX5GYjWAR
         GqnO/b7PbWdRPl7ZvGmydmwx3UaHUaPr3o4w+vzXAEnjFtg2AhZET1sxpHvcAFCMFGMi
         ToZA==
X-Gm-Message-State: AOAM532dh62yzzGtxQdtOptpw8W81NKgXNjNwwPAbfOWkmLhW0lUdPEx
        K6XS9JEUo4i3PHC/vKYHrPBiSdp5QVnwaA==
X-Google-Smtp-Source: ABdhPJzBWMuX2InEqB7W4dTEYG4ew7uDSq+AZj3S3v79zv7expCwNwagzSNBR6yDb+hbEfRZmXvJzA==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr47121657wri.69.1636233066156;
        Sat, 06 Nov 2021 14:11:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] grep: make "extendedRegexp=true" the same as "patternType=extended"
Date:   Sat,  6 Nov 2021 22:10:54 +0100
Message-Id: <patch-8.8-dadd5dff77a-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
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
 Documentation/git-grep.txt    | 3 +--
 grep.c                        | 8 +++-----
 grep.h                        | 5 +----
 t/t7810-grep.sh               | 2 +-
 5 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 2669b1757d3..9868ea8a061 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -11,8 +11,7 @@ grep.patternType::
 	value 'default' will return to the default matching behavior.
 
 grep.extendedRegexp::
-	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set.
+	Deprecated synonym for 'grep.patternType=extended`.
 
 grep.threads::
 	Number of grep worker threads to use.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 078dfeadf50..211ba6801b0 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -347,8 +347,7 @@ grep.patternType::
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
index e4e548aed90..55b23d045e0 100644
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
@@ -191,7 +189,6 @@ struct grep_opt {
 		[GREP_COLOR_SELECTED] = "", \
 		[GREP_COLOR_SEP] = GIT_COLOR_CYAN, \
 	}, \
-	.only_matching = 0, \
 	.color = -1, \
 	.output = std_output, \
 }
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

