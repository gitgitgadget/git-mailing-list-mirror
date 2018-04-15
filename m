Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD1F1F404
	for <e@80x24.org>; Sun, 15 Apr 2018 16:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeDOQpw (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 12:45:52 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40426 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbeDOQpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 12:45:47 -0400
Received: by mail-lf0-f65.google.com with SMTP id i18-v6so3713674lfc.7
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 09:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QwvxSGeMKVC7WmcwG9S0ke3Xegnkk90aOSjCBDrdQME=;
        b=YDNNOGjUqg0wmNDTPdboW5UjL3RuFWfE6jiuYldpmWqCHFWOsFwUW2tr/Ft7/7r030
         kRTdUm44Nh8fM1hQc88rpQUlNYmCNslLvClheEhwOPgpaHujsmWSoJIaBZG2yAIKySk3
         xSu+O2EpFki599noy7XS18tf1IDXt3Y6KnNn9M671iGixdxEsfdxVo4HAtGZy4FrLYgD
         j8RD1V7e2F404uVnI/L7ly1PKhc2Yb+73staQ+xxft7NF29ZbTpAc6KtdiemuFRdQ734
         B/TUO3nQjmBDerAO6kUJmN2FsSQ1ZcEsPTvzzHX46BnrZu2xxtitZBxFRYc/+7eqqeWk
         bvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QwvxSGeMKVC7WmcwG9S0ke3Xegnkk90aOSjCBDrdQME=;
        b=e2Sl330N8XUFNByPAAeF1lu6cetl5FuI5bVPXotQ6sI+NQDeBgp1U+8HvHXdntSCB3
         S+HODp1EmgI6zT3SkCG6nz3jBzUotBRfn5V+dLkCQC3qI6dNBytxB3eXvT7oq2c/jCeh
         NxsQHn2HrvJweQtOX/F4p2qu+KuxKSh2FYrw9GNFjiYeyvfWeS3RZ/YzBG2IFFitmZiS
         VcZEzlCGPhwiKpr3FsK9tzWMMoFSHUAp3TephG1QB5HyqeyYsTGpef8BvkGJXDNbIH4r
         t+VD/TL9TKrmU6JdcRlEGFSMO9fXun5ETNcrrrQolOusZbRUJw/5h9gFSVoqjth6x8IT
         ZxSQ==
X-Gm-Message-State: ALQs6tAFEI9ooHzYHJCJrCDQuUR11d/oBC3iWFnTQh6KJdaGTrzoGVNp
        iKBn1JGawmW7W/eDBYy03Pg=
X-Google-Smtp-Source: AIpwx4/5gkA0L1tLT0w7FT3lMKYSF7EjG7fB/XbgXjMSgcYX1W3IvAUOc0ifduIS54qHXg49X41O2A==
X-Received: by 10.46.151.149 with SMTP id y21mr7716576lji.64.1523810746393;
        Sun, 15 Apr 2018 09:45:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s25-v6sm2360702lfc.21.2018.04.15.09.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 09:45:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/6] git.c: implement --list-cmds=all and use it in git-completion.bash
Date:   Sun, 15 Apr 2018 18:42:34 +0200
Message-Id: <20180415164238.9107-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415164238.9107-1-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com>
 <20180415164238.9107-1-pclouds@gmail.com>
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

