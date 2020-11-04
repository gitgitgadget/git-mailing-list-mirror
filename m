Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F0C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0722074F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmYyZ0jI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgKDPaD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgKDP3v (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:29:51 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E6C061A4A
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:29:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so2694832wmj.5
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AzLOdnXEICj4FHUvX2bZwJp8OrMxEniBQ8k+UfjODZ8=;
        b=jmYyZ0jIDB31Av6nECr9ZvQ7cANLx7tQ2QmMFLCllDiSL13PBiMzTusSmYubj+Rvfz
         xI17aNa1hnapHNGLYZ2f8gNzaI607PrOwRziqdhVfkqRGcDUzHTBv997JV3tHO+oHvkb
         5s7UHCvLWqAMxOQqmIuHA4YB+0hK+Z7UGkVuP72tRFJ5eL3ZC9WgpJ1+ZR6plQ7VfMx9
         VwQUyw2Pvtst08FRH141cnpUdD+st7rUI3PDj0nEbZgdoJnCwmhY1ThGE9AG/vVuAiv+
         V4O4T5EzjLq7vUovWTMD4pf/yzqA6n9tclZwV/6Uz5Whw6bdwu4nIHKzcni92UOl8hkH
         fuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AzLOdnXEICj4FHUvX2bZwJp8OrMxEniBQ8k+UfjODZ8=;
        b=FPHPL3YWvAn1P84mj6x2iEIbD+/ZMSP3yBP3fbQ+P3jDoJOfGJMyGyktQ3dQWsv3ll
         6F/M54fK2xtUunrA0a9HYwSVVnbvOvVVNSNp5sQHBKQmOTID39ZM5nzA9/klQs2DOs12
         dVSwubNLPL25VyNHDhJcS+TW67viwhWzXV5F0yKpSEEQvg/3Xe+0bnw5wsywTJZQ8fPF
         XAlZ9nYIJhwUlQsGzhgzLOqLPv7Fy2nWkCrASzeKEcp6mlHm5RioF9NUDYXkGUEXi19m
         tIHydbHu/hE9f1SagQjbP/zZ2xLm+G6maJoEwJC2yXvSGoO2arTMFLXAKd4ZvcYrcvQq
         kiig==
X-Gm-Message-State: AOAM532dWFnH3jyts+xjT7csc3k7yuykJuoIJD4R2BUS49PGGmFTIiXc
        xFzDVJcdKdhvS9QSnKZkjUi12s5EBXY=
X-Google-Smtp-Source: ABdhPJwngqM6iHx4aws7UyFdwD0MrqP90O+MXz7LBoEWnrFxyzFIcE9aAIFBi0tpJzswD55TstCy9g==
X-Received: by 2002:a7b:c748:: with SMTP id w8mr5200191wmk.32.1604503785157;
        Wed, 04 Nov 2020 07:29:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm3188785wrw.36.2020.11.04.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:29:44 -0800 (PST)
Message-Id: <da499f1e4cc1fc949aff0089898d0275d3997acd.1604503780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
        <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 15:29:38 +0000
Subject: [PATCH v2 2/4] rebase -i: use struct object_id rather than looking up
 commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We already have a struct object_id containing the oid that we want to
set ORIG_HEAD to so use that rather than converting it to a string and
then calling get_oid() on that string.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c |  5 +++--
 sequencer.c      | 10 +++-------
 sequencer.h      |  5 +++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index cd101b2559..4e4a5e774e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -370,8 +370,9 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 
 		split_exec_commands(opts->cmd, &commands);
 		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto, head_hash,
-			&commands, opts->autosquash, &todo_list);
+			shortrevisions, opts->onto_name, opts->onto,
+			&opts->orig_head, &commands, opts->autosquash,
+			&todo_list);
 	}
 
 	string_list_clear(&commands, 0);
diff --git a/sequencer.c b/sequencer.c
index 00acb12496..f79c3df861 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3965,21 +3965,17 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
-			 const char *orig_head)
+			 const struct object_id *orig_head)
 {
-	struct object_id oid;
 	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
 
-	if (get_oid(orig_head, &oid))
-		return error(_("%s: not a valid OID"), orig_head);
-
 	if (run_git_checkout(r, opts, oid_to_hex(onto), action)) {
 		apply_autostash(rebase_path_autostash());
 		sequencer_remove_state(opts);
 		return error(_("could not detach HEAD"));
 	}
 
-	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+	return update_ref(NULL, "ORIG_HEAD", orig_head, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 }
 
 static int stopped_at_head(struct repository *r)
@@ -5314,7 +5310,7 @@ static int skip_unnecessary_picks(struct repository *r,
 
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head,
+		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
 		    struct todo_list *todo_list)
 {
diff --git a/sequencer.h b/sequencer.h
index b2a501e445..ea56825488 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -163,8 +163,9 @@ void todo_list_add_exec_commands(struct todo_list *todo_list,
 				 struct string_list *commands);
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
-		    struct commit *onto, const char *orig_head, struct string_list *commands,
-		    unsigned autosquash, struct todo_list *todo_list);
+		    struct commit *onto, const struct object_id *orig_head,
+		    struct string_list *commands, unsigned autosquash,
+		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
 /*
-- 
gitgitgadget

