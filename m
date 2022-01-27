Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9FDC433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245421AbiA0TIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 14:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiA0TId (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 14:08:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25698C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso6621011wmj.0
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OFSFOkjuqqF8lzY7lcKawx11bc/uDnRWJ1yOFsJJV7U=;
        b=UEprRjz98FgfcYjsTFY1PFDXemguGxbtxWNQv+z3F8uRKG4wd0y+fIzIEy3buqcTYY
         kdZCkU3OosGJU6CtzRYXIfzG+hnK7KEew+0/Uz58KfQtd/RAfCIilAHlHdoe7aBZl2Hp
         G9mX0BHQaWHpC4LgFZAa7e7OjA/KcHKEXY3aUPehOEa4zniOBrtYM9Wj2uDtZwiVeZq7
         gebWdsc1qV/FO1WmeRSmNKwpwNFHvNFlhdfKkF6SKmMIfmehWanUNk44FNt8oRQIDcq1
         ABo6om3iMmsSkXI3BJbqstvGdpq8vJYAFh8yqgy4C3bprZvnV05XTRIV7bNCHXWExaV6
         FNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OFSFOkjuqqF8lzY7lcKawx11bc/uDnRWJ1yOFsJJV7U=;
        b=b23J9gGsTt/DGdZ26FAcn/l1pX51gJ14l9QPj7WucAOMdVAa99sJP1XUTBqO6iNGva
         l0bTMInGyO7vDoP1JYdS3Pe9IO0KoMT/+SEg2AuiJFk3UdudLaz+FJst32EZGaCeMlJ9
         XKvDKrCJ3PvJQjfo+pgti0NUwLeU7dATLpTZ2gZmUuzjfWaetlOwLVXBXp7APkaaqasf
         fm1fZ/zSskRowVDT2z4gaabLmfeh/RfAUU36YA+8LvlCnsIO0i2M0OhtR3b0jPkVlgSv
         3MrYS0Tutf+WcCBsibhyb21IIApvncok8cOv2BlfpWPTBQ3SK7sBqkg1U7c0oHj/9IdJ
         cnHw==
X-Gm-Message-State: AOAM531r7pwmb94PlblRpH2FSjTDnIeIrVsLcKvz8YGRYTbA1QP/TdLb
        EeWv1KbU7qGf0fMD5wSNyhnZbRQHlfo=
X-Google-Smtp-Source: ABdhPJxXW+eS03M2zvcgdoV9bIJIdB3jcM6cVC0yz8702RP4t/dQUIGB1dHdIO2dhLVZxYI26CKDjg==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr12937111wmr.4.1643310511421;
        Thu, 27 Jan 2022 11:08:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z1sm129590wma.20.2022.01.27.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:08:30 -0800 (PST)
Message-Id: <pull.1127.v2.git.1643310510.gitgitgadget@gmail.com>
In-Reply-To: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 19:08:26 +0000
Subject: [PATCH v2 0/3] Fix two --diff-filter bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A colleague noticed that git diff --diff-filter=Dr behaved in an unexpected
way. The expectation was that the command shows only deleted files, but not
renamed ones.

Turns out that Git's code is incorrect and turns on all diff-filter flags
because the argument contains a lower-case letter. But since it starts with
an upper-case letter, we should actually not turn all those flags on.

While working on the fix, I realized that the documentation of the
--diff-filter flag was not updated when intent-to-add files were no longer
shown as modified by git diff, but as added.

Changes since v1:

 * Now even the case of multiple --diff-filter options is handled.

Johannes Schindelin (3):
  docs(diff): lose incorrect claim about `diff-files --diff-filter=A`
  diff.c: move the diff filter bits definitions up a bit
  diff-filter: be more careful when looking for negative bits

 Documentation/diff-options.txt |  7 +--
 diff.c                         | 97 +++++++++++++++-------------------
 diff.h                         |  2 +-
 t/t4202-log.sh                 | 13 +++++
 4 files changed, 60 insertions(+), 59 deletions(-)


base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1127%2Fdscho%2Fdiff-filter-buglets-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1127/dscho/diff-filter-buglets-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1127

Range-diff vs v1:

 1:  704bb2ba18e = 1:  704bb2ba18e docs(diff): lose incorrect claim about `diff-files --diff-filter=A`
 -:  ----------- > 2:  19c7223e265 diff.c: move the diff filter bits definitions up a bit
 2:  e8006493a9e ! 3:  b041d2b7a3b diff-filter: be more careful when looking for negative bits
     @@ Commit message
          provided a lower-case letter: if the `--diff-filter` argument starts
          with an upper-case letter, we must not start with all bits turned on.
      
     +    Even worse, it is possible to specify the diff filters in multiple,
     +    separate options, e.g. `--diff-filter=AM [...] --diff-filter=m`.
     +
     +    Let's accumulate the include/exclude filters independently, and only
     +    special-case the "only exclude filters were specified" case after
     +    parsing the options altogether.
     +
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## diff.c ##
     +@@ diff.c: void diff_setup_done(struct diff_options *options)
     + 	if (!options->use_color || external_diff())
     + 		options->color_moved = 0;
     + 
     ++	if (options->filter_not) {
     ++		if (!options->filter)
     ++			options->filter = ~filter_bit[DIFF_STATUS_FILTER_AON];
     ++		options->filter &= ~options->filter_not;
     ++	}
     ++
     + 	FREE_AND_NULL(options->parseopts);
     + }
     + 
      @@ diff.c: static int diff_opt_diff_filter(const struct option *option,
     + 	BUG_ON_OPT_NEG(unset);
       	prepare_filter_bits();
       
     - 	/*
     +-	/*
      -	 * If there is a negation e.g. 'd' in the input, and we haven't
     -+	 * If the input starts with a negation e.g. 'd', and we haven't
     - 	 * initialized the filter field with another --diff-filter, start
     - 	 * from full set of bits, except for AON.
     - 	 */
     - 	if (!opt->filter) {
     +-	 * initialized the filter field with another --diff-filter, start
     +-	 * from full set of bits, except for AON.
     +-	 */
     +-	if (!opt->filter) {
      -		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
      -			if (optch < 'a' || 'z' < optch)
      -				continue;
     -+		optch = optarg[0];
     -+		if (optch >= 'a' && 'z' >= optch) {
     - 			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
     - 			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
     +-			opt->filter = (1 << (ARRAY_SIZE(diff_status_letters) - 1)) - 1;
     +-			opt->filter &= ~filter_bit[DIFF_STATUS_FILTER_AON];
      -			break;
     - 		}
     +-		}
     +-	}
     +-
     + 	for (i = 0; (optch = optarg[i]) != '\0'; i++) {
     + 		unsigned int bit;
     + 		int negate;
     +@@ diff.c: static int diff_opt_diff_filter(const struct option *option,
     + 			return error(_("unknown change class '%c' in --diff-filter=%s"),
     + 				     optarg[i], optarg);
     + 		if (negate)
     +-			opt->filter &= ~bit;
     ++			opt->filter_not |= bit;
     + 		else
     + 			opt->filter |= bit;
       	}
     +
     + ## diff.h ##
     +@@ diff.h: struct diff_options {
     + 	struct diff_flags flags;
     + 
     + 	/* diff-filter bits */
     +-	unsigned int filter;
     ++	unsigned int filter, filter_not;
     + 
     + 	int use_color;
       
      
       ## t/t4202-log.sh ##
     @@ t/t4202-log.sh: test_expect_success 'diff-filter=R' '
       
       '
       
     -+test_expect_success 'diff-filter=Ra' '
     ++test_expect_success 'multiple --diff-filter bits' '
      +
      +	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
      +	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
     ++	test_cmp expect actual &&
     ++	git log -M --pretty="format:%s" --diff-filter=aR HEAD >actual &&
     ++	test_cmp expect actual &&
     ++	git log -M --pretty="format:%s" \
     ++		--diff-filter=a --diff-filter=R HEAD >actual &&
      +	test_cmp expect actual
      +
      +'

-- 
gitgitgadget
