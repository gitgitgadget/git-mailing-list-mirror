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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC92C433E9
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F0064F99
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhBEWBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhBEO5n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:57:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F52C061356
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 08:28:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q2so9479901edi.4
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e8ISuPnC887pAvl2A11C8Wo7UzdCNPjl6jx7j86v4HM=;
        b=lW+sjktXp9+jfICPkOMgHP1IM30Tee59KHHYbGI3ZAZ/53cTUWkMwpMS7xvvboajCo
         3MRnQy4z+uHQQz6TO8hZFRKALf/wviH29GyNbVm/GWJJpow0aWPWHJlu5txA31Hlbtn/
         P6w06JdskNKU6BpVe46RQMbWl48ud9nv85m113EBV/3mRnxGsa9vHnHKdUzuT4bu+H9Y
         SCJ2XNvUic3qstnp/KGxfBsXxMJECQ7uTELniX0biafZwphU5cFNGVbajnOiLxenci1/
         ZN+RatfcNGCRc4qGs6BOuxsXZ4mJFNsO1QqRA/T9wZA0KsOaqlH/DGcVgLvdoBbiI6Bj
         OtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e8ISuPnC887pAvl2A11C8Wo7UzdCNPjl6jx7j86v4HM=;
        b=Sojc1Bgnl0immsuMKu5I2e04IZE7ABK9WXKaXXOwGjNQU9UiN8Zx0nSMxSArqLhQSW
         KKdaQ12NC118jHFgXOi1+Dif+u6SaWl4wKyXSJ6kKPEz2Z/Oryh9TjjtadpR+72cirQ+
         GhfO/8G4V1LvIRSOuD5zj0dynq5/8mS95oIk6vVc4UNc6xiOyyxOOcCADe6xL6xY7T66
         GU3vV/ub1W3vIBNnDSaGYf1PfCo+VIvosstAb5TYb+uvhRcjVN2QzDirVEcbBEjiZdwF
         ha1ki4RDZdUJP3AQ4AGgOxu+NEeuhS//FlecpJBn9YOv+D6jcqHtwZdGvpKYgap1JmZG
         ef9g==
X-Gm-Message-State: AOAM533YoDVAYVd/NGRhAuuvGQqrOM/iX+nZ/Vtb7fkpj73ML9y2Fs4T
        uKrCqFl8WiZ2zUbHolg3hWzuLIXSh+4=
X-Google-Smtp-Source: ABdhPJzq32v3MBhv2jKSck0K+sEIFWF57KZTedhbJQME0nHJyCH/UmefohNNs9ixVGflhd+a9BiYMw==
X-Received: by 2002:adf:9226:: with SMTP id 35mr5476315wrj.408.1612536374532;
        Fri, 05 Feb 2021 06:46:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm12249260wrx.2.2021.02.05.06.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:14 -0800 (PST)
Message-Id: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:07 +0000
Subject: [PATCH v2 0/6] Optionally restrict range-diff output to "left" or "right" range only
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of my quite common workflows is to see whether an ancient topic branch I
have lying about has made it into Git. Since my local commit OIDs have
nothing to do with the OIDs of the corresponding commits in git/git, my only
way is to fire up git range-diff ...upstream/master, but of course that
output contains way more commits than I care about.

To help this use case, here is a patch series that teaches git range-diff
the --left-only and --right-only options in the end, restricting the output
to those commits and commit pairs that correspond to the commits in the
first and the second range, respectively.

The first part of the series contains cleanup patches that are not strictly
related to the feature I implemented here, but since I already have them, I
figured I could just as well contribute them all together.

This patch series is based on js/range-diff-wo-dotdot.

Changes since v1:

 * Adjusted the comment above show_range_diff() to reflect the new
   signature.

Johannes Schindelin (6):
  range-diff: avoid leaking memory in two error code paths
  range-diff: libify the read_patches() function again
  range-diff: simplify code spawning `git log`
  range-diff: combine all options in a single data structure
  range-diff: move the diffopt initialization down one layer
  range-diff: offer --left-only/--right-only options

 Documentation/git-range-diff.txt |   9 +++
 builtin/log.c                    |  10 ++-
 builtin/range-diff.c             |  21 +++++--
 log-tree.c                       |   8 ++-
 range-diff.c                     | 101 +++++++++++++++++--------------
 range-diff.h                     |  17 ++++--
 t/t3206-range-diff.sh            |  15 +++++
 7 files changed, 120 insertions(+), 61 deletions(-)


base-commit: 35fac18ea5ccab7524501bcb4542473ef8195541
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-869%2Fdscho%2Frange-diff-left-and-right-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-869/dscho/range-diff-left-and-right-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/869

Range-diff vs v1:

 1:  5f2f06b79e20 = 1:  15f4f6abdaa2 range-diff: avoid leaking memory in two error code paths
 2:  0d25dd2a9c2d = 2:  99e466ef32d7 range-diff: libify the read_patches() function again
 3:  d6c582c25df0 = 3:  a36631b663e2 range-diff: simplify code spawning `git log`
 4:  b620be042eb3 ! 4:  7367eadfe243 range-diff: combine all options in a single data structure
     @@ range-diff.h
      +struct range_diff_options {
      +	int creation_factor;
      +	unsigned dual_color:1;
     -+	const struct diff_options *diffopt;
     -+	const struct strvec *other_arg;
     ++	const struct diff_options *diffopt; /* may be NULL */
     ++	const struct strvec *other_arg; /* may be NULL */
      +};
      +
       /*
     -  * Compare series of commits in RANGE1 and RANGE2, and emit to the
     -  * standard output.  NULL can be passed to DIFFOPT to use the built-in
     -  * default.
     +- * Compare series of commits in RANGE1 and RANGE2, and emit to the
     +- * standard output.  NULL can be passed to DIFFOPT to use the built-in
     +- * default.
     ++ * Compare series of commits in `range1` and `range2`, and emit to the
     ++ * standard output.
        */
       int show_range_diff(const char *range1, const char *range2,
      -		    int creation_factor, int dual_color,
 5:  9fa945db5f13 = 5:  a6285292b4f1 range-diff: move the diffopt initialization down one layer
 6:  1c599abdbb6f ! 6:  8357d3c94f17 range-diff: offer --left-only/--right-only options
     @@ range-diff.h
       	int creation_factor;
       	unsigned dual_color:1;
      +	unsigned left_only:1, right_only:1;
     - 	const struct diff_options *diffopt;
     - 	const struct strvec *other_arg;
     + 	const struct diff_options *diffopt; /* may be NULL */
     + 	const struct strvec *other_arg; /* may be NULL */
       };
      
       ## t/t3206-range-diff.sh ##

-- 
gitgitgadget
