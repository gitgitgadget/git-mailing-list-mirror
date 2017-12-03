Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C10E20C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbdLCWSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:17 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:37618 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752499AbdLCWSD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:18:03 -0500
Received: by mail-it0-f67.google.com with SMTP id d137so2269413itc.2
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wNcSs0ucRFVmzbDylka+3ADBuW3/vZ+fsnVj+GY54H4=;
        b=t5LmUiZjH0uPdxcj9S/IEiXNLSWftLVaDrhabYQe53wX1QFJ1rv6Pca9E3fnS5lc/D
         P0YLQaSOOLJCIaUKEc7/Tb2KnWqYbIUN0tuZNKQ1wMJ5tL4ft+HgjloQc8fzxMxQROyS
         wapl0q6MvaaLMrpyb0245UV9yqn8x8PthpqbUcgJ2jgczzoh5+uwiJOYHKajKDZUm0fA
         O0B93P1Ku0XrqPko3GrQ6DLWkisHuqXYn47l5auH1OZRA8f2N4J8/Ke9kfj1Qhh0cL07
         jjWedLDFI/V6vX8U2QApQgohPG2HRzdDCCCHc4du91X/WxLyNrhADL88rBz2RGJNZufs
         89vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wNcSs0ucRFVmzbDylka+3ADBuW3/vZ+fsnVj+GY54H4=;
        b=ZPt8CCkgY98iMPt5qDtkU+9mIWcNvGxg83MwG69UI5Or0n+Apq22Y4iwYU5fGPelK/
         KlEt4XC+27XeDx8ja1kKeqwRW644ATOtAoRysGgU5BqojvNujSxAiijNlQTDQz29dWrM
         ApwOqOtkS6Mav0qjZ9naPcCwmoNTAnShzznqNuboWXtQOvEPRHFByg4eOovZuZqN9SjD
         ooHcV1XedtljsTCw7xIP+9YzUmmajg+Ww0Sum7G3SLA5FS6RN/+skDYR60RTpH6V9Zyt
         sOnvw9iqaigktvV/B4QNMJj8oMKTOoTR0dnlOJhokFz/eYS59KrMKHjRxUHQDlvRTJXn
         Ilbw==
X-Gm-Message-State: AJaThX6cVnss2mCoDXvtZDOEDDfd0108ZwAm/SgiSiybf0TCKHksFTtw
        ycWJ3RDZ6vlAZpHWk69CrLrd7+UE
X-Google-Smtp-Source: AGs4zMYTd/feNP1T/9qLpsy/JsR2yDzd/coeKzGG5/0vUUbvCKZRu8Iq1PhBf1pI0oIW70wSl7U3UQ==
X-Received: by 10.107.50.5 with SMTP id y5mr21236271ioy.139.1512339483000;
        Sun, 03 Dec 2017 14:18:03 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:18:02 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 6/9] rebase -i: update functions to use a flags parameter
Date:   Sun,  3 Dec 2017 17:17:18 -0500
Message-Id: <20171203221721.16462-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update functions used in the rebase--helper so that they take a generic
'flags' parameter instead of a growing list of options.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 builtin/rebase--helper.c | 13 +++++++------
 sequencer.c              |  9 +++++----
 sequencer.h              |  8 +++++---
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index af0f91164fd0..fe814bf7229e 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,7 +12,7 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	int keep_empty = 0;
+	unsigned flags = 0, keep_empty = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
@@ -48,16 +48,17 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, NULL, options,
 			builtin_rebase_helper_usage, PARSE_OPT_KEEP_ARGV0);
 
+	flags |= keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
+	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTED_IDS : 0;
+
 	if (command == CONTINUE && argc == 1)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
-	if (command == SHORTEN_OIDS && argc == 1)
-		return !!transform_todo_insn(1);
-	if (command == EXPAND_OIDS && argc == 1)
-		return !!transform_todo_insn(0);
+		return !!sequencer_make_script(stdout, argc, argv, flags);
+	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
+		return !!transform_todo_insn(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 0ff3c90e44bf..7d712811e9d1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2444,14 +2444,15 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	strbuf_release(&sob);
 }
 
-int sequencer_make_script(int keep_empty, FILE *out,
-		int argc, const char **argv)
+int sequencer_make_script(FILE *out, int argc, const char **argv,
+			  unsigned flags)
 {
 	char *format = NULL;
 	struct pretty_print_context pp = {0};
 	struct strbuf buf = STRBUF_INIT;
 	struct rev_info revs;
 	struct commit *commit;
+	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
 
 	init_revisions(&revs, NULL);
 	revs.verbose_header = 1;
@@ -2494,7 +2495,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 }
 
 
-int transform_todo_insn(int shorten_ids)
+int transform_todo_insn(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -2522,7 +2523,7 @@ int transform_todo_insn(int shorten_ids)
 
 		/* add commit id */
 		if (item->commit) {
-			const char *oid = shorten_ids ?
+			const char *oid = flags & TODO_LIST_SHORTED_IDS ?
 					  short_commit_name(item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
diff --git a/sequencer.h b/sequencer.h
index 4e444e3bf1c4..3bb6b0658192 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,10 +45,12 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-int sequencer_make_script(int keep_empty, FILE *out,
-		int argc, const char **argv);
+#define TODO_LIST_KEEP_EMPTY (1U << 0)
+#define TODO_LIST_SHORTED_IDS (1U << 1)
+int sequencer_make_script(FILE *out, int argc, const char **argv,
+			  unsigned flags);
 
-int transform_todo_insn(int shorten_ids);
+int transform_todo_insn(unsigned flags);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.15.1.280.g10402c1f5b5c

