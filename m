Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC214C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B062074D
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 06:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpH86+o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgCXGGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:06:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34604 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgCXGGe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 02:06:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so8792085pfj.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 23:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHCjMXc3LdKATOoXVfiZevEOWbg5DU546sNfai8ekMg=;
        b=CpH86+o41SBNqAEPiLUwAK+FTrQeZ1RmUIj6P96fUicZVChsbZtDRuOuPjrukHYPCl
         Agy8qMOUyNhg27NPG20M06FT8R+STczfL3iKC8mpN9d/kSiF2wC43NJnlLlq3uQUYwpR
         4OZTowDUTUtMyu4WtuMPd9oaPg/NC5OVqRtpgMFKkqIkDKCWxjJRIAq2WVYOf86llSqn
         wc4FpPUpQRUOehmuMOo0nH4zIrS/FcHct/o8q5BSamsamnJBngFWiMV84GFUKtNiSK8k
         Kw9eQRA3ifHZ8XI9KTQvaP2ZGSm7uoso4YA/VH9r3W8lunpviQvUr7ZJAQy58sjgqJY5
         kJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHCjMXc3LdKATOoXVfiZevEOWbg5DU546sNfai8ekMg=;
        b=UJWEuv9OzqjgXCiLHZC2VqCtKolimfD6M7upTtsDPS60a0z3/1tI/bSER+VMidiL1G
         H/FCFlwRWuZEta9jjEXAI6PsifxS2AVNXVnA4OUq7+Z7ohPRkqbX5weYtmXlMpOWoStT
         G4G21aK/hBu61oqAPb3OwpQ6+DsDNyvCv1WsWZ98INg4mi/oxyE0jH7FSwL6l73ETk9n
         CPE9XXxJHD7lU62sV9HHJAnOZtAaztJrPUQGQ4icBUKLHMOFK4o24dE8Jy3rBtVcmeBc
         YqeLA6/Kp8Rw0LYQwj4+5eKOSm2D5+s97yd6mj8Hblz+KLeIPCFmTR03KtR/H0Nl6ajL
         faqg==
X-Gm-Message-State: ANhLgQ3VTyzxQTNVm7xOZVmR6vpWcNY4ocAVOcPkDapIIu5DmQfLtZ4H
        UodS91ve7uEuLhlNzrvhPTk=
X-Google-Smtp-Source: ADFU+vt1dTnehWguzhC8LgjxfSqVG4TH+JFkB9JVnwCxDb0fXt8VnsjsxLEti8OCF58qZuDc3m/4ig==
X-Received: by 2002:a63:ec44:: with SMTP id r4mr25038141pgj.425.1585029990885;
        Mon, 23 Mar 2020 23:06:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e126sm14888388pfa.122.2020.03.23.23.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 23:06:30 -0700 (PDT)
Date:   Mon, 23 Mar 2020 23:06:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlosmn@github.com>
Subject: Re: [PATCH v7 0/6] Reftable support git-core
Message-ID: <20200324060628.GB13508@google.com>
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Han-Wen Nienhuys wrote:

> This adds the reftable library, and hooks it up as a ref backend.
>
> Feedback wanted:
>
>  * spots marked with XXX in the Git source code.
>
>  * what is a good test strategy? Could we have a CI flavor where we flip the
>    default to reftable, and see how it fares?
[...]
> Han-Wen Nienhuys (5):
>   refs.h: clarify reflog iteration order
>   create .git/refs in files-backend.c
>   refs: document how ref_iterator_advance_fn should handle symrefs
>   Add reftable library
>   Reftable support for git-core
>
> Jonathan Nieder (1):
>   reftable: file format documentation
[...]
>  51 files changed, 8547 insertions(+), 32 deletions(-)

This series was discussed at the Git Contributor Summit, and I
promised to provide a summary here.  Sorry for the delay.

Contribution format
~~~~~~~~~~~~~~~~~~~
This is a bit of an unusual contribution to Git:

- the heart of the series is in a single commit
- it is under a different license than most of Git
- the code doesn't use the same dialect as and "look like" the rest of
  Git

All three of these are because the code is meant to be a standalone
library that can be used by Git, libgit2, and any other project that
wants to understand reftables.  But they create obstacles to reviewing
(one reviewer said he had spent a two-hour block looking at the patch
and not made much headway).

On the other hand, people mostly agreed that having the ability to
share this code with libgit2 is beneficial.  So how can we get a
substantial review without losing that benefit?

 1. Most importantly, people would like a series of multiple patches
    that tell a story.  If review of an early patch in the series
    reveals significant changes that should happen in reftable
    upstream, that's fine --- upstream, that can happen in a patch on
    top, whereas in the series being contributed, the patch would be
    amended.

    In the end, there would be two different series of commits: the
    contributed series, and the upstream history.  The upstream
    history might be messier, and that's fine.  The contributed series
    would be applied to git.git.

    If I understood correctly, this is more important for the initial
    contribution than for later changes.  Git includes some code (e.g.
    in compat/) with outside upstreams and gets all-in-one-commit
    updates.  As long as upstream has a functional review process,
    this is fine --- here, reftable upstream (you :)) wants review on
    the initial contribution and splitting into a series that tells a
    story is the cost of making that review feasible to provide.

 2. Both Git and libgit2 have abstractions like strbuf.  We'd like
    reftable to make use of similar abstractions where they make the
    code cleaner.

 3. libgit2 has a git_malloc allocator.  reftable doesn't necessarily
    have to use it or make it pluggable --- at worst, we can #define
    malloc to use it.  But it's something to be aware of.

Maintenance
~~~~~~~~~~~
There's some interest in the maintenance story: if we run into an
issue with the reftable library, do we report and fix it on the git
mailing list or does the reftable library have its own upstream forums
for that?

Portability
~~~~~~~~~~~
There was some confusion about the scope of what the reftable library
provides.  It provides a reader and a writer and the caller is
responsible for connecting those to files.

There were some questions about mmap usage here (there is none) and
whether the library needs some kind of seeking reader interface for
abstracting the OS interface to files.

I think the upshot is

 4. Some summary documentation would be helpful e.g. in the README.md,
    to point people to what header file a person should start with to
    understand the library

 5. People are also interested in the file-oriented part of reftable,
    even though this library doesn't implement it (that's patch 6,
    which is Git-specific).

Testing
~~~~~~~
Git's testsuite has various GIT_TEST_* knobs.  A GIT_TEST_REF_BACKEND
knob would be helpful, to allow running the full testsuite with
reftable.  That's a good way to suss out edge cases.

The testsuite should *also* include some specific tests designed for
reftable.  They can demonstrate edge cases and demonstrate some of the
benefits

- case sensitivity
- handling of directory/file conflicts

That provides another entry point for people to understand reftable.

We also discussed table-driven tests that can be shared between
implementations but didn't end up saying anything too concrete about
that.

Summary
~~~~~~~
Breaking down the library into multiple patches is likely to be a
signficant amount of work, but it's a good way to break the review
into manageable pieces that get the project engaged.

Integration testing is also likely to be helpful.

People were very excited about the benefits reftable brings and it
feels a little strange to ask so much when you've already written this
code, but this seemed like the best way to make it into something the
project understands well and to get any kinks ironed out.  I'm happy
to help in any way I can.

Thoughts?

Thanks,
Jonathan
