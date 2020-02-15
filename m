Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90158C7114E
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C1120718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjCUxiGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgBOVgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:36:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46697 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgBOVgt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 16:36:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so15109449wrl.13
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HuYFe5Ry7Pi79MrnRKQ3+x1WnYCRSTlNLvVlabA16HU=;
        b=JjCUxiGgOUMfjOsijxi4VzEWrgEQyAN/IHF0Jz5Z9IbexJtnCm1OYO4/HA5w0m6iCO
         HPSWpTSeejaLFTIMLnMYHqAXU5PA6GbrOlPIInijx/09/nUKYjb8L09Cd1QgqTr05BxI
         R6cTc9TTeXkE7fHUyYYspg7iUldrm0v7qm1I85Y+LkXzYkLRS912qlg7ss4FUOUrTbQb
         CUGwfhMzBoULMEiOBShTdWlmVJ18Iqs6Z3+2vtHxbE6c7QTEBTD1fYlRSBr8N9k5W5Sa
         FSrwF/u6QlCyR0oGuvRa/zPEAzRGYzqlkBsYkwvV5wIsJd4wHhJHLrOh351z9ktoEw1o
         d8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HuYFe5Ry7Pi79MrnRKQ3+x1WnYCRSTlNLvVlabA16HU=;
        b=QUOWtU2qFhU2iEh8RQTNds53ydoL+4tjpB7jSTAxvBU1PXm4VJCnJIFLaszzCaoLe6
         ARN74oAq+2Fpec0UUvfKQeT81NXsVXyD/sPcI3GSqFh9XltZYyRhk0p3iunqjDWWWP2J
         Vn+Tl38HM4uep0gHjmbFCFxTg+qZu62N4SP/6R0FJv/PNiwoSkpN4QceK3MguB0f8jYU
         kpGeGgCkEXiUOkvvlP1DoUXh/HTlgyNprAUiO1plcxn/ODVkCBjyIE7nBhPbPDQRnLBR
         exW2vjXhaLuusn2kr1/ftWJct+PzXKwYDZSgHdYtjmhgwSBl7U/uoQlMQBWeEFjgdVwh
         s52g==
X-Gm-Message-State: APjAAAUvOYHnKBCc3SUbfV4+1ie2z7CowIKerpxR7p5KksnGtGnhdOF0
        mytWCg1Yt+s584wb6J6hMadGAqj2
X-Google-Smtp-Source: APXvYqywRXr03yWllh/d0xirfP9zwLynx3Bf8jJy2g2WQSgs6BJ8uXeAlq3ImvMGdimi4EzsuNqWgg==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr11463211wrv.259.1581802607978;
        Sat, 15 Feb 2020 13:36:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm13043977wmc.47.2020.02.15.13.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 13:36:47 -0800 (PST)
Message-Id: <2791b818c4d84152edba16c339d15913f7a63022.1581802602.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
        <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 15 Feb 2020 21:36:27 +0000
Subject: [PATCH v5 06/20] rebase, sequencer: remove the broken GIT_QUIET
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The GIT_QUIET environment variable was used to signal the non-am
backends that the rebase should perform quietly.  The preserve-merges
backend does not make use of the quiet flag anywhere (other than to
write out its state whenever it writes state), and this mechanism was
broken in the conversion from shell to C.  Since this environment
variable was specifically designed for scripts and the only backend that
would still use it is no longer a script, just gut this code.

A subsequent commit will fix --quiet for the interactive/merge backend
in a different way.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rebase.c | 6 ++----
 sequencer.c      | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 669690f9664..7551f950593 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -699,8 +699,8 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 		   opts->onto ? oid_to_hex(&opts->onto->object.oid) : "");
 	write_file(state_dir_path("orig-head", opts), "%s",
 		   oid_to_hex(&opts->orig_head));
-	write_file(state_dir_path("quiet", opts), "%s",
-		   opts->flags & REBASE_NO_QUIET ? "" : "t");
+	if (!(opts->flags & REBASE_NO_QUIET))
+		write_file(state_dir_path("quiet", opts), "%s", "");
 	if (opts->flags & REBASE_VERBOSE)
 		write_file(state_dir_path("verbose", opts), "%s", "");
 	if (opts->strategy)
@@ -1153,8 +1153,6 @@ static int run_specific_rebase(struct rebase_options *opts, enum action action)
 	add_var(&script_snippet, "revisions", opts->revisions);
 	add_var(&script_snippet, "restrict_revision", opts->restrict_revision ?
 		oid_to_hex(&opts->restrict_revision->object.oid) : NULL);
-	add_var(&script_snippet, "GIT_QUIET",
-		opts->flags & REBASE_NO_QUIET ? "" : "t");
 	sq_quote_argv_pretty(&buf, opts->git_am_opts.argv);
 	add_var(&script_snippet, "git_am_opt", buf.buf);
 	strbuf_release(&buf);
diff --git a/sequencer.c b/sequencer.c
index fdb8f91fbce..f475d2a3b1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2570,8 +2570,6 @@ static void write_strategy_opts(struct replay_opts *opts)
 int write_basic_state(struct replay_opts *opts, const char *head_name,
 		      struct commit *onto, const char *orig_head)
 {
-	const char *quiet = getenv("GIT_QUIET");
-
 	if (head_name)
 		write_file(rebase_path_head_name(), "%s\n", head_name);
 	if (onto)
@@ -2580,8 +2578,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 	if (orig_head)
 		write_file(rebase_path_orig_head(), "%s\n", orig_head);
 
-	if (quiet)
-		write_file(rebase_path_quiet(), "%s\n", quiet);
+	if (opts->quiet)
+		write_file(rebase_path_quiet(), "%s", "");
 	if (opts->verbose)
 		write_file(rebase_path_verbose(), "%s", "");
 	if (opts->strategy)
-- 
gitgitgadget

