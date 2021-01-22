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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C221C10DC1
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF1C23AC2
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbhAVSk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbhAVSRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 13:17:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89CC0613D6
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c128so5143231wme.2
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 10:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMg4nHZwoff9HRmEt3xctuZ1droy91uJbxZSjjYM1uM=;
        b=R9r+Odks8nrt33dffh02/pxl4CC+oV6n3krGkn1lwugf9Kcq+vqQMwwYunpQVnq3He
         ZA6zY1FTZij2+OFfP8LPewjMR3EJ/8M+kXLto2Fp/77c7E51O8rP++PrYvFYExzDxRA0
         i8BUZ8RhOdfwQ8S0cTMqksNSVuJWj5cQwGEl9nR9eG7U/fiQeLS8/1oG3jq26mUC45ih
         fVyuqMVfrTqLwMpaliF1nQtC56bnb/vpkinoG43oztg2RN8e/kJmyxjX3kyUqy/lyYA4
         0UlJ3/CILnsk5b8Vw2G2oVo6ZNxraMLop6oR3CfsiRHMnm6Ol/vLY8dtBpaqYVJgcjag
         DWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMg4nHZwoff9HRmEt3xctuZ1droy91uJbxZSjjYM1uM=;
        b=Bg4NYbuCS5z/PXou4szhQD32XLy++RXC8BTc1TD2AMLmvHYPfEwitQgtNFx7/i0LE8
         NWIBaHpHFRZ1nn9fnGpMo7JIXEnCcewVE8QuYcdJyAUKPyT8WbWo/wNuo57dNSG1Y42T
         gFPupPhgnOV9X1ANy8THtvqOV5PB6n83m+FXUk1ceX5ojF8KnnLfKVBRbnmIv9DnhCxM
         y/CuyfGlo6yYz+EHxk8dCTW8nFg1C74i3MrIJ2f0oNQL4/elG4PwuD3Qw/sXL25p0goo
         SCTmlMxweux7KF8uEZIg8rDcmEJeE/jNG5tpknZ15EgkG1UAdP0lBBQdIIbvOx8neJNe
         cp3g==
X-Gm-Message-State: AOAM530RcsJUhnPla13E+6DDKdkKiZNscfr32viUtZLZ3vQ9FxH73Sgb
        9uGX8Gg8/5VvqQcP4YR9LYgqgdeabe4=
X-Google-Smtp-Source: ABdhPJyBO5Ad0adrt6WR2Zs/lEWIONXLlQwdQq26vpPX0DvYDYQJZTq5hK5yCszGH/AwWCQGKychgQ==
X-Received: by 2002:a1c:7d0c:: with SMTP id y12mr5180330wmc.184.1611339374372;
        Fri, 22 Jan 2021 10:16:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u7sm922638wrr.80.2021.01.22.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:16:13 -0800 (PST)
Message-Id: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.git.1611267638.gitgitgadget@gmail.com>
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Jan 2021 18:16:09 +0000
Subject: [PATCH v2 0/3] Range diff with ranges lacking dotdot
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

 Documentation/git-range-diff.txt | 13 +++++++++++++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  9 +++++----
 revision.c                       | 25 +++++++++++++++++++++++++
 revision.h                       |  7 +++++++
 t/t3206-range-diff.sh            |  8 ++++++++
 6 files changed, 59 insertions(+), 5 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/841

