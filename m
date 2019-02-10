Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079461F453
	for <e@80x24.org>; Sun, 10 Feb 2019 13:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfBJN1c (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Feb 2019 08:27:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55281 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfBJN11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Feb 2019 08:27:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so12204441wmh.4
        for <git@vger.kernel.org>; Sun, 10 Feb 2019 05:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lmhlurXZsGsBs2IcDPWEncXOvBp+o8f/ujq4NdZ2avo=;
        b=UT4MHPxU4suCo2W2e/u7iD01qj6aNjlVhIu8MBlu3+/V1qA/lJ9yZdKFH4ccEsCMRx
         VXBD7Ef0vPBdp4rMfjyDHFKygZtrhsVyy4Ap2+Y39R+vScyAhQzjzE6/uwn0XQb4IUoj
         hkySq0OgCwWhMpwm9GhCrDbjV3QcCdQFaRpWrZNMdGlQ+TwzYkyzAI2+xphJRzZ5mYqR
         g7UMbcyCbUox4EZMFlk4m46x8bb5zPWvGRQfvFkBBhuSHLWxJnc9nMjgCj+ETn7Wxwtz
         rD8b/wX7wzRKbkhkF9q7L3AA/b1cyZp1k8u7TMIEkMFZYztSLdByKScZEMk8bGxDUN8Q
         g3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lmhlurXZsGsBs2IcDPWEncXOvBp+o8f/ujq4NdZ2avo=;
        b=bUG3XLyqZLMjZixP9mWFeCLI8JMPAHWN23FZaeGQuAVUA/rV8d9qZtU0bO2sgeYPef
         IMsfirjbRVLU+VikWuLIICEf958xcDAN/afoOzpYf4mwMxgL51fBKP5Fan+yo8qDYHZN
         KOvIos8ErCHFaTQEISfdiGTme6PaSQ6mWiEgiUOtcWDo/oecaYknDfRlCvDfuNuy5zDn
         7fLrurnqHFVxz/CHPrvvVDeOV16EdUYMYNcxJHQuxLO3cWn2I1N1rgl0CzQO5S0HhksG
         BYRA1J1NqZqQMbGCZ08Q5SuHl62U1taEB3yPJttH08ql2pZCJMY05S5Es6PbgTiHl9tt
         fEgw==
X-Gm-Message-State: AHQUAuZUYpOvTbKVTZaWsiR9o9QN3Z8BIHUofEy/bUnhyB6mC4JgGe6h
        2DQK3g1jNfw4sAo6/tUvy84Rgarx
X-Google-Smtp-Source: AHgI3IYLP6hYGpwfD9+WtzwgR2L+YmL99Hjurony/zNNXodT/i+C8mKRtflex2NPX5gQ0G3N6Ohbag==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr9079870wrw.316.1549805244359;
        Sun, 10 Feb 2019 05:27:24 -0800 (PST)
Received: from localhost.localdomain (atoulouse-658-1-21-92.w86-222.abo.wanadoo.fr. [86.222.20.92])
        by smtp.googlemail.com with ESMTPSA id z26sm5266314wml.44.2019.02.10.05.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:27:23 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 15/16] sequencer: use edit_todo_list() in complete_action()
Date:   Sun, 10 Feb 2019 14:26:47 +0100
Message-Id: <20190210132648.12821-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190210132648.12821-1-alban.gruin@gmail.com>
References: <20190129150159.10588-1-alban.gruin@gmail.com>
 <20190210132648.12821-1-alban.gruin@gmail.com>
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
No changes since v6.

 sequencer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index f6ed4e21e9..df8b239fdc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4765,6 +4765,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	struct todo_list new_todo = TODO_LIST_INIT;
 	struct strbuf *buf = &todo_list->buf;
 	struct object_id oid;
+	int res;
 
 	get_oid(onto, &oid);
 	shortonto = find_unique_abbrev(&oid, DEFAULT_ABBREV);
@@ -4789,24 +4790,16 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
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

