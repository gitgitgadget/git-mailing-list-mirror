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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2CEC433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D34664DA1
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhA0Qj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 11:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236371AbhA0QiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 11:38:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62B2C061756
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:27 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f16so2057645wmq.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2021 08:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P+7JMF1bqONdfw07yzuMZgLt5xHU0jbF8xAtQ0ovgw0=;
        b=prIDsBjojCfFU8fJdlt0DYHjPpjTDliGOtPRPPZjwMTbv41kAb4/TM4EavqUm1vdJQ
         UD7DhhAh8SvBn9gAbq6mRHfNLXwxBbQ4/faF+RanYIejfWJHTb1tIbjjYTIZaPscETrg
         6BmJ9j7BDpa4mQ+cR7yHpI//B1JTnHCQZuMMNrxtlfSA683d1y+evGJCQgOXVBwlR740
         mYoR/UdCbix4rp53RwhNUlrT8CgcIkTAzsagdv0XcZHnOaeaJDJTlw8zBmGb/SWM56JZ
         oqSWxlyGaQw7iuSrI5jv86uphLTtKlowTfhqxSGzCHe/wiH762vbljT3du8jKbXWjD0S
         GMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P+7JMF1bqONdfw07yzuMZgLt5xHU0jbF8xAtQ0ovgw0=;
        b=sTS7edAts9CfNHA10DUIyHowocLGBDRBxJkcGlT/TXYjb7IFXZcLh4IpoYZXCiq+x1
         TmcUvrscR4rsV3NF86+SElsYnmcxBJQ1tver4JBercJe0hnf8Xm7ONga18LzO4Obo+Ld
         Sr+USkvqMIuvQy8GlIyhSBf97RTrldaBnoCAvbR2foCuSB+7FFQo+McODOhgeGTz2DVh
         knE+07XQfAPjP3LLcvzU86i72MrIiMmBN9L7EZ5U3k0QzH5WS3xkzTVMg+DCTOvuEBqN
         7rmzZy70Tc4ahqpBj/q7K3rbKQV3pRLDXEoytbp+fXtKxKkCjYS0ZJpgyEpsGZck1mWf
         iayA==
X-Gm-Message-State: AOAM532yzSz4pW8jN74WygrzVLtmGngKiiiDMu0m4Jpos28pVewVoCtl
        1ro7axC0OFwYJdhBE59CGfKHlnZzxUw=
X-Google-Smtp-Source: ABdhPJxQ2mlhOD7qmjW+QJVuko/MsUT9WnQ4RUCMIsXrAb09IM2MzSrJQh8lKN8MNLL57wCQWb8Brw==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr5084695wme.146.1611765446271;
        Wed, 27 Jan 2021 08:37:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v126sm3148787wma.22.2021.01.27.08.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 08:37:25 -0800 (PST)
Message-Id: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
References: <pull.841.v2.git.1611339373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Jan 2021 16:37:21 +0000
Subject: [PATCH v3 0/3] Range diff with ranges lacking dotdot
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

 Documentation/git-range-diff.txt | 12 ++++++++++++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  9 +++++----
 range-diff.c                     | 17 +++++++++++++++++
 range-diff.h                     |  8 ++++++++
 t/t3206-range-diff.sh            |  8 ++++++++
 6 files changed, 51 insertions(+), 5 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/841

