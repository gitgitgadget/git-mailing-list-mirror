Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5CC4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 01:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKCBNb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 21:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCBNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 21:13:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317D2198
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 18:13:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d25so480331lfb.7
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 18:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9R09kLcw//PYpBEshsVT1eYMX/Pn7AKLhMIz4DPxttc=;
        b=mJ2mlAbHDxYaIHL5DbBFxHccpvowPLqarYZwwWWCKUR9NXckqT8J7yPPeDiDDW7KCE
         0SISLDka5dqwBO978sIpZ+ciY+VAgi6GmDX7QEZLgQI9BL/QQUEfomIBENPVQxFxAaaN
         oFthrsRDwUfP0ZL0F2EKAxcehV1/YZgU5gYsDWrY5inR4Huh0Vg3POjfs0TtnoHrNMkQ
         iefEN5hQ/fSrQSn9n8Senyxd3+KHrGkX++DP72uSzfXISwDFalVqhRQhvSD1lhzPzMeY
         ZBJ9//VK8bUDNoyzj5qB6iNxdI4BI8h+5oFNp6Jk/tOjFg3a624fkcTC12PZ6AJDidTt
         BIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9R09kLcw//PYpBEshsVT1eYMX/Pn7AKLhMIz4DPxttc=;
        b=CYFYsGguWti56DyB3qFN7F5n0huCi4zuEC/bRj3MKtDjfTlcjv8XOYRRKJoDYjGMla
         mzSRXWM3v0xWXH5AHsJkuRKHBavROH/ZD4teUWkq4B5plQkwN2FKMQ1M5pHaWMv9Tmaz
         4KcizYAkYB/08FBx11mwu/j7y6357UfjzVNFJmsotrLoSO73syVtRRXRMkBY2TSGQ1KC
         DuZTM7e414UhrmxyAdv+RUQzcbdzVOLPerVtHWsoMLHr7rLipgY2LNmbbMa8zsmajbTY
         qk4eNan08oWObLxRxlti6Aynz7WSS7/QH1rXUtFNkvA22rw5uIywmgx19TrIJWWULAK2
         +B4w==
X-Gm-Message-State: ACrzQf2sW7fLR8dwD0xMXGn1WnA4gGb3mkzRNKKIxhfcAwlt8szukP1F
        IGRVrrNc5kT/QldB97ibJlOaY+0Z3vHLCXfICPA=
X-Google-Smtp-Source: AMsMyM6uDlsrH5v9/P/V8Db+rwlFmVoxALjGwa4sbAGHvcqAWnGR+bhflijhCrbsIee5Gp3Ch5EH83cSSf22/uws3S4=
X-Received: by 2002:a05:6512:3e0f:b0:4ae:5dc5:82d4 with SMTP id
 i15-20020a0565123e0f00b004ae5dc582d4mr10045304lfv.65.1667438007297; Wed, 02
 Nov 2022 18:13:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1397.v3.git.1667014975042.gitgitgadget@gmail.com>
 <pull.1397.v4.git.1667292904.gitgitgadget@gmail.com> <db47fbc663eb0f3a1fc9a063dfb1051bc64601af.1667292904.git.gitgitgadget@gmail.com>
In-Reply-To: <db47fbc663eb0f3a1fc9a063dfb1051bc64601af.1667292904.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Nov 2022 18:13:00 -0700
Message-ID: <CABPp-BG4in6hPnniHoE+au0XyVXwgs9pNUJdpLDTmP=dxvKjqw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] merge-tree.c: support --merge-base in conjunction
 with --stdin
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2022 at 1:55 AM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kyle Zhao <kylezhao@tencent.com>
>
> The previous change add "--merge-base" option in order to allow users to

s/add/added/ ?

> specify merge-base for the merge. But it doesn't compatible well with
> --stdin, because multiple batched merges can only have the same specified
> base.

"it doesn't compatible well" doesn't parse for me.

> This patch allows users to pass --merge-base option into the input line,
> such as:

Quoting from Documentation/SubmittingPatches:

"""
Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behavior.
"""

>
>     printf "--merge-base=<b3> <b1> <b2>" | git merge-tree --stdin
>
> This does a merge of b1 and b2, and uses b3 as the merge-base.

Perhaps something like:

"""
The previous commit added a `--merge-base` option in order to allow
using a specified merge-base for the merge.  Extend the input accepted
by `--stdin` to also allow a specified merge-base with each merge
requested.  For example:

    printf "--merge-base=<b3> <b1> <b2>" | git merge-tree --stdin

does a merge of b1 and b2, and uses b3 as the merge-base.
"""

However, I'm a bit curious about using `--merge-base=` on the input
line as opposed to just using a simpler marker; something like

    printf "<b3> -- <b1> <b2>" | git merge-tree --stdin

