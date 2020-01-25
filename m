Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F34C2D0DB
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD59220716
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 20:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJahnqZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgAYU7h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:59:37 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38191 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgAYU7h (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 15:59:37 -0500
Received: by mail-ot1-f53.google.com with SMTP id z9so4941611oth.5
        for <git@vger.kernel.org>; Sat, 25 Jan 2020 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXjw7pcSOQbkE526ouJ5Xh5Kf++QMET0b+EilAWv5FU=;
        b=EJahnqZsV/msrBKA+DyWCs5GK1ud6TG9hHaA0ajnx1jIh8s8OphUCtnl/UW8dd2UPS
         p0qkmS/DmU22lGw54/ohKhC9+6P7VawZ6yXsI2yGGziQ+qeN0yhzEZERzfqXJZ6BOV7t
         CLBjVR3q7r3RZzyDokAwnZFnLhbcrmheQQEESqmEqTp59oN2VggQMAw2SDxc6/rTQbQe
         UQ00XJ4S1O2tJx7l41XBbGak77TgFJF3N60lkjAbGlEo+QWtZoF6TUpUWmvfTNMKa1Ti
         wcnXmGzmSEQnQcybL3uPRPrE+gTXWJWLEuZ38/GBNWop2jSwi4h0xIKsYatCFzCEYTvx
         vHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXjw7pcSOQbkE526ouJ5Xh5Kf++QMET0b+EilAWv5FU=;
        b=TkvJVYStgr+kboYYBIRlX6mUPWn/oqmhLVJVN9RdEIFZh1zNHdvVUdoyQ4TVZR1Zla
         r5dnqhWA4FLm7dbFODMdZD3uDuO1EW3BLB5gx1xOaqEDDxLYqGkcALidhctAvpGNV+mM
         6t7l5LRz3uMUD3/Z5fbvEuEZUIuXY0ynvG0abI1gXt0hwhQvjy8A7fWPcBTMfFbezTZK
         R2h4V6a73q7udEQyzKHsmMW9TeJ2kweC/jCSZjKCypY0mTKRnSChlSXgCy0ByCpk1HUR
         HM5Ojw1HmjXM671ZVJGvAqcYcnmOhfDXmef9ys86zFHbrLmpcC4+nORfqcETrthHRcLo
         QfSQ==
X-Gm-Message-State: APjAAAWNbYFvSn0HE5gRSuDbcYv1oG5iDmPc/r8Nwd6+yCAkpTre1zWc
        kI/uBIw61OvQC6WDSEjERieHX/TIro0INHimvUU=
X-Google-Smtp-Source: APXvYqyB1qhZVImzaHIMEnuOcuIUo2DCrxFDZ6qt0m2LsSHIqAnmY7hES5HAf86f4DkYddWndUXanjU7lLs0+W2zPmI=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr7657306otp.316.1579985976591;
 Sat, 25 Jan 2020 12:59:36 -0800 (PST)
MIME-Version: 1.0
References: <062301d5d0bc$c3e17760$4ba46620$@Frontier.com> <d4056731-c13b-c89d-dfd2-e6235e29fed6@gmail.com>
 <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
In-Reply-To: <405d83bd-cd50-49c5-a068-6d3ce102f669@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 25 Jan 2020 12:59:25 -0800
Message-ID: <CABPp-BFB3pN1arWb9Acj7La1aX7j=axANnSWV8f7SmW_KuqD0g@mail.gmail.com>
Subject: Re: Sparse Checkout Trouble (2.5.0)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     JunkYardMail1 <JunkYardMail1@frontier.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 24, 2020 at 7:41 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 1/21/2020 8:19 PM, Derrick Stolee wrote:
> > On 1/21/2020 7:42 PM, JunkYardMail1 wrote:
> >> Reverting back to the previous version (2.24.1) allowed to un-stage the
> >> files and reset the changes.
> >
> > This is definitely pointing to a regression, and the feature did get a
> > bit of an overhaul. The goal was to not change how existing users
> > interacted with it, though, so this is a bit alarming.
> >
> > I did find a behavior change related to these paths in Git for Windows
> > 2.25.0 versus 2.24.1:
> >
> >   $ git clone https://github.com/derrickstolee/git-sparse-checkout-test
> >   Cloning into 'git-sparse-checkout-test'...
> >   remote: Enumerating objects: 6, done.
> >   remote: Counting objects: 100% (6/6), done.
> >   remote: Compressing objects: 100% (4/4), done.
> >   remote: Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
> >   Receiving objects: 100% (6/6), done.
> >   error: invalid path 'directory-1/prn/a'
> >   fatal: unable to checkout working tree
> >   warning: Clone succeeded, but checkout failed.
> >   You can inspect what was checked out with 'git status'
> >   and retry with 'git restore --source=HEAD :/'
> >
> > The checkout here is _expected_ to fail, due to the protected
> > filenames. What is troublesome is the following sparse-checkout
> > commands fail, and the read-tree command fails in a way that
> > 2.24.1 does not:
> >
> >   $ git sparse-checkout init
> >   error: invalid path 'directory-1/prn/a'
> >   error: invalid path 'directory-1/prn/a'
> >
> >   $ git sparse-checkout set "/*" "\!/*/"
> >   error: invalid path 'directory-1/prn/a'
> >   error: invalid path 'directory-1/prn/a'
> >
> >   $ git read-tree -mu HEAD
> >   error: invalid path 'directory-1/prn/a'
> >
> > The double error messages are due to the "try with an in-memory
> > pattern set, then roll back if there is a failure." The patterns
> > we are trying to create do not include the directory that is failing.
> >
> > I'll keep looking into this.
>
> I am still struggling to find out exactly what goes wrong here.
>
> I'm CC'ing Elijah because he also made changes to dir.c, and
> perhaps he has some idea of what's going on.

If you think it might be related to the dir.c changes, I can take a
look.  I don't have any immediate ideas off the top of my head.
However, since I'm really suffering with "git read-tree -mu HEAD"
being the mechanism for updating sparsity (for reasons independent of
the issue being discussed here), I've been tempted to dig into that
anyway to write a replacement without the nasty side-effects.  I'll
take a look early next week and see if I can spot anything.

> Using GIT_TRACE2_PERF=1, I can see that the error appears during
> the traverse_trees() which is after the sparse-checkout patterns
> have applied the skip-worktree bit.
>
> Thanks,
> -Stolee
