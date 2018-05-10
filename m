Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 421221F42D
	for <e@80x24.org>; Thu, 10 May 2018 08:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756944AbeEJIrn (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 04:47:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46170 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756780AbeEJIrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 04:47:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id x7-v6so1798750lff.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 01:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=B6mkEmlmN8o2qKL11sTBOhWgAB3BKVytrl+yObD1Wy2PovpW9QDOiw10vuZ8cejsPZ
         9JahtZ+7Smc+ZuZhZC64k4zbtltkyQZop/fE8beo6VuBg355kHeW6Epz5qaO+h9kd0cj
         b17Ef/p1vnIhH+tJCRXnjXVZx1y3zg3xGMogkhIwDVeXEsO8D9WJh9gfBMObo9321BPV
         nQ5uv1k4i01Rvfis60HV0kfpM+JTjQq7gVQ7iM0a9lK5/P9hIy5NAxUciHP2J10R6pSg
         xMew/d0NHjVyiv5wHuj3bXDUvRqfUJ1p3OqPhxw3Y58V9WI1F5JLReAUgBrO47E4XO07
         H8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUMa/4s34NbgmqtA5r7pEwSHwn02XFefZ1BxXnUXuWQ=;
        b=kqHz2oNhaQF3ZJ86eY3ZQuHh9tC0wS0Pezg/wbpJAphshfEUg7Jkrczniy71I4wg9L
         796PzGLbvoKApMRUNC0Kd4I6J8k5HMYTAdTmvXnC05W8Z5Wt9iPA83+01KoftpV5igwI
         1FvcBL+kwcAlsxAW1H4Z8fHcQ/e85xK5E7/+s3Y5+CGmNclFwe14usTA6432o/jZzLiQ
         4RFaIfBJ4Pp1WLn6nFbiW9JOMjWttyJGbE13hjSEWZlIdIeUQrS+77gOWBzTu72Gn8Dg
         Zp/RHZGDSgr75F5Cy0d1pMEX2D3AaZRrPNdBHNorX2CN/wfd/RgZ6PAviOgcMZw7lGJG
         pQMA==
X-Gm-Message-State: ALKqPwezKh/ZgALkjPll8G2AjrvwQomQEJ+cMBMpSM049ChB2FM922ej
        nwmJSOAdDVWAlgdNhpZ+bK+iTA==
X-Google-Smtp-Source: AB8JxZrPNI0DXDL9OGu33l8D0PiVyVvqgANjGz8sM3jYHpshs5AKCzNMuZVyyBy2w+vASlfH+Ob1Ww==
X-Received: by 2002:a2e:83d7:: with SMTP id s23-v6mr499186ljh.34.1525942025202;
        Thu, 10 May 2018 01:47:05 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l24-v6sm68024lje.42.2018.05.10.01.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 01:47:04 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: [PATCH v7 06/13] git --list-cmds: collect command list in a string_list
Date:   Thu, 10 May 2018 10:46:45 +0200
Message-Id: <20180510084652.25880-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510084652.25880-1-pclouds@gmail.com>
References: <20180507175222.12114-1-pclouds@gmail.com>
 <20180510084652.25880-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of printing the command directly one by one, keep them in a
list and print at the end. This allows more modification before we
print out (e.g. sorting, removing duplicates or even excluding some
items).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 git.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git.c b/git.c
index cd85355d81..376a59b97f 100644
--- a/git.c
+++ b/git.c
@@ -36,7 +36,7 @@ const char git_more_info_string[] =
 
 static int use_pager = -1;
 
-static void list_builtins(unsigned int exclude_option, char sep);
+static void list_builtins(struct string_list *list, unsigned int exclude_option);
 
 static int match_token(const char *spec, int len, const char *token)
 {
@@ -47,18 +47,24 @@ static int match_token(const char *spec, int len, const char *token)
 
 static int list_cmds(const char *spec)
 {
+	struct string_list list = STRING_LIST_INIT_DUP;
+	int i;
+
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
 		int len = sep - spec;
 
 		if (match_token(spec, len, "builtins"))
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
 
@@ -249,7 +255,13 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
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
@@ -533,14 +545,14 @@ int is_builtin(const char *s)
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

