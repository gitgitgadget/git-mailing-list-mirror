Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4235220A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbdLERxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:53:12 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:36086 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbdLERwz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:52:55 -0500
Received: by mail-it0-f65.google.com with SMTP id d16so3550410itj.1
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d/jTP+/A4P3LIw4/cidTCNL4DpNZj0AtuikubpkwKDo=;
        b=DtKxFEI/i/XMFzJCg33rgJvW+cK0g/H7R7n6coIXni0VnCalIda+cXKJyQij96UHuM
         pvwT3gqkjheHZNC4ERAyzf6SbRwlewUHsMFQGoippU2GOhqrcxiF6mwvMC80v5ySBnUc
         Psu13q5wA2yw1zXwZfwRqL7KxdlT/VMZabEXqgXYU3M6ApfPDqagju7eemlYxkO3oL02
         yVXJHIpB4383QTODnznRQ+wxW859lJ30f7X/R2VnposrvBIW2P7o0A4agu6dySqPF4AB
         //vwc77/X5sJUEjUt4Hhl/Xy3yktDJsYZWyNW8vqOOgdN1CZn1728FcmXW6y2TNUfiV8
         zroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d/jTP+/A4P3LIw4/cidTCNL4DpNZj0AtuikubpkwKDo=;
        b=bIBX1dDRg2TVEQ5EiHs7Oa73yn3dG5x6njbFEYNFZIARfXkr5tJRUqBo2Zsh6ZiwSD
         ktqxxRggGaZuShhKzT6hNU6fNEjrc1wbMqAUmpq3HvAmNVjU+k/SsEwEMPDRdokfokyN
         +K63rQRtZ17B8vZGFCRgkmCFfvBMEjd4SVQaLR6d6iHs+pwhMgjAlrXkbbFQs6G/f5zw
         Dwz1lsgumpV5sp9+vYCDDnKHXjbTXbviZ8hwdJDBiC+yT8R2m0iyHO9LhfN4R5FRSN6M
         W/RyROXokNQBBoXmqmGz46A09ahzaOBoi1UNHTXXQutJbMNm7c8lXru3mMBn9i5iT6p+
         aOVA==
X-Gm-Message-State: AJaThX4fE9sMbzB9aWisDkeXFD53jLykGFlKyxcBZJ7gWJrv2TEduDKt
        JafOcnz2uMGUuwFqyv9+kKb+w/1asig=
X-Google-Smtp-Source: AGs4zMaVJn3SpawEkimsnlEzdqva1Y5XNsiEir4gw7coUvfVvo5/yE71O5OsDprPUepS1pqrwat4Sg==
X-Received: by 10.107.129.150 with SMTP id l22mr30551864ioi.158.1512496374859;
        Tue, 05 Dec 2017 09:52:54 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i195sm264737ioi.44.2017.12.05.09.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:52:54 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v3 6/9] rebase -i: update functions to use a flags parameter
Date:   Tue,  5 Dec 2017 12:52:32 -0500
Message-Id: <20171205175235.32319-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.gbdce6e0789cb
In-Reply-To: <20171205175235.32319-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171205175235.32319-1-liambeguin@gmail.com>
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
index c3b8e4d401f8..1102ecb43b67 100644
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
+	flags |= command == SHORTEN_OIDS ? TODO_LIST_SHORTEN_IDS : 0;
+
 	if (command == CONTINUE && argc == 1)
 		return !!sequencer_continue(&opts);
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
-	if (command == SHORTEN_OIDS && argc == 1)
-		return !!transform_todos(1);
-	if (command == EXPAND_OIDS && argc == 1)
-		return !!transform_todos(0);
+		return !!sequencer_make_script(stdout, argc, argv, flags);
+	if ((command == SHORTEN_OIDS || command == EXPAND_OIDS) && argc == 1)
+		return !!transform_todos(flags);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index c9a661a8c4bd..8b0dd610c881 100644
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
 
 
-int transform_todos(int shorten_ids)
+int transform_todos(unsigned flags)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -2522,7 +2523,7 @@ int transform_todos(int shorten_ids)
 
 		/* add commit id */
 		if (item->commit) {
-			const char *oid = shorten_ids ?
+			const char *oid = flags & TODO_LIST_SHORTEN_IDS ?
 					  short_commit_name(item->commit) :
 					  oid_to_hex(&item->commit->object.oid);
 
diff --git a/sequencer.h b/sequencer.h
index 4f7f2c93f83e..68284e9762c8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,10 +45,12 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-int sequencer_make_script(int keep_empty, FILE *out,
-		int argc, const char **argv);
+#define TODO_LIST_KEEP_EMPTY (1U << 0)
+#define TODO_LIST_SHORTEN_IDS (1U << 1)
+int sequencer_make_script(FILE *out, int argc, const char **argv,
+			  unsigned flags);
 
-int transform_todos(int shorten_ids);
+int transform_todos(unsigned flags);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
-- 
2.15.1.280.g10402c1f5b5c

