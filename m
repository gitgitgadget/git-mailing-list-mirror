Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD7EC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiCQSK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237191AbiCQSKV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E0138588
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so7100015wrh.10
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DFr3eM+/XMAxCx4FYp6g0nid7x1TAE+PlzbP76MxV4=;
        b=gGEiRhXMp/+y1khAQjlX0Z0+1wIUoDHuNMby6yxt+MHUzf8NUsgt+CAgG0b8GjdGKc
         /c/2RnfGI0vf/Q3XjCrcO+XG7SRd66TbN8WmlDwtV6i+fmf9CUEI0zxUxxemToQTQwRE
         k4+uXujJTncX2v2wj/mCTT39VFVofU7SAhwjCx7hwW2mrP59TOI05vTUYmuhZMgtUY1o
         p0DHOHLg8vkaZ4BJ1zznpfveqs0PT/hMaD/JbA+sG1gws9SWUG9CIEGRU7HqHdikOBGi
         T0WDQK4BmwOskVpXewszaXaoguee7nPMs2idTJIq4qelCzl8dKUs9vTqj3POQKiUHYMh
         Ri5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DFr3eM+/XMAxCx4FYp6g0nid7x1TAE+PlzbP76MxV4=;
        b=oapdNyk+u9F/K+aN6L/XcwB8UtN8VUmzmMl4hUlIGNZtGU7PcZ58gcP8cvEG2NFies
         60llsWdLSKWzDxuUkQWheVg7lrhxvxFtSUrb4tAn0lvfmSlqMY5AYimT+4rqHOvZqenI
         P11pjToiFDyPSwU9MXEMb8TSmhJbXahWj+iGFXFJvuq0c9igl6BLh1MKrIvf1NQjK63a
         UCW+xYvQR2z4PfjfeaE6kHV2QO5ZLB13En4V1IKIaJxuRgQzdZhov5g2GYlqAWDMGGZJ
         ocIfBcE16lF1XnYthxqXQ5zoUK/XcT4Zm8K5glB5i6Zj3UYMYyULebITPWhLFv69mtWv
         WQiw==
X-Gm-Message-State: AOAM532vscXA9rW2orPxL6CmhErQXeOAIh32v//1X+aq1Iabo6C8hAOX
        bne4FOJ6zhYXuRLEld8xcTkyPqRU1z6SQA==
X-Google-Smtp-Source: ABdhPJwv5gDBfSOsG6MpbeXKD4J8/BWy/9IVISRCF3Hj56rXwFqq/5S6Th5yjruXvW5gWVhxW/4pZQ==
X-Received: by 2002:a05:6000:144b:b0:1fe:ac08:7038 with SMTP id v11-20020a056000144b00b001feac087038mr5028797wrx.318.1647540541436;
        Thu, 17 Mar 2022 11:09:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:09:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 8/8] reflog [show]: display sensible -h output
Date:   Thu, 17 Mar 2022 19:08:40 +0100
Message-Id: <patch-8.8-618e975f8b2-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "git reflog show -h" output to show the usage summary
relevant to it, rather than displaying the same output that "git log
-h" would show.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c  | 25 +++++++++++++++++++++++--
 t/t1410-reflog.sh |  5 +++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3971921fc14..aaf65ed31c6 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -5,6 +5,9 @@
 #include "worktree.h"
 #include "reflog.h"
 
+#define BUILTIN_REFLOG_SHOW_USAGE \
+	N_("git reflog [show] [<log-options>] [<ref>]")
+
 #define BUILTIN_REFLOG_EXPIRE_USAGE \
 	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
 	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
@@ -17,6 +20,11 @@
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
 
+static const char *const reflog_show_usage[] = {
+	BUILTIN_REFLOG_SHOW_USAGE,
+	NULL,
+};
+
 static const char *const reflog_expire_usage[] = {
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	NULL
@@ -33,7 +41,7 @@ static const char *const reflog_exists_usage[] = {
 };
 
 static const char *const reflog_usage[] = {
-	N_("git reflog [show] [<log-options>] [<ref>]"),
+	BUILTIN_REFLOG_SHOW_USAGE,
 	BUILTIN_REFLOG_EXPIRE_USAGE,
 	BUILTIN_REFLOG_DELETE_USAGE,
 	BUILTIN_REFLOG_EXISTS_USAGE,
@@ -207,6 +215,19 @@ static int expire_total_callback(const struct option *opt,
 	return 0;
 }
 
+static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	parse_options(argc, argv, prefix, options, reflog_show_usage,
+		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
+		      PARSE_OPT_KEEP_UNKNOWN);
+
+	return cmd_log_reflog(argc - 1, argv + 1, prefix);
+}
+
 static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 {
 	struct cmd_reflog_expire_cb cmd = { 0 };
@@ -404,7 +425,7 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		goto log_reflog;
 
 	if (!strcmp(argv[1], "show"))
-		return cmd_log_reflog(argc - 1, argv + 1, prefix);
+		return cmd_reflog_show(argc, argv, prefix);
 	else if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
 	else if (!strcmp(argv[1], "delete"))
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 0dc36d842b0..3f469353ec7 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -111,6 +111,11 @@ test_expect_success 'correct usage on sub-command -h' '
 	grep "git reflog expire" err
 '
 
+test_expect_success 'correct usage on "git reflog show -h"' '
+	test_expect_code 129 git reflog show -h >err &&
+	grep -F "git reflog [show]" err
+'
+
 test_expect_success 'pass through -- to sub-command' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.35.1.1384.g7d2906948a1

