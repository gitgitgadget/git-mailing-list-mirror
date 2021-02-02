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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C52C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB0664EDC
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBBJi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhBBJgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831BC0613ED
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:35 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w14so13961455pfi.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kqwdb8r6AYGlkBimMW+sv/XZ+sfF5CnrUqX2tByesZw=;
        b=Z8kDvKMCBIdzsZGyBdtSeLe/zri1ZD2MtpwNktdqDEILJyrkklxZSEHMq+A4Iy91YK
         dr2IJrGcsIhHWfCiUYCQf2rHFstWcUIW0oxnWOOXGBUWW5FzqxadZYOX80lVRbopjsAt
         aRBORfrt4EyYKITI7NOn3a/9HRZA/6TCNN4UQ2JphWs8jrvJE0DsUblE2HjNvQZdl8MW
         w+JEpukuqgTn99TjSzTeeqG1lCz+VjZrA3ybMjPaCUhejB+MG9OLtpcmhhIg9eTBaBjF
         LXwf/CmOAqHvYq0DRIft26sSz3hit6AFKl9kmhS8wyE38GFftXmVXrvhKWTSY14XBhUh
         MhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqwdb8r6AYGlkBimMW+sv/XZ+sfF5CnrUqX2tByesZw=;
        b=IMJGtmIO8URZ4E5BI9cPP78yo8lr9CSocABOSGnHbe9rysUZyrN17iQyM3p9NxEGjh
         5MTrYXialpAkDVvDzp/MVIa2MlRqRscPhdwSDSs3whUyPqQ81j+4+A6NyYLPmbhdvZU6
         0VmKfuz7BcqxIf6JieXBohOHBMzzimU8Nv1srAt6ZX+2Bzce9LESR2L5XT/WmJN38Avm
         2w8smOpMOxT601DVyE673Ja804t7JTJDaNW4roxFYVgCor54zQJfFmEDhtkvAxslxCoG
         oJQ1Cl+1T7CZtscNsBb4F4nd2Zc2SAcM4bxuIJ7ukZN8GOOT3R7y9S7Igu41QkdTuGTQ
         whGw==
X-Gm-Message-State: AOAM533MDO8K/VUyoUUgF8Gf+LmRk9m9M46KRnXjZ+in45xdXlP9+sUx
        6naK1Xh0JyXeqJVnzD1pJOfQQ3+7CqY=
X-Google-Smtp-Source: ABdhPJyxT6oJII7D3c+kDv4x+D50DW8QbwVIVsdEqrNGrCbqPNwtYhiEEza8NYqMGrQb42JL3+9gJg==
X-Received: by 2002:a05:6a00:15d2:b029:1b7:30c1:8495 with SMTP id o18-20020a056a0015d2b02901b730c18495mr20100355pfu.32.1612258474904;
        Tue, 02 Feb 2021 01:34:34 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.29
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:30 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 9/9] stash show: learn stash.showIncludeUntracked
Date:   Tue,  2 Feb 2021 01:33:26 -0800
Message-Id: <2c5d5d9dd47f1c6ba49312204d155d404d5fdc4f.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
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
index a9956e5c51..e18c1deb97 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -91,8 +91,8 @@ show [-u|--include-untracked|--only-untracked] [<diff options>] [<stash>]::
 	By default, the command shows the diffstat, but it will accept any
 	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
-	You can use stash.showStat and/or stash.showPatch config variables
-	to change the default behavior.
+	You can use stash.showIncludeUntracked, stash.showStat, and
+	stash.showPatch config variables to change the default behavior.
 
 pop [--index] [-q|--quiet] [<stash>]::
 
diff --git a/builtin/stash.c b/builtin/stash.c
index 7a8770676b..784fb518be 100644
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
@@ -842,6 +847,9 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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

