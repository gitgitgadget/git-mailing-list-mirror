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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FABC433E6
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256CF64DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 07:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhBPHNM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 02:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhBPHM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 02:12:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274FC0613D6
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id t29so5582410pfg.11
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 23:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4xHkRdQK9hus34IfJrurywHDuA3WyE3C32AHtBBmu+Y=;
        b=EIOXrcdXNXFUUypjUuvt0YS97T0ZUQUhibrDs8uoHv3CQKM5Lu+FeOwjxs1sE6MIEZ
         3cB1hP1cuWNmJNfpvAP5Is9vdejfFmigEKVuQgKLUR+BIazw+JTprKiuYxC7yxmO9d1U
         Ic+DUnVDjEFuwAP4JvSbPiQ9T34Cfr6JMxIzT/eRr06ze3IMnTPtioFKQRBqPYSE5MqA
         J1wQTcPcT5So8y8JJ0uZ6mQdGx26YqidIsdfnb6Nv2zjpg7XZUZPfHC7V2OFf9sR4Vd9
         y0SfbIJs1zQUi60x14vxR6r/rE2ZomNPaHkOE/3M+Kyqnk9aNcrJKgGAsmjStxbsrv45
         5lQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4xHkRdQK9hus34IfJrurywHDuA3WyE3C32AHtBBmu+Y=;
        b=G+64oJqHKUsbzrcMWuuYPuoZY8LscF/5zNR0PmI6IrcRIV979k1ICE95ADyQkTK51T
         n/07lrHblXWb7IRh195rgFUbC0qrkLqGMsC3s6OdOabAQ3dpw6ip8h58xo/Rn9h7nzGS
         VmTfv1MA4fI2xNig0H2Swx/1+ZXJgD4oEPcuc7g8nPMFgDVMTEpdPwzhZjAgZloqWLI3
         KVCUsJswYpRcagv2eCY/qULa4xP5km4iazNrA0xDHakS7Qt32xJxUPtsWNiUBU/viNVi
         YMwZBxOU8yY1wWSs/I+MCGNJn+6Z8N1VqofyQ1uMb45zQNHmOLo7Ck5hbQkHrqkIgM74
         d0Vg==
X-Gm-Message-State: AOAM532HNSzvlE9dbWt5WF+YK0YEHf18Qf7gnDHn6kV/FVgeeD/1XkLB
        23xaPFMyIzxje47kePxIBCFZQEAO1Zk=
X-Google-Smtp-Source: ABdhPJx3WTYLTt/mJyjKo/nVqn7eG0S71I0d3E0XoGGXUEB3LySdC+re4tqIdDgb7G7Bvv5eiJvlQg==
X-Received: by 2002:aa7:8110:0:b029:1d6:241b:d83e with SMTP id b16-20020aa781100000b02901d6241bd83emr18648083pfi.23.1613459536735;
        Mon, 15 Feb 2021 23:12:16 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id d133sm20025278pfd.6.2021.02.15.23.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 23:12:16 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/2] stash show: learn stash.showIncludeUntracked
Date:   Mon, 15 Feb 2021 23:11:57 -0800
Message-Id: <d19d07ec27d094175621eb400f74717c596c609d.1613459475.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1613459474.git.liu.denton@gmail.com>
References: <cover.1612855690.git.liu.denton@gmail.com> <cover.1613459474.git.liu.denton@gmail.com>
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
index 417ed2b4a1..c788a3e236 100644
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
@@ -868,6 +873,9 @@ static int show_stash(int argc, const char **argv, const char *prefix)
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

