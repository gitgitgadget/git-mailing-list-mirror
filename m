Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E8EC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB7F206D4
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLdPZ+i5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHCSlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSlY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:41:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF6C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:41:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so30062876wrs.8
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3NbXiKCJNWD1g71KylzmjpGN8DEoAPiMabdQvWMKbXQ=;
        b=DLdPZ+i5yh28cGXCB+diGblXMBa8YkHaNb7Aub4fnTP0NofYzuQC5shGIfoxUagqNk
         CfeIFH6GGFqwCuQAay8seAfAEth6Hcey+oXavc/cyUa9kTgiNXv/o405aWw8zBeZQ5j0
         X+kp8Fd/1MTMNnEWKxfLcz0egLkWv7213BKLuFrYkUBC8LFvqE4M7b+Na55Z78Lj4gEw
         zmP4oLAhp1xQWF5i6JNp4hoqLY2f2LXQ9fH451bqhdFKjB52b6UAC+cq6PutAaPGDQpz
         pwHbIh/dDwvTH2XhsQRKPzi1wZx27DGt5IowTSbExev6ke6fsWYVfO+uIj/TGd98ehe6
         HKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3NbXiKCJNWD1g71KylzmjpGN8DEoAPiMabdQvWMKbXQ=;
        b=e4zWE3ofD0EhGDk7qJL48iPZ5+jKqLTPSGtpiLPCerezj9fYV68tJypTh1GCrwUW0a
         Y2oO8iO0Y6i9JaYp4yCKpCfjI7VB/a+XUw1vBAnfkE+burGmQr76l0KiJV7NCohyGaXg
         CVuBz4QI0dp9fXCNz4L+7fYOX1fSv7NaNhGKDML5lvyPiTRs8Ss7nLEAUpszX5mLpQ35
         ZPGHZ34i5XI8NztDgGqItf5JcdAXty2X0n7DYgGS7irQkKBWoIkFyCQQ5bnxMLfzGfEw
         weeiN5eapoblYE7GVe7/b2PGXeQFI/Se0tSojBVNPmEs/C6sgFFLb2Ia0vtuJd56dQ6u
         MXmQ==
X-Gm-Message-State: AOAM530oZF6waa4+qIWpGOsmLTVzxOT2IT9UOocDnSXnfTO4+yHCxP6R
        fqIkJUmiaqm9jBswzJMyFs/ZsWOO
X-Google-Smtp-Source: ABdhPJyLFVkzdqeRIwNye/V4mbAlSe0qfzxXNpnSlcm02qhruldGBGWLZ1lsK4wYLloI0qkA1aDbuQ==
X-Received: by 2002:a5d:4906:: with SMTP id x6mr16898905wrq.142.1596480081822;
        Mon, 03 Aug 2020 11:41:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm30860130wrb.59.2020.08.03.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:41:21 -0700 (PDT)
Message-Id: <pull.825.v2.git.git.1596480080.gitgitgadget@gmail.com>
In-Reply-To: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Aug 2020 18:41:16 +0000
Subject: [PATCH v2 0/4] Attr fixes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes a few issues surrounding .gitattributes files and usage of the
merge machinery outside of "git merge". All were issues I found and fixed
while working on merge-ort.

Changes since v1:

 * Made the fixes suggested by Eric and Junio
 * Just ripped out the test in patch 2 that was testing undefined behavior
   (especially since it was a test_expect_failure, and clearly was testing
   multiple things wrong), as suggested by Junio.

Elijah Newren (4):
  t6038: make tests fail for the right reason
  t6038: remove problematic test
  merge: make merge.renormalize work for all uses of merge machinery
  checkout: support renormalization with checkout -m <paths>

 builtin/checkout.c         | 18 ++++++------------
 builtin/merge.c            |  4 ----
 merge-recursive.c          |  3 +++
 t/t6038-merge-text-auto.sh | 26 ++++++--------------------
 4 files changed, 15 insertions(+), 36 deletions(-)


base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-825%2Fnewren%2Fattr-fixes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-825/newren/attr-fixes-v2
Pull-Request: https://github.com/git/git/pull/825

