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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E99CC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F3164F51
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 09:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhBDJcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhBDJcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 04:32:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D56C061573
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 01:31:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j11so2483615wmi.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xu2tH6mG35jgRr5f01k9OLhr76DoiunoJ3Ybe7vjz3E=;
        b=aAPAXBxSYNpu7/ys6oSO7POjg4VZ/uWoBbQSKbCsFsL7DYKA1Xq0VdyJFTxiB6CVWD
         Rla1uWwKQPbRafJnbzErjg6uRfm0fTt7pt4W+i3eMFk6J0HYPycjQpOyKOjvv+ratHEm
         BFjiBe/BiVrVfhDOGyqk+9T5ibPRRPHaWRPpgZPDEIheAXYnSVsm4fu3HiM60bPJhfiP
         uBcN8l/uTiGcnTFyohOW9Q6//Kuzysy6XwN7zsMJFJjqvyIU9UxALS48HE7k+8txAJij
         4RFnP9Os6DtwsTD4KIU6+Rpz8NgqfMeyu6fYGeln541NnGsjEYwBguSDHndLG/Y4xP59
         BE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xu2tH6mG35jgRr5f01k9OLhr76DoiunoJ3Ybe7vjz3E=;
        b=i76vEZDQZj5UDSTtqRaZHiioAiBDZXM5V+C5DSkIbIAgg5iC75z4nvfx6WJwjpyKM6
         XmssI4K7tg0hTiMldm/d5K/z9bQEo5NS0FUPpylGfP/YuAC+X6UyJai+DbqyYSi7YNYX
         +C04/LKXuVNzCwzoLKpJ4F0FNr7BiH18YMkxcUMNuThDdAoQn9Wevaxm0j/muhL/NqcT
         tm4orN7Huo8il0Ylw+FbUNCX5JpC/4wYqTxguslUFRd5+CGZQ83PwUO1vPrLCgmT7t0P
         9uhnn7gmBWd4XpMfhh0hRkW9eW4y6+m3rz50KvNX0hfRWOUy+4vqJPaBti5z0VV2Co9b
         eaJQ==
X-Gm-Message-State: AOAM532hGs9urEmsgLsPdoQUep+T8ThtQ8JzbkNQQL2NAGs9nIvXT8xd
        Q59KA3BbT1PLQMaspZL1l09Dz1B73i8=
X-Google-Smtp-Source: ABdhPJxfOqlxBbWyPePAs1c2OM7ZzaZUJGHeNq8aimooz4p1wKKXD9jK78idIA6kUsWlXiolltN8QA==
X-Received: by 2002:a1c:acc9:: with SMTP id v192mr6545796wme.22.1612431095248;
        Thu, 04 Feb 2021 01:31:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm7199769wrx.84.2021.02.04.01.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 01:31:34 -0800 (PST)
Message-Id: <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
In-Reply-To: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 09:31:29 +0000
Subject: [PATCH v4 0/3] Range diff with ranges lacking dotdot
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

 Documentation/git-range-diff.txt | 12 ++++++++++++
 builtin/log.c                    |  2 +-
 builtin/range-diff.c             |  9 +++++----
 range-diff.c                     | 22 ++++++++++++++++++++++
 range-diff.h                     |  8 ++++++++
 t/t3206-range-diff.sh            |  8 ++++++++
 6 files changed, 56 insertions(+), 5 deletions(-)


base-commit: 71ca53e8125e36efbda17293c50027d31681a41f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-841%2Fdscho%2Frange-diff-with-ranges-lacking-dotdot-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-841/dscho/range-diff-with-ranges-lacking-dotdot-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/841

Range-diff vs v3:

 1:  b98fa94b8703 = 1:  b98fa94b8703 range-diff/format-patch: refactor check for commit range
 2:  0880ca587e63 ! 2:  448e6a64fa15 range-diff/format-patch: handle commit ranges other than A..B
     @@ Commit message
          described to specify commit ranges that `range-diff` does not yet
          accept: "<commit>^!" and "<commit>^-<n>".
      
     -    Let's accept them.
     +    Let's accept them, by parsing them via the revision machinery and
     +    looking for at least one interesting and one uninteresting revision in
     +    the resulting `pending` array.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## range-diff.c ##
     +@@
     + #include "pretty.h"
     + #include "userdiff.h"
     + #include "apply.h"
     ++#include "revision.h"
     + 
     + struct patch_util {
     + 	/* For the search for an exact match */
      @@ range-diff.c: int show_range_diff(const char *range1, const char *range2,
       
       int is_range_diff_range(const char *arg)
       {
      -	return !!strstr(arg, "..");
     -+	static regex_t *regex;
     -+
     -+	if (strstr(arg, ".."))
     -+		return 1;
     ++	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
     ++	const char *argv[] = { "", copy, "--", NULL };
     ++	int i, positive = 0, negative = 0;
     ++	struct rev_info revs;
      +
     -+	/* match `<rev>^!` and `<rev>^-<n>` */
     -+	if (!regex) {
     -+		regex = xmalloc(sizeof(*regex));
     -+		if (regcomp(regex, "\\^(!|-[0-9]*)$", REG_EXTENDED) < 0)
     -+			BUG("could not compile range-diff regex");
     ++	init_revisions(&revs, NULL);
     ++	if (setup_revisions(3, argv, &revs, 0) == 1) {
     ++		for (i = 0; i < revs.pending.nr; i++)
     ++			if (revs.pending.objects[i].item->flags & UNINTERESTING)
     ++				negative++;
     ++			else
     ++				positive++;
      +	}
      +
     -+	return !regexec(regex, arg, 0, NULL, 0);
     ++	free(copy);
     ++	object_array_clear(&revs.pending);
     ++	return negative > 0 && positive > 0;
       }
      
       ## t/t3206-range-diff.sh ##
 3:  5ab9321a34ca = 3:  295fdc1cd32c range-diff(docs): explain how to specify commit ranges

-- 
gitgitgadget
