Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DECC433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbiBUTjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbiBUTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C230A237DA
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id d10so35796660eje.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shxpMCyvbMukuf9TyMo3+w4092PTHlb4omY9rDI7eUc=;
        b=HlQ2FIxxCiHrBt9fm8h1VnMdXLnSMJ/Py7qZHrX/f8HB516jjUEghqsJ0C7lA4GrRO
         TwQVl4cgnoIZnC2pgIR6boLN20M1kVvjx0ZW8fvtWaOjFUx9IKyrKImUDoJyIoQIWb/a
         e8SE01aKOvlAEDfl060FMFCV5uY4qBqGXjwBzEzH2jBBP7li0AHwnwMjfYuIkMalnUW0
         ycZJbmzR6iyYbQf/cHmu/d4lWc5EDP9Gx2+y4PH3Izfq0R3CIc3KvOy2vQ28kVybUMHF
         iRaiDwPYERbeo7ynqa3c35KegbXr1pcIs4u4XYO9ogoQtCYViOSOFEfisD14EVEy8ffB
         2NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shxpMCyvbMukuf9TyMo3+w4092PTHlb4omY9rDI7eUc=;
        b=vZAknuGxq/lncZh7NEHK9wCvTkzicva1PLd0knw0d73jbB+7Y9SRqUZrLEXNSLqrQM
         IlGElqqRfmPCrkkI/fcho6KV7XUjziX8zD6mYkuoORdTpcuSnNyLvUTxaWXnGzvhVi1N
         plh9IgFrClvQ+K59e2F0rlg3N1zpcdeLJ98FbSZnUvUNex8FJf67SaAzZNp55OeyJ9GO
         mWXyNZ7cUdtx1r0V2yaOpTELXh8g1+Y+60xeA7G8OFlW+e7GvsNc3ECjNa/ImjRgYKOp
         S6NiKBBNnJemvfIdoVYFLXJgDt991xpwSVR2EPMucZJf+A8+mSRJYJqRpC+E/xzX3bEN
         AhDw==
X-Gm-Message-State: AOAM5322BHYBadl1LB+AflGOH1mjopjJoQr+rf/F8c8KkdAQF95TFMM3
        ZBOFOqkiDoYEoIlLXNUqRrPA9DMkXc3csQ==
X-Google-Smtp-Source: ABdhPJx8XIHBwdYxH7/IES7tNZdwE+hFHjeK0okfYXtoHGK4M3urIQfOvspdUoH+uBTHyRK9CBRkrw==
X-Received: by 2002:a17:907:20d2:b0:6b5:1bad:89f2 with SMTP id qq18-20020a17090720d200b006b51bad89f2mr16367741ejb.331.1645472341050;
        Mon, 21 Feb 2022 11:39:01 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:00 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] help.c: split up list_all_cmds_help() function
Date:   Mon, 21 Feb 2022 20:38:47 +0100
Message-Id: <patch-v2-4.9-f9c4d5e2d28-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the listing of commands and aliases from
list_all_cmds_help(). This will make a subsequent functional change
smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 help.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/help.c b/help.c
index 77af953826e..004117347ee 100644
--- a/help.c
+++ b/help.c
@@ -433,15 +433,10 @@ static int get_alias(const char *var, const char *value, void *data)
 	return 0;
 }
 
-void list_all_cmds_help(void)
+static void list_all_cmds_help_external_commands(void)
 {
 	struct string_list others = STRING_LIST_INIT_DUP;
-	struct string_list alias_list = STRING_LIST_INIT_DUP;
-	struct cmdname_help *aliases;
-	int i, longest;
-
-	puts(_("See 'git help <command>' to read about a specific subcommand"));
-	print_cmd_by_category(main_categories, &longest);
+	int i;
 
 	list_all_other_cmds(&others);
 	if (others.nr)
@@ -449,6 +444,13 @@ void list_all_cmds_help(void)
 	for (i = 0; i < others.nr; i++)
 		printf("   %s\n", others.items[i].string);
 	string_list_clear(&others, 0);
+}
+
+static void list_all_cmds_help_aliases(int longest)
+{
+	struct string_list alias_list = STRING_LIST_INIT_DUP;
+	struct cmdname_help *aliases;
+	int i;
 
 	git_config(get_alias, &alias_list);
 	string_list_sort(&alias_list);
@@ -474,6 +476,17 @@ void list_all_cmds_help(void)
 	string_list_clear(&alias_list, 1);
 }
 
+void list_all_cmds_help(void)
+{
+	int longest;
+
+	puts(_("See 'git help <command>' to read about a specific subcommand"));
+	print_cmd_by_category(main_categories, &longest);
+
+	list_all_cmds_help_external_commands();
+	list_all_cmds_help_aliases(longest);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
-- 
2.35.1.1132.ga1fe46f8690

