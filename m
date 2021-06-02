Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2AEC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892BA6023B
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 23:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhFBXoF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 19:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFBXoE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 19:44:04 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220ABC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 16:42:10 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id p67-20020a4a2f460000b0290245cdf2d1a4so971738oop.8
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 16:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iyi83NBx79sgUbVMeau3OCWKpKqzeJDlNoNf+7EoRqo=;
        b=aDrxIsv2NyfGKvqYSdklTLGs9up8xaDzUI3TaFICdoXPCSVYVIONjpHUJR8sGS2JAO
         EqbYoW7petMHcWDFnekK0WS8tu4vzSwMTmD79sppq+ykD1IxRuj68ECjoTMNPtsYbe3B
         MMcgM1en4/pc2fKAxPbLyyRiMsNuCM5wO3j/3L1Wp6G0X+DczRnvyjAw3svBCuPVLMzP
         4vYYbZTj0LH2aFUkVEaXrpxd+r9ZqoRVFcIVEaUMGkkIbwykcicTFW6GUu2EVw1r79OY
         mOoimeGWLQSdBp1iaaHfMHhlGnFrcg/M6JixNCF4ZM7ENLt70lnsOZiYm3dXL5YXdb3u
         ONgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iyi83NBx79sgUbVMeau3OCWKpKqzeJDlNoNf+7EoRqo=;
        b=SNGFb4lY7/s0HIRbCzCuR2FCZr0Wq8eYQUF2bIFEYRfo0uOlITzRDATyRE+dKvC6Wr
         vB8DAb3/cKYIRWTFlZeIIYaS4JXvqCm5wSRv5r7Ou20tJAkxZjLBCIQCizJhK+gz69a+
         90wxWkq8gDGRuV8hffgaKzB00d3Qpx6KP9rhwx+jmpDqs+qFYHXedYLQ3oN/712I7huG
         /nCzxlWXyc+H9jEPr5GGOrffLjE81vR+Ot9tq/FQ8IQA+08UUK6Gr37optWndYvl0nZ5
         5qXoX3mF5zTm4+OFob+Z3yBaJ3WXfFFegLcrzJonzbIINf1Rb3i94+4p2w/YlOUoeYTJ
         kQwQ==
X-Gm-Message-State: AOAM531/vtcqqVGXP9QgutyZ5Ng+2bNfH75Z/KmAyeJ1uYkXlmM10uCE
        dp487LAByHCh/wYig88YAMuaGSdklLrdrrXWpMg=
X-Google-Smtp-Source: ABdhPJxDwyBIHJZQqy1vSkqAIcRYu0ihBiZeKDIJU9ZGiu7iRMwAE+CDt7KTV1jZMCCs5S2bN1MvvSILmy03q5Fg1TQ=
X-Received: by 2002:a4a:b301:: with SMTP id m1mr26381634ooo.7.1622677329309;
 Wed, 02 Jun 2021 16:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210601183106.3084008-1-tpr.ll@botech.co.uk> <f6d39636-308c-c846-55b5-3f16a155e69d@gmail.com>
 <xmqqmts9q9m2.fsf@gitster.g> <CABPp-BHs0ACvkCJMB-tO8xkiidB12NrN1hOhLRvm3U_Q=r2YcQ@mail.gmail.com>
 <9BCB8981-09D5-4BF4-981B-2BF0AA0D6E5A@botech.co.uk>
In-Reply-To: <9BCB8981-09D5-4BF4-981B-2BF0AA0D6E5A@botech.co.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Jun 2021 16:41:58 -0700
Message-ID: <CABPp-BHT3ZrGrDVBcSTuzhSmy0EdtGUeHF_RAVohw=nemGhoOA@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees: add core.sparseCheckoutRmFiles config
To:     "Tim Renouf (open source)" <tpr.ll@botech.co.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jun 1, 2021 at 11:14 PM Tim Renouf (open source)
<tpr.ll@botech.co.uk> wrote:
>
> Hi all
>
> Thanks for the reviews and comments.
>
> My use case is that I never want it to remove or otherwise touch those fi=
les outside of sparse-checkout that happen to be the same path as index pat=
hs. I realize that currently gives me complications (e.g. I must never try =
and merge/cherry-pick/rebase a commit that might cause a merge conflict out=
 there), and I realize that=E2=80=99s not what everyone else wants. For exa=
mple, I don=E2=80=99t want git reset --hard or whatever to remove those fil=
es. Hence the config option.

