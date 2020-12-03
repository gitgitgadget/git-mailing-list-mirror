Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FD2C4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2B6A221F2
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 20:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgLCUXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 15:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCUXA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 15:23:00 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F202C061A51
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 12:22:20 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id s75so523725oih.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p/cEChX1Z196fJy5JPHdWqYznNUeS5QyED4AK1wT99w=;
        b=ET6zcXb9mjLSVHieGFTJPkOnCdfl6ZUpTh/E3Idc1/00pCTMM1u7L5urwPxv/L6kYM
         MjykMb+q21GY+//7fJJyBjfAh5tG3wFUL8AYtxEA1mqOOMwkRq9sL+scL0+ck3LFIv+s
         IVBNvtTvUkWe2IdqFj3rQvFklSllOjBpVitEVKtrZjqve8BKQJiaQHImU4fp9t+gxXc8
         PaSaLMzAxSW+BxYjLLEfE8QTV6YnQLPZZ10Jsi69Y6/ya+Tl1rBHzm1BAv8JTqgy9v+E
         jUF5pKRzbIxo8lUiCtvORD5iSCGe5Eq2jI/+rLuYsA/CdFvz0v1ZMYycUwv7RqaMWdqa
         4wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p/cEChX1Z196fJy5JPHdWqYznNUeS5QyED4AK1wT99w=;
        b=o1B2iWlRheQOmYnsTjJm+AHrvMsBFHM7WLMY2JtWQNHzaUAW3+oW8zlCjT5WNe5sZV
         FDObBzA4u3xsn8KfqetNOZVtY+iSJKES/hUxIEJ4HL25qvwEluhuX9mMrJjWPcVgLnxD
         4qS2/PnLa3LP9qf6Hmk/cQzbdG7tzZbnX6OKGfYlupusBOpYSIQEbE9yy9YRVRdyqwub
         50O4yxn3gmDqNkjlc4EpvnmWvq2lr50qBpPlZpVMsl0OWG8TKLG1Ru74O8qzDzUr2H7m
         AoRHHbwIe9QHeUM2BLCfCjLUTplrv9XbymI37aN7wzwDMUiJ6RhrCU9+//l/sarr6Car
         vj/w==
X-Gm-Message-State: AOAM532yY8P7q29bUl1xvXL7RzRhhQ52d8SW6JsITyn67fRz39Y9Ya3A
        cxgnxSGJrujd+TjreNVQD2BL++99XpzXawgp5L0=
X-Google-Smtp-Source: ABdhPJzaemp6m7OrigDGlKGuWvaEQCq9jCLvF/XZ0LqOZ5hz89LpY8J9kAvb1mnpsS6ziLi1u0uyqYa4ixP6n1aMvgA=
X-Received: by 2002:a54:4704:: with SMTP id k4mr591058oik.39.1607026939648;
 Thu, 03 Dec 2020 12:22:19 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
 <20201108213838.4880-25-sorganov@gmail.com> <CABPp-BGZO+7bRdCAGFdetOkmwyFnHxDPQ=SD4f6TSa9ZYGFn=A@mail.gmail.com>
 <877dpyhefj.fsf@osv.gnss.ru>
