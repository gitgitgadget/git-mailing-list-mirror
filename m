Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3032C432BE
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9722860231
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 00:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhHUAVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 20:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhHUAVY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 20:21:24 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C1C06179A
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 17:20:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso13022536otp.1
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 17:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkVK7Uhi1eoCZi4xoJzNvlZhQ1g/UUU2fgZogdcPuGg=;
        b=ubd537egWsa8fTkFeipcfgIxfCA2jsL4NB2bqr4glaHz7FC1+QbpneOBIR9y2j66If
         bHIif/sse0FOTX8IGIjZ2xB+x7r3vbcAEFM9rB8AMlU+bNGAsQj9MruojkelU8DQz5rx
         cCYfmh47koZtXi2GswntBjv3qbzOy9I+s/q83FGVqiYYD7ktKUBGIa/yE9hK9aFQay+y
         nRHoLLqXjNIo4BZ9D59uSYtvE0JNqoSGgfQ/s9Qm/co43TtiTPRe6I+8KHHX2embdziU
         W9znIB4zL9bYl1wmidZtWORuihGjQm7F4rZrqkeDUQvj4Wc52VTMWYdn24b0R3wQ5oYc
         0c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkVK7Uhi1eoCZi4xoJzNvlZhQ1g/UUU2fgZogdcPuGg=;
        b=FYUMXQiC0pC+z7nNDgzWqDkGDJPPwrtWpP7wSMMIXXK0eTnzTMcnY1BPAAzZqauU5t
         cht7uH3/sbCjQ7vuCTwBrScPOD+yQk+hdyIMyfbyfeLGiItOMWcjUnrR78r7ADXI+Xyw
         JO4IzpCYNLqpXo1OufgUC7cJqdMR2inTbL6XI0v07Ks7yztS9H/WtpqIuaQrFfuqEPlK
         q0cSFl/HJ22QN8dJEs9yMUsOGweyt861Yi9JgaKuZdrdswSoPi8g4R6Aeux28tlbrMPy
         XcdyGXwTCfKrCd/4vHeYe5OBF1xGZ7OJAwbRe/vOratCuaZ4fNTLmq+mVZZwcJbinZZo
         ydcQ==
X-Gm-Message-State: AOAM532inEMTFqqaIaWus0pQJQt9SY1wSQ9UqpT1KlzBQzdGjQBwpqRu
        u+pQtKNhKJZ5VdRHJ6KzPRrLm4NwN/Y2U9lbhe0=
X-Google-Smtp-Source: ABdhPJxFYzC7p7DmmxQMggPNr+wQ6UCH7sT/iXy75sdWWs6A1Yx1u2qDvtkq5rgQfB2hiUnuZYRdCduM0g0I/0uPNYQ=
X-Received: by 2002:a9d:448:: with SMTP id 66mr19088238otc.345.1629505245179;
 Fri, 20 Aug 2021 17:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <7cad9eee90bcee3cb98be5c7a2edaca5e855c157.1629220124.git.gitgitgadget@gmail.com>
 <xmqqzgte62ud.fsf@gitster.g> <b3c7e700-f36c-d58f-0c49-450444df8c63@gmail.com>
 <CABPp-BEtOWUGCcn3B0On80=tMZ_Re9ScHnBiwPPPFY=x2TwG5Q@mail.gmail.com> <xmqq7dgfu1zb.fsf@gitster.g>
In-Reply-To: <xmqq7dgfu1zb.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 17:20:34 -0700
Message-ID: <CABPp-BHLw-h0oQLNwT+DAXeHZZfJRaiyoM+kDuqx_aT80-zM3w@mail.gmail.com>
Subject: Re: [PATCH 1/6] t1092: use ORT merge strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 20, 2021 at 4:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Wed, Aug 18, 2021 at 11:42 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> >     It seems to me that it would let us live in the future in a more
> >> >     comprehensive way if we tweaked merge_recursive() and/or
> >> >     merge_recursive_generic() so that all internal callers, not just
> >> >     builtin/merge.c, would redirect to the ort machinery when say
> >> >     GIT_TEST_REPLACE_RECURSIVE_WITH_ORT environment exists, and
> >> >     doing it that way we do not need to sprinkle "-srecursive" and
> >> >     "-sort" everywhere in our tests at randomly chosen places to
> >> >     give test coverage to both strategies.
> >
> > GIT_TEST_MERGE_ALGORITHM already does this; the testsuite already had
> > `-s recursive` sprinkled everywhere (due to contrast with `-s
> > resolve`), but since I wanted to use all existing recursive tests as
> > ort tests, then rather than tweaking all the test files and copying
> > tests and whatnot, we decided to just have GIT_TEST_MERGE_ALGORITHM
> > reinterpret "recursive" to whatever GIT_TEST_MERGE_ALGORITHM says.
>
> I somehow thought that direct calls to merge_recursive() and
> merge_recursive_generic() are not affected with that environment
> variable, so you cannot influence what happens during "git am -3"
> and "git stash apply" with that, but perhaps I was not reading the
> code correctly.

Sorry for being unclear.  I was responding to the "sprinkling" portion
of the quote; GIT_TEST_MERGE_ALGORITHM allows us to avoid sprinkling
-srecursive and -sort in various places.

You are correct that merge_recursive() and merge_recursive_generic()
are unaffected by the environment variable; the environment variable
operates at a higher level in the code to choose whether to call e.g.
merge_recursive() vs. merge_incore_recursive().

> It seems that merge_recursive() and merge_ort_recursive() are
> interface compatible and the latter can serve as a drop-in
> replacement for the former?

Yes, merge_ort_recursive() and merge_ort_nonrecursive() were meant as
interface compatible drop-in replacements for merge_recursive() and
merge_trees(), to make it easy to switch callers over.

There is no such replacement for merge_recursive_generic(), though,
and builtin/{am, merge-recursive, stash}.c will all need to be
modified to work with merge-ort.  IIRC, when last we discussed that
interface, we realized that the three were using it a bit differently
and it had some hardcoded am-specific assumptions that were not
appropriate for the other two, so it's not clear to me we should port
that interface.
