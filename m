Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36BFC43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345854AbiFJCCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiFJCBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:01:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC52C5E66
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:01:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k16so34649771wrg.7
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAbyg0JbTlrDxmih6UvEBUcaeXgJS0dGfj5b2o6l0Rk=;
        b=gspviPmUuB4vDQyH3B/DJ2z7CovsfP7nLTmDT6EmhDgQcPbGNI/hSrnLxyEuW9saZU
         j3y1gXJN+/qIO/mfjfaiWjHAxEZ233BcLIp1KNFPuPdzfv+JtZz7hnx8EhUcSFEgwPSS
         IcGefLXSW2hnA3RVWSvmgR6Voj3h8uaeFZeL2EVGtDC9u/MR0RlQbfE/Vrrmu5m+wQJF
         J5A3C6TK9p31eWu/5dtn9JIAgmyblDYBygV+XlGlXTDNB0luFbAdW+NSlmjj6l0MmDfw
         6g5HW7z+mdYzu3FaMSvJ8fIhLkL6/hSJc6l4YIpuC3UZLhj6foE3DbFtTMCEorrdWjiV
         X2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAbyg0JbTlrDxmih6UvEBUcaeXgJS0dGfj5b2o6l0Rk=;
        b=HOtEIr/L1sEoH4WoCFxtu1tiyYArIFfdM3Q1wbwQL1PWAszY/IoS6TwXeCcq5D+OCd
         IP28al7d2fWj9ECrPtpTZ3PtqiVk4eR80YcgaoSq3KRCfQ6v6sDN2nXVNTzCyudC2cbz
         9ajSb2+Z84Cf1zKEcsks/oPNZGbLwv40kokm99JG7GMNQde0gvJnxOVrJPBudG8KmNAe
         TroZpZNL/3w/ioZc47T2M58K68y5wBqFjc9aCF9VxczF2NcDPRJKAB8LSROPAVQ7gknu
         IPQAwPKEx7d+Lnb5ua6O/ZkOusKGNHs8ckUpSFl/DC0Fkzaom8uUj3ArU/L9TCTpZj/b
         nQ8g==
X-Gm-Message-State: AOAM530LKaSguGhPmt/InuYnnnGR+G7MkGRDxyjBNrpLEGlQ54Wd8GZ1
        LaUTuwTqvOV2DisdSooKYyY9NRMGgHV37w==
X-Google-Smtp-Source: ABdhPJyjnzKe6xZXC/gARRO7w1Hsx2+mf+ERdG6/I8LVsY141jXyoeqcN8BM7/dXMZjNhErpZtxG8Q==
X-Received: by 2002:adf:dc87:0:b0:216:cfca:65d with SMTP id r7-20020adfdc87000000b00216cfca065dmr29455441wrj.316.1654826506881;
        Thu, 09 Jun 2022 19:01:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 03/20] git-submodule.sh: remove unused --super-prefix logic
Date:   Fri, 10 Jun 2022 04:01:15 +0200
Message-Id: <RFC-patch-03.20-6c774505ac5-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "$prefix" variable has not been set since b3c5f5cb048 (submodule:
move core cmd_update() logic to C, 2022-03-15), so we'd never pass the
--super-prefix option to "git submodule--helper", and can therefore
remove the handling of it from builtin/submodule--helper.c as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 53 +++++++++++++++----------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c6c2ba1b6dc..70693205764 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3364,35 +3364,32 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-#define SUPPORT_SUPER_PREFIX (1<<0)
-
 struct cmd_struct {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
-	unsigned option;
 };
 
 static struct cmd_struct commands[] = {
-	{"list", module_list, 0},
-	{"name", module_name, 0},
-	{"clone", module_clone, 0},
-	{"add", module_add, SUPPORT_SUPER_PREFIX},
-	{"update", module_update, 0},
-	{"resolve-relative-url-test", resolve_relative_url_test, 0},
-	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
-	{"init", module_init, SUPPORT_SUPER_PREFIX},
-	{"status", module_status, SUPPORT_SUPER_PREFIX},
-	{"sync", module_sync, SUPPORT_SUPER_PREFIX},
-	{"deinit", module_deinit, 0},
-	{"summary", module_summary, SUPPORT_SUPER_PREFIX},
-	{"push-check", push_check, 0},
-	{"absorb-git-dirs", absorb_git_dirs, SUPPORT_SUPER_PREFIX},
-	{"is-active", is_active, 0},
-	{"check-name", check_name, 0},
-	{"config", module_config, 0},
-	{"set-url", module_set_url, 0},
-	{"set-branch", module_set_branch, 0},
-	{"create-branch", module_create_branch, 0},
+	{"list", module_list},
+	{"name", module_name},
+	{"clone", module_clone},
+	{"add", module_add},
+	{"update", module_update},
+	{"resolve-relative-url-test", resolve_relative_url_test},
+	{"foreach", module_foreach},
+	{"init", module_init},
+	{"status", module_status},
+	{"sync", module_sync},
+	{"deinit", module_deinit},
+	{"summary", module_summary},
+	{"push-check", push_check},
+	{"absorb-git-dirs", absorb_git_dirs},
+	{"is-active", is_active},
+	{"check-name", check_name},
+	{"config", module_config},
+	{"set-url", module_set_url},
+	{"set-branch", module_set_branch},
+	{"create-branch", module_create_branch},
 };
 
 int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
@@ -3401,15 +3398,9 @@ int cmd_submodule__helper(int argc, const char **argv, const char *prefix)
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage("git submodule--helper <command>");
 
-	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		if (!strcmp(argv[1], commands[i].cmd)) {
-			if (get_super_prefix() &&
-			    !(commands[i].option & SUPPORT_SUPER_PREFIX))
-				die(_("%s doesn't support --super-prefix"),
-				    commands[i].cmd);
+	for (i = 0; i < ARRAY_SIZE(commands); i++)
+		if (!strcmp(argv[1], commands[i].cmd))
 			return commands[i].fn(argc - 1, argv + 1, prefix);
-		}
-	}
 
 	die(_("'%s' is not a valid submodule--helper "
 	      "subcommand"), argv[1]);
-- 
2.36.1.1178.gb5b1747c546

