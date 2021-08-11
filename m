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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D793EC432BE
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD3F260C40
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhHKE6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbhHKE6D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:58:03 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AAFC061798
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:39 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t128so2858794oig.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4+gcVRn0cHI+p6n/RurUG5QxeJqTeD6wcp6ayJQbRQ=;
        b=Zm0gjvCGhWO4Bu0KiEGMUIJzRpIToGEgyhC78U7TMaD2QuQOdVDGmBaYvW+TzUGzus
         MfGT83w2BhZcxETiBpUABq7ch1N0wGc4kECgcc7l8lQ/gGvbdB7A/5O/X0QMsnPvuqzN
         eeReahsnPIAomWk4ufDTeEtszLb+QwEkChaYdJyK1UWwzTmDTj3YrlDXHV3ataiudM6E
         eJMf6+zzVCb3bI7bD2BZkn6UwyEYK/OHrgICPSAIScVydZT8TQvGkpkuQDOYWWuH576o
         QPhdTbYTizkmYBcUeizRYFv4quhS9xo8gSO/vsowQSPahPpjfW68Nx6/81DiUUrgjcy4
         Ja1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4+gcVRn0cHI+p6n/RurUG5QxeJqTeD6wcp6ayJQbRQ=;
        b=EG8lFk2mompT3oRInXaTv7yidZoP63d+ojP4ylNwp1zEm9xsXuusrMQbPZiz884HkK
         7ulXzqhr4Sgm7oOFInqjBIRtzXknJI649XHPnd+BGIIKz3C8Ad+0m0fbOotXPn/a6caV
         KzuIaFte7K5wGmi8bNYOqkejO3j4abNqTWo2Q4gMiThsTV0I7T9h7aEEMaPjwr0s09kK
         y75HRcITE/HJcaDyGiOWeyLBshuqsLaZKFoY3THinRCOVFKj+i7lvDsjUpdomv+ZTGOg
         usAeM2p9fdtqszFsUX4BOHIOFgRyXkCYU6VzF+uvdqxWoIh60DKW81+xz2nVq8QY3uql
         59gw==
X-Gm-Message-State: AOAM532rEYOl4us4Gai4HgKgBvq3q3Ri8Dcob4x7Rq76Vktt4DMvfYsG
        NhuUZ8J0pNri/iwFDP92IPOMDL2o9hvalQ==
X-Google-Smtp-Source: ABdhPJwUaWqObfkONxiP9yeg6AgbH2zHtjbhdylqgyMfLXp3pIbYvnrr/wg9fz+6TUfJRms5AwRM2w==
X-Received: by 2002:aca:ac51:: with SMTP id v78mr357172oie.96.1628657859060;
        Tue, 10 Aug 2021 21:57:39 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id y138sm3662158oie.22.2021.08.10.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/7] stage: add 'diff' subcommand
Date:   Tue, 10 Aug 2021 23:57:26 -0500
Message-Id: <20210811045727.2381-7-felipe.contreras@gmail.com>
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
 Documentation/git-stage.txt | 5 +++++
 builtin/stage.c             | 6 +++++-
 t/t3710-stage.sh            | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index e2f83783b2..460a8d6228 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git stage' [options] [--] [<paths>...]
 'git stage' (-a | --add) [options] [--] [<paths>...]
 'git stage' (-r | --remove) [options] [--] [<paths>...]
+'git stage' (-d | --diff) [options] [--] [<paths>...]
 
 
 DESCRIPTION
@@ -32,11 +33,15 @@ OPTIONS
 --remove::
 	Remove changes from the staging area. See linkgit:git-reset[1].
 
+-d::
+--diff::
+	View the changes staged for the next commit. See linkgit:git-diff[1].
 
 SEE ALSO
 --------
 linkgit:git-add[1]
 linkgit:git-reset[1]
+linkgit:git-diff[1]
 
 GIT
 ---
diff --git a/builtin/stage.c b/builtin/stage.c
index 2d50b3c393..c57bb2d683 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -10,6 +10,7 @@ static const char *const stage_usage[] = {
 	N_("git stage [options] [--] <paths>..."),
 	N_("git stage --add [options] [--] <paths>..."),
 	N_("git stage --remove [options] [--] <paths>..."),
+	N_("git stage --diff [options] [<commit>] [--] <paths>..."),
 	NULL
 };
 
@@ -41,11 +42,12 @@ static int rerun(int argc, const char **argv, ...)
 
 int cmd_stage(int argc, const char **argv, const char *prefix)
 {
-	int add = 0, remove = 0;
+	int add = 0, remove = 0, diff = 0;
 
 	struct option options[] = {
 		OPT_BOOL_F('a', "add", &add, N_("add changes"), PARSE_OPT_NONEG),
 		OPT_BOOL_F('r', "remove", &remove, N_("remove changes"), PARSE_OPT_NONEG),
+		OPT_BOOL_F('d', "diff", &diff, N_("show changes"), PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -54,6 +56,8 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 
 	if (remove)
 		return rerun(argc, argv, "reset", NULL);
+	if (diff)
+		return rerun(argc, argv, "diff", "--staged", NULL);
 
 	return rerun(argc, argv, "add", NULL);
 }
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
index 834eee66d5..aab979c20c 100755
--- a/t/t3710-stage.sh
+++ b/t/t3710-stage.sh
@@ -35,4 +35,11 @@ test_expect_success 'unstage' '
 	! in_stage bar
 '
 
+test_expect_success 'diff' '
+	echo foo > foo &&
+	git stage --add foo &&
+	git stage --diff > out &&
+	test_file_not_empty out
+'
+
 test_done
-- 
2.32.0.48.g096519100f