Every case I've ever seen of present-despite-skip-worktree files is an
accidental and erroneous condition.  If you're trying to use it for
something else, we'd really need to understand the higher level
use-cases so that we can make ranges of commands work together nicely.
The sparse checkout capability itself was started by a low-level
implementational detail ("treat paths as though they matched HEAD and
don't write them to the working tree") and led to a maze of surprises,
bugs, edge cases, etc.  I'd rather not compound that problem by adding
another configuration option defined via a similar low-level
implementational detail.

I'm also leaning towards having `git reset --hard` not clear
present-despite-skip-worktree files, and not having `git status`
report them; both seem like an unnecessary performance issue for this
rare accidental/erroneous condition.  I totally agree that `git
switch/checkout` should not delete or overwrite such files if they
differ from HEAD; but similar to how having a dirty file prevents a
branch switch to some branch that deletes the file, a
present-despite-skip-worktree file that differs from HEAD should
result in an error message and an aborted switch/checkout.  At least
for the standard sparse-checkout behavior; don't know what your
usecase is.

> Am I right in saying that the sparse-index work makes it easier to achiev=
e my use case? In that those outside-sparse-checkout paths would not ever g=
et merged into the index, even if I merge/cherry-pick/rebase a tree with pa=
ths there?

If you merge/cherry-pick/rebase a commit with changes to a path
outside the sparse-checkout, and it merges cleanly with your current
branch, then with sparse-index it wouldn't even show up in the index
(though one of its parent trees would be modified because of the
changes to that file).  But that's not very different than without the
sparse-index, at least with the ort merge backend (available and ready
for using starting with git-2.32).  The recursive merge strategy (the
default) is known to write files to the working tree despite the
sparse-checkout requests, even when the merge is clean, but that's
just a bug in the recursive backend.  (One that isn't easily fixable
within its design, which is one of many reasons it was being written
in the form of the ort backend.)

If you merge/cherry-pick/rebase a commit with changes to a path
outside the sparse-checkout, and it conflicts with your branch, then
with or without sparse-index, that file is going to show up in the
index with higher order stages and be written to the working tree.
That is, so long as you don't have a file in the way.  Since the ort
backend makes use of the checkout machinery to switch from the current
state to the new state, fixing checkout to throw an error and abort
when a present-despite-skip-worktree file is present would cause
merges/rebases/cherry-picks to do the same.

> I can go into more details on how I arrived ay my use case if it helps.
>
> So maybe there are two separate things here:
>
> 1. The bug that checkout removes my file when it is dirty, instead of ref=
using (unless -f) or just ignoring it.

Yep, we need to fix this.

> 2. My use case, which is to do its best to never remove or otherwise touc=
h worktree files outside sparse-checkout.

Can you expand on this use case a bit?  Should git diff or git status
report on your changes for your usecase?  Should "git restore" ignore
the given paths and not overwrite it?  What if the user explicitly
listed the path in question?  Should stash save these changes or
ignore them?  Should add include these changes or ignore them?  Since
your indexed file is different than the worktree file, should "git mv"
move just the file recorded in the index, just the one in the
worktree, or both?  If someone tries to run "git archive", should your
modified files be included?  If you don't like anything touching these
paths, does that mean they are also uninteresting?  So for example,
should "git log -p" or "git grep $REVISION" only return results inside
the sparse-checkout list of paths?

From a higher level, what are you trying to achieve?  Is it similar to
`git update-index --assume-unchanged`?  The point of sparse-checkout
was to reduce the number of files in the working tree, but it appears
you aren't trying to do that; you are putting files back into the
working tree anyway.  So, what's the point of sparse-checkout then?

It's possible sparse-checkout doesn't meet your needs, and just isn't
designed to meet them, and we need another special concept for your
case.  Or perhaps there's a config option that's meaningful.  Or maybe
you're just struggling with the bugs of sparse-checkout, of which
there are *many*.  See e.g.
https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3Bx=
ZafA@mail.gmail.com/

> > I'm also worried that making a config option may have masked subtle
> > bugs in the patch that the rest of the testsuite would have turned up.
>
> It is true that not hiding it in a config option makes a few tests fail, =
including ones that specifically test that a git reset after a materializat=
ion from a merge conflict causes the file to be removed.

Yeah, not so surprising that it has weird interactions with merging
(and perhaps different weird interactions with different merge
backends).  Anything that touches unpack-trees.c either needs to be
part of standard operation, or if it's behind a special config option,
then it needs to be accompanied with a huge number of tests from many
different commands since it affects so many things.  We're trying to
add a battery of tests for sparse-checkout and sparse-index, and we
still obviously need a lot more.

Hope that helps,
Elijah
