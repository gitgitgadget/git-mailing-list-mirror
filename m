Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166BFC388F9
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE87C20759
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y433xziF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgKDP3o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 10:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgKDP3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 10:29:44 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013E7C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 07:29:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id s9so22473182wro.8
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 07:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nhmrFfg9H1W5Mc/KWknNzUEGeo+2XoLBO1n5LYNNp0M=;
        b=Y433xziF13utokunhnVy1evkP3DnVP09B11uS35B6YXgjldNTZwNBqe63Qe7HmHLY9
         6FdR6zE/7W8Acz3XmGhg+FBC5DXfMJQqzzT/M4eFRCPyVyC9q8khwsYjfIeRrdmR+r5e
         dqD3tVWRKtmnnKXFXk/ow9bkgbkQSg6EMhUlMuKxovi9ItpzGGmxpmKHkrqcwH1/OIwz
         6Pr1vNUeLGZy1h3ogdOisIaZrNa3HOfa91ntEninEt82fgo2MMURFdChsj+V8xm5iUSu
         Ls72HLzte0o60cM3p5Cv+pmEgMYbBOavCCqmZsS5aBDc8sWKzuQ+n6KqMEXdFtxT+sZo
         /nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nhmrFfg9H1W5Mc/KWknNzUEGeo+2XoLBO1n5LYNNp0M=;
        b=dHqvmcl5Qyv7DzvbMq8tHJxELMAMFIlL3livhnCCMqI3VjsaPWzFvxV/9kpD7kapRc
         rGU+nGqL6oZnFN7dbBvLCr42+L0W4iMrHDqFmbOGhwbvHJPaAuaRfGMn8/AO18IGkSk+
         T7h3LhRvrDnYdvuV52jHy+3Hu03yLXD7IzEf0KEtxuMNU2zTEFqSVVyVoF5sfgrJoCvG
         N67YEMhipII2VRRU5WSXrkCNgWPJ7Sq/eQzzbUNWHPhmyrmDKAJsq0eKHQIvVpO5a8xT
         bx8h8c6SrAwqhKJ5xTcBSBUmhr5jTq/R9ETkfwsbzReM7r/xD4caecyBf4VSE2XXe/Eb
         U8aA==
X-Gm-Message-State: AOAM532FgKkA0L9qM6rPdBrfdbJ2lrSIoX2RpPr5j/PlifLzCS9y/m3U
        qiehe4SRHwPs3m+1Vdil+WkkfSRaqhQ=
X-Google-Smtp-Source: ABdhPJyuf1LYBqSVXEHt+88Ey/tWECc9g3OE7DWnkE529i5wOAhYzDqjMsmNT/tgtQ+/5e/Uo6wCFA==
X-Received: by 2002:adf:edcf:: with SMTP id v15mr31078290wro.291.1604503782409;
        Wed, 04 Nov 2020 07:29:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm2962346wrk.28.2020.11.04.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:29:41 -0800 (PST)
Message-Id: <pull.773.v2.git.1604503780.gitgitgadget@gmail.com>
In-Reply-To: <pull.773.git.1603807337.gitgitgadget@gmail.com>
References: <pull.773.git.1603807337.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Nov 2020 15:29:36 +0000
Subject: [PATCH v2 0/4] rebase -i: fix ORIG_HEAD handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer containing the oid for ORIG_HEAD is overwritten before ORIG_HEAD
is created. This series fixes that bug and then converts the code to use
struct object_id rather than passing around strings.

Thanks to Caspar for reporting the bug and providing a reproducible example

Changes since v1:

 * Updated the commit message to patch 1 as suggested by Junio
 * Moved the conversion from find_unique_abbrev() to oid_to_hex() from patch
   1 to patch 4
 * Fixed a compilation error in patch 3 (the required change was in patch 4
   by a mistake)

Cc: Johannes Schindelin Johannes.Schindelin@gmx.de
[Johannes.Schindelin@gmx.de], Caspar Duregger herr.kaste@gmail.com
[herr.kaste@gmail.com]

Phillip Wood (4):
  rebase -i: stop overwriting ORIG_HEAD buffer
  rebase -i: use struct object_id rather than looking up commit
  rebase -i: use struct object_id when writing state
  rebase -i: simplify get_revision_ranges()

 builtin/rebase.c              | 20 ++++++++++----------
 sequencer.c                   | 15 ++++++---------
 sequencer.h                   |  7 ++++---
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 4 files changed, 31 insertions(+), 22 deletions(-)


base-commit: 2e673356aefa8ed19be3c878f966ad6189ecb510
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-773%2Fphillipwood%2Fwip%2Frebase-fix-orig_head-handling-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-773/phillipwood/wip/rebase-fix-orig_head-handling-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/773