In-Reply-To: <877dpyhefj.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Dec 2020 12:22:08 -0800
Message-ID: <CABPp-BEyiLDZ5Ums1D5gL679EMmKXpqxWDF_xGT4scXLMkwseg@mail.gmail.com>
Subject: Re: [PATCH v1 24/27] doc/git-log: describe new --diff-merges options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 11:34 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sun, Nov 8, 2020 at 1:46 PM Sergey Organov <sorganov@gmail.com> wrote:
> >>
> >> Describe all the new --diff-merges options in the git-log.txt
> >>
> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> >> ---
> >>  Documentation/git-log.txt | 79 +++++++++++++++++++++++----------------
> >>  1 file changed, 46 insertions(+), 33 deletions(-)
> >>
> >> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> >> index 2b8ac5ff882a..de498a189646 100644
> >> --- a/Documentation/git-log.txt
> >> +++ b/Documentation/git-log.txt
> >> @@ -120,45 +120,58 @@ DIFF FORMATTING
> >>  By default, `git log` does not generate any diff output. The options
> >>  below can be used to show the changes made by each commit.
> >>
> >> -Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> >> -will never show a diff, even if a diff format like `--patch` is
> >> -selected, nor will they match search options like `-S`. The exception is
> >> -when `--first-parent` is in use, in which merges are treated like normal
> >> -single-parent commits (this can be overridden by providing a
> >> -combined-diff option or with `--no-diff-merges`).
> >> +Note that unless one of `--diff-merges` variants (including short
> >> +`-m`, `-c`, and `--cc` options) is explicitly given, merge commits
> >> +will not show a diff, even if a diff format like `--patch` is
> >> +selected, nor will they match search options like `-S`. The exception
> >> +is when `--first-parent` is in use, in which case
> >> +`--diff-merges=first-parent` is implied.
> >>
> >> --c::
> >> -       With this option, diff output for a merge commit
> >> -       shows the differences from each of the parents to the merge result
> >> -       simultaneously instead of showing pairwise diff between a parent
> >> -       and the result one at a time. Furthermore, it lists only files
> >> -       which were modified from all parents.
> >> -
> >> ---cc::
> >> -       This flag implies the `-c` option and further compresses the
> >> -       patch output by omitting uninteresting hunks whose contents in
> >> -       the parents have only two variants and the merge result picks
> >> -       one of them without modification.
> >> +--diff-merges=(off|none|first-parent|separate|combined|dense-combined)::
> >> +--no-diff-merges::
> >> +       Specify diff format to be used for merge commits. This has no
> >> +       effect unless diff output is enabled in the first place (e.g.,
> >> +       with `--patch` option.)
> >
> > This seems inconsistent with c7eaf8b4c3 ("log: when --cc is given,
> > default to -p unless told otherwise", 2015-08-20); shouldn't these
> > imply -p?
>
> Looks like it is indeed, and worse yet, the patch series don't handle
> this optimally due to my ignorance of this behavior. I think I need to
> make changes to imply -p whenever some of diff-merge options (except
> --diff-merges=none) are explicitly given, cause it's now, after these
> patches, is unclear why only combined diffs imply -p, and not, say,
> --diff-merges=first-parent.
>
> Nice catch, thanks!
>
> BTW, in the original, why only "git log" is affected? Ah, probably
> because "git show" has -p by default?
>
> While we are at it, why do we have "git show" at all? How is it
> essentially different from "git log -n1 --first-parent ..."? I mean,
> shouldn't it effectively be just an alias?

git show does not just operate on commits.  It can also display blobs,
trees, or tags.  I see people use it with blobs in the form of
REVISION:FILENAME references.  git show also is not limited to
displaying just one object, hence -n1 would be problematic; you'd need
to use --no-walk instead when operating on commits.  Also, git show
uses --cc when operating on commits, not --first-parent.

However, you are right that it is pretty close to just being something
you could alias if you limited it to commits.  If I understand
correctly, that alias would be `git log --no-walk -p --cc ...` (though
you only need the explicit -p with pretty old versions of git).

> >
> >> ++
> >> +--diff-merges=(off|none):::
> >> +--no-diff-merges:::
> >> +       (default) Disable output of diffs for merge commits. Useful to
> >> +       override implied value.
> >> ++
> >> +--diff-merges=first-parent:::
> >> +       This option makes merge commits show the full diff with
> >> +       respect to the first parent only, exactly like  regular
> >> +       commits.
> >
> > Not sure that "exactly like regular commits" is helpful here; I'd
> > personally rather cut those four words out.  I'm worried it'll be
> > taken not as an implementation explanation, but as a "this treats
> > merge commits in the natural way that regular commits are" which users
> > may mistakenly translate to "it shows what changes the user manually
> > made as part of the commit" which is not at all the correct mapping.
>
> Dunno. Don't have strict preference here. Git has no idea how the
> changes in a commit have been made in the first place. Changes are just
> changes.

If you don't have a preference, can we drop those four words?  ;-)

> To my excuse, I took this from git:5fbb4bc191 that has:
>
> +Note that unless one of `-c`, `--cc`, or `-m` is given, merge commits
> +will never show a diff, even if a diff format like `--patch` is
> +selected, nor will they match search options like `-S`. The exception is
> +when `--first-parent` is in use, in which merges are treated like normal
> +single-parent commits (this can be overridden by providing a
> +combined-diff option or with `--no-diff-merges`).

Yeah, I can see where you're coming from, though the context change
feels like just enough different that the four words you added bother
me a bit more.  However, this existing wording does bother me now that
you highlight it.  Even though it's not something introduced by your
patch, I'd really like to drop "normal" here; I think it is prone to
cause confusion to users and as far as I can tell provides no useful
meaning for the sentence.  (There are multiple types of single-parent
commits?  What is an "unnormal" one?  How do I tell which kind I want?
 etc...).
