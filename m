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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA67C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42BF64EB8
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhBIHcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhBIHaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:39 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C3C0617A9
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:21 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id g3so9270484plp.2
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLiWm6iDaHdSP2hf/1tCnjQIYyR9mFiDO5xDNC6TE7w=;
        b=MmBZ/rg+l2oO4TCyLVRXcjteY+20qRinMZhpoNiNHNlDg6uw9x61iLqppT19UMgq2x
         XUu+RHiKBlarPxxOQjxw/esQI0Nf/lmUD578uVrDwuTWG490tae5q+lOa8DB8X+eKrLb
         W5Jkq80Hqp0WEJtn9OQsjq2LbSBHcxc2VLCNhK4UjZm14lnMS9VMIjwMHrXk27mZTqes
         4n7ur56OIitCoLYGis48S7T9b6fRUIbiR8AqPuBOF0oE0f11x1IZgqyoGegbqsLADHke
         UoIk9FycBo1J52YA2diefoc6pfhA2RxVEDZ2+WtSu0c5BK8aJ09K3HR89Xc2SOvVHe7T
         BbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLiWm6iDaHdSP2hf/1tCnjQIYyR9mFiDO5xDNC6TE7w=;
        b=bSzpty4+UdK0B+IEkYGxvJaPO1NCo8fNsfBODeRMCBqkK9WwrAGBYbPN5L7lEBUmnZ
         ccmR0ecBz6/gyhERtDtTIQ3z95DNULIwqao4e3tjbOmFhM2/QQq4sOzDpba+QloBKfHd
         uf72h+ddfmpZGVXHJvlM/+BMFFNt56QXtodn+uRZKWm4qk1K/52XFhDSwBPyiy6jkZjI
         Vv+BLu+ZQZ7paPxR5/ecZLjkLF5efeOqqDIzIz/obmvOxqCqlI5UPscVy9UeJ6W98KWg
         Z9Hrm2GsvbQ9I3JhC1RppYrD0tv0K5ol2jxsWAMsyeIOEJiggjeIoNI2KOWXj5XDcG/A
         EyCw==
X-Gm-Message-State: AOAM532uxiI9pOFcRZLS3K+QNMFVrDcuN+0uieFlQJUGUgYLHS5LOUNm
        w8TEwlbtnQzq/TkCkaP2oDiT8e3icGc=
X-Google-Smtp-Source: ABdhPJxjFkvqjGn7LjGrLC52JwUHnP8AdNKWxCrXJYH55ctW4v+p4jWaAWWqxYPeyv/QjypP4Qz1TQ==
X-Received: by 2002:a17:902:7c98:b029:e1:8840:8abd with SMTP id y24-20020a1709027c98b02900e188408abdmr19430799pll.12.1612855761183;
        Mon, 08 Feb 2021 23:29:21 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:20 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 9/9] stash show: learn stash.showIncludeUntracked
Date:   Mon,  8 Feb 2021 23:28:55 -0800
Message-Id: <ac4019f47e389b6c9d02f49734361d52cc640a05.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
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
index 9d4b9f0b5c..d004e9abdb 100644
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
index f7220fad56..53428e9e64 100644
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
@@ -886,6 +891,9 @@ static int show_stash(int argc, const char **argv, const char *prefix)
 		if (show_patch)
 			rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
+		if (show_include_untracked)
+			show_untracked = UNTRACKED_INCLUDE;
+
 		if (!show_stat && !show_patch) {
 			free_stash_info(&info);
 			return 0;
diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
index 978bc97baf..8bcd4c5ca8 100755
--- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -318,6 +318,8 @@ test_expect_success 'stash show --include-untracked shows untracked files' '
 	test_cmp expect actual &&
 	git stash show --only-untracked --include-untracked >actual &&
 	test_cmp expect actual &&
+	git -c stash.showIncludeUntracked=true stash show >actual &&
+	test_cmp expect actual &&
 
 	cat >expect <<-EOF &&
 	diff --git a/tracked b/tracked
-- 
2.30.0.478.g8a0d178c01

