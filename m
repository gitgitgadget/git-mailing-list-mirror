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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF4CC4320A
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307A960EB9
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhHKE6B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhHKE56 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:57:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033E4C061799
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:35 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so1959859otu.5
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRc80Wly3gkGEC9v0m5UQMTUEmsXTxaF8hBoUEHlKv0=;
        b=kco9555504aYS+wKG6jSNK/+KvwmdmdwGMOT7CCqUBOMGsDYJqk52Huwy5bxOprnNs
         ZiT/A+GFKWQU49a9cOZ9kHyw/hCOV4awbPGLbNKOdIPZFIvuHbmVOHWjFABy8eSm4r8w
         LbzURHnL92rd1HKTAIt6OmuGtdLG4PHtInYV7tDSuk1LqoEeyeCoWeP3+uKDSU1YuRcV
         PrdYKVd/P6hPZJ9bHY5thtvoE7aShaGcSkEDJGAZYzk5fMq7yg31aRZY2SAdDn7tIhMq
         knq1K/xlA4lnnGtv09atWHvPSYBEWZJ4euc/wVOjU7VQsaOj5fYnNOQ24YmjUCHmLx9g
         o5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRc80Wly3gkGEC9v0m5UQMTUEmsXTxaF8hBoUEHlKv0=;
        b=VuNYa7EA0JbpUAqhRdAUYJmAFGH5jtYLMg+YoQLOsBtRbHDyAPvwHLUHG+Vm7er5F0
         bUy26MpQin/dvte75JCbVzt2H0jHCzJ+85o7QSDm7EAwHAVK/OKaKjfW6zf7k5YCAbs9
         4Xi71MjsMkkV3yp6v/dzv5/ta6xAuO4Ps3AoBLFTVQ1Nq4SFaxSGliqh8bc2sOIabi5x
         BCTCNFEnY2EsQDImOEn3YXg4ZaUPR/s5ovO5y0kEom7n9urI7MJ9/XkMp0lUWUTnelwl
         OsxMOcZ9v2v3hrZb3jUYhpcQQ+2uuSXBnXW8s7EINg7wsqJfC8CHt6Tbs7CVvHcHA0kc
         iTxA==
X-Gm-Message-State: AOAM530YRuZs95pIYssDLd+6vlygOm8QEI4Zw6RikXAkTX8jEVwBVwJN
        doXX/wyFkrcfMHc69Srnv2wh24sQP7AOqQ==
X-Google-Smtp-Source: ABdhPJxJozaO9P96PXPm+e3iwZxdMwOj6Cjzwf6FB38LWYeODbJNWpncJ8C4LysdUiQK4EiskFyyMQ==
X-Received: by 2002:a05:6830:151:: with SMTP id j17mr10767480otp.327.1628657854102;
        Tue, 10 Aug 2021 21:57:34 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id j18sm291555ots.10.2021.08.10.21.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:33 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/7] stage: add 'add' subcommand
Date:   Tue, 10 Aug 2021 23:57:23 -0500
Message-Id: <20210811045727.2381-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.48.g096519100f
In-Reply-To: <20210811045727.2381-1-felipe.contreras@gmail.com>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-stage.txt            | 15 ++++++++++++---
 builtin/stage.c                        |  4 ++++
 contrib/completion/git-completion.bash |  5 +++++
 t/t3710-stage.sh                       |  6 ++++++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 3f7b036901..348d7d1d92 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -3,21 +3,30 @@ git-stage(1)
 
 NAME
 ----
-git-stage - Add file contents to the staging area
+git-stage - Manage the staging area
 
 
 SYNOPSIS
 --------
 [verse]
 'git stage' [options] [--] [<paths>...]
+'git stage' (-a | --add) [options] [--] [<paths>...]
 
 
 DESCRIPTION
 -----------
 
-The staging area is a location where changes are stored in preparation for a commit.
+This command is useful to manage the staging area which is a location where
+changes are stored in preparation for a commit.
+
+Without arguments it's a synonym for linkgit:git-add[1].
+
+OPTIONS
+-------
+-a::
+--add::
+	Add changes to the staging area. See linkgit:git-add[1].
 
-This is a synonym for linkgit:git-add[1].
 
 SEE ALSO
 --------
diff --git a/builtin/stage.c b/builtin/stage.c
index 49016b0d5f..5a80bbc76c 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -8,6 +8,7 @@
 
 static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
+	N_("git stage --add [options] [--] <paths>..."),
 	NULL
 };
 
@@ -34,7 +35,10 @@ static int rerun(int argc, const char **argv, ...)
 
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
+	int add = 0;
+
 	struct option options[] = {
+		OPT_BOOL_F('a', "add", &add, N_("add changes"), PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..8656c47f39 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2376,6 +2376,11 @@ _git_send_email ()
 
 _git_stage ()
 {
+	if [[ "$cur" == --* ]]; then
+		__gitcomp_builtin stage
+		return
+	fi
+
 	_git_add
 }
 
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
index 2bf59905ca..225c6dd739 100755
--- a/t/t3710-stage.sh
+++ b/t/t3710-stage.sh
@@ -17,4 +17,10 @@ test_expect_success 'basic' '
 	in_stage foo
 '
 
+test_expect_success 'add' '
+	touch bar &&
+	git stage --add bar &&
+	in_stage bar
+'
+
 test_done
-- 
2.32.0.48.g096519100f

