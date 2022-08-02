Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25450C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237111AbiHBPzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiHBPzG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:55:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89322C663
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z17so13750251wrq.4
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WuGtDV3aipUEWtW+BToP1XxnP0TZD/9lgpFpxZCAVhg=;
        b=W0vAKyp333FnvEN9aXVteV9m9Pqzc/WNdOMXe+xJBgAgvdhfLlzdXyH4xi2f5sD4J9
         4rFMOvJqHoOYxf5mPh85xUPgZiZQejYoz29rO0WfaDIyfCLKacmkIzm2DK4E0rqarujs
         ZlZQbUMB8w8QzCtHjCThgX9kHryQqTzzfnRQlyojw/OQrJVCHJpWPDWTanx4u76e47Dg
         fW741lZZtmxFd0LhpllTlNFeXg4emeF9TITaPc8xq+VvmjlZYfRyQktJ77mXSkJrjVai
         izW4oDwQxe5wKXVGtunQ/H4tffB+FH+SVZVch83gpcWgrpY7kjCK2MmOlW5M9ZS2MwXR
         +NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WuGtDV3aipUEWtW+BToP1XxnP0TZD/9lgpFpxZCAVhg=;
        b=XQWiiYw0i5lXv98/UX5dgVdFn1PInxZEcWbncUnxq/HwYMhJDZzT/owVirktXG36eB
         fnPUGWx34URvgm2UDuGV6wtCsEG3lqsW3tsNamX/chYGROOfMmBi6cvx3bjVkoZ9Folb
         BCq1ranBEcL/1QX9Vkh/Wj1W3zI0KPumkke+4veHZwEG/npOSK8BLR2qXIV4A1tfruWw
         2+gnuIwpqFkYrF5VvQItnzdscMS6g/bP4QmiiDnZxNg1i4W0yNULz1/PJTPwp7iFpj5g
         srqwzvXFmLGsgZdlG7+KO5cvWVSFG7F53WlUo1rpBJb6LNZYaHWxBkUEILilhp1GDXoT
         LqYA==
X-Gm-Message-State: ACgBeo2hRDMSjJZk0HIpi5hl59EcpK2NYN+XAio4NWDdxNmAXW3Y1fZV
        UszwxYw2ZSfW9Uov1Y85dZZTO7jVMlKKdA==
X-Google-Smtp-Source: AA6agR5fFKiYkP4U+P9iDHWsShKKBNcB1vxlJLbhzd07u5iDO0Wp+bfabMhi1DSR48/LQOikQAXX5Q==
X-Received: by 2002:a5d:4802:0:b0:21e:c78b:30b5 with SMTP id l2-20020a5d4802000000b0021ec78b30b5mr12881986wrq.203.1659455697020;
        Tue, 02 Aug 2022 08:54:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:56 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 12/17] submodule--helper: fix obscure leak in module_add()
Date:   Tue,  2 Aug 2022 17:54:36 +0200
Message-Id: <patch-v5-12.17-e74c396073b-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
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
index a5b0b3859c5..9cc92b4da9e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3284,6 +3284,8 @@ static int module_add(int argc, const char **argv, const char *prefix)
 		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 1;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
@@ -3333,21 +3335,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
@@ -3362,15 +3360,17 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
2.37.1.1233.ge8b09efaedc

