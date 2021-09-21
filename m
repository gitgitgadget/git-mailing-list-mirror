Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54219C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3064E61038
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhIUKZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhIUKZj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0EC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q26so37544096wrc.7
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/HhV77JDN4JO3Do2yhmTA4G2PSp2t4PVrA7jIaKsHRA=;
        b=eQfr3PNs+oA7aPr9aWxI3LoFs3HxqCZ22AofcabaFpyr0YTPti3zVZ0cUvuNcJTmom
         vYR+4DCL567CKmxPMSXGut8Kch70ep5X7f4RZaPvjLAVlsQynqnGuNeKeIN42tuI8Md7
         pC9RK0DjXkZv4m642tC3yU9p6KHvKvTTClM4WvmRV5ztokcvmaCRlLTa5L+KvhrRMJGs
         T6nbNk8VBeiQB9W1efmtbR/3BEdSZSU1yh3C31fmz5dXuKy9LsQIzXaENm7vZYjaUytd
         rjsN657zEnlcQ9nNfBTLhNc1upXzv0hvkWjT3OcsH2gKMiDB/8bJ3kSwXG8A5LxncPrp
         C5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/HhV77JDN4JO3Do2yhmTA4G2PSp2t4PVrA7jIaKsHRA=;
        b=ygUuZBPQrt28LLzri0/nwr393X55EPXW4IHBvAKTJ/+h9uo6ZgbeJf3lUR8K3m5BPV
         o8v6ttF1jV9BcMw5QUlvyMrmVO4z3tZv2Qy5TIfNE5c+HLGwg3jgvogz4kYCQ94gfUN6
         l1IkLekPdk9TT18fBkKIRLHqrlraeMLmOlGeWaNhySPwHBQNFCYw15Ow2MgwlzLzHSzU
         irqmqvsdGDWMKldFmGV8KjvhL2JE+82bfc+Rr+/pBx8p6dBzLoTMMupMjbTM1qcfJl3O
         +vcX6dyXEMZG2fDeA49CtSH1uSOBNBSI+Qvb+++WKB/M52nOOdZrJUAHljhrEPzALri9
         fffw==
X-Gm-Message-State: AOAM53191qMU5riI06mrXZvoyxnS/J5ZWQw9TzDMSYLjj05dqUzN0zhO
        jnTBobI1neu6Vfi2+vwc5/dS96VJpCc=
X-Google-Smtp-Source: ABdhPJw7XC1UeP5W3/dGGqC5oNnGSzT2JyKdPL22Xx3SQEIOasiSODOeObC6YPs6YIX+r3IZBo9r5A==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr21495620wrz.84.1632219849304;
        Tue, 21 Sep 2021 03:24:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s14sm18607611wrp.84.2021.09.21.03.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:08 -0700 (PDT)
Message-Id: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:23:57 +0000
Subject: [PATCH v3 00/10] rebase: dereference tags
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the comments on V2. Here are the changes from that version:

 * dropped the controversial cleanup that was patch 8
 * reworded patch 10 as suggested by Junio

Cover letter for v2: Thanks to Ævar and Johannes for their comments.

 * Changed "! test_cmp_rev" to "test_cmp_rev !" (suggested by Ævar)
 * Fixed the quoting for the title of the "rebase --quit" tests.
 * Reworked the last commit to handle the error case first (suggested by
   Ævar)
 * Tweaked the commit messages for patches 8 & 11
 * Rebased onto 31e4a0db03 ("Merge branch 'ab/rebase-fatal-fatal-fix'",
   2021-09-08) to avoid a merge conflict that upset gitgitgadget

Cover letter for V1: Aborting a rebase stated with git rebase <upstream>
<tag-object> should checkout the commit pointed to by . Instead it gives

    error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD': trying to write non-commit object       710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'


The fix for that is in the last patch, the rest of the patches are cleanups
to t3407 and builtin/rebase.c

Phillip Wood (10):
  t3407: run tests in $TEST_DIRECTORY
  t3407: use test_commit
  t3407: use test_cmp_rev
  t3407: rename a variable
  t3407: use test_path_is_missing
  t3407: strengthen rebase --abort tests
  t3407: rework rebase --quit tests
  rebase: use our standard error return value
  rebase: use lookup_commit_reference_by_name()
  rebase: dereference tags

 builtin/rebase.c        |  49 ++++++++-----------
 t/t3407-rebase-abort.sh | 105 ++++++++++++++++++----------------------
 2 files changed, 67 insertions(+), 87 deletions(-)


base-commit: 31e4a0db0337e2aa972d9b9f11a332dff7c4cbcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1033%2Fphillipwood%2Fwip%2Frebase-handle-tags-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1033/phillipwood/wip/rebase-handle-tags-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1033

Range-diff vs v2:

  1:  bac009d8543 =  1:  bac009d8543 t3407: run tests in $TEST_DIRECTORY
  2:  abfffb31a56 =  2:  abfffb31a56 t3407: use test_commit
  3:  7755ce17fef =  3:  7755ce17fef t3407: use test_cmp_rev
  4:  38eee11baf5 =  4:  38eee11baf5 t3407: rename a variable
  5:  61a37c89f1e =  5:  61a37c89f1e t3407: use test_path_is_missing
  6:  6866630528b =  6:  6866630528b t3407: strengthen rebase --abort tests
  7:  fd55a3196b1 =  7:  fd55a3196b1 t3407: rework rebase --quit tests
  8:  ad3c4efc027 <  -:  ----------- rebase: remove redundant strbuf
  9:  ad940b633d0 !  8:  d3af62c746c rebase: use our standard error return value
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		} else if (!(options.flags & REBASE_NO_QUIET))
       			; /* be quiet */
      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
     - 		reset_head(the_repository, NULL, "Fast-forwarded", options.head_name,
     - 			   RESET_HEAD_REFS_ONLY, "HEAD", buf.buf,
     + 			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
       			   DEFAULT_REFLOG_ACTION);
     + 		strbuf_release(&msg);
      -		ret = !!finish_rebase(&options);
      +		ret = finish_rebase(&options);
       		goto cleanup;
 10:  bc103e703e8 =  9:  4eedd3ae766 rebase: use lookup_commit_reference_by_name()
 11:  951de6bb199 ! 10:  55a6250ab38 rebase: dereference tags
     @@ Metadata
       ## Commit message ##
          rebase: dereference tags
      
     -    Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
     -    should checkout the commit pointed to by <tag-object>. Instead it gives
     +    A rebase started with 'git rebase <A> <B>' is conceptually to first
     +    checkout <B> and run 'git rebase <A>' starting from that state.  'git
     +    rebase --abort' in the middle of such a rebase should take us back to
     +    the state we checked out <B>.
      
     -        error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
     -        trying to write non-commit object
     -        710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'
     +    This used to work, even when <B> is a tag that points at a commit,
     +    until Git 2.20.0 when the command was reimplemented in C.  The command
     +    now complains that the tag object itself cannot be checked out, which
     +    may be technically correct but is not what the user asked to do.
      
     -    This is because when we parse the command line arguments although we
     -    check that the tag points to a commit we remember the oid of the tag
     -    and try and checkout that object rather than the commit it points
     -    to. Fix this by using lookup_commit_reference_by_name() when parsing
     -    the command line.
     +    Fix this old regression by using lookup_commit_reference_by_name()
     +    when parsing <B>. The scripted version did not need to peel the tag
     +    because the commands it passed the tag to (e.g 'git reset') peeled the
     +    tag themselves.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          ---

-- 
gitgitgadget
