Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA78C433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799D2207CD
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 21:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzClv9T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGAVTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgGAVTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 17:19:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9158C08C5C1
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 14:19:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l2so23581656wmf.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 14:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RB8F/pw8EUIgRZ74ydQDRMG6Kw+U5uLMIknTRhrBxJs=;
        b=bzClv9T8uYH4GA25Qr8Qp/lvCdGiOMQQJvKzvL5u5R10n4q4dlKsiiidbcnvm38Yad
         Y9hwOtqKCST/e/Eo6vPUcC2ujF+QnflrDGgf85Q5TCzI6vhQ5Yul3lP1t1bgavZ3Yqrj
         +G9/BPjKuR6u/bmaOM4geiFTabi9vBa8abNbdAb7gItBStU8MJH3hiVmH+XAs+YE1t7+
         CjF4vT5bhss2E2MJpC7KNF1MLQNF4FTQAEd1GFSt8UTZrmR2T0WrcdyqmCAn0uWfYc57
         2L2WZ1JAKEF3c0OZv1khJdYcb7KFZhCkSu8IMcrIe8rvB5+30BCi9YFnXeEkcBRUF4cL
         5/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RB8F/pw8EUIgRZ74ydQDRMG6Kw+U5uLMIknTRhrBxJs=;
        b=lUUJyNMlrrEV5Qaifbr7LvOi4pgh2/FUUFiQiXdY0UvBn04XQGi95nPLnZHXEvdzlb
         gUh+bGLVrBZ2KurGY9bAoo7XD6lTIYwK+h9nlZfU+g8uf+JIcCn62JEMDny18RUj/s5+
         4yZ+O1zFijwhAWHqayExnqL4Tabx6y1xvhfvClm56ynPhidQPTbhhTao7ml9Jo8lAEoC
         jEk4pNeEo2+DezXy3mSgfxrH3N+QjGmr7OxXZ+oXcaKg6ouTfn8B8Z8PDgqV9wYi8ZRo
         n7vD1gjCVI8dHnQlaq+c9KrG65T3Oeh2inyqbCkjOxPaJAqH7kliZbZTROAKjKMAPweF
         OXJA==
X-Gm-Message-State: AOAM532pdi8JYd3DhHkLNdplSU9kTm0js4O5tSqGScP3vt+AJJP88bjT
        EnqpInqIXTtFcZFvnmiktxnOCKHf
X-Google-Smtp-Source: ABdhPJwo0ejb8UAPYV2mozGCkl+ArPqPgrcbro2SE7/F+tQ5NhXqR0bBZcqkRToCtOhWAKVmqcj6uA==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr27265127wmg.127.1593638349162;
        Wed, 01 Jul 2020 14:19:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm8993806wrs.95.2020.07.01.14.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 14:19:08 -0700 (PDT)
Message-Id: <pull.654.v5.git.1593638347.gitgitgadget@gmail.com>
In-Reply-To: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
References: <pull.654.v4.git.1593107621.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Jul 2020 21:19:05 +0000
Subject: [PATCH v5 0/2] Fix difftool problem with intent-to-add files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This problem was reported in 
https://github.com/git-for-windows/git/issues/2677, but the problem actually
lies with git diff --raw, and it seems that the bug has been with us ever
since --intent-to-add was introduced.

Changes since v4:

 * Improved both commit messages after feedback from Junio.

Changes since v3:

 * Instead of showing the same OID in git diff-files --raw as in git
   diff-files -p for intent-to-add files, we now imitate the logic for
   modified (non-intent-to-add) files: we show the "null" OID (i.e.
   all-zero).
   
   
 * As a consequence, we no longer just undo the inadvertent change where
   intent-to-add files were reported with the empty tree instead of the
   empty blob, but we fix the bug that has been with us since 
   run_diff_files() was taught about intent-to-add files, i.e. we fix the
   original bug of 425a28e0a4e (diff-lib: allow ita entries treated as "not
   yet exist in index", 2016-10-24), at long last.
   
   

Changes since v2:

 * Now we also drop the no-longer-used definition of hash_t in t2203.

Changes since v1:

 * Rebased onto sk/diff-files-show-i-t-a-as-new.
 * Verified that sk/diff-files-show-i-t-a-as-new does not completely resolve
   the issue (the --raw output still claims the empty blob as the
   post-image, although the difftool symptom "went away").
 * Amended the central patch of this PR to include a fix for the regression
   test that was introduced in sk/diff-files-show-i-t-a-as-new: it expected
   the raw diff to contain the hash of the empty tree object (which is
   incorrect no matter how you turn it: any hash in any raw diff should
   refer to blob objects).
 * Reordered the patches so that the central patch comes first (otherwise,
   the "empty tree" fix would cause a test failure in t2203).

Johannes Schindelin (2):
  diff-files --raw: show correct post-image of intent-to-add files
  difftool -d: ensure that intent-to-add files are handled correctly

 diff-lib.c            | 3 +--
 t/t2203-add-intent.sh | 5 ++---
 t/t7800-difftool.sh   | 8 ++++++++
 3 files changed, 11 insertions(+), 5 deletions(-)


base-commit: feea6946a5b746ff4ebf8ccdf959e303203a6011
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-654%2Fdscho%2Fdifftool-ita-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-654/dscho/difftool-ita-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/654

Range-diff vs v4:

 1:  69256ab910 ! 1:  4392ae4be6 diff-files --raw: show correct post-image of intent-to-add files
     @@ Commit message
      
                  [...] 0{40} if creation, unmerged or "look at work tree".
      
     -    This happens for example when showing modified, unstaged files.
     +    on the right hand (i.e. postimage) side. This happens for files that
     +    have unstaged modifications, and for files that are unmodified but
     +    stat-dirty.
      
          For intent-to-add files, we used to show the empty blob's hash instead.
          In c26022ea8f5 (diff: convert diff_addremove to struct object_id,
          2017-05-30), we made that worse by inadvertently changing that to the
          hash of the empty tree.
      
     -    Let's make the behavior consistent with modified files by showing
     +    Let's make the behavior consistent with files that have unstaged
     +    modifications (which applies to intent-to-add files, too) by showing
          all-zero values also for intent-to-add files.
      
          Accordingly, this patch adjusts the expectations set by the regression
 2:  9bb8d84ea9 ! 2:  5f933e852a difftool -d: ensure that intent-to-add files are handled correctly
     @@ Commit message
      
          In https://github.com/git-for-windows/git/issues/2677, a `git difftool
          -d` problem was reported. The underlying cause was a bug in `git
     -    diff-files --raw` that we just fixed.
     +    diff-files --raw` that we just fixed: it reported intent-to-add files
     +    with the empty _tree_ as the post-image OID, when we need to show
     +    an all-zero (or, "null") OID instead, to indicate to the caller that
     +    they have to look at the worktree file.
     +
     +    The symptom of that problem shown by `git difftool` was this:
     +
     +            error: unable to read sha1 file of <path> (<empty-tree-OID>)
     +            error: could not write '<filename>'
      
          Make sure that the reported `difftool` problem stays fixed.
      

-- 
gitgitgadget