(which follows a precedent set by git-merge-recursive).  Your version
is a bit more self-documenting, but what if we want to allow users to
specify multiple merge bases in the future (for use in passing to
merge_incore_recursive())?  Is it annoying to need to prefix each one?

> Signed-off-by: Kyle Zhao <kylezhao@tencent.com>
> ---
>  Documentation/git-merge-tree.txt |  3 ++-
>  builtin/merge-tree.c             | 22 ++++++++++++++++++++--
>  t/t4301-merge-tree-write-tree.sh | 21 +++++++++++++++++++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
> index d9dacb2ce54..be6a11bbaec 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -66,7 +66,8 @@ OPTIONS
>
>  --merge-base=<commit>::
>         Instead of finding the merge-bases for <branch1> and <branch2>,
> -       specify a merge-base for the merge.
> +       specify a merge-base for the merge. When --stdin is passed, this
> +       option should be passed into the input line.

I'm not sure "passed into the input line" will be clear to readers.
Perhaps we want to have --stdin documented (looks like I forgot to do
that in my series; oops), mentioning the input format.

>  [[OUTPUT]]
>  OUTPUT
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index f402b807c0f..7a8049e7b0c 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -551,16 +551,34 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>
>                 if (o.mode == MODE_TRIVIAL)
>                         die(_("--trivial-merge is incompatible with all other options"));
> +               if (merge_base)
> +                       die(_("--merge-base should be passed into the input line"));

If we change the input as noted above, the wording here may need to change too.

>                 line_termination = '\0';
>                 while (strbuf_getline_lf(&buf, stdin) != EOF) {
>                         struct strbuf **split;
>                         int result;
> +                       const char *input_merge_base = NULL;
> +                       const char *arg;
>
>                         split = strbuf_split(&buf, ' ');
> -                       if (!split[0] || !split[1] || split[2])
> +                       if (!split[0] || !split[1])
>                                 die(_("malformed input line: '%s'."), buf.buf);
>                         strbuf_rtrim(split[0]);
> -                       result = real_merge(&o, merge_base, split[0]->buf, split[1]->buf, prefix);
> +
> +                       /* parse --merge-base=<commit> option */
> +                       arg = split[0]->buf;
> +                       if (skip_prefix(arg, "--merge-base=", &arg))
> +                               input_merge_base = arg;
> +
> +                       if (input_merge_base && split[2] && !split[3]) {
> +                               strbuf_rtrim(split[1]);
> +                               result = real_merge(&o, input_merge_base, split[1]->buf, split[2]->buf, prefix);
> +                       } else if (!input_merge_base && !split[2]) {
> +                               result = real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
> +                       } else {
> +                               die(_("malformed input line: '%s'."), buf.buf);
> +                       }
> +
>                         if (result < 0)
>                                 die(_("merging cannot continue; got unclean result of %d"), result);
>                         strbuf_list_free(split);
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 5b0073d3dcd..aec2c00b91f 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -860,6 +860,13 @@ test_expect_success '--stdin with both a successful and a conflicted merge' '
>         test_cmp expect actual
>  '
>
> +
> +test_expect_success '--merge-base is incompatible with --stdin' '
> +       test_must_fail git merge-tree --merge-base=side1 --stdin 2>expect &&
> +
> +       grep "^fatal: --merge-base should be passed into the input line" expect
> +'

Yeah, most merge-tree options are for controlling the output, and as
such they are not incompatible with --stdin.  This option is, so it
makes sense you need a special check for it.  Looks good.

> +
>  # specify merge-base as parent of branch2
>  # git merge-tree --write-tree --merge-base=c2 c1 c3
>  #   Commit c1: add file1
> @@ -890,4 +897,18 @@ test_expect_success 'specify merge-base as parent of branch2' '
>         )
>  '
>
> +test_expect_success '--stdin with both a normal merge and a merge-base specified merge' '
> +       cd base-b2-p &&
> +       printf "c1 c3\n--merge-base=c2 c1 c3" | git merge-tree --stdin >actual &&
> +
> +       printf "1\0" >expect &&
> +       git merge-tree --write-tree -z c1 c3 >>expect &&
> +       printf "\0" >>expect &&
> +
> +       printf "1\0" >>expect &&
> +       git merge-tree --write-tree -z --merge-base=c2 c1 c3 >>expect &&
> +       printf "\0" >>expect &&
> +       test_cmp expect actual
> +'

This last test seems odd.  You are merely testing that the output of
"git merge-tree --stdin" matches the output of repeated calls to "git
merge-tree", not that the merges involved produce correct results?
Maybe that's fine since earlier tests verify that individual
merge-tree calls are doing the right thing, I was just a bit
surprised.  Maybe a comment in the code that this was your intent
would be helpful?