Range-diff vs v1:

 1:  5839ba4f761 ! 1:  3f21e10f919 range-diff: refactor check for commit range
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    range-diff: refactor check for commit range
     +    range-diff/format-patch: refactor check for commit range
      
     -    Currently, when called with exactly two arguments, we test for a literal
     -    `..` in each of the two.
     +    Currently, when called with exactly two arguments, `git range-diff`
     +    tests for a literal `..` in each of the two. Likewise, the argument
     +    provided via `--range-diff` to `git format-patch` is checked in the same
     +    manner.
      
          However, `<commit>^!` is a perfectly valid commit range, equivalent to
          `<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
          gitrevisions[7].
      
          In preparation for allowing more sophisticated ways to specify commit
     -    ranges, let's refactor the conditional into its own function.
     +    ranges, let's refactor the check into its own function.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     + ## builtin/log.c ##
     +@@ builtin/log.c: static void infer_range_diff_ranges(struct strbuf *r1,
     + 				    struct commit *head)
     + {
     + 	const char *head_oid = oid_to_hex(&head->object.oid);
     +-	int prev_is_range = !!strstr(prev, "..");
     ++	int prev_is_range = specifies_commit_range(prev);
     + 
     + 	if (prev_is_range)
     + 		strbuf_addstr(r1, prev);
     +
       ## builtin/range-diff.c ##
     -@@ builtin/range-diff.c: N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
     - NULL
     - };
     +@@
     + #include "parse-options.h"
     + #include "range-diff.h"
     + #include "config.h"
     ++#include "revision.h"
       
     -+static int is_range(const char *range)
     -+{
     -+	return !!strstr(range, "..");
     -+}
     -+
     - int cmd_range_diff(int argc, const char **argv, const char *prefix)
     - {
     - 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
     + static const char * const builtin_range_diff_usage[] = {
     + N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
      @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char *prefix)
       		diffopt.use_color = 1;
       
       	if (argc == 2) {
      -		if (!strstr(argv[0], ".."))
      -			die(_("no .. in range: '%s'"), argv[0]);
     -+		if (!is_range(argv[0]))
     ++		if (!specifies_commit_range(argv[0]))
      +			die(_("not a commit range: '%s'"), argv[0]);
       		strbuf_addstr(&range1, argv[0]);
       
      -		if (!strstr(argv[1], ".."))
      -			die(_("no .. in range: '%s'"), argv[1]);
     -+		if (!is_range(argv[1]))
     ++		if (!specifies_commit_range(argv[1]))
      +			die(_("not a commit range: '%s'"), argv[1]);
       		strbuf_addstr(&range2, argv[1]);
       	} else if (argc == 3) {
       		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
     +
     + ## revision.c ##
     +@@ revision.c: void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
     + 	fputs(mark, stdout);
     + 	putchar(' ');
     + }
     ++
     ++int specifies_commit_range(const char *range)
     ++{
     ++	return !!strstr(range, "..");
     ++}
     +
     + ## revision.h ##
     +@@ revision.h: int rewrite_parents(struct rev_info *revs,
     +  */
     + struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
     + 
     ++/*
     ++ * Determine whether the given argument defines a commit range, e.g. A..B.
     ++ * Note that this only validates the format but does _not_ parse it, i.e.
     ++ * it does _not_ look up the specified commits in the local repository.
     ++ */
     ++int specifies_commit_range(const char *range);
     ++
     + #endif
 2:  88c15617b4b ! 2:  2c2744333ec range-diff: handle commit ranges other than A..B
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    range-diff: handle commit ranges other than A..B
     +    range-diff/format-patch: handle commit ranges other than A..B
      
          In the `SPECIFYING RANGES` section of gitrevisions[7], two ways are
          described to specify commit ranges that `range-diff` does not yet
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## builtin/range-diff.c ##
     -@@ builtin/range-diff.c: NULL
     + ## revision.c ##
     +@@ revision.c: void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
       
     - static int is_range(const char *range)
     + int specifies_commit_range(const char *range)
       {
      -	return !!strstr(range, "..");
      +	size_t i;
     @@ builtin/range-diff.c: NULL
      +		return 1;
      +
      +	i = strlen(range);
     -+	c = i ? range[--i] : 0;
     ++	c = i > 2 ? range[--i] : 0;
      +	if (c == '!')
     -+		i--; /* might be ...^! or ...^@ */
     ++		i--; /* might be ...^! */
      +	else if (isdigit(c)) {
      +		/* handle ...^-<n> */
      +		while (i > 2 && isdigit(range[--i]))
     @@ builtin/range-diff.c: NULL
      +	} else
      +		return 0;
      +
     ++	/* Before the `!` or the `-<n>`, we expect `<rev>^` */
      +	return i > 0 && range[i] == '^';
       }
     - 
     - int cmd_range_diff(int argc, const char **argv, const char *prefix)
      
       ## t/t3206-range-diff.sh ##
      @@ t/t3206-range-diff.sh: test_expect_success 'simple A B C (unmodified)' '
 3:  041456b6e73 = 3:  4f5e5acd954 range-diff(docs): explain how to specify commit ranges

-- 
gitgitgadget
