Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44202C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7302218AC
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 21:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410939AbgJPVN2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 17:13:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:34906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410926AbgJPVN2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 17:13:28 -0400
Received: (qmail 31980 invoked by uid 109); 16 Oct 2020 21:13:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 21:13:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13401 invoked by uid 111); 16 Oct 2020 21:13:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Oct 2020 17:13:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 16 Oct 2020 17:13:27 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
Message-ID: <20201016211327.GC3356073@coredump.intra.peff.net>
References: <20201016205232.2546562-1-emilyshaffer@google.com>
 <20201016205232.2546562-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016205232.2546562-3-emilyshaffer@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 01:52:32PM -0700, Emily Shaffer wrote:

> Some users skimmed past the note in 'git help apply' mentioning 'git
> am' and weren't sure how to retain commit details. An example
> illustrating the difference between the two shows this information in
> another way, so users who prefer to be shown rather than told can
> discover the difference too.

Having an example showing the difference seems reasonable. However, I
think it should come lower in the file. Putting such a big chunk between
the DESCRIPTION and OPTIONS sections will makes it much harder to find
the options (and that's what people are usually looking for).

Plus it's customary to have the example section (which is usually
pluralized as EXAMPLES) near the end. See:

  https://man7.org/linux/man-pages/man7/man-pages.7.html

which gives recommended names and order.

> Notes:
>     In this change, I wasn't sure about a few things:
>     
>     - Should the comments on the snippets live outside of the blockquote instead?

I think it is OK as-is, but it might be easier to follow visually with
text like:

   Here's a sample patch that we'll use below.

   -----
   $ cat the-patch, etc
   -----


   We can apply it with `git am`, which will create a new commit:

   -----
   $ git am ...etc...
   -----

Especially in the HTML version, which puts the code blocks into a box
with a different backgrounds, that makes it easy to visually jump to
each box without having to carefully read the contents.

>     - Should 'git reset' be included in the snippets, so that users don't try to
>       paste without thinking?

I don't think they could meaningfully paste this anyway, since they
don't have the base commit that it would apply to (you could make the
patch strict add, but I think it's perhaps desirable that they aren't
real runnable commands).

>     - Should the example go underneath the options list?

Yes. :)

You can say "see the EXAMPLES section below" next to the added text if
you want to point out that the example clarifies it further (though I
don't think it's strictly necessary).

>     Anyway, we got internal feedback that the description in 'git help am' wasn't
>     very noticeable. I'm not sure I agree, but it's true that some folks grok
>     examples more easily than they grok prose, so we figured it probably couldn't
>     hurt to provide both.

I think the example is a reasonable one to show, even aside from the "is
it noticeable" level. Having it present twice feels a little funny, but
cross-referencing ("see the examples section in git-am(1)") gets
awkward.

I do like the added text that back-references "git apply" from the "git
am" manpage.

> +# use 'git am' to create a new commit with details from the patch
> +$ git status
> +On branch main
> +nothing to commit, working tree clean
> +$ git am ~/0001-README-add-more-text.patch
> +Applying: README: add more text
> +$ git status
> +On branch main
> +nothing to commit, working tree clean
> +$ git log --oneline
> +dd6a400 (HEAD -> main) README: add more text
> +90b59fb base commit

I know you're trying to show with "git status" that the working tree is
kept clean. But it does make the example much longer. I kind of think
showing just "git am" and "git log" would be sufficient.

> +# use 'git apply' to apply to the worktree without creating a commit.
> +$ git status
> +On branch main
> +nothing to commit, working tree clean
> +$ git apply ~/0001-README-add-more-text.patch
> +$ git status
> +On branch main
> +Changes not staged for commit:
> +  (use "git add <file>..." to update what will be committed)
> +  (use "git restore <file>..." to discard changes in working directory)
> +	modified:   README
> +
> +no changes added to commit (use "git add" and/or "git commit -a")

Showing status afterwards here makes sense. I'm not sure if you need to
show that it's clean before-hand, though, which could also reduce the
size of the example.

-Peff
