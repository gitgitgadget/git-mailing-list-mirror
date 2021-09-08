Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3E8C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69AC60E97
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 13:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344707AbhIHNm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbhIHNm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 09:42:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10663C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 06:41:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d6so3338381wrc.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rmRBP5gqh6McvajV8o0dq4SeUyNVcIizrxGNl0q3wLA=;
        b=Hib0Vetz4dGa4chjUXHhyZR/z8k4kxOaQ4zQEUcUQFexFNn3It2ZjHxDb+3ZqqdTor
         q+h+osgczpWOhg3J+7sQdZ74BIK92mmBxG3xyfk36GspZ8B+VA7117cRaFW/Im+y+hQQ
         t/lb4F7LXojBEPR5/bKheofOWo8SuHSfgGJoo0tzVjtA/2u6FTQiXwCbuMeCwyLaDlA8
         nZbqKVD4GvoSgCV/vsULFBFGzvqN+lseWUgj66WHFbFqQVAN+XXagDNB1NSlsjeKuAj2
         2fnR4nofNZdDeMuN3uxwqKCaPNyVklGCNDgPzVyK3mvbjq8VVHwpy4sMK9tAJkSJAEy1
         vL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rmRBP5gqh6McvajV8o0dq4SeUyNVcIizrxGNl0q3wLA=;
        b=r3KJTNwHt61P9Gdvqbupwz2fuI8HKez6tHVqPbqh5cVOd98641V7DTSA13anrdnXlw
         XKSveObDP7MGys8HkehIvcCe0WYEKggYoNdaIDr/ZB3GuLcC/neg1XjEWgQiZuWb85MQ
         sBH3N41HtSPFQ+z64oNitHZaVniUVF+ptc/+Vmg6Kq8OaWwA0lwBabqb7cwMEv+SkCMS
         Bc5aPMDUpSU2N2fxCzMNtqOvVXkQXrLUIoG+2F21jS0adt/B+LCwkvdiQ3AQe5/u76dp
         C8xwxNvdjeGxni57vTiNisRO5rS3ZBXOwcuyfP6XrVd/4rG4JMZtBLwgRwnn6oWrEc3q
         1KIw==
X-Gm-Message-State: AOAM530i7w+3VBRxtOmAFmKuxFXRNJpLXrl7EKtagfJNDH5u8d7XwUHk
        fmDSDKtCbLXJSMoxQqkJy5COGRk6KZM=
X-Google-Smtp-Source: ABdhPJxljw0oWw3yP7QGKCNiC3ZhydjitD0BYSzvV/vf7LLIwh8ZSHndxnxOqdlZekZgPpwzgf8ylQ==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr4115189wrt.57.1631108476698;
        Wed, 08 Sep 2021 06:41:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm2621172wrc.26.2021.09.08.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 06:41:16 -0700 (PDT)
Message-Id: <c8a92d4242b4dfad71297d1eec9c3ef658641193.1631108472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 13:41:12 +0000
Subject: [PATCH 5/5] rebase: remove unused parameter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that we use reset_head() we don't need to pass orig_head around.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c |  3 +--
 sequencer.c      | 12 +++++-------
 sequencer.h      |  5 ++---
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d9..1520f75a491 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -377,8 +377,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head, &commands, opts->autosquash,
-			&todo_list);
+			&commands, opts->autosquash, &todo_list);
 	}
 
 	string_list_clear(&commands, 0);
diff --git a/sequencer.c b/sequencer.c
index 1a9dbc70d3c..a7ea60a7a82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4193,8 +4193,7 @@ int apply_autostash_oid(const char *stash_oid)
 }
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
-			 const char *onto_name, const struct object_id *onto,
-			 const struct object_id *orig_head)
+			 const char *onto_name, const struct object_id *onto)
 {
 	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
 
@@ -5567,9 +5566,8 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const struct object_id *orig_head,
-		    struct string_list *commands, unsigned autosquash,
-		    struct todo_list *todo_list)
+		    struct commit *onto, struct string_list *commands,
+		    unsigned autosquash, struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
 	const char *todo_file = rebase_path_todo();
@@ -5616,7 +5614,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 		return error(_("nothing to do"));
 	} else if (res == -4) {
-		checkout_onto(r, opts, onto_name, &onto->object.oid, orig_head);
+		checkout_onto(r, opts, onto_name, &onto->object.oid);
 		todo_list_release(&new_todo);
 
 		return -1;
@@ -5644,7 +5642,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 
 	res = -1;
 
-	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
+	if (checkout_onto(r, opts, onto_name, &oid))
 		goto cleanup;
 
 	if (require_clean_work_tree(r, "rebase", "", 1, 1))
diff --git a/sequencer.h b/sequencer.h
index cdeb0c6be47..352b24014bb 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -163,9 +163,8 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const struct object_id *orig_head,
-		    struct string_list *commands, unsigned autosquash,
-		    struct todo_list *todo_list);
+		    struct commit *onto, struct string_list *commands,
+		    unsigned autosquash, struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
-- 
gitgitgadget
