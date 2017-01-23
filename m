Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C83C20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbdAWWwk (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:52:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33600 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdAWWwj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:52:39 -0500
Received: by mail-wm0-f68.google.com with SMTP id r144so30038116wme.0
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gof4dTBCVbnJ5rqfG78FexSctAmvVm3x4NomlbKqRk4=;
        b=mxy7Im4A7d2d0fkIKXx+LUVNtAYHp95uBh7tlhyVoF6K05xtOvOodi+u4nnaPaLNGB
         e50BeKP3V48gHQN9WF38s4mCjfT3x5sdUS8Mt4dSexsxia394NOdT+AwYsAD7LJrqtQo
         t4WbF5cwLO5a3mhp16roFhRTUx8O6oNiYRkL7y9ThB7njPdCuzpH6Xe0KOVQUmBg6x6N
         Kq4eAFJ6dk2GKtWB+khQG6EPzvWZDWwreyGIdqiaGvURjyH1WgG4AyYzKLG6Ni0ni+lV
         M4buJRP+eYYUS3RITuCxUf8LGsY21nLg48VOjCdXCi2/1G3Z/PY462i9AXbox9GbWv/5
         t5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gof4dTBCVbnJ5rqfG78FexSctAmvVm3x4NomlbKqRk4=;
        b=QVCdPpWTRfhdx8gXAiPqCpuQZsl/eeekI/LjXnOndduKE10mqgJ2NL0pU6H3FDWs2I
         9zkK/S0kFdXCTGcCqDSotOxipyRhXemLkwzJvs2zsWJadKfq9zKR2s8dJGwZtGWot890
         7+i1wNnITXvlwHBoL7gvkQCTMPhJSRCvkxIUA4J30BzmtmIxXWKZFso5pJGyWfcu4Wh7
         GoAeyd6AuCSF6l1DwajiVBQftFM+D1c7sieTAQbnH1c+iCDhA4W7F83ILPfaX3d6mR9H
         dJ7TQ//Zslb2UENqDVUOx4EOLv9tP/IdPPeRHeXidli45I8JEpJiIbmoNOds83YboFWI
         Q7rw==
X-Gm-Message-State: AIkVDXL7glh5PURr2vzGwgXFlB7Tulrf0YdAYkGNtBuX7HT3IiJO1PmLM7diKK/u9Uk40Q==
X-Received: by 10.28.94.2 with SMTP id s2mr14443754wmb.127.1485211958058;
        Mon, 23 Jan 2017 14:52:38 -0800 (PST)
Received: from localhost ([151.74.133.189])
        by smtp.gmail.com with ESMTPSA id e72sm947039wma.16.2017.01.23.14.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jan 2017 14:52:37 -0800 (PST)
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 1/5] sequencer: sort options load/save by struct position
Date:   Mon, 23 Jan 2017 23:52:17 +0100
Message-Id: <20170123225221.3659-2-giuseppe.bilotta@gmail.com>
X-Mailer: git-send-email 2.11.0.616.gd72966cf44.dirty
In-Reply-To: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
References: <20170123225221.3659-1-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No functional change. The order in which options are serialized and
reloaded is now the same in which they appear in the replay_opts
structure. This makes it easier to spot when we forget to
serialize/reload an option value.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 sequencer.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9adb7bbf1d..672c81b559 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -975,22 +975,22 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 	if (!value)
 		error_flag = 0;
-	else if (!strcmp(key, "options.no-commit"))
-		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.edit"))
 		opts->edit = git_config_bool_or_int(key, value, &error_flag);
-	else if (!strcmp(key, "options.signoff"))
-		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
 		opts->record_origin = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.no-commit"))
+		opts->no_commit = git_config_bool_or_int(key, value, &error_flag);
+	else if (!strcmp(key, "options.signoff"))
+		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
 		opts->allow_ff = git_config_bool_or_int(key, value, &error_flag);
 	else if (!strcmp(key, "options.mainline"))
 		opts->mainline = git_config_int(key, value);
-	else if (!strcmp(key, "options.strategy"))
-		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.gpg-sign"))
 		git_config_string_dup(&opts->gpg_sign, key, value);
+	else if (!strcmp(key, "options.strategy"))
+		git_config_string_dup(&opts->strategy, key, value);
 	else if (!strcmp(key, "options.strategy-option")) {
 		ALLOC_GROW(opts->xopts, opts->xopts_nr + 1, opts->xopts_alloc);
 		opts->xopts[opts->xopts_nr++] = xstrdup(value);
@@ -1223,14 +1223,14 @@ static int save_opts(struct replay_opts *opts)
 	const char *opts_file = git_path_opts_file();
 	int res = 0;
 
-	if (opts->no_commit)
-		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
 	if (opts->edit)
 		res |= git_config_set_in_file_gently(opts_file, "options.edit", "true");
-	if (opts->signoff)
-		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file, "options.record-origin", "true");
+	if (opts->no_commit)
+		res |= git_config_set_in_file_gently(opts_file, "options.no-commit", "true");
+	if (opts->signoff)
+		res |= git_config_set_in_file_gently(opts_file, "options.signoff", "true");
 	if (opts->allow_ff)
 		res |= git_config_set_in_file_gently(opts_file, "options.allow-ff", "true");
 	if (opts->mainline) {
@@ -1239,10 +1239,10 @@ static int save_opts(struct replay_opts *opts)
 		res |= git_config_set_in_file_gently(opts_file, "options.mainline", buf.buf);
 		strbuf_release(&buf);
 	}
+	if (opts->gpg_sign)
+		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->strategy)
 		res |= git_config_set_in_file_gently(opts_file, "options.strategy", opts->strategy);
-	if (opts->gpg_sign)
-		res |= git_config_set_in_file_gently(opts_file, "options.gpg-sign", opts->gpg_sign);
 	if (opts->xopts) {
 		int i;
 		for (i = 0; i < opts->xopts_nr; i++)
-- 
2.11.0.616.gd72966cf44.dirty