Range-diff vs v1:

 1:  24f2c4a623 ! 1:  da05958c58 rebase -i: stop overwriting ORIG_HEAD buffer
     @@ Metadata
       ## Commit message ##
          rebase -i: stop overwriting ORIG_HEAD buffer
      
     -    After rebasing ORIG_HEAD is supposed to point to the old HEAD of the
     -    rebased branch. Unfortunately the buffer storing the oid was
     -    overwritten with a new oid before ORIG_HEAD was created. The buffer is
     -    also used when writing .git/rebase-merge/orig-head which is used by
     -    `rebase --abort` to restore the previous head. Luckily that file is
     -    written before the buffer is overwritten.  As we want the full oid
     -    find_unique_abbrev() is replaced with oid_to_hex_r() rather than
     -    find_unique_abbrev_r().
     +    After rebasing, ORIG_HEAD is supposed to point to the old HEAD of the
     +    rebased branch.  The code used find_unique_abbrev() to obtain the
     +    object name of the old HEAD and wrote to both
     +    .git/rebase-merge/orig-head (used by `rebase --abort` to go back to
     +    the previous state) and to ORIG_HEAD.  The buffer find_unique_abbrev()
     +    gives back is volatile, unfortunately, and was overwritten after the
     +    former file is written but before ORIG_FILE is written, leaving an
     +    incorrect object name in it.
     +
     +    Avoid relying on the volatile buffer of find_unique_abbrev(), and
     +    instead supply our own buffer to keep the object name.
      
          I think that all of the users of head_hash should actually be using
          opts->orig_head instead as passing a string rather than a struct
          object_id around is a hang over from the scripted implementation. This
          patch just fixes the immediate bug and adds a regression test based on
     -    Caspar's reproduction example. The users will be converted to use
     +    Caspar's reproduction example[1]. The users will be converted to use
          struct object_id and head_hash removed in the next few commits.
      
     +    [1] https://lore.kernel.org/git/CAFzd1+7PDg2PZgKw7U0kdepdYuoML9wSN4kofmB_-8NHrbbrHg@mail.gmail.com
     +
          Reported-by: Caspar Duregger <herr.kaste@gmail.com>
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
       	const char *shorthead;
       
      -	*head_hash = find_unique_abbrev(orig_head, GIT_MAX_HEXSZ);
     -+	oid_to_hex_r(head_hash, orig_head);
     ++	find_unique_abbrev_r(head_hash, orig_head, GIT_MAX_HEXSZ);
       	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
      -						   *head_hash);
      +						   head_hash);
 2:  589aed08f1 = 2:  da499f1e4c rebase -i: use struct object_id rather than looking up commit
 3:  11494a7b79 ! 3:  076d212915 rebase -i: use struct object_id when writing state
     @@ builtin/rebase.c: static int get_revision_ranges(struct commit *upstream, struct
       {
       	FILE *interactive;
       
     +@@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
     + 
     + 	if (init_basic_state(&replay,
     + 			     opts->head_name ? opts->head_name : "detached HEAD",
     +-			     opts->onto, head_hash)) {
     ++			     opts->onto, &opts->orig_head)) {
     + 		free(revisions);
     + 		free(shortrevisions);
     + 
      
       ## sequencer.c ##
      @@ sequencer.c: static void write_strategy_opts(struct replay_opts *opts)
 4:  ed78f8628a ! 4:  faae3ccff5 rebase -i: simplify get_revision_ranges()
     @@ Commit message
          use a opts->orig_head instead we can stop returning head_hash from
          get_revision_ranges().
      
     +    Because we want to pass the full object names back to the caller in
     +    `revisions` the find_unique_abbrev_r() call that was used to initialize
     +    `head_hash` is replaced with oid_to_hex().
     +
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## builtin/rebase.c ##
     @@ builtin/rebase.c: static int edit_todo_file(unsigned flags)
       	struct commit *base_rev = upstream ? upstream : onto;
       	const char *shorthead;
       
     --	oid_to_hex_r(head_hash, orig_head);
     +-	find_unique_abbrev_r(head_hash, orig_head, GIT_MAX_HEXSZ);
       	*revisions = xstrfmt("%s...%s", oid_to_hex(&base_rev->object.oid),
      -						   head_hash);
      +			     oid_to_hex(orig_head));
     @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts,
       		return -1;
       
       	if (init_basic_state(&replay,
     - 			     opts->head_name ? opts->head_name : "detached HEAD",
     --			     opts->onto, head_hash)) {
     -+			     opts->onto, &opts->orig_head)) {
     - 		free(revisions);
     - 		free(shortrevisions);
     - 

-- 
gitgitgadget
