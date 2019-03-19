Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A27220248
	for <e@80x24.org>; Tue, 19 Mar 2019 19:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCSTEB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 15:04:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37540 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfCSTEB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 15:04:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so70634wro.4
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=rWGh19B4fp21dviG2WNKTXCkWsG4gng0mLhkJ5wH/m0=;
        b=EaVuEv1Xb++kjPyBJmINgRK4W66uyrRY7XQwhgXgzL70NTYewWuAnNapvlK4IgWLBU
         LvKp5nO2XbbikpmnQEtg2pRf9kE5rlm/knWovEMEh4UukzFMTnQ6G7OiRSimK9dLa5b9
         ofyBi20wnSSYk6T4WdL0DzQwZz04wMq6C76ZTNC03me/csIqYUH6lrQ+CGW4vH2+EOfb
         uwwNztX9n2nxMAFQIoMr+BJbkHe/qUKXXNnL+FNZMy327CAv2K6WSsnjqLUzYBijnFfJ
         n/z0NNoYRKNVI9Es6HI2tuxI62+8Dx8vbheCQG1g2k8pEJrhWZKhqYv2mPZC2IMoZR1f
         ofNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=rWGh19B4fp21dviG2WNKTXCkWsG4gng0mLhkJ5wH/m0=;
        b=TACSMtkf/k64b0nOlj9dlH3xFP7K9PMTTeygB0iKBsS73e12NiCQ3cUl2MxdNH19nX
         VN2XDazmjNdkpZhi1dU4EipCpXP6iNOiS3mClvu1Y5QCnEClBje5at3b3e7O5MrGg8X9
         QHa2I9YzbIBwDTqr7bATevHXFNEgPKDyTYXTmoIHoXuWRoKPiDZfYjxRPTEhLEstewtS
         od0K1x6EbeAeweEVis6wFxDsxKFNH0leqKhTqFZ+ya68iu1T2L2G7E52GqqlaRs6JTct
         D1C62CKnfPZyfW0+QDqNavAelDlho9OkcPi6VUl15my/l2havcrBxsfqqMh8Bnss24fu
         klJw==
X-Gm-Message-State: APjAAAWMN1G2reRxBWIBg1jdO8I9TR/dSVR0XD12UCx5pz2F/rnFU6SY
        yogrJ7dmOcAcc0cXkbE3sHb0GHjfQPA=
X-Google-Smtp-Source: APXvYqzMd0l75xR9a6UPWDAhJaffcQndK7fbOqrHN9J1RIMm4cz+F2KTExYSVM+MnnfKnUQH2sWI7Q==
X-Received: by 2002:adf:b651:: with SMTP id i17mr17241491wre.108.1553022238286;
        Tue, 19 Mar 2019 12:03:58 -0700 (PDT)
Received: from lindisfarne.localdomain (host-89-242-184-133.as13285.net. [89.242.184.133])
        by smtp.gmail.com with ESMTPSA id s187sm6253853wms.7.2019.03.19.12.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 12:03:57 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 03/11] rebase: use OPT_RERERE_AUTOUPDATE()
Date:   Tue, 19 Mar 2019 19:03:09 +0000
Message-Id: <20190319190317.6632-4-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319190317.6632-1-phillip.wood123@gmail.com>
References: <20190319190317.6632-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As we have a macro for this it makes sense to use it. Having
cmd_rebase() and cmd_rebase__interactive() use the same values for
this option will be helpful when we start running interactive rebases
without forking rebase--interactive.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index b634879c5b..ccf178326c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -206,14 +206,13 @@ static int read_basic_state(struct rebase_options *opts)
 			    &buf))
 			return -1;
 		if (!strcmp(buf.buf, "--rerere-autoupdate"))
-			opts->allow_rerere_autoupdate = 1;
+			opts->allow_rerere_autoupdate = RERERE_AUTOUPDATE;
 		else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
