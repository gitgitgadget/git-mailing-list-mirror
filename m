Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A3AC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E59264E12
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239069AbhCDAWw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhCCL3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 06:29:31 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1982C06178C
        for <git@vger.kernel.org>; Wed,  3 Mar 2021 03:16:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t9so3937325pjl.5
        for <git@vger.kernel.org>; Wed, 03 Mar 2021 03:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfMShd3SzFQGBIIhGdfN0qRFTjbAIiKVq2tPnPt8dKc=;
        b=nJveudr5WuEBzn+5PXrrMACD1NdTwm3GCS8+ah2C/UE4yyipnznXYTj/fjBUGBeqKL
         QuNWDdXOxJAQpdGVw59n2cYy6tOon0JZWejq4CZGeAaqw5ppHtcGiEns5aQb6neCUKVg
         iisWhTD52AhDyriqHPZ1KHuQQPz/5rPS+61iVQEcE829VsL6oHphdbik9iXg6iomkemd
         wqVJGRp+CmN0xXy+qZ3K2f+h6td47hSMZvtRyqi5vcYGnMfolMqXXCC33EnA1ufkbNHF
         wte6hwLmN4dU3ibBglrrprkLou6hU2oJubEuIzCvf2os+RyYEGnY3+wd05ClJ8Ph0Hr5
         ufKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfMShd3SzFQGBIIhGdfN0qRFTjbAIiKVq2tPnPt8dKc=;
        b=R1KGKBX65VYHIU5JHoBp+0QU1C/N+f4Q3fypC5M0nuEJ2WA8fwJFyWCaqdlv4O/LYg
         Jw3iPEPGr7S6C4AJMCj5UNwpfdTBGbN0/+km7PLTu6Qqw5If4ngm1fHHIm5QocwQD77/
         2puwRJH8Xj+W2WUCXBTxyB4SqKbRCPO0KVf86kX52JP4xpgqJzSCYQoCurvH65wWqz+q
         SKY5c4zjNwEj7Xe6LlMkDD7nLBb2IUZbN75WBkA/sqT00bu8hO6+V+U/HN3TkHrW6KYb
         tu3xZbNs9mgfNvLqA6VAL5B3Ch97MjUy4Ml9jbvIRGXi7tD1PFwimBRYgNhuyAFVIoj4
         WnYA==
X-Gm-Message-State: AOAM533yppbvL2YlxdxcadhEC5nTHSGmxuGxr5AkI9iM06wiyjg63wDH
        g+KUvLoCNyGA7+og1SshwwG2ZdnnSMc=
X-Google-Smtp-Source: ABdhPJzQ0fCUs5AF/BSWIqjPQYvH2RL/O7aTDpSbQynNYg8KWVAOZz0iUjUtVJLzOh2Wrn7HaTZ3Pw==
X-Received: by 2002:a17:90b:1090:: with SMTP id gj16mr2298886pjb.57.1614770215983;
        Wed, 03 Mar 2021 03:16:55 -0800 (PST)
Received: from archbookpro.localdomain ([172.92.165.181])
        by smtp.gmail.com with ESMTPSA id d7sm13978175pfh.73.2021.03.03.03.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 03:16:55 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/2] stash show: learn stash.showIncludeUntracked
Date:   Wed,  3 Mar 2021 03:16:43 -0800
Message-Id: <3480086f1dc3d3dc290ff80563b83bd5378fe33e.1614770171.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.228.gb75b4e4ce2
In-Reply-To: <cover.1614770171.git.liu.denton@gmail.com>
References: <cover.1613459474.git.liu.denton@gmail.com> <cover.1614770171.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit teaches `git stash show --include-untracked`. It
may be desirable for a user to be able to always enable the
--include-untracked behavior. Teach the stash.showIncludeUntracked
config option which allows users to do this in a similar manner to
stash.showPatch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/stash.txt     | 5 +++++
 Documentation/git-stash.txt        | 4 ++--
 builtin/stash.c                    | 8 ++++++++
 t/t3905-stash-include-untracked.sh | 2 ++
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/stash.txt b/Documentation/config/stash.txt
index 00eb35434e..413f907cba 100644
--- a/Documentation/config/stash.txt
+++ b/Documentation/config/stash.txt
@@ -5,6 +5,11 @@ stash.useBuiltin::
 	is always used. Setting this will emit a warning, to alert any
 	remaining users that setting this now does nothing.
 
+stash.showIncludeUntracked::
+	If this is set to true, the `git stash show` command without an
+	option will show the untracked files of a stash entry.  Defaults to
+	false. See description of 'show' command in linkgit:git-stash[1].
+
 stash.showPatch::
 	If this is set to true, the `git stash show` command without an
 	option will show the stash entry in patch form.  Defaults to false.
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 8eeb60feb1..a8c8c32f1e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -91,8 +91,8 @@ show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
-	You can use stash.showStat and/or stash.showPatch config variables
-	to change the default behavior.
+	You can use stash.showIncludeUntracked, stash.showStat, and
+	stash.showPatch config variables to change the default behavior.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 9b7a541cd0..8922a1240c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -768,6 +768,7 @@ static int list_stash(int argc, const char **argv, const char *prefix)
 
 static int show_stat = 1;
 static int show_patch;
+static int show_include_untracked;
 static int use_legacy_stash;
 
 static int git_stash_config(const char *var, const char *value, void *cb)
@@ -780,6 +781,10 @@ static int git_stash_config(const char *var, const char *value, void *cb)
 		show_patch = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "stash.showincludeuntracked")) {
+		show_include_untracked = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "stash.usebuiltin")) {
 		use_legacy_stash = !git_config_bool(var, value);
 		return 0;
@@ -869,6 +874,9 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		if (show_patch)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
+		if (show_include_untracked)
+			show_untracked = UNTRACKED_INCLUDE;
+
 		if (!show_stat && !show_patch) {
 			free_stash_info(&info);
 			return 0;
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 08ceef6411..b470db7ef7 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -319,6 +319,8 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	test_cmp expect actual &&
 	git stash show --only-untracked --include-untracked >actual &&
 	test_cmp expect actual &&
+	git -c stash.showIncludeUntracked=true stash show >actual &&
+	test_cmp expect actual &&
 
 	cat >expect <<-EOF &&
 	diff --git a/tracked b/tracked
-- 
2.31.0.rc1.228.gb75b4e4ce2

