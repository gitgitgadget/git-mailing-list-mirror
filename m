Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2727C433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 11:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbiAKLMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiAKLMO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 06:12:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF25C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w26so4869696wmi.0
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=5teVLw05UeLzMec9KlgVuuTlp2TjAYPq0Fm0GQNhHTM=;
        b=jZ9vp2zNJfhzPBigmeGCTCyyTh7KBfOLoaYObqzpnviq3hcFfqbZcx7IXpZwANArgh
         Tf9NS0WiP0oZ1Je1Gbp1zL5k+MANdNF+eZVAvZ+H+ilnS05LZ9qf4hWkvxhjVhrGhJU7
         keGkdCNicaPJLh9wGZnWtyyRrwuAIcRmTcC1bc4NTrPjxLlTFVvSGkbTOmeh0ATFn9ss
         /JC1KB5W7m/aPpIKyFtidHjrJrq80RA4SaC1FdBdUw7bSso4GHezhb/anJb3rbyMOgJJ
         ETbA2qHVCvFzIILG/cznFV6+HRytWJlNB9l6bfhEnOSvqHr5ZhkHVvKBdxy2AyoeN1X6
         HCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=5teVLw05UeLzMec9KlgVuuTlp2TjAYPq0Fm0GQNhHTM=;
        b=l6X2tDkS0spSUlXCmZLO0TxjdaP0ok+7nHatXhNB2GeNhgqXKsJlMwFGTVEVWXaQrV
         C6JJJi7t5U6CJawH9mkte+cuXpGbA9ksLZUbO0P7jB6stzC3ApHH33ee0Wq2vhlmg0q+
         WyhnK3Gf5IrYAGKfZJ6BqD/Y6moeHyuEimP42U9h0M7rY1t+uRTE5f3GCg7RJQOp4vDU
         L7EO3k2pMye+Y81CmcBDfS4XJf3VpV4Ghc6a6dq1oxZsiPJGzR+dTSQ7Gkco0zNBixBx
         Z1qfQTXKyf2w2wU66Avl9eeubP9pIsKz44UleHZTTM2K7JhWAyQ0NFD7gs9FMbG1Odfh
         L+/g==
X-Gm-Message-State: AOAM531k6hb31224kkGrwIZp2+YwKYhX+OXlpFn/8Sa3ROLT+dYWL2CQ
        PiZ+ZG1ULXKW29CJ9AssFKpgmAg+gvc=
X-Google-Smtp-Source: ABdhPJw44xvBP+mvO6L9O1+THJdjocV8lTeEtEX0DbPrYAn6bRV6hOBPgSYA7cwh/C8IX2C9/4SnuQ==
X-Received: by 2002:a05:600c:1f16:: with SMTP id bd22mr563636wmb.55.1641899531882;
        Tue, 11 Jan 2022 03:12:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm1362606wmf.25.2022.01.11.03.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:12:11 -0800 (PST)
Message-Id: <pull.1100.v2.git.1641899530.gitgitgadget@gmail.com>
In-Reply-To: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Jan 2022 11:12:08 +0000
Subject: [PATCH v2 0/2] builtin add -p: fix hunk splitting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio and Ævar for their comments on V1. I've updated the commit
message and added a helper function as suggested.

V1 Cover Letter: Fix a small regression in the hunk splitting of the builtin
version compared to the perl version. Thanks to Szeder for the easy to
follow bug report.

Phillip Wood (2):
  t3701: clean up hunk splitting tests
  builtin add -p: fix hunk splitting

 add-patch.c                | 20 ++++++++++------
 t/t3701-add-interactive.sh | 48 ++++++++++++++++++++++++++++++++++----
 2 files changed, 56 insertions(+), 12 deletions(-)


base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1100%2Fphillipwood%2Fwip%2Fadd-p-fix-hunk-splitting-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1100/phillipwood/wip/add-p-fix-hunk-splitting-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1100

Range-diff vs v1:

 1:  cc8639fc29d = 1:  cc8639fc29d t3701: clean up hunk splitting tests
 2:  5d5639c2b04 ! 2:  b698989e265 builtin add -p: fix hunk splitting
     @@ Metadata
       ## Commit message ##
          builtin add -p: fix hunk splitting
      
     +    The C reimplementation of "add -p" fails to split the last hunk in a
     +    file if hunk ends with an addition or deletion without any post context
     +    line unless it is the last file to be processed.
     +
          To determine whether a hunk can be split a counter is incremented each
          time a context line follows an insertion or deletion. If at the end of
          the hunk the value of this counter is greater than one then the hunk
     @@ Commit message
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
       ## add-patch.c ##
     +@@ add-patch.c: static int is_octal(const char *p, size_t len)
     + 	return 1;
     + }
     + 
     ++static void complete_file(char marker, struct hunk *hunk)
     ++{
     ++	if (marker == '-' || marker == '+')
     ++		/*
     ++		 * Last hunk ended in non-context line (i.e. it
     ++		 * appended lines to the file, so there are no
     ++		 * trailing context lines).
     ++		 */
     ++		hunk->splittable_into++;
     ++}
     ++
     + static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
     + {
     + 	struct strvec args = STRVEC_INIT;
      @@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
       			eol = pend;
       
       		if (starts_with(p, "diff ")) {
     -+			if (marker == '-' || marker == '+')
     -+				/*
     -+				 * Last hunk ended in non-context line (i.e. it
     -+				 * appended lines to the file, so there are no
     -+				 * trailing context lines).
     -+				 */
     -+				hunk->splittable_into++;
     ++			complete_file(marker, hunk);
       			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
       				   file_diff_alloc);
       			file_diff = s->file_diff + s->file_diff_nr - 1;
     +@@ add-patch.c: static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
     + 				file_diff->hunk->colored_end = hunk->colored_end;
     + 		}
     + 	}
     +-
     +-	if (marker == '-' || marker == '+')
     +-		/*
     +-		 * Last hunk ended in non-context line (i.e. it appended lines
     +-		 * to the file, so there are no trailing context lines).
     +-		 */
     +-		hunk->splittable_into++;
     ++	complete_file(marker, hunk);
     + 
     + 	/* non-colored shorter than colored? */
     + 	if (colored_p != colored_pend) {
      
       ## t/t3701-add-interactive.sh ##
      @@ t/t3701-add-interactive.sh: test_expect_success 'correct message when there is nothing to do' '

-- 
gitgitgadget
