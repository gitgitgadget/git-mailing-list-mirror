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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944F7C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3799B64FF0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhBEV6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 16:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbhBEO6v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:58:51 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFBFC06121F
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:28:50 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l12so6502715wmq.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5Z1+Cfk2iul7MZhTGGh3/zmJzJYC6ZYLog0Jd0Fq/7c=;
        b=HJ2Bqpb4Hbl6Si/LV+iMLR1UEN4OWag4Y6EhbvqaL/OlKOB39wfteRibieCyslfa65
         2XsgDGlzIBExHLIR01d1ZqDt6mceSO4TCZu+O50Q7IJWYsYI4C+pdhmmFQn4c3X/r9ri
         3Oxuq5NYO9QV/7Hr23uOP1+isDzZIUZ+g2uiC2/MUQOQYcG1uGZlfdF2seW6b5G0WAXs
         hvdNDEugJ1jVC87tUKShkL9nV4+Vq+pcH/Cqnte+Apl7VOovMvgt9M8EHY/YB1UMG78K
         LV9ixaoU0GrEeYN7M1wbmVzh4ibgUmaHNFFvJr1cBs6ulLv9WmmwOy4/xlyMmwSJ3Xsn
         6rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5Z1+Cfk2iul7MZhTGGh3/zmJzJYC6ZYLog0Jd0Fq/7c=;
        b=ue6bGxQXlbIjlu7/zXZ/w81OgG+fv1nCQRb9LMFMPe5xOHTjaAVaKfxtO9hNZnmcrE
         G2yhsOch+rgdNeTay13rm01bSdQIG9idHtTtij0tDCnbV6ZmSsD2NBXBIDMgPe1s2AW0
         AzbpYUNfzGLdKPEqa48lsZpKpOvALcidH6Kpaip/v+Rd28phQaS+cgg0tTFbjeFaA4ya
         mUZ+Qg+OeSJ6ojYKJZXngVgp220tDtn6E9fEvWV3QICzVR8x1gNdds7nohMHUMMXozn7
         Bf2jpjvH21eyU2CQA+oJOkpoaB76q/F9YKQ2C4q4Euu1VvMbnG0SI9F++hD5JSnt5W7Y
         vfeg==
X-Gm-Message-State: AOAM533+uzOk2zCihzZaC3ZS7QOZ83wEbrfilOJpxCWXyznlbZpEcidB
        a9lxg1U7WyGOnT87yAwfEw6u83g3vYs=
X-Google-Smtp-Source: ABdhPJwjzcgDMjjbVQtgWVw/kMJfuyu2o+Zx1nOp3fUWmddI3cWz3j9VTpe5+pGj0Dw6VRZTh1zOyQ==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr3848385wmc.27.1612536291298;
        Fri, 05 Feb 2021 06:44:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x22sm3320493wmc.25.2021.02.05.06.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:44:50 -0800 (PST)
Message-Id: <pull.841.v6.git.1612536290.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
References: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:44:46 +0000
Subject: [PATCH v6 0/3] Range diff with ranges lacking dotdot
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In
https://lore.kernel.org/git/20200306091933.mx2jmurmdnsjua4b@pengutronix.de/,
it was reported that git range-diff does not handle commit ranges like
rev^!. This patch series fixes that.

Changes since v5:

 * The commit marks are now cleared in a separate loop.
 * The regression test no longer looks only for "rang" but for "range" in
   the error message.
 * We now pass NULL as opt parameter to setup_revisions(), not 0.

Changes since v4:

 * The commit marks are now cleared in is_range_diff_range().
 * A regression test now verifies that HEAD^{/something..or other} isn't
   mistaken for a commit range.
 * The manual page no longer mentions "symmetric range", to avoid
   contentious language.

Changes since v3:

 * The revision machinery is now used directly to validate the commit
   ranges.

Changes since v2:

 * Move the helper function from revision.c to range-diff.c and rename it.
 * Use a regex to make it easier to understand what we're trying to match.
 * Fix the documentation that claimed that we used git merge-base internally
   when git range-diff parses ...-style arguments, which is not the case.

Changes since v1:

 * In addition to git range-diff, git format-patch --range-diff gets the
   same improvement.
 * The comment talking about ^@ was removed.
 * The parsing was made a bit safer (e.g. catching ! by its own as an
   invalid range).

Johannes Schindelin (3):
  range-diff/format-patch: refactor check for commit range
  range-diff/format-patch: handle commit ranges other than A..B
  range-diff(docs): explain how to specify commit ranges

 Documentation/git-range-diff.txt | 11 +++++++++++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  9 +++++----
 range-diff.c                     | 29 +++++++++++++++++++++++++++++
 range-diff.h                     |  6 ++++++
 t/t3206-range-diff.sh            | 13 +++++++++++++
 6 files changed, 65 insertions(+), 5 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/841

Range-diff vs v5:

 1:  b98fa94b8703 = 1:  b98fa94b8703 range-diff/format-patch: refactor check for commit range
 2:  04b5d75adbc3 ! 2:  f8e6a1ad9d3d range-diff/format-patch: handle commit ranges other than A..B
     @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
      +	struct rev_info revs;
      +
      +	init_revisions(&revs, NULL);
     -+	if (setup_revisions(3, argv, &revs, 0) == 1)
     -+		for (i = 0; i < revs.pending.nr; i++) {
     -+			struct object *obj = revs.pending.objects[i].item;
     -+
     -+			if (obj->flags & UNINTERESTING)
     ++	if (setup_revisions(3, argv, &revs, NULL) == 1) {
     ++		for (i = 0; i < revs.pending.nr; i++)
     ++			if (revs.pending.objects[i].item->flags & UNINTERESTING)
      +				negative++;
      +			else
      +				positive++;
     ++		for (i = 0; i < revs.pending.nr; i++) {
     ++			struct object *obj = revs.pending.objects[i].item;
     ++
      +			if (obj->type == OBJ_COMMIT)
      +				clear_commit_marks((struct commit *)obj,
      +						   ALL_REV_FLAGS);
      +		}
     ++	}
      +
      +	free(copy);
      +	object_array_clear(&revs.pending);
     @@ t/t3206-range-diff.sh: test_expect_success 'simple A B C (unmodified)' '
      +
      +test_expect_success 'A^{/..} is not mistaken for a range' '
      +	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
     -+	test_i18ngrep "not a commit rang" error
     ++	test_i18ngrep "not a commit range" error
      +'
      +
       test_expect_success 'trivial reordering' '
 3:  bc5de807735d = 3:  08c5f8732747 range-diff(docs): explain how to specify commit ranges

-- 
gitgitgadget
