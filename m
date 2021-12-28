Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbhL1Pg1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 10:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbhL1PgY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 10:36:24 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1E6C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so39064324wrw.10
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EVUhYLTMcJ4GzeOT7tBwmhHddDDY2tZ5vzaBZo9XqbI=;
        b=i1Gjzp+lMfNCb+kD2N5VKW/0VZWW0BgvYCKynSEtUtiogIOrO+Q3fGM7UJdWM+H5CO
         W7vJ0MPLu2UZLVbGFCV1wSOGEjxrZtxoBtz9K7uuqiuURPf8XSrqEzRgWbX8g113jVi1
         dNTOpAKu9w0XvP9CVcuymIZofbt+ie0dvLjNQ0h9915wDFLIMowtLLpN/mN+QnyvSwyy
         qYcdn0zHKU6O/HGdbnpKMnCPFuyLcvrtleXGKKxELGwXIcYY4fYXiT/2oUdEomnJfWeq
         TJ/R6zzt3cDAyyM+VveAwgkgaw7obroUXGaqVUgBZXhHfRNiezTbp8bY/hSqqZiH5Zdi
         jcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVUhYLTMcJ4GzeOT7tBwmhHddDDY2tZ5vzaBZo9XqbI=;
        b=qyrcpxqIBwNzV3pKIj7iogDkfaILvB0+Gl4SNZ5Kd6OJWcjGSIQOT11pdfrXZt1+df
         KMKtk6hw6IczKTAl3lnsvoP1RYuNes5NarwnoWkOoSQaIzj8XOHSHXKbNJPkJLtf8eBT
         6fJRu9vIslbZ5NT1rzun5WAg/YQcdW3oLcg3Rdy5k5H7Dq6vC6Lc0b/osyKPZFw42yEq
         BB5H6JBpGP8XhAFSQP14+03Dz0ZmvHEWBmNLl2q9U0rY6DDWxLnhDznZ7bGC+dUHu/DR
         jOhucd+Wpb59Sln8mnS3dC420y2grGauyV0cg/hbzUcESBnSUH41GxS5y8ONlH6Hz4xp
         ChZA==
X-Gm-Message-State: AOAM530tOCtw5OFOsF2R2irLr1CGfnKqVtj0mV+AU/0PX7SwQoOF2R4T
        zFcrsnkLlsn1HFe5pNWHHeJuSWjsoPj3gtle
X-Google-Smtp-Source: ABdhPJwNX7NFFThR8p7QvgWko5i+njJbtcez6bN0onm5awDkrVF8IREy25wE/vG7wGI4V68VP30YSg==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr16195968wrh.43.1640705782356;
        Tue, 28 Dec 2021 07:36:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p23sm18403137wms.3.2021.12.28.07.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 07:36:21 -0800 (PST)
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
Subject: [PATCH 4/7] help.c: split up list_all_cmds_help() function
Date:   Tue, 28 Dec 2021 16:35:09 +0100
Message-Id: <patch-4.7-f040dd549b4-20211228T153456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
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
index 0ba9b866f03..ef1aa26efa6 100644
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
2.34.1.1257.g2af47340c7b

