Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC113C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 05:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF8922517
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 05:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbhARFQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 00:16:00 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44311 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbhARFP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 00:15:59 -0500
Received: by mail-ed1-f49.google.com with SMTP id p22so16091631edu.11
        for <git@vger.kernel.org>; Sun, 17 Jan 2021 21:15:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61p+HT5zqNDsRuAZayAmcKs0ISkKchc/rc8RCTUM7O4=;
        b=iVxCzQUbL21yPvVHziIFfEGn/PCIbtOyE7qJbQAyid/sE9eaK4BGnr+QRc3h/IYgN5
         2hZ792uNhR9djTT/IPdNxSMF17xcHoMufeKXEGbBVEngRTsS7igcJCeeh4Ln834CfMYA
         UUrlf2jGTAD+krOY5HvTVvFtmOT3C9hchsB9n0Xgqd7ni39U+ZAnsCdmznqrWTkTCmge
         boRqP2Z8rCvt5XMeSOVaoDHWkb0vplArrFlLfBOtKNJEPMAYGvWM2o1U57smQEH/Urmq
         e0G0M5LluRwdVkIrBQDX0oT6qPGtPzpGTccMu3EMCKWFqzIdgmN4kSnjrocN7b3McpQx
         pSPA==
X-Gm-Message-State: AOAM531Ge2dgbGkBn7nk6esOVDgz0uOp3ACZWZfsUoEKWluWfpbEt8mG
        FMwfraBsxSAoEVHVvjYGhRk5xBxv0cWDVdLuhLhBWRwH4oM=
X-Google-Smtp-Source: ABdhPJx5Q4lEzrRICsLq0ZxF4AIihdVBmjgzB9Las9vM5+7OANH/NN67JHofHBn3Z1j7Qb9CkSKxj73w3FQ/f9Qzpc4=
X-Received: by 2002:a05:6402:b52:: with SMTP id bx18mr4593321edb.221.1610946917405;
 Sun, 17 Jan 2021 21:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210117234244.95106-1-rafaeloliveira.cs@gmail.com> <20210117234244.95106-7-rafaeloliveira.cs@gmail.com>
In-Reply-To: <20210117234244.95106-7-rafaeloliveira.cs@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Jan 2021 00:15:06 -0500
Message-ID: <CAPig+cQ4jeSkOLb-Ski0G2tvafxh0Jjv+ObB7ZkbcryVYedGZQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] worktree: teach `list` verbose mode
To:     Rafael Silva <rafaeloliveira.cs@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 17, 2021 at 6:43 PM Rafael Silva
<rafaeloliveira.cs@gmail.com> wrote:
> "git worktree list" annotates each worktree according to its state such
> as "prunable" or "locked", however it is not immediately obvious why
> these worktrees are being annotated. For prunable worktrees a reason
> is available that is returned by should_prune_worktree() and for locked
> worktrees a reason might be available provided by the user via `lock`
> command.
>
> Let's teach "git worktree list" to output the reason why the worktrees
> are being annotated. The reason is a text that can take virtually any
> size and appending the text on the default columned format will make it
> difficult to extend the command with other annotations and not fit nicely
> on the screen. In order to address this shortcoming the annotation is
> then moved to the next line indented followed by the reason, if the
> reason is not available the annotation stays on the same line as the
> worktree itself.

If you're re-rolling, let's mention the new `--verbose` option
somewhere in the commit message since that is the focus of this patch.
The second paragraph would be a good place:

    Let's teach "git worktree list" a --verbose mode which
    outputs the reason...

Also, the final sentence is a bit difficult to follow due to the comma
before "if the reason is not available". If you make the "if the
reason is not available" a separate sentence, it becomes simple to
understand.

> diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
> @@ -135,6 +135,33 @@ test_expect_success '"list" all worktrees with prunable consistent with "prune"'
> +test_expect_success '"list" all worktrees --verbose with locked' '
> +       test_when_finished "rm -rf locked out actual expect && git worktree prune" &&
> +       git worktree add locked --detach &&
> +       git worktree lock locked --reason "with reason" &&
> +       test_when_finished "git worktree unlock locked" &&
> +       echo "$(git -C locked rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
> +       printf "\tlocked: with reason\n" >>expect &&
> +       git worktree list --verbose >out &&
> +       sed -n "s/  */ /g;/\/locked  *[0-9a-f].*$/,/locked: .*$/p" <out >actual &&
> +       test_cmp actual expect
> +'

At first, I wondered if we would also want this test to have a
locked-no-reason worktree to ensure that its `locked` annotation stays
on the same line as the worktree, but that's not needed because that
case is already covered by the existing test. Fine.

> +test_expect_success '"list" all worktrees --verbose with prunable' '
> +       test_when_finished "rm -rf prunable out actual expect && git worktree prune" &&
> +       git worktree add prunable --detach &&
> +       echo "$(git -C prunable rev-parse --show-toplevel) $(git rev-parse --short HEAD) (detached HEAD)" >expect &&
> +       printf "\tprunable: gitdir file points to non-existent location\n" >>expect &&
> +       rm -rf prunable &&
> +       git worktree list --verbose >out &&
> +       sed -n "s/  */ /g;/\/prunable  *[0-9a-f].*$/,/prunable: .*$/p" <out >actual &&
> +       test_i18ncmp actual expect
> +'

An alternative would be to have a single test of --verbose which
includes a locked-no-reason worktree, a locked-with-reason worktree,
and a prunable worktree. However, that's a very minor and subjective
point and certainly not worth a re-roll or changing unless you think
it's a nice simplification.
