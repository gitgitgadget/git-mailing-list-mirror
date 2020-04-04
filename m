Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9DC2BA17
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E2620787
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 01:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTHEKduf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDDBMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 21:12:15 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46335 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgDDBMK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 21:12:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id g7so8087222qtj.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 18:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pl1XNZPlETb/eF7+ncdGisECAzly55YIoQ5HmWsqVoQ=;
        b=DTHEKdufZ9W4nXMSkjFEK7/tplqeweWvyp1X7xBtEKZndN6znkVGEt8a4sjF+DNxg2
         zolP0e8eethnqkkYBmAH3YYTO+ePXZBuAu289310mSkxLxza8dtXARgFU+8YOnNjXqBe
         FMX1s78XHMUnDQTsRY9Av3rs1S38fm9PLFj2X6Do0JFys39mSQebwwpXEPjPL7EP/zoN
         eDKT4Yfq8/61S3prFOPTwfJAFQP3z0r4GdmH1CCiXTZbouXPeo96QZRPF32QjtLXuMW0
         5WtVk3YiOvXv+HQE7ldawcJqhZtvCQjhe8s8DAxbVKe+pZidValX4BI6VGLCcICX7Q0B
         Rxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pl1XNZPlETb/eF7+ncdGisECAzly55YIoQ5HmWsqVoQ=;
        b=Z3Pn2zkmIJJASGB8s19YbHIw/+KJGOmVJ17qwwZLw0FcJ7zOs2X7cD/8POz6VgFytg
         nNbfT2L3/M3uktblyGcRmI70jBHqR85ghYJsejQmQ8eBYtz3U9MZVfbrjTNG0idIP+RU
         DZK7mMZMWDbZp8rF0qtMr5NUlhv4KMHRmtajYLbx8f1fd4+2m29nJ0tfgYcHwzDulTsW
         mMBKggyg3QFtI/Uayp0Oqcp1HxrgiRtyYbAjLt9KbUDJuITJ3ZgGb2xmXWoXqngcdzek
         w+QnXqYXRRylSnNnmItQEjkdbYsSKT4it3bzdzbCpSGoxl7bi8KfnwtrYwvDzxfYcEZo
         1Oag==
X-Gm-Message-State: AGi0PuaJyf0MPtmyS/mxbVXlLoKLKHYSz623BlFuQNs0yywrjLtGFenE
        BvXd6SOmFbdJOOZGLLR9d9Qj8jSX
X-Google-Smtp-Source: APiQypKKFg5wOxeC9g1yMU0rceRnWjaKvO+FoJqFG9QA9Jq68OPh54BXvdi24napyAdQ4moSNYVw+w==
X-Received: by 2002:ac8:4a94:: with SMTP id l20mr11213190qtq.302.1585962729302;
        Fri, 03 Apr 2020 18:12:09 -0700 (PDT)
Received: from localhost.localdomain (ktnron0919w-grc-01-76-68-143-128.dsl.bell.ca. [76.68.143.128])
        by smtp.gmail.com with ESMTPSA id a136sm3297503qkc.75.2020.04.03.18.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 18:12:08 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 10/23] sequencer: make apply_rebase() accept a path
Date:   Fri,  3 Apr 2020 21:11:23 -0400
Message-Id: <e0b8e409afbf8d90b4fc6406a67a1a1e930e022f.1585962673.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585962672.git.liu.denton@gmail.com>
References: <cover.1584782450.git.liu.denton@gmail.com> <cover.1585962672.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to make apply_rebase() more generic for future extraction, make
it accept a `path` argument so that the location from where to read the
reference to the autostash commit can be customized. Remove the `opts`
argument since it was unused before anyway.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 sequencer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index d1d59867ae..ae9efe5825 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3649,13 +3649,13 @@ static enum todo_command peek_command(struct todo_list *todo_list, int offset)
 	return -1;
 }
 
-static int apply_autostash(struct replay_opts *opts)
+static int apply_autostash(const char *path)
 {
 	struct strbuf stash_sha1 = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
 	int ret = 0;
 
-	if (!read_oneliner(&stash_sha1, rebase_path_autostash(),
+	if (!read_oneliner(&stash_sha1, path,
 			   READ_ONELINER_SKIP_IF_EMPTY)) {
 		strbuf_release(&stash_sha1);
 		return 0;
@@ -3748,7 +3748,7 @@ static int checkout_onto(struct repository *r, struct replay_opts *opts,
 		return error(_("%s: not a valid OID"), orig_head);
 
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
@@ -4061,7 +4061,7 @@ static int pick_commits(struct repository *r,
 				run_command(&hook);
 			}
 		}
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 
 		if (!opts->quiet) {
 			if (!opts->verbose)
@@ -5070,7 +5070,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		todo_list_add_exec_commands(todo_list, commands);
 
 	if (count_commands(todo_list) == 0) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return error(_("nothing to do"));
@@ -5081,12 +5081,12 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 	if (res == -1)
 		return -1;
 	else if (res == -2) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 
 		return -1;
 	} else if (res == -3) {
-		apply_autostash(opts);
+		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		todo_list_release(&new_todo);
 
-- 
2.26.0.159.g23e2136ad0