-			opts->allow_rerere_autoupdate = 0;
+			opts->allow_rerere_autoupdate = RERERE_NOAUTOUPDATE;
 		else
 			warning(_("ignoring invalid allow_rerere_autoupdate: "
 				  "'%s'"), buf.buf);
-	} else
-		opts->allow_rerere_autoupdate = -1;
+	}
 
 	if (file_exists(state_dir_path("gpg_sign_opt", opts))) {
 		strbuf_reset(&buf);
@@ -263,10 +262,11 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	if (opts->strategy_opts)
 		write_file(state_dir_path("strategy_opts", opts), "%s",
 			   opts->strategy_opts);
-	if (opts->allow_rerere_autoupdate >= 0)
+	if (opts->allow_rerere_autoupdate > 0)
 		write_file(state_dir_path("allow_rerere_autoupdate", opts),
 			   "-%s-rerere-autoupdate",
-			   opts->allow_rerere_autoupdate ? "" : "-no");
+			   opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
+				"" : "-no");
 	if (opts->gpg_sign_opt)
 		write_file(state_dir_path("gpg_sign_opt", opts), "%s",
 			   opts->gpg_sign_opt);
@@ -625,9 +625,9 @@ static int run_am(struct rebase_options *opts)
 	argv_array_push(&am.args, "--rebasing");
 	argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
 	argv_array_push(&am.args, "--patch-format=mboxrd");
-	if (opts->allow_rerere_autoupdate > 0)
+	if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
 		argv_array_push(&am.args, "--rerere-autoupdate");
-	else if (opts->allow_rerere_autoupdate == 0)
+	else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
 		argv_array_push(&am.args, "--no-rerere-autoupdate");
 	if (opts->gpg_sign_opt)
 		argv_array_push(&am.args, opts->gpg_sign_opt);
@@ -713,9 +713,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 			argv_array_pushf(&child.args, "--cmd=%s", opts->cmd);
 		if (opts->allow_empty_message)
 			argv_array_push(&child.args, "--allow-empty-message");
-		if (opts->allow_rerere_autoupdate > 0)
+		if (opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE)
 			argv_array_push(&child.args, "--rerere-autoupdate");
-		else if (opts->allow_rerere_autoupdate == 0)
+		else if (opts->allow_rerere_autoupdate == RERERE_NOAUTOUPDATE)
 			argv_array_push(&child.args, "--no-rerere-autoupdate");
 		if (opts->gpg_sign_opt)
 			argv_array_push(&child.args, opts->gpg_sign_opt);
@@ -764,9 +764,9 @@ static int run_specific_rebase(struct rebase_options *opts)
 	add_var(&script_snippet, "action", opts->action ? opts->action : "");
 	add_var(&script_snippet, "signoff", opts->signoff ? "--signoff" : "");
 	add_var(&script_snippet, "allow_rerere_autoupdate",
-		opts->allow_rerere_autoupdate < 0 ? "" :
 		opts->allow_rerere_autoupdate ?
-		"--rerere-autoupdate" : "--no-rerere-autoupdate");
+			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
+			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
 	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
 	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
 	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
@@ -1007,7 +1007,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		.type = REBASE_UNSPECIFIED,
 		.flags = REBASE_NO_QUIET,
 		.git_am_opts = ARGV_ARRAY_INIT,
-		.allow_rerere_autoupdate  = -1,
 		.allow_empty_message = 1,
 		.git_format_patch_opt = STRBUF_INIT,
 	};
@@ -1102,10 +1101,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('p', "preserve-merges", &options.type,
 			    N_("try to recreate merges instead of ignoring "
 			       "them"), REBASE_PRESERVE_MERGES),
-		OPT_BOOL(0, "rerere-autoupdate",
-			 &options.allow_rerere_autoupdate,
-			 N_("allow rerere to update index with resolved "
-			    "conflict")),
+		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
 		OPT_BOOL('k', "keep-empty", &options.keep_empty,
 			 N_("preserve empty commits during rebase")),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
-- 
2.21.0

