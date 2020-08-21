Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176ABC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D716420702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9gYqMrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHUREd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgHUQ7l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:59:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF449C061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so2550385wmj.5
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dHNM27XinzMglGnjtEfcchfbu6xBtIMvkpbi398dy5E=;
        b=s9gYqMrFLVUmgDJ0frlx4P9fEdvUyJpXEDT1jO2hfrq1ErSA+S3br8rvGRrf0RiINv
         gneldrjfoa5OXdY4dnmtbjWLXY3gnRB7CoOuQD+rp+sgETXO39QlWW7+3GZPlE2pLSCo
         vdq1LgHNpU5+7vPKTugVprIK6QQ39n90lJKXO4LkXqJP5OW2R7WZ6XFjSdN0eLgAB3b+
         KJRB0QOMNtdsIsP/OE2KZG4587TLaqG8E2XxSiWEe4WiEBO/KPyWmtcxF1Or0czJp0dQ
         qCtemWWXbx/Yfz7wJBYFn2IY6IXhJJ2mzwf4E4DeV4MMhpO73AElam6UOqhy5thhrEOK
         TgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dHNM27XinzMglGnjtEfcchfbu6xBtIMvkpbi398dy5E=;
        b=Ft+xJeWC6vWcvn7JbnuQsTmB/GEw8hI2T/pU+nuPRt+SMGHfJdTG7L28pXkVXcWJLA
         i2Ihy19GbaecQbQdo6QASTE5t5lNqLUZl30f49yfKCSUNUfP9YApQ6Qf1aukzm1hdwEm
         lkVFZp99+l4p3qiYpg9A8q4FP/vWZ7gCpEI82+ciEeWKrJP+lcDeLws/xZW/vkx0vfYu
         H8I8c1Qkk3mrnJrWUtoatmfN5U/6J8ip5PUTv8YjlqapEa0mUMA3kWTLjNb5WqruiubE
         2EV9Ib540rZ6hq8XmUuLQ+bdGRSJijFDvv3sqKVHRGR6s1SjloUHkHeooC+tkDLRdd1r
         0XCw==
X-Gm-Message-State: AOAM533cSaNovX8FvcpzuX0Qgy9GmLnix06UKlKRGIiRa9bDbHvF0NV8
        ZxyW6qABb4wHkLN+1yReIXZicru7nEE=
X-Google-Smtp-Source: ABdhPJziNKrC6C4R3RsiEkMRm6qC0YQsDJoJy/o9dDhwHkO4fY17NZrQ8c15x5FrrR6XdGp4/iZsUw==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr4261695wmc.9.1598029178804;
        Fri, 21 Aug 2020 09:59:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b77sm7045632wmb.3.2020.08.21.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:59:38 -0700 (PDT)
Message-Id: <pull.706.v3.git.1598029177.gitgitgadget@gmail.com>
In-Reply-To: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
References: <pull.706.v2.git.1597850128.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 16:59:33 +0000
Subject: [PATCH v3 0/4] Use refs API for handling sundry pseudorefs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes the handling of CHERRY_PICK_HEAD and REVERT_HEAD to use
the refs API, as a preliminary refactor for reftable. 

No functional changes.

Han-Wen Nienhuys (4):
  refs: make refs_ref_exists public
  sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
  builtin/commit: suggest update-ref for pseudoref removal
  sequencer: treat REVERT_HEAD as a pseudo ref

 builtin/commit.c | 26 +++++++++++-----------
 builtin/merge.c  |  2 +-
 path.c           |  2 --
 path.h           |  9 ++++----
 refs.c           |  2 +-
 refs.h           |  2 ++
 sequencer.c      | 56 +++++++++++++++++++++++++++++-------------------
 wt-status.c      |  6 +++---
 8 files changed, 57 insertions(+), 48 deletions(-)


base-commit: 675a4aaf3b226c0089108221b96559e0baae5de9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-706%2Fhanwen%2Fstray-pseudorefs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-706/hanwen/stray-pseudorefs-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/706

Range-diff vs v2:

 1:  a8467a0d66 = 1:  bfea176682 refs: make refs_ref_exists public
 2:  2797e98446 = 2:  5ff5d2c663 sequencer: treat CHERRY_PICK_HEAD as a pseudo ref
 3:  2681638651 ! 3:  8aacde69c8 builtin/commit: suggest update-ref for pseudoref removal
     @@ Commit message
      
       ## builtin/commit.c ##
      @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const char *prefix,
     - 		struct ident_split ci, ai;
     - 
     - 		if (whence != FROM_COMMIT) {
     -+			const char *pseudoref = (whence == FROM_MERGE) ?
     -+							      "MERGE_HEAD" :
     -+							      "CHERRY_PICK_HEAD";
     -+			const char *what = (whence == FROM_MERGE) ?
     -+							 "merge" :
     -+							 "cherry-pick";
     -+
       			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
       				!merge_contains_scissors)
       				wt_status_add_cut_line(s->fp);
     @@ builtin/commit.c: static int prepare_to_commit(const char *index_file, const cha
      -					"If this is not correct, please remove the file\n"
      -					"	%s\n"
      -					"and try again.\n"),
     --				whence == FROM_MERGE ?
     --					git_path_merge_head(the_repository) :
     --					git_path_cherry_pick_head(the_repository));
      +			status_printf_ln(
      +				s, GIT_COLOR_NORMAL,
     -+				_("\n"
     -+				  "It looks like you may be committing a %s.\n"
     -+				  "If this is not correct, please remove %s with\n"
     -+				  "	git update-ref -d %s\n"
     -+				  "and try again.\n"),
     -+				what, pseudoref, pseudoref);
     + 				whence == FROM_MERGE ?
     +-					git_path_merge_head(the_repository) :
     +-					git_path_cherry_pick_head(the_repository));
     ++					      _("\n"
     ++					  "It looks like you may be committing a merge.\n"
     ++					  "If this is not correct, please run\n"
     ++					  "	git update-ref -d MERGE_HEAD\n"
     ++					  "and try again.\n") :
     ++					      _("\n"
     ++					  "It looks like you may be committing a cherry-pick.\n"
     ++					  "If this is not correct, please run\n"
     ++					  "	git update-ref -d CHERRY_PICK_HEAD\n"
     ++					  "and try again.\n"));
       		}
       
       		fprintf(s->fp, "\n");
 4:  9dcc10f807 = 4:  9ba0136645 sequencer: treat REVERT_HEAD as a pseudo ref

-- 
gitgitgadget