Range-diff vs v1:

 1:  3619118175 ! 1:  21033c4c14 t6038: make tests fail for the right reason
     @@ Commit message
          t6038 had a pair of tests that were expected to fail, but weren't
          failing for the expected reason.  Both were meant to do a merge that
          could be done cleanly after renormalization, but were supposed to fail
     -    for lack of renormalization.  Unfortunately, both tests has staged
     +    for lack of renormalization.  Unfortunately, both tests had staged
          changes, and checkout -m would abort due to the presence of those staged
          changes before even attempting a merge.
      
 2:  83a50f7e0b ! 2:  305fe534c5 t6038: fix test with obviously incorrect expectations
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    t6038: fix test with obviously incorrect expectations
     +    t6038: remove problematic test
      
     -    t6038.11, 'cherry-pick patch from after text=auto' was set up so that on
     -    a branch with no .gitattributes file, you cherry-picked a patch from a
     -    branch that had a .gitattributes file (containing '* text=auto').
     -    Further, the two branches had a file which differed only in line
     -    endings.  In this situation, correct behavior is not well defined:
     -    should the .gitattributes file affect the merge or not?
     +    t6038.11, 'cherry-pick patch from after text=auto' was a test of
     +    undefined behavior.  To make matters worse, while there are a couple
     +    possible correct answers, this test was coded to only check for an
     +    obviously incorrect answer.  And the final cherry on top is that the
     +    test is marked test_expect_failure, meaning it can't provide much value,
     +    other than possibly confusing future folks who come along and try to
     +    work on attributes and look at existing tests.  Because of all these
     +    problems, just remove the test.
     +
     +    But for any future code spelunkers, here's my understanding of the two
     +    possible correct answers:
     +
     +    This test was set up so that on a branch with no .gitattributes file,
     +    you cherry-picked a patch from a branch that had a .gitattributes file
     +    (containing '* text=auto').  Further, the two branches had a file which
     +    differed only in line endings.  In this situation, correct behavior is
     +    not well defined: should the .gitattributes file affect the merge or
     +    not?
      
          If the .gitattributes file on the other branch should not affect the
          merge, then we would have a content conflict with all three stages
          different (the merge base didn't match either side).
      
          If the .gitattributes file from the other branch should affect the
     -    merge, then we would expect the line endings to be normalized to LF so
     -    that the versions from both sides match, and then the cherry-pick has no
     -    conflicts and can succeed.  After the cherry-pick, the line endings in
     -    the file will change from CRLF to LF.
     -
     -    This test had an expectation that the line endings would remain CRLF.
     -    Further, it expected an error message that was built assuming
     -    cherry-pick was the old scripted version, because cherry-pick no longer
     -    uses the error message that was encoded in this test.  So, although I
     -    don't know what correct behavior for this test is, I know that this test
     -    was not testing for it.
     -
     -    Since I have no idea which of the two cases above provides correct
     -    behavior, let's just assume for now it's the case where we assume that
     -    .gitattributes affects the merge and update it accordingly.
     +    merge, then we would expect the line endings to be normalized to LF for
     +    the version to be recorded in the repository.  This would mean that when
     +    doing a three-way content merge on the file that differed in line
     +    endings, that the three-way content merge would see that the versions on
     +    both sides matched and so the cherry-pick has no conflicts and can
     +    succeed.  The line endings in the file as recorded in the repository
     +    will change from CRLF to LF.  The version checked out in the working
     +    copy will depend on the platform (since there's no eol attribute defined
     +    for the file).
     +
     +    Also, as a final side note, this test expected an error message that was
     +    built assuming cherry-pick was the old scripted version, because
     +    cherry-pick no longer uses the error message that was encoded in this
     +    test.  So it was wrong for yet another reason.
     +
     +    Given that the handling of .gitattributes is not well defined and this
     +    test was obviously broken and could do nothing but confuse future
     +    readers, just remove it.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## t/t6038-merge-text-auto.sh ##
      @@ t/t6038-merge-text-auto.sh: test_expect_failure 'checkout -m addition of text=auto' '
     + 	git diff --no-index --ignore-cr-at-eol expected file
       '
       
     - test_expect_failure 'cherry-pick patch from after text=auto was added' '
     +-test_expect_failure 'cherry-pick patch from after text=auto was added' '
      -	append_cr <<-\EOF >expected &&
     -+	cat <<-\EOF >expected &&
     - 	first line
     - 	same line
     - 	EOF
     -@@ t/t6038-merge-text-auto.sh: test_expect_failure 'cherry-pick patch from after text=auto was added' '
     - 	git config merge.renormalize true &&
     - 	git rm -fr . &&
     - 	git reset --hard b &&
     +-	first line
     +-	same line
     +-	EOF
     +-
     +-	git config merge.renormalize true &&
     +-	git rm -fr . &&
     +-	git reset --hard b &&
      -	test_must_fail git cherry-pick a >err 2>&1 &&
      -	grep "[Nn]othing added" err &&
      -	compare_files expected file
     -+	git cherry-pick a &&
     -+	git cat-file -p HEAD:file >actual &&
     -+	compare_files expected actual
     - '
     - 
     +-'
     +-
       test_expect_success 'Test delete/normalize conflict' '
     + 	git checkout -f side &&
     + 	git rm -fr . &&
 3:  08c8080b31 ! 3:  379a87ea82 merge: make merge.renormalize work for all uses of merge machinery
     @@ builtin/merge.c: static const char **xopts;
       static const char *branch;
       static char *branch_mergeoptions;
      -static int option_renormalize;
     -+static int option_renormalize = -1;
       static int verbosity;
       static int allow_rerere_auto;
       static int abort_current_merge;
     @@ builtin/merge.c: static int try_merge_strategy(const char *strategy, struct comm
       			o.subtree_shift = "";
       
      -		o.renormalize = option_renormalize;
     -+		if (option_renormalize != -1)
     -+			o.renormalize = option_renormalize;
       		o.show_rename_progress =
       			show_progress == -1 ? isatty(2) : show_progress;
       
 4:  fcc7ea3add = 4:  36e08a75a3 checkout: support renormalization with checkout -m <paths>

-- 
gitgitgadget
