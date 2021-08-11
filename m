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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A09C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D4060C40
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 04:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhHKE6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 00:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbhHKE6B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 00:58:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D10C061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id h11so2912493oie.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RxztbMBSydknvjo9KVqjccctAKEHcBiI11pEBFR2m4=;
        b=IftnNJ7YIN/k8KwR7BHcZFFR76Ul6sOWDbC5ECxSMFhCM4JmmygThQZxFwWcA402dk
         75xSUaLJ/xozofUAhlPs/capGTKJTCXrnfyChn/O1rrJPqsuKds+YBbBWws5OrUWFmLz
         TsG5N/t9LqEjSY9iWmuJAAPuGLf6PGxJmWM2HyGZQVxzNNt6ucL1HaO1fWt9QAPESsS+
         Fnq+4bIdBo25HDYQ8DHzeWWR7r7gclDyXYhzrB4HBAaV6AWNR8edLcxhhZ4D1jj7oK3s
         27cv687syr/ppV4m99JJwsllzW3zq8Y8LredwTO9pPUKlBehWYnIgliiweoSmCHMS1T5
         CO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RxztbMBSydknvjo9KVqjccctAKEHcBiI11pEBFR2m4=;
        b=b1IWFDmFuTfumBa7f4cBRUGfzLbvUJr+Flp8/ACIEUJIm+8JwGwXltYD0LkAzEh+U8
         vGq6+xJRWtNVB4g/ZGr0pKtTU48B3I8TS2xEpjetLSY9N/M5ohOr8/F2vapfiyyCoZOV
         XnUxZ1BPfruUthsaBHp8qGTaYoyffsolvd/CwJ0wd4G5bHKpqN8xEgrNYZhDX8YWSA9b
         zE5foVQ1tUDpT6ZtGzvM+IgRRp4f7oLwMlW/YZPwxMsBGIr9JL157qgb/gEyHZMS3a4z
         +R0HZDsGBzX95rixzDRyz5d6A+qE36tPT32HVS0ZEfs3bkZdhtiY/Gl0NQIah4MChhIl
         LIFQ==
X-Gm-Message-State: AOAM531/j1hYCPoQg9s1+SJvWC+SK8hQvwoXLnX8fNRC1zlYsvSNpxfe
        ceyjnlUt4yiK1N7J6wF9hoSIqjZIKblY+A==
X-Google-Smtp-Source: ABdhPJzIZCZkgbXRnEMbzhGQAPjVF2W1pOgusa8YMkIem/szJBBScIt3IoiSHwgrs/Xm6HFQ+4J+tA==
X-Received: by 2002:aca:2403:: with SMTP id n3mr8970637oic.109.1628657857246;
        Tue, 10 Aug 2021 21:57:37 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id n9sm4292281otn.54.2021.08.10.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 21:57:36 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Michael J Gruber <git@grubix.eu>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/7] unstage: add 'unstage' command
Date:   Tue, 10 Aug 2021 23:57:25 -0500
Message-Id: <20210811045727.2381-6-felipe.contreras@gmail.com>
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
 Documentation/git-unstage.txt | 25 +++++++++++++++++++++++++
 builtin.h                     |  1 +
 builtin/stage.c               | 15 +++++++++++++++
 git.c                         |  1 +
 t/t3710-stage.sh              |  7 +++++++
 5 files changed, 49 insertions(+)
 create mode 100644 Documentation/git-unstage.txt

diff --git a/Documentation/git-unstage.txt b/Documentation/git-unstage.txt
new file mode 100644
index 0000000000..cafc24cb36
--- /dev/null
+++ b/Documentation/git-unstage.txt
@@ -0,0 +1,25 @@
+git-unstage(1)
+==============
+
+NAME
+----
+git-unstage - Remove changes from the staging area
+
+
+SYNOPSIS
+--------
+[verse]
+'git unstage' [options] [--] [<paths>...]
+
+DESCRIPTION
+-----------
+
+Removes changes from the staging area. This is the same as `git reset`.
+
+SEE ALSO
+--------
+linkgit:git-reset[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/builtin.h b/builtin.h
index d08d803c4f..326f8af3e7 100644
--- a/builtin.h
+++ b/builtin.h
@@ -229,6 +229,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix);
 int cmd_tar_tree(int argc, const char **argv, const char *prefix);
 int cmd_unpack_file(int argc, const char **argv, const char *prefix);
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
+int cmd_unstage(int argc, const char **argv, const char *prefix);
 int cmd_update_index(int argc, const char **argv, const char *prefix);
 int cmd_update_ref(int argc, const char **argv, const char *prefix);
 int cmd_update_server_info(int argc, const char **argv, const char *prefix);
diff --git a/builtin/stage.c b/builtin/stage.c
index dee8781dc5..2d50b3c393 100644
--- a/builtin/stage.c
+++ b/builtin/stage.c
@@ -13,6 +13,11 @@ static const char *const stage_usage[] = {
 	NULL
 };
 
+static const char *const unstage_usage[] = {
+	N_("git unstage [options] [--] <paths>..."),
+	NULL
+};
+
 static int rerun(int argc, const char **argv, ...)
 {
 	int ret;
@@ -52,3 +57,13 @@ int cmd_stage(int argc, const char **argv, const char *prefix)
 
 	return rerun(argc, argv, "add", NULL);
 }
+
+int cmd_unstage(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = { OPT_END() };
+
+	argc = parse_options(argc, argv, prefix, options, unstage_usage,
+		PARSE_OPT_KEEP_UNKNOWN | PARSE_OPT_KEEP_DASHDASH);
+
+	return rerun(argc, argv, "reset", NULL);
+}
diff --git a/git.c b/git.c
index 3b92e60329..2d319cc15b 100644
--- a/git.c
+++ b/git.c
@@ -607,6 +607,7 @@ static struct cmd_struct commands[] = {
 	{ "switch", cmd_switch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
+	{ "unstage", cmd_unstage, RUN_SETUP | NEED_WORK_TREE },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
 	{ "unpack-objects", cmd_unpack_objects, RUN_SETUP | NO_PARSEOPT },
 	{ "update-index", cmd_update_index, RUN_SETUP },
diff --git a/t/t3710-stage.sh b/t/t3710-stage.sh
index 209f2bde9a..834eee66d5 100755
--- a/t/t3710-stage.sh
+++ b/t/t3710-stage.sh
@@ -28,4 +28,11 @@ test_expect_success 'remove' '
 	! in_stage bar
 '
 
+test_expect_success 'unstage' '
+	touch bar &&
+	git stage bar &&
+	git unstage bar &&
+	! in_stage bar
+'
+
 test_done
-- 
2.32.0.48.g096519100f

