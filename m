Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50CFF200B9
	for <e@80x24.org>; Mon,  7 May 2018 17:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752735AbeEGRxL (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 13:53:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42985 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbeEGRxI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 13:53:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id u21-v6so41884740lfu.9
        for <git@vger.kernel.org>; Mon, 07 May 2018 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZLmwCRDDjY8b0NTrvRipCv1o+KWWZIVdBkWIaavwHgg=;
        b=ALQY7UxFWCqS88do/ta+h8YgHkNoYlfpS38JosKnUrreeibfCN2r68hbqVKQVoIm6L
         pfmL9EmkGmx5RMD3FcwEgkaH2prUYU0C2zFh0xFAXcwL5ksRnr62auq/3/uECSsQTzfm
         BIAAUU3LDF69d4z96adEVK/A01u2vY58Iq6OkDH0CdCNCwq0MXLTlz9WlUtumm0FtPf4
         MDyQpy8w50j586mfsGVw6TCuD0oXJB6AmQndrwYmRuTDcMDotM816qY2RrVSQrxPxVkH
         i4OIH+r5goijk9Y7qQqxYo03laZquByWN9XABmyIyfDMtpuaAt3/ytAAPPLAVuAwNUzq
         PHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLmwCRDDjY8b0NTrvRipCv1o+KWWZIVdBkWIaavwHgg=;
        b=ojLWjcc54gKlTDNyLoi9HS/nD3J/tYp4Vo5r1Wf996KYceXPDKppuZPgtupU2i+osH
         l5HGXRXhqXPt3xRIWrRcutqCc7NHWdto+7TOPllMzm/oRp2Tu2Y/MuFumuUeswW71PCo
         1jQECPD4P73b+5fbdknP7EH8ZDV9CDvdLg5kZ3iyo5waEoF1yt/9A9m/iWjTtNFNXn/L
         8FSg4fEGrXfKsxqHL8SZ+kiQOznEt1f6i+2g0/cxpvl7JhV/KWyzKa9rZMPwLkM2+Cou
         uYHB2bosBIW/GjfWdjQ1AcIGPHPgt9sHBcY+CAf6LTg559U8gsSMsMne9q00r5CKqapI
         N1Qw==
X-Gm-Message-State: ALQs6tBeaKVgtTotjLSg1m9igKi2STDw0B66NJfXVfRkioSJcm97OjmX
        /0fMK6f4DaCrKMhwnphwJnc=
X-Google-Smtp-Source: AB8JxZqikjnu/BUK3y9OUsVoIQ4QS5Zs5kltuMVQ+jsG/cZPle9G6mJfbNQzZc6D3ByYVLvsLTQmHQ==
X-Received: by 2002:a2e:86d9:: with SMTP id n25-v6mr6662080ljj.18.1525715587446;
        Mon, 07 May 2018 10:53:07 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm4376865ljk.83.2018.05.07.10.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 10:53:06 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v6 06/13] git --list-cmds: collect command list in a string_list
Date:   Mon,  7 May 2018 19:52:15 +0200
Message-Id: <20180507175222.12114-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180507175222.12114-1-pclouds@gmail.com>
References: <20180429181844.21325-1-pclouds@gmail.com>
 <20180507175222.12114-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of printing the command directly one by one, keep them in a
list and print at the end. This allows more modification before we
print out (e.g. sorting, removing duplicates or even excluding some
items).
---
 git.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index b2842a22e2..a0477c459e 100644
--- a/git.c
+++ b/git.c
@@ -36,22 +36,28 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(unsigned int exclude_option, char sep);
+static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
 static int list_cmds(const char *spec)
 {
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int i;
+
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
 		if (len == 8 && !strncmp(spec, "builtins", 8))
-			list_builtins(0, '\n');
+			list_builtins(&list, 0);
 		else
 			die(_("unsupported command listing type '%s'"), spec);
 		spec += len;
 		if (*spec == ',')
 			spec++;
 	}
+	for (i = 0; i < list.nr; i++)
+		puts(list.items[i].string);
+	string_list_clear(&list, 0);
 	return 0;
 }
 
@@ -242,7 +248,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 			(*argc)--;
 		} else if (skip_prefix(cmd, "--list-cmds=", &cmd)) {
 			if (!strcmp(cmd, "parseopt")) {
-				list_builtins(NO_PARSEOPT, ' ');
+				struct string_list list = STRING_LIST_INIT_DUP;
+				int i;
+
+				list_builtins(&list, NO_PARSEOPT);
+				for (i = 0; i < list.nr; i++)
+					printf("%s ", list.items[i].string);
+				string_list_clear(&list, 0);
 				exit(0);
 			} else {
 				exit(list_cmds(cmd));
@@ -526,14 +538,14 @@ int is_builtin(const char *s)
 	return !!get_builtin(s);
 }
 
-static void list_builtins(unsigned int exclude_option, char sep)
+static void list_builtins(struct string_list *out, unsigned int exclude_option)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		if (exclude_option &&
 		    (commands[i].option & exclude_option))
 			continue;
-		printf("%s%c", commands[i].cmd, sep);
+		string_list_append(out, commands[i].cmd);
 	}
 }
 
-- 
2.17.0.705.g3525833791

