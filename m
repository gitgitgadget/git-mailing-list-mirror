Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF3C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiGYMjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbiGYMjk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C81B79B
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c12so6371321ede.3
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ML1aLf9VSmMHZDK+x3hSBr7J7SIFGLLempBpG069tpo=;
        b=NdOPsJawzF+dh1FYdnolZIUp8g9lNrqLhtWu15VKhesdQerTdO9n83vVc5WTJIn5m1
         pgta1UnIdXvxzs05bhyl3I7DGIt2+FCU5PfrS+xOOhkWv5r/7DAvyWMG3tFA8ZMFlBxb
         GgWPjK3SUa2PtCWcq7OzCDmolS2F4u8V0g83PJrD8SSenYLtpD4+kyJlg5hqpTIKf7a8
         zMeV7vuKyjyjzEOLnqALAdCQtze/DuLALBFQKApkOtomKoGO1tGl2zdIDKI8oVtDNsu2
         LR+98z8XI2Ow6Muw1yfeFSieR8txgKJKGfSlk6M8e2mbHmbK0WK0j9LOsihvv1HOSdYy
         Z5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ML1aLf9VSmMHZDK+x3hSBr7J7SIFGLLempBpG069tpo=;
        b=GwqmwAa+kLK8dSGJ/dFAFGUWFyqcx98s+mIqLgQYRhLYITDUDDy0lnF/hpZK6YANcs
         ZRi/AVDEx8HaWmnw2Vf9Annc16LCP0fwW/Xcp8kzqUy0gy8XnZ8WCRGQp4kGkj+HOCjn
         EEUXLEDd306//VOmCyubT3ElgNd/GVZLJOyH0Gr+0t/SdVCGC7T+i9udnkrk+koFpJRO
         T2ofFv0nuAQpUChT54+2Ik1icwioMOF1/E2B0PUgJc02BMgHL8LseYYbIl19WMLMFwcs
         c3PduQ4a+I0M8/NIWnsfFbP1FiCzi7nDNcKeybr5+5ZsLdk3JlWBtIRNbPYeWzoti5tp
         ULpw==
X-Gm-Message-State: AJIora+g0yrweSAP6rOFELzjabxz8p10rTv4suYOjZ9IKuWMAbMLxPSY
        y6xAn7nALvrHVgnn0XajDHtOuKXtLD8=
X-Google-Smtp-Source: AGRyM1t0zAfniWjNOjJ2/MgHeogjYQsaZWzw9bl+bGtmbqTBHKxX4Yp/0vYKmDHfsCZpRRXTbWSRDg==
X-Received: by 2002:a05:6402:90d:b0:43b:9ee5:f7eb with SMTP id g13-20020a056402090d00b0043b9ee5f7ebmr12982631edz.71.1658752766638;
        Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b592ee073sm5394463ejb.147.2022.07.25.05.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:26 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 15/20] builtin/notes.c: let parse-options parse subcommands
Date:   Mon, 25 Jul 2022 14:38:52 +0200
Message-Id: <20220725123857.2773963-16-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git notes' parses its subcommands with a long list of if-else if
statements.  parse-options has just learned to parse subcommands, so
let's use that facility instead, with the benefits of shorter code,
handling unknown subcommands, and listing subcommands for Bash
completion.  Make sure that the default operation mode doesn't accept
any arguments.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/notes.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index a3d0d15a22..42cbae4659 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -994,17 +994,31 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 
 int cmd_notes(int argc, const char **argv, const char *prefix)
 {
-	int result;
 	const char *override_notes_ref = NULL;
+	parse_opt_subcommand_fn *fn = list;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
 			   N_("use notes from <notes-ref>")),
+		OPT_SUBCOMMAND("list", &fn, list),
+		OPT_SUBCOMMAND("add", &fn, add),
+		OPT_SUBCOMMAND("copy", &fn, copy),
+		OPT_SUBCOMMAND("append", &fn, append_edit),
+		OPT_SUBCOMMAND("edit", &fn, append_edit),
+		OPT_SUBCOMMAND("show", &fn, show),
+		OPT_SUBCOMMAND("merge", &fn, merge),
+		OPT_SUBCOMMAND("remove", &fn, remove_cmd),
+		OPT_SUBCOMMAND("prune", &fn, prune),
+		OPT_SUBCOMMAND("get-ref", &fn, get_ref),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+	if (fn == list && argc && strcmp(argv[0], "list")) {
+		error(_("unknown subcommand: %s"), argv[0]);
+		usage_with_options(git_notes_usage, options);
+	}
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
@@ -1014,28 +1028,5 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		strbuf_release(&sb);
 	}
 
-	if (argc < 1 || !strcmp(argv[0], "list"))
-		result = list(argc, argv, prefix);
-	else if (!strcmp(argv[0], "add"))
-		result = add(argc, argv, prefix);
-	else if (!strcmp(argv[0], "copy"))
-		result = copy(argc, argv, prefix);
-	else if (!strcmp(argv[0], "append") || !strcmp(argv[0], "edit"))
-		result = append_edit(argc, argv, prefix);
-	else if (!strcmp(argv[0], "show"))
-		result = show(argc, argv, prefix);
-	else if (!strcmp(argv[0], "merge"))
-		result = merge(argc, argv, prefix);
-	else if (!strcmp(argv[0], "remove"))
-		result = remove_cmd(argc, argv, prefix);
-	else if (!strcmp(argv[0], "prune"))
-		result = prune(argc, argv, prefix);
-	else if (!strcmp(argv[0], "get-ref"))
-		result = get_ref(argc, argv, prefix);
-	else {
-		result = error(_("unknown subcommand: %s"), argv[0]);
-		usage_with_options(git_notes_usage, options);
-	}
-
-	return result ? 1 : 0;
+	return !!fn(argc, argv, prefix);
 }
-- 
2.37.1.633.g6a0fa73e39