Range-diff vs v2:

 1:  3f21e10f919 ! 1:  b98fa94b870 range-diff/format-patch: refactor check for commit range
     @@ builtin/log.c: static void infer_range_diff_ranges(struct strbuf *r1,
       {
       	const char *head_oid = oid_to_hex(&head->object.oid);
      -	int prev_is_range = !!strstr(prev, "..");
     -+	int prev_is_range = specifies_commit_range(prev);
     ++	int prev_is_range = is_range_diff_range(prev);
       
       	if (prev_is_range)
       		strbuf_addstr(r1, prev);
     @@ builtin/range-diff.c: int cmd_range_diff(int argc, const char **argv, const char
       	if (argc == 2) {
      -		if (!strstr(argv[0], ".."))
      -			die(_("no .. in range: '%s'"), argv[0]);
     -+		if (!specifies_commit_range(argv[0]))
     ++		if (!is_range_diff_range(argv[0]))
      +			die(_("not a commit range: '%s'"), argv[0]);
       		strbuf_addstr(&range1, argv[0]);
       
      -		if (!strstr(argv[1], ".."))
      -			die(_("no .. in range: '%s'"), argv[1]);
     -+		if (!specifies_commit_range(argv[1]))
     ++		if (!is_range_diff_range(argv[1]))
      +			die(_("not a commit range: '%s'"), argv[1]);
       		strbuf_addstr(&range2, argv[1]);
       	} else if (argc == 3) {
       		strbuf_addf(&range1, "%s..%s", argv[0], argv[1]);
      
     - ## revision.c ##
     -@@ revision.c: void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
     - 	fputs(mark, stdout);
     - 	putchar(' ');
     + ## range-diff.c ##
     +@@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
     + 
     + 	return res;
       }
      +
     -+int specifies_commit_range(const char *range)
     ++int is_range_diff_range(const char *arg)
      +{
     -+	return !!strstr(range, "..");
     ++	return !!strstr(arg, "..");
      +}
      
     - ## revision.h ##
     -@@ revision.h: int rewrite_parents(struct rev_info *revs,
     -  */
     - struct commit_list *get_saved_parents(struct rev_info *revs, const struct commit *commit);
     + ## range-diff.h ##
     +@@ range-diff.h: int show_range_diff(const char *range1, const char *range2,
     + 		    const struct diff_options *diffopt,
     + 		    const struct strvec *other_arg);
       
      +/*
     -+ * Determine whether the given argument defines a commit range, e.g. A..B.
     -+ * Note that this only validates the format but does _not_ parse it, i.e.
     -+ * it does _not_ look up the specified commits in the local repository.
     ++ * Determine whether the given argument is usable as a range argument of `git
     ++ * range-diff`, e.g. A..B. Note that this only validates the format but does
     ++ * _not_ parse it, i.e. it does _not_ look up the specified commits in the
     ++ * local repository.
      + */
     -+int specifies_commit_range(const char *range);
     ++int is_range_diff_range(const char *arg);
      +
       #endif
 2:  2c2744333ec ! 2:  0880ca587e6 range-diff/format-patch: handle commit ranges other than A..B
     @@ Commit message
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     - ## revision.c ##
     -@@ revision.c: void put_revision_mark(const struct rev_info *revs, const struct commit *commit)
     + ## range-diff.c ##
     +@@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       
     - int specifies_commit_range(const char *range)
     + int is_range_diff_range(const char *arg)
       {
     --	return !!strstr(range, "..");
     -+	size_t i;
     -+	char c;
     +-	return !!strstr(arg, "..");
     ++	static regex_t *regex;
      +
     -+	if (strstr(range, ".."))
     ++	if (strstr(arg, ".."))
      +		return 1;
      +
     -+	i = strlen(range);
     -+	c = i > 2 ? range[--i] : 0;
     -+	if (c == '!')
     -+		i--; /* might be ...^! */
     -+	else if (isdigit(c)) {
     -+		/* handle ...^-<n> */
     -+		while (i > 2 && isdigit(range[--i]))
     -+			; /* keep trimming trailing digits */
     -+		if (i < 2 || range[i--] != '-')
     -+			return 0;
     -+	} else
     -+		return 0;
     ++	/* match `<rev>^!` and `<rev>^-<n>` */
     ++	if (!regex) {
     ++		regex = xmalloc(sizeof(*regex));
     ++		if (regcomp(regex, "\\^(!|-[0-9]*)$", REG_EXTENDED) < 0)
     ++			BUG("could not compile range-diff regex");
     ++	}
      +
     -+	/* Before the `!` or the `-<n>`, we expect `<rev>^` */
     -+	return i > 0 && range[i] == '^';
     ++	return !regexec(regex, arg, 0, NULL, 0);
       }
      
       ## t/t3206-range-diff.sh ##
 3:  4f5e5acd954 ! 3:  5ab9321a34c range-diff(docs): explain how to specify commit ranges
     @@ Documentation/git-range-diff.txt: Finally, the list of matching commits is shown
      +
      +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
      +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
     -+  equivalent to `<base>..<rev1> <base>..<rev2>` where `<base>` is the
     -+  merge base as obtained via `git merge-base <rev1> <rev2>`.
     ++  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.
      +
      +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
      +  <base>..<rev2>`.

-- 
gitgitgadget
