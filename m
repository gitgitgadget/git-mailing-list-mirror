Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF83C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D786561090
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbhIGVGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346800AbhIGVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:06:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9B7C0612E7
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 14:05:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so2836466wmn.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ytsj04nFhmbl4mk7gBcgown+uZa8IB5N3pzgrY2z1us=;
        b=XFIqqgr0wFHIDNvkAqK/uq4k4FslMkCEPFpdFfkU0r0gw/s2I5Ud7wk2VNH6b85VC+
         VJYg9V1DXstoqvXLC2fXJDJ10G2Bt03JLiFAXWyc2EfnSf36IPHVGqCZLrXCSiJO0LNM
         TzT/zZ3Vhn/C08s9aelM1vC+yzWuqnKx/UUIQX3LbCtcRYV7t+NIwGuZjinOl2T5b2Cx
         Jz9SFXAGLoDIqFRgryrOeFEhVXTQt96FnLVHO4hdDKVmovgodNCdo4xVUrzJ4QEykP2K
         A5L/Pkq9xDbLFT1Eq4ypH1YszVLwDPyfZOuAMWQKsGy/DIc2D0CqkNfdHDGhpRcy6JHW
         obRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ytsj04nFhmbl4mk7gBcgown+uZa8IB5N3pzgrY2z1us=;
        b=cHEQMyDWtsNEJqW/qYdvaTCIAOmXr98G/NKnSWHlV3B7ZZaPgJKThuwI0EPJNEW3np
         iR6eH3uJGIV44YbvINByAlPidH7yB/cI87qZ7lBazoplGQOfNR8lgbkQeh8fazutBjXE
         MnYTWoz/dJUAiKjk78iUE40RuB1RRF0t/Zg87ev35r/IJ1mvEvNZwH00stBvyWqOrGgR
         yWnYENYYNk/BeOL/vp1LWGav6iMnCpRQUPgywGFn3uY+8SP9W5XFh/Wx26yUmKV2n5d9
         CFiDahjYR933tcYd9gbUMsH9Wz+Z4BCmqWJyYm9YR9/FSGd3x1eoD7PeQD7war7Gl2PK
         ytAQ==
X-Gm-Message-State: AOAM531jYr9RSPxz5gYFjDnHoHmHGwfY9vHtgDAN9QUk1Z7Utt6vsV5c
        qviVY33r+E9VD1CaN0zyYkgQhm1rdEw=
X-Google-Smtp-Source: ABdhPJzU2/4U8rXy32oTF4oYhQezGSZpsfxCYKeY1iId2LUWHxgp6btqqx5Bqy/eg4Mb9Bexe2kBFg==
X-Received: by 2002:a05:600c:4309:: with SMTP id p9mr175671wme.174.1631048720971;
        Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u26sm127136wrd.32.2021.09.07.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 14:05:20 -0700 (PDT)
Message-Id: <aae9323b25fa9cdd69dcde278f9ac2c60539f153.1631048713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
References: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
        <pull.195.v3.git.1631048712.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 21:05:12 +0000
Subject: [PATCH v3 11/11] sequencer: restrict scope of a formerly public
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The function to add the `exec` commands to the todo list only needed to
be public API because it was not only used internally by the sequencer,
but also by `git rebase --preserve-merges`.

Now that that mode has been removed, we no longer need that function to
be scoped publicly.

Helped-by: Alban Gruin <alban.gruin@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 4 ++--
 sequencer.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7f07cd00f3f..3cdb20b0743 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5387,8 +5387,8 @@ int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
  * Add commands after pick and (series of) squash/fixup commands
  * in the todo list.
  */
-void todo_list_add_exec_commands(struct todo_list *todo_list,
-				 struct string_list *commands)
+static void todo_list_add_exec_commands(struct todo_list *todo_list,
+					struct string_list *commands)
 {
 	struct strbuf *buf = &todo_list->buf;
 	size_t base_offset = buf->len;
diff --git a/sequencer.h b/sequencer.h
index d57d8ea23d7..60a156ea906 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -160,8 +160,6 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
 			  const char **argv, unsigned flags);
 
-void todo_list_add_exec_commands(struct todo_list *todo_list,
-				 struct string_list *commands);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
-- 
gitgitgadget
