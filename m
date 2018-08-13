Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2638D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbeHMS6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:40 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:43139 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeHMS6j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:39 -0400
Received: by mail-lj1-f170.google.com with SMTP id r13-v6so13015197ljg.10
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b5UEMXF5TH+J1NUSFH5SeMHcduExX4lTph5EpNU2PA4=;
        b=gELWe93bomXRX90BdOhrDukvYnl95LuoLcNTBNR+R/wyTdmmkCTlIqb/ThDsMJ0NAs
         XVFBAM7vq4sWDbrym3YhJ7KMe8dFDEvPPw6JsT7TdmwF8rBXrHpM0MjFZOEpel6wF4vE
         ng75/oTqwQ7SIoJQaM+65bF41fDmobcX0q5mpFfQ7Snz8QSeyrQjb9yYsfgRScjMCRvs
         iEXJRtB7b7TqXgy8q03ZyeFb4EVkJnGs5+j4ohljMWOh3vq1+FfT8pHM/omrJMsh86IB
         WBxt1WsVtXEVXFpJqavKschAAElv2RokBAG56eR6kq4iStpp06LJ6MCGxg2tqxUXHf+6
         3Ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b5UEMXF5TH+J1NUSFH5SeMHcduExX4lTph5EpNU2PA4=;
        b=imcfhxHZpu2xPyrAMQB/4r3NfcbYNMaLcIoDKVobdgj6aufOxqsyYMItwibeBugxzq
         5kLhnMiwXt7vO1iNbZS08s4aK3PS+lvCqP8S2k0XfO2uW1RYogXDkBcdjT4AU9aGfJOj
         MST7Wmp5Ah7qYaIzGIISZrwh8aYuCVelyY+Bz6oU23VZRHgm/tfyQWPkrZaykuIZ2yAz
         nc709sohSl1or5n29hoYrfYg8nGmv/Vdmeq9S7ZICJG1L2Dni2Cn3mFNnB0LA7bfC2+Y
         WJBL/0XEmfygRNWdpl2oQ1wHoukKVkgwfp+ImIxftCckgUP5S6BR2pt9PnHemFa6xmtm
         MVsw==
X-Gm-Message-State: AOUpUlHxkjm8DGMlYT8mM5vqmLHbiqZrF/q3USKoQmClVs2uiVhtVrgM
        OrCkA+JVxJSU0A0CpluDTuydfLCg
X-Google-Smtp-Source: AA+uWPyywEAcGlk2PebxWdfJP0URPZnY1ZLbeq9/32VRk/Lbv2QrV2eQ2H8PA7/Wc5zQkiuRnUsPBg==
X-Received: by 2002:a2e:8950:: with SMTP id b16-v6mr7411469ljk.111.1534176944484;
        Mon, 13 Aug 2018 09:15:44 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:43 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 22/24] apply.c: make init_apply_state() take a struct repository
Date:   Mon, 13 Aug 2018 18:14:39 +0200
Message-Id: <20180813161441.16824-23-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're moving away from the_index in this code. "struct index_state *"
could be added to struct apply_state. But let's aim long term and put
struct repository here instead so that we could even avoid more global
states in the future. The index will be available via
apply_state->repo->index.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c         | 2 ++
 apply.h         | 4 ++++
 builtin/am.c    | 2 +-
 builtin/apply.c | 2 +-
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 572cd639a6..3704850ef2 100644
--- a/apply.c
+++ b/apply.c
@@ -76,10 +76,12 @@ static int parse_ignorewhitespace_option(struct apply_state *state,
 }
 
 int init_apply_state(struct apply_state *state,
+		     struct repository *repo,
 		     const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
+	state->repo = repo;
 	state->apply = 1;
 	state->line_termination = '\n';
 	state->p_value = 1;
diff --git a/apply.h b/apply.h
index 01963b5ec4..78c8bcfc3c 100644
--- a/apply.h
+++ b/apply.h
@@ -1,6 +1,8 @@
 #ifndef APPLY_H
 #define APPLY_H
 
+struct repository;
+
 enum apply_ws_error_action {
 	nowarn_ws_error,
 	warn_on_ws_error,
@@ -62,6 +64,7 @@ struct apply_state {
 	int unsafe_paths;
 
 	/* Other non boolean parameters */
+	struct repository *repo;
 	const char *index_file;
 	enum apply_verbosity apply_verbosity;
 	const char *fake_ancestor;
@@ -116,6 +119,7 @@ int apply_parse_options(int argc, const char **argv,
 			int *force_apply, int *options,
 			const char * const *apply_usage);
 int init_apply_state(struct apply_state *state,
+		     struct repository *repo,
 		     const char *prefix);
 void clear_apply_state(struct apply_state *state);
 int check_apply_state(struct apply_state *state, int force_apply);
diff --git a/builtin/am.c b/builtin/am.c
index 2c19e69f58..9f7ecf6ecb 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1464,7 +1464,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	int force_apply = 0;
 	int options = 0;
 
-	if (init_apply_state(&apply_state, NULL))
+	if (init_apply_state(&apply_state, the_repository, NULL))
 		BUG("init_apply_state() failed");
 
 	argv_array_push(&apply_opts, "apply");
diff --git a/builtin/apply.c b/builtin/apply.c
index 48d3989331..3f099b9605 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -16,7 +16,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct apply_state state;
 
-	if (init_apply_state(&state, prefix))
+	if (init_apply_state(&state, the_repository, prefix))
 		exit(128);
 
 	argc = apply_parse_options(argc, argv,
-- 
2.18.0.1004.g6639190530

