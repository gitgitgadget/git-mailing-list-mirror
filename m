Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5AFECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiHaXPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbiHaXPL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC396205FB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u17so858258wrp.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P3z2thcGVWYUQbMKsW9j3j+BCZPoI5S6eUNvyNy2kBc=;
        b=hjUP7qKBXWnvdmuVUeq+6Mtf8uHKnkhLbeSU81gDGTwISiJWIb+YgtARAMFPGbBY/6
         hgd9RHOqrxVN+BkXjH1AB08VOPp6o9syY0RkDbCW8lvIi5/i7tDpobO3vVo78g6yv9el
         YUtTBo8y98/FZY9fRuaqjY4Qiwg6R2mIwansRiGnWevDt4+nA+OGLENa1N9jWvLHYz0Q
         cAUQ7TLcb+0EWqxN9ysUrN2IHfoGhBBPfyUJsWyx4IEXovA6DZIsMbe1a+ldB7/4alTO
         pz9qGfi2aXSmo7/K/JuHp46wkklRpMzu3MmEA0o9uh/lHh9ZnMZVAeKenClQwRMqXRgp
         2guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P3z2thcGVWYUQbMKsW9j3j+BCZPoI5S6eUNvyNy2kBc=;
        b=N7l4beZfo+bcnTskyddR0621umezVS6q0nNIBDAinstUlIUYJtVBD8aaEDo2dUfWEc
         R/Hbner5dnMWOceE4VzlO4zcslG7oO5YhSKVwVaHmE5oUyycA9i3UoC5C/5fmLhS7FKs
         N9Au2cplcSbEte5ZxVVp7HjkqI6cCxqzAl6zT7QmaLnML5jxJlYw9dEyjgzSdxbv1h4B
         ru8GfkCIGFA6LAf1yKZE8gHlxEctKibtbuwkqsSN3gIfsKHAJCNgKur4MdDyBDvXlZOc
         KhVjC3F2NGYwvsOpl8PdFCD8Sq3x3c62cWR8KlJdmMc374+6jCY4iOAA8tZ3zJHAW5bk
         uM6Q==
X-Gm-Message-State: ACgBeo0S9AXhxS8R94QWqZW5yfD1iWkqAIbJG1rY9h/D6MLTXuA/gvSB
        F5qBgLyzP6krSJkbUbN/ttWK6nvBUSfj/A==
X-Google-Smtp-Source: AA6agR78rWWfFRl4XC/B5ppP4E9qpLyVML8LsgJs6r8Drks54v3MzT9aYSLv+GYXgh9g0MEtU8DKBg==
X-Received: by 2002:adf:dbc1:0:b0:224:fc61:fef7 with SMTP id e1-20020adfdbc1000000b00224fc61fef7mr13001613wrj.312.1661987696035;
        Wed, 31 Aug 2022 16:14:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 12/17] submodule--helper: fix obscure leak in module_add()
Date:   Thu,  1 Sep 2022 01:14:19 +0200
Message-Id: <patch-v7-12.17-b8654647601-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an obscure leak in module_add(), if the "git add" command we were
piping to failed we'd fail to strbuf_release(&sb). This fixes a leak
introduced in a6226fd772b (submodule--helper: convert the bulk of
cmd_add() to C, 2021-08-10).

In fixing it move to a "goto cleanup" pattern, and since we need to
introduce a "ret" variable to do that let's also get rid of the
intermediate "exit_code" variable. The initialization to "-1" in
a6226fd772b has always been redundant, we'd only use the "exit_code"
value after assigning the return value of pipe_command() to it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 170eaf010ac..675dc3f16a3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3296,6 +3296,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
@@ -3345,21 +3347,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	die_on_repo_without_commits(add_data.sm_path);
 
 	if (!force) {
-		int exit_code = -1;
-		struct strbuf sb = STRBUF_INIT;
 		struct child_process cp = CHILD_PROCESS_INIT;
 
 		cp.git_cmd = 1;
 		cp.no_stdout = 1;
 		strvec_pushl(&cp.args, "add", "--dry-run", "--ignore-missing",
 			     "--no-warn-embedded-repo", add_data.sm_path, NULL);
-		if ((exit_code = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
+		if ((ret = pipe_command(&cp, NULL, 0, NULL, 0, &sb, 0))) {
 			strbuf_complete_line(&sb);
 			fputs(sb.buf, stderr);
-			free(add_data.sm_path);
-			return exit_code;
+			goto cleanup;
 		}
-		strbuf_release(&sb);
 	}
 
 	if(!add_data.sm_name)
@@ -3374,15 +3372,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	add_data.progress = !!progress;
 	add_data.dissociate = !!dissociate;
 
-	if (add_submodule(&add_data)) {
-		free(add_data.sm_path);
-		return 1;
-	}
+	if (add_submodule(&add_data))
+		goto cleanup;
 	configure_added_submodule(&add_data);
+
+	ret = 0;
+cleanup:
 	free(add_data.sm_path);
 	free(to_free);
+	strbuf_release(&sb);
 
-	return 0;
+	return ret;
 }
 
 #define SUPPORT_SUPER_PREFIX (1<<0)
-- 
2.37.3.1420.g76f8a3d556c

