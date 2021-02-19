Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36110C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB4464EB8
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBSMez (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 07:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSMey (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 07:34:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BABC061786
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r21so8214482wrr.9
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SmsT1W75xq9UDaNSJqKxZw4Kme5aeukoedObX+3RTxk=;
        b=JHujE8wRmCBb4PQt9F9g5nvTQrgh1UFZuTLPtRsdTzcK0saM1uo2kVKSgCYlHjmLt+
         Zk/pxVe0wOSri7BoqU08BTNFgeai+u6MjEZuRn7cDV8k1n1prXSiDh0zPzN/2JBbg9w9
         Hze45Sey+E7xCYEQ7ljVvvEuOUUjurO/y33jLDGVWIX6SfHE0L1COSREepsSHhuhaNp9
         xrfo8GO1zOQ70Sfq+70oRGZWgr66CpRnybr3c/5CBuHS4OiyA5vwz2yRxst/E1h09NI0
         4o7WCaEw4JtWQiDsExvP4m6tA+f/HqgDs+cw3wiXj/m5jF0L9R3ZWc83PTIAssT9fOOR
         XnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SmsT1W75xq9UDaNSJqKxZw4Kme5aeukoedObX+3RTxk=;
        b=TvOWLDqWtni410dyAFNM8EqigqY+GsUl5B9omfAGUQbgjt5hOzdjsG4QjG1XsrCzeY
         U6l9n2dFmIoPYJZUtWZOVI3O1nSIJPkpe/PJG3hNfYiurH4osOsE1DOJa8Nj0KC5xSqy
         jj/IYWYl50IUPhFFIRB9ExPt7/L2dYg/zHoOp1PpHwr1brRAPb8ZuBmtBYsAmQrLgUUs
         t29LRS2bZ8tMhT+RRpax+fe+vFlWKAJi3FE2aoZZPzihVw0ezj+mN04dwwgjEBCLpeIQ
         P/ScKPpDBpJHmr43acyr35fsDTdc4P0AryuiSde7yKFuWRnnCVNh5X0/yQwxPvrGcpt5
         Pgkg==
X-Gm-Message-State: AOAM533TcTWrh7rVogkoPrtCEPwEmxvMkW7+JS7a+00o/GQyMXANEQIP
        9wXrdidt+JmkT1urRQLsLekEcR/ZXwQ=
X-Google-Smtp-Source: ABdhPJwvXnAOKHrr5VZQFaSDmgTMxP/yCpV/U4aHAsxV6dkq0hywWM3obFnD8s9pAD4ashBHdgINoQ==
X-Received: by 2002:a5d:4850:: with SMTP id n16mr9095796wrs.296.1613738052209;
        Fri, 19 Feb 2021 04:34:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m17sm10790936wmq.5.2021.02.19.04.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 04:34:11 -0800 (PST)
Message-Id: <pull.852.v3.git.1613738051.gitgitgadget@gmail.com>
In-Reply-To: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
References: <pull.852.v2.git.1612183647.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Feb 2021 12:34:05 +0000
Subject: [PATCH v3 0/5] Speed up remove_redundant()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, me@ttaylorr.com,
        peff@peff.net, gitster@pobox.com,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty pointed out that git merge-base --independent is quite slow
when many commits are provided in the input. This boils down to some
quadratic behavior in remove_redundant() because it calls
paint_down_to_common() in a loop.

This series avoids that by using a single commit walk, pushing a flag that
means "this commit is reachable from a parent of a commit in the list." At
the end of the walk, the input commits without that flag are independent.

There is an extra performance enhancement using the first-parent history as
a heuristic. This helps only when there is a single independent result, as
we can short circuit the walk when all other inputs are found to be
reachable from the top one. It also gets faster when we discover the commit
with lowest generation and can restrict our walk further to the next-lowest
generation number.

My tests were on the Linux kernel repository, testing this command:

  git merge-base --independent $(git for-each-ref refs/tags --format="%(refname)")

       Before: 16.4s
After Patch 1:  1.1s
After Patch 2:  0.1s


This does not change the correctness of the function. It is tested carefully
in t6600-test-reach.c, among existing merge-base tests. There are also more
tests in scripts like t6012-rev-list-simplify.sh that trigger the new logic
under GIT_TEST_COMMIT_GRAPH=1.


Updates in V3
=============

 * Patch 2 is updated to René's comments. Sorry I dropped the ball on this.
   I had the changes locally, but never pushed them until now.


Updates in V2
=============

 * The old algorithm is not entirely removed. It is still faster than the
   new algorithm if all input commits are not in the commit-graph file
   (unless the commit-graph file is really close to the input commits, but
   that is an unreasonable expectation). Now, the new logic only happens if
   there is an input commit with finite generation number.

 * There was a copy of 'array' being used for the final reorder which is now
   removed. We still need to be careful about the RESULT bit.

 * The final patch is new, adding yet another speedup in the form of
   increasing the min_generation cutoff when we find the input commit of
   smallest generation. This can reduce the time significantly when given
   many inputs. This does require copying the 'array' again, so we can sort
   by generation number while preserving the original order of 'array' which
   is required by some callers.

Thanks, -Stolee

Derrick Stolee (5):
  commit-reach: reduce requirements for remove_redundant()
  commit-reach: use one walk in remove_redundant()
  commit-reach: move compare_commits_by_gen
  commit-reach: use heuristic in remove_redundant()
  commit-reach: stale commits may prune generation further

 commit-reach.c | 190 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 165 insertions(+), 25 deletions(-)


base-commit: 5a3b130cad0d5c770f766e3af6d32b41766374c0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-852%2Fderrickstolee%2Fmerge-independent-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-852/derrickstolee/merge-independent-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/852

Range-diff vs v2:

 1:  649f6799e6bf = 1:  649f6799e6bf commit-reach: reduce requirements for remove_redundant()
 2:  2f80ae5fcb00 ! 2:  c2c08989ce60 commit-reach: use one walk in remove_redundant()
     @@ commit-reach.c: struct commit_list *get_octopus_merge_bases(struct commit_list *
       	unsigned char *redundant;
       	int *filled_index;
      @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit **array, int cnt
     - 	for (i = filled = 0; i < cnt; i++)
     - 		if (!redundant[i])
     - 			array[filled++] = work[i];
     -+	for (j = filled, i = 0; i < cnt; i++)
     -+		if (redundant[i])
     -+			array[j++] = work[i];
     - 	free(work);
     - 	free(redundant);
     - 	free(filled_index);
       	return filled;
       }
       
     @@ commit-reach.c: static int remove_redundant(struct repository *r, struct commit
      +	}
      +
      +	/* clear marks */
     -+	for (i = 0; i < walk_start_nr; i++)
     -+		clear_commit_marks(walk_start[i], STALE);
     ++	clear_commit_marks_many(walk_start_nr, walk_start, STALE);
      +	free(walk_start);
      +
      +	return count_non_stale;
 3:  009f64b53c95 = 3:  1d3c5ebbb632 commit-reach: move compare_commits_by_gen
 4:  83feabeebb5f = 4:  c1fc174d42aa commit-reach: use heuristic in remove_redundant()
 5:  14f0974c9872 = 5:  539db83bd735 commit-reach: stale commits may prune generation further

-- 
gitgitgadget
