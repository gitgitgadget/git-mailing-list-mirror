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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB25EC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8F1F64FB0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 23:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhBDXaP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 18:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhBDXaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 18:30:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B0C0613D6
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 15:29:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y187so4458439wmd.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fIOx32yW/4rrZ2jGU5Iu1whHoaWG1ItuRI6PedcsxVo=;
        b=QeQAjWz0ky2BV1MT892s8IQryrSK4VZuT2qpDQ8RSsAycQHv1CRK3OOSnPRiLqFF0b
         zcbn1GqawPPG6M9LTP9ay9JajfaLl0uglrKNR6q/QrQ4mUkz5vhh5rpbrPcFSqfM5Gae
         2GmgRSdCVI+cJ6yp4y66pGWhGl+RQS+1v+1RqVjXbytvBCY681Wb8wuc64pwxKCYaINq
         9ma02kfVlMgTMMIbpgIJIrCBsCVKz+hUFDk6CRSSwv6ASHeS4E6cBLtzQyklN+qtmGkL
         q1OEwDH52FBG9tA8wH4KFwemk5xS3iNzbWnpPBnOv6gi8oBrnW63W2ban+SDJgcCMRZ6
         7bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fIOx32yW/4rrZ2jGU5Iu1whHoaWG1ItuRI6PedcsxVo=;
        b=bw0Jc4Sw+oFh6T4kt7slVU4DfQVrgIgJUv88gqEf959JfTQMePD1mbHkkwfecep/2F
         MG5frfd8wk1LjFPdY5dZirz2EIdd9nJ4aLK+eihdr+r9KHeKbhUezlvuhnjQz2PLk77G
         X5ctD4lCXpKXv7jsmiZ1v3ZOz1+Pg7wQDgFk69FRqi7bepYEuNoFlo893ANB53bvAcQ8
         v3ZhIA3qHGE6WNAniIRtLdUdx7OhCWv26bbN+3gco1U8UhRgcb0vH4DBX2lauWOqZs+I
         wcnjNPxg+yQLzcXTy1UXYB4g1oqVDxkik28HSQFznWyJSdyZUvIeAnFi/dK5fBftqz1p
         StOg==
X-Gm-Message-State: AOAM531Ne98aoz3nSjXV5XD5duKwYAV3BJhNY2d1SDv0Z88m78nJynWE
        jEQ43AqT/+eXxZBxUAYJ0zHdj6/JgYo=
X-Google-Smtp-Source: ABdhPJxw+phOUav7TePUbFv7I2q2Hk3Uc3msiGJE4UTNab4pp01LfPkGgUiptnNZZOwwJOQgGpmcew==
X-Received: by 2002:a1c:356:: with SMTP id 83mr1208390wmd.31.1612481394010;
        Thu, 04 Feb 2021 15:29:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm7020184wmq.45.2021.02.04.15.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 15:29:53 -0800 (PST)
Message-Id: <pull.841.v5.git.1612481392.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
References: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 23:29:49 +0000
Subject: [PATCH v5 0/3] Range diff with ranges lacking dotdot
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
 range-diff.c                     | 27 +++++++++++++++++++++++++++
 range-diff.h                     |  6 ++++++
 t/t3206-range-diff.sh            | 13 +++++++++++++
 6 files changed, 63 insertions(+), 5 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/841

Range-diff vs v4:

 1:  b98fa94b8703 = 1:  b98fa94b8703 range-diff/format-patch: refactor check for commit range
 2:  448e6a64fa15 ! 2:  04b5d75adbc3 range-diff/format-patch: handle commit ranges other than A..B
     @@ Commit message
          looking for at least one interesting and one uninteresting revision in
          the resulting `pending` array.
      
     +    This also finally lets us reject arguments that _do_ contain `..` but
     +    are not actually ranges, e.g. `HEAD^{/do.. match this}`.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## range-diff.c ##
     @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
      +	struct rev_info revs;
      +
      +	init_revisions(&revs, NULL);
     -+	if (setup_revisions(3, argv, &revs, 0) == 1) {
     -+		for (i = 0; i < revs.pending.nr; i++)
     -+			if (revs.pending.objects[i].item->flags & UNINTERESTING)
     ++	if (setup_revisions(3, argv, &revs, 0) == 1)
     ++		for (i = 0; i < revs.pending.nr; i++) {
     ++			struct object *obj = revs.pending.objects[i].item;
     ++
     ++			if (obj->flags & UNINTERESTING)
      +				negative++;
      +			else
      +				positive++;
     -+	}
     ++			if (obj->type == OBJ_COMMIT)
     ++				clear_commit_marks((struct commit *)obj,
     ++						   ALL_REV_FLAGS);
     ++		}
      +
      +	free(copy);
      +	object_array_clear(&revs.pending);
      +	return negative > 0 && positive > 0;
       }
      
     + ## range-diff.h ##
     +@@ range-diff.h: int show_range_diff(const char *range1, const char *range2,
     + 
     + /*
     +  * Determine whether the given argument is usable as a range argument of `git
     +- * range-diff`, e.g. A..B. Note that this only validates the format but does
     +- * _not_ parse it, i.e. it does _not_ look up the specified commits in the
     +- * local repository.
     ++ * range-diff`, e.g. A..B.
     +  */
     + int is_range_diff_range(const char *arg);
     + 
     +
       ## t/t3206-range-diff.sh ##
      @@ t/t3206-range-diff.sh: test_expect_success 'simple A B C (unmodified)' '
       	test_cmp expect actual
     @@ t/t3206-range-diff.sh: test_expect_success 'simple A B C (unmodified)' '
      +	EOF
      +	test_cmp expect actual
      +'
     ++
     ++test_expect_success 'A^{/..} is not mistaken for a range' '
     ++	test_must_fail git range-diff topic^.. topic^{/..} 2>error &&
     ++	test_i18ngrep "not a commit rang" error
     ++'
      +
       test_expect_success 'trivial reordering' '
       	git range-diff --no-color master topic reordered >actual &&
 3:  295fdc1cd32c ! 3:  bc5de807735d range-diff(docs): explain how to specify commit ranges
     @@ Documentation/git-range-diff.txt: Finally, the list of matching commits is shown
      +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
      +  in linkgit:gitrevisions[7] for more details.
      +
     -+- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
     -+  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
     -+  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.
     ++- `<rev1>...<rev2>`. This is equivalent to
     ++  `<rev2>..<rev1> <rev1>..<rev2>`.
      +
      +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
      +  <base>..<rev2>`.

-- 
gitgitgadget
