Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51713C433E6
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B9164F64
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239635AbhBDTIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 14:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239604AbhBDTGs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 14:06:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C564C061793
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 11:06:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so2718497pfk.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=pjeD/5iII+wpd7eXuoJNZwQSxNEFcfUWISfFq8PAUkmz8o2JVc+0cj1OxJWsTH6dIu
         PmYfmp2dF0ELOU1W6X/Y4xhORiyGYsEur+WIuJfxuvZ9Nsz181rYFzu9PZPloFOzSh8s
         CuFXTdALzGIWW28BX/vAKsL7X+JCr4xhzwXV1yEYw4OMkbDkqImLLj9R1F8mRUqmvDlI
         y3yj2gqC7jE62pEnf/ol5tTVIyELbAuPdT5se1h9JGbHn/6tbKfG0ac3YEg0IF/YCBnp
         leblpxbpQ+StjH843RPxwZ/94x+uD4LFWtu63oT5G0WhAVK0t/b7rvhBCyt0VPn8Kovg
         hCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKNDGS89h3BP7A+kc9sS7Cfxp6AlmTx76lu6cpG0xto=;
        b=D7PzDWh9b6oTg1Zhiz8usRj1I/JvVeJgQoHtx6nbSv/QOPLirBGrv1TM7dOiEN15rK
         HvJ8G4Q49AccbZ/PDOvWugSJozKj023G1jEBJIQ7b9yVbfYEQRKgw7cGj2sjuQvL7k87
         BJjlgeLE0AKmbeNmKoBwcYrAAhYH3VjcXBkug9rR71Erf5szsED+0P3rtmAugOght8ue
         YX7rIZhAXlOhqTO7Anlh1gzyPt/nY32lKDhzYf60FKjdS9KgjGni58D3UU37CwBI8oJ3
         nocYGbXIUDFkiWQEpvd4aDihrXQpo9widkq/cOh5hpQU59FvFp0DJA6jLkGQStUtHcfm
         hMFg==
X-Gm-Message-State: AOAM533qmR8KfyUfDwWsRvcxyCuIs7vSxieskl6ziGEVRHmC8Mo2Nypc
        P+9bt0G4Bs7pfJwWIcaXCj1MfF0n7aOKJw==
X-Google-Smtp-Source: ABdhPJy68903wyaVx/fdHUFC9ijaZzRz482ebjCTkbOoqcc1q/VZU43F28n9kl2eZTRFeNTWWFjDBA==
X-Received: by 2002:a63:9811:: with SMTP id q17mr452755pgd.238.1612465567398;
        Thu, 04 Feb 2021 11:06:07 -0800 (PST)
Received: from localhost.localdomain ([2405:204:332c:6caa:c21:291b:12a6:463f])
        by smtp.googlemail.com with ESMTPSA id 9sm6729524pfo.1.2021.02.04.11.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:06:06 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, christian.couder@gmail.com,
        phillip.wood123@gmail.com, Charvi Mendiratta <charvi077@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 4/8] sequencer: pass todo_item to do_pick_commit()
Date:   Fri,  5 Feb 2021 00:35:03 +0530
Message-Id: <20210204190507.26487-5-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210204190507.26487-1-charvi077@gmail.com>
References: <20210129182050.26143-1-charvi077@gmail.com>
 <20210204190507.26487-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an additional member of the structure todo_item will be required in
future commits pass the complete structure.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 034149f24d..09cbb17f87 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1877,8 +1877,7 @@ static void record_in_rewritten(struct object_id *oid,
 }
 
 static int do_pick_commit(struct repository *r,
-			  enum todo_command command,
-			  struct commit *commit,
+			  struct todo_item *item,
 			  struct replay_opts *opts,
 			  int final_fixup, int *check_todo)
 {
@@ -1891,6 +1890,8 @@ static int do_pick_commit(struct repository *r,
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res, unborn = 0, reword = 0, allow, drop_commit;
+	enum todo_command command = item->command;
+	struct commit *commit = item->commit;
 
 	if (opts->no_commit) {
 		/*
@@ -4140,8 +4141,8 @@ static int pick_commits(struct repository *r,
 				setenv(GIT_REFLOG_ACTION, reflog_message(opts,
 					command_to_string(item->command), NULL),
 					1);
-			res = do_pick_commit(r, item->command, item->commit,
-					     opts, is_final_fixup(todo_list),
+			res = do_pick_commit(r, item, opts,
+					     is_final_fixup(todo_list),
 					     &check_todo);
 			if (is_rebase_i(opts))
 				setenv(GIT_REFLOG_ACTION, prev_reflog_action, 1);
@@ -4603,11 +4604,14 @@ static int single_pick(struct repository *r,
 		       struct replay_opts *opts)
 {
 	int check_todo;
+	struct todo_item item;
+
+	item.command = opts->action == REPLAY_PICK ?
+			TODO_PICK : TODO_REVERT;
+	item.commit = cmit;
 
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(r, opts->action == REPLAY_PICK ?
-			      TODO_PICK : TODO_REVERT, cmit, opts, 0,
-			      &check_todo);
+	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
 int sequencer_pick_revisions(struct repository *r,
-- 
2.29.0.rc1

