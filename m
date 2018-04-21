Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362841F404
	for <e@80x24.org>; Sat, 21 Apr 2018 16:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeDUQyh (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 12:54:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46534 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbeDUQyd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 12:54:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id j68-v6so9179870lfg.13
        for <git@vger.kernel.org>; Sat, 21 Apr 2018 09:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwvxSGeMKVC7WmcwG9S0ke3Xegnkk90aOSjCBDrdQME=;
        b=hTG/IXHt3aSkv77zv8iYjHIoZjeJ7qIp1eIABp5jdpBfZvCMaQ3wlSsWWtriL0INK0
         9vaxbmU8XAfp11L9TiJp99a3hdmp/eFOOXvAD//um43MTBwiZGmmMg0dQa9jHejsc2i3
         FPsQ921gfmUoR8acE8PSzlkizB4RH0yexM+rZwjR9QewZtJs0pBaQGL7ETrGakgScVSV
         +CaqRSrJD40kurHdht696zuwxwDtZmJR5tfM5B//uxCsYw9B/Ca3h5xp3gWSlCImEvsa
         KA6RCWgSLL5oSaIfGfuYohBOuTEIbLtURFF/hua9SsoLNlUOVTdTVALEZI082trK0dIV
         MHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwvxSGeMKVC7WmcwG9S0ke3Xegnkk90aOSjCBDrdQME=;
        b=BRdOgrl/QFndbf8T3H3QZtanOtVTurPxHJ2rRN5pWQwgg9XV863gMkeKM5pneBplHx
         kOo7NyDThfisqvhBmZ1X2V4nH+hVouWg4HomQFcTdIy6HTeZtDyTEM+uVx5av1JfnxNn
         08D2FvCORqLijhO4mPDUSczaCpmWoPF2GNSrOwnHczYBgsKFHvREkOJjj+P4aIveAkRL
         7quF8+tBvcbQv9qhcVn1lXFNPsD7b1UtrcWg2ehRqz+jGLmAyY2QbaTJdFN9QvI2avgn
         lPpWpiU+cHvsNLoJtHCNXwobE9jacLPLK8N0NJuTQqBvBWar0T7Sz7g6eq02UUPTLdBV
         uXtQ==
X-Gm-Message-State: ALQs6tBM2wjwglErabtNWtgZxWLJAiPwrBeH//wEDsiSgTWSHr8WyPmq
        Av21s3cNnVJWzAy+zQLOZ6TtpA==
X-Google-Smtp-Source: AIpwx4+V4fyTPtfy9KOYD7E3urfk2wDl31Qnix2kmwyrOKwJ1Xor+pu2z5a69K+KuKZvUKY9zWWQxg==
X-Received: by 10.46.77.214 with SMTP id c83mr9461927ljd.126.1524329671759;
        Sat, 21 Apr 2018 09:54:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g81sm1526523ljb.12.2018.04.21.09.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Apr 2018 09:54:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.org,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v3 2/6] git.c: implement --list-cmds=all and use it in git-completion.bash
Date:   Sat, 21 Apr 2018 18:54:10 +0200
Message-Id: <20180421165414.30051-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180421165414.30051-1-pclouds@gmail.com>
References: <20180415164238.9107-1-pclouds@gmail.com>
 <20180421165414.30051-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash |  2 +-
 git.c                                  |  2 ++
 help.c                                 | 18 ++++++++++++++++++
 help.h                                 |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3556838759..a5f13ade20 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -839,7 +839,7 @@ __git_commands () {
 	then
 		printf "%s" "${GIT_TESTING_COMMAND_COMPLETION}"
 	else
-		git help -a|egrep '^  [a-zA-Z0-9]'
+		git --list-cmds=all
 	fi
 }
 
diff --git a/git.c b/git.c
index 28bfa96d87..64f67e7f7f 100644
--- a/git.c
+++ b/git.c
@@ -228,6 +228,8 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				list_builtins(0, '\n');
 			else if (!strcmp(cmd, "parseopt"))
 				list_builtins(NO_PARSEOPT, ' ');
+			else if (!strcmp(cmd, "all"))
+				list_all_cmds();
 			else
 				die("unsupported command listing type '%s'", cmd);
 			exit(0);
diff --git a/help.c b/help.c
index 60071a9bea..e155c39870 100644
--- a/help.c
+++ b/help.c
@@ -228,6 +228,24 @@ void list_common_cmds_help(void)
 	}
 }
 
+void list_all_cmds(void)
+{
+	struct cmdnames main_cmds, other_cmds;
+	int i;
+
+	memset(&main_cmds, 0, sizeof(main_cmds));
+	memset(&other_cmds, 0, sizeof(other_cmds));
+	load_command_list("git-", &main_cmds, &other_cmds);
+
+	for (i = 0; i < main_cmds.cnt; i++)
+		puts(main_cmds.names[i]->name);
+	for (i = 0; i < other_cmds.cnt; i++)
+		puts(other_cmds.names[i]->name);
+
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
+}
+
 int is_in_cmdlist(struct cmdnames *c, const char *s)
 {
 	int i;
diff --git a/help.h b/help.h
index b21d7c94e8..0bf29f8dc5 100644
--- a/help.h
+++ b/help.h
@@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
 }
 
 extern void list_common_cmds_help(void);
+extern void list_all_cmds(void);
 extern const char *help_unknown_cmd(const char *cmd);
 extern void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
-- 
2.17.0.367.g5dd2e386c3

