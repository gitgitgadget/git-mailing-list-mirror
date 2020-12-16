Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD763C2BBCD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA109230FA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 17:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgLPRR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 12:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgLPRR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 12:17:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903BAC06179C
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:18 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so23935803wra.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b2cG405Y+7WJZZlHQsVXFrfX2Zp46T247qcedPbqxSY=;
        b=XchJe/vwH0A6YPCIZJbXvAiVnnAN6As3JMGBwMcFyTMGjSEhziORR2PHU1Jxp+xLKk
         YWcb+f11wlX4jvdQOz1UynPkC7DK+V5TB/2hhwkL74NeQq/ws4NgyxMOOuDG02x6wCFg
         4TyMTSfu33fK9a/XW2kz6COGywfmMmxT4rGgT8vwMAYQKbyj59vj44RRBx7EgYJCri5x
         NEiOfSTDBi1Ck0+K8kPFKqa0RF2rORQKGC3Oef4W9u98UrsaIEvrNbGeUyDFLm29mZRB
         e4TSM3NOsh5jHceG8dBzaemPWkBKlpzZy7RfkfjxY+RnYbCxMTqA0X05IgMrHSFqsawf
         /8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b2cG405Y+7WJZZlHQsVXFrfX2Zp46T247qcedPbqxSY=;
        b=OxL9OWZXYKdy7SRFyyuEXqrReqMR/CbD4PV41zjaBcSRyEi4tG7jJT9c+y+cPwito4
         s/rttKjxak92uNw+odLcrGVor6ePRJxx8nyPg5w0PaN6E1aVsXp4pwLIMZ63cNFpHHFz
         8JCpWQoK+XYGpftAPfSkLu/EBRIhl1GdrzFX9L2BaZntRTxO59e1QUSSQENW/ToOnCl/
         b+8jSVRq707wE3Q9YXJqVdiygTO6gX6hlHq+BxdCDIPzCzP54WEMGgCZiUtcdQtsJYlK
         c7jEMjJFeZjlazOs6B+BfO+A7bhiNrjAsHqE8bOnzgKhLtB2zPCeABl1hZIdmAXd8Fxw
         lybA==
X-Gm-Message-State: AOAM533Li6AGaYpL1jX/mdp7vqbSqdxdKYqppz8pQFgEOccmLeXniWXo
        T1EhCPy0v8Ba6VnrerDGuyG7o/VX8Gs=
X-Google-Smtp-Source: ABdhPJzM6ZeB8CEVFPlt+lxPc8XfJzblC79AvKeiDO4IqXJyxIrp+KoaTINlEEFTo1FLBfYIX4A2kQ==
X-Received: by 2002:adf:d0c6:: with SMTP id z6mr8091547wrh.10.1608139035817;
        Wed, 16 Dec 2020 09:17:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g78sm3583222wme.33.2020.12.16.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 09:17:15 -0800 (PST)
Message-Id: <pull.814.v3.git.1608139034.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
References: <pull.814.v2.git.1608097965.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 17:17:11 +0000
Subject: [PATCH v3 0/3] merge-ort: implement recursive merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on en/merge-ort-2 (it does NOT depend on en/merge-ort-3
and can thus be reviewed/merged independently of it).

This short series adds handling of recursive merges (merging of multiple
merge-bases to create a virtual merge base) to merge-ort. With this short
series the number of test failures under GIT_TEST_MERGE_ALGORITHM=ort drops
by 801 (from 1448 to 647).

Changes since v2:

 * rename local var from 'next' to 'previous' to make reversing logic
   clearer (as suggested by Stolee)
 * employ MAYBE_UNUSED modifier on new functions as better way to avoid
   unused-function errors (as suggested by Johannes)

Elijah Newren (3):
  merge-ort: copy a few small helper functions from merge-recursive.c
  merge-ort: make clear_internal_opts() aware of partial clearing
  merge-ort: implement merge_incore_recursive()

 merge-ort.c | 149 +++++++++++++++++++++++++++++++++++++++++++++++++---
 merge-ort.h |  10 ++++
 2 files changed, 152 insertions(+), 7 deletions(-)


base-commit: c5a6f65527aa3b6f5d7cf25437a88d8727ab0646
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-814%2Fnewren%2Fort-recursive-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-814/newren/ort-recursive-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/814

Range-diff vs v2:

 1:  0b455bd6fe7 ! 1:  dcf28565ad3 merge-ort: copy a few small helper functions from merge-recursive.c
     @@ merge-ort.c: void merge_finalize(struct merge_options *opt,
      +	c->maybe_tree = t;
      +}
      +
     ++MAYBE_UNUSED
      +static struct commit *make_virtual_commit(struct repository *repo,
      +					  struct tree *tree,
      +					  const char *comment)
     @@ merge-ort.c: void merge_finalize(struct merge_options *opt,
      +	return commit;
      +}
      +
     ++MAYBE_UNUSED
      +static struct commit_list *reverse_commit_list(struct commit_list *list)
      +{
     -+	struct commit_list *next = NULL, *current, *backup;
     ++	struct commit_list *previous = NULL, *current, *backup;
      +	for (current = list; current; current = backup) {
      +		backup = current->next;
     -+		current->next = next;
     -+		next = current;
     ++		current->next = previous;
     ++		previous = current;
      +	}
     -+	return next;
     ++	return previous;
      +}
      +
       static void merge_start(struct merge_options *opt, struct merge_result *result)
       {
       	/* Sanity checks on opt */
     -@@ merge-ort.c: void merge_incore_recursive(struct merge_options *opt,
     - 			    struct commit *side2,
     - 			    struct merge_result *result)
     - {
     -+	(void)reverse_commit_list;
     -+	(void)make_virtual_commit;
     - 	die("Not yet implemented");
     - }
 2:  fc26c1a11db = 2:  bffc45c6570 merge-ort: make clear_internal_opts() aware of partial clearing
 3:  d8f79450a40 ! 3:  59216a155ae merge-ort: implement merge_incore_recursive()
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
     +@@ merge-ort.c: static inline void set_commit_tree(struct commit *c, struct tree *t)
     + 	c->maybe_tree = t;
     + }
     + 
     +-MAYBE_UNUSED
     + static struct commit *make_virtual_commit(struct repository *repo,
     + 					  struct tree *tree,
     + 					  const char *comment)
     +@@ merge-ort.c: static struct commit *make_virtual_commit(struct repository *repo,
     + 	return commit;
     + }
     + 
     +-MAYBE_UNUSED
     + static struct commit_list *reverse_commit_list(struct commit_list *list)
     + {
     + 	struct commit_list *previous = NULL, *current, *backup;
      @@ merge-ort.c: static void merge_ort_nonrecursive_internal(struct merge_options *opt,
       	}
       }
     @@ merge-ort.c: void merge_incore_recursive(struct merge_options *opt,
       			    struct commit *side2,
       			    struct merge_result *result)
       {
     --	(void)reverse_commit_list;
     --	(void)make_virtual_commit;
      -	die("Not yet implemented");
      +	/*
      +	 * merge_incore_nonrecursive() exists for cases where we always

-- 
gitgitgadget
