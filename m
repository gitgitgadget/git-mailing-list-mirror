Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B3AE1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 15:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfA2PD3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 10:03:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38539 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbfA2PDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 10:03:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so22404598wrw.5
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 07:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyXVmiPUOy/7vpmjSQtFxJ8ZMnwEugQPRgDOriSXTms=;
        b=elu4W2IF+2FZzr3ezBVHzjcPOzbl0XX5PY4MNreu3TxlG5b8TKcRiu45GaYic0qlCl
         eEfwRacdxeVM6W4bnExBY92+s539N1/OCquQYn962czN3N7vERtKx47CovrFv2z6NUi+
         skyIfVgufi0mRuhNsFtES2RRpx+J0COE0IEufQ2ggXan2DMujtAd00ej83EMviZBf2G0
         UQ1MWAs2CObYPxpMxjQSluBLA5u+CgSZjtEES+RNS579fSpxhZwmCjQO5RMWFRiA/601
         JOLgzl676ipI2umjSOy4qWdGQbd0JTDh2jEDmd10V7EdC5s/2MWRBRm4KELkjl4u2Yug
         owZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyXVmiPUOy/7vpmjSQtFxJ8ZMnwEugQPRgDOriSXTms=;
        b=cxZJ52Z30pvK002mBb+08GUM7U8/QK2DUcjTALLBdiMGKchjWs8vN4w7ignUVU3JlS
         rUUEuj2Ebzq/xmJ4tOemi+58ZffcQo1/nyeAEEP5xMV0agoFchcUgD3wuUuBJfUfxzIx
         o/PlVH2fYu3x8wUs5Orkon9O2DQW0M90W+xq32fcjPyQgIVp0EjAk9Wd202KbiVB+TBQ
         EFUX0Ms3QeW+LAyO28CypMH4iuqSLlE6/mpviFknrpNb00uOLEn3a2fARrOEIlUFcQzQ
         Wwslz9PYn3C8LXzo9tu7BhzE68FYbqpx0KbfK6oum7RN60azH4k2RQihyvh+np6qo4e8
         BokQ==
X-Gm-Message-State: AHQUAuarNkqE4SbDN4kDEqS/Lj2ykoAqN75ZOBPP5pwqO+NlthOd1Xqy
        oJcR7b7JX9tZZYzDSBC528pMpFDJ
X-Google-Smtp-Source: AHgI3IYtloxXBjEwt7ndP3c4sWNYOgKnhNL9Npty8s9GbBbeqTt1r38LSKsISl7rlXnbaEcdXxl33A==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr10925644wrw.14.1548774197455;
        Tue, 29 Jan 2019 07:03:17 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-47-104.w86-221.abo.wanadoo.fr. [86.221.54.104])
        by smtp.googlemail.com with ESMTPSA id 129sm4420851wmd.18.2019.01.29.07.03.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:03:17 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v6 15/16] sequencer: use edit_todo_list() in complete_action()
Date:   Tue, 29 Jan 2019 16:01:58 +0100
Message-Id: <20190129150159.10588-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129150159.10588-1-alban.gruin@gmail.com>
References: <20190123205821.27459-1-alban.gruin@gmail.com>
 <20190129150159.10588-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This changes complete_action() to use edit_todo_list(), now that it can
handle the initial edit of the todo list.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 sequencer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8f47f0cf39..21b04e0642 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4709,6 +4709,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4733,24 +4734,16 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		return error(_("nothing to do"));
 	}
 
-	if (todo_list_write_to_file(r, todo_list, todo_file,
-				    shortrevisions, shortonto, -1,
-				    flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
-		return error_errno(_("could not write '%s'"), todo_file);
-
-	if (copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
-
-	if (launch_sequence_editor(todo_file, &new_todo.buf, NULL)) {
+	res = edit_todo_list(r, todo_list, &new_todo, shortrevisions,
+			     shortonto, flags);
+	if (res == -1)
+		return -1;
+	else if (res == -2) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 
 		return -1;
-	}
-
-	strbuf_stripspace(&new_todo.buf, 1);
-	if (new_todo.buf.len == 0) {
+	} else if (res == -3) {
 		apply_autostash(opts);
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
-- 
2.20.1

