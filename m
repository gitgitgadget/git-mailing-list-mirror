Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D067FC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 06:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiBZGCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 01:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBZGCP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 01:02:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D82B324A
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:01:41 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id q17so10179364edd.4
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 22:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zxv3k2LNTXK2UfWwvpsLgcIoMZzsm62VM3hpM3Z9Sf0=;
        b=DdvfMz+TgGb+tN6Fhz5H1Z5A84rTPIroU76FsWx4oOyd2O/3MRvFcrNrN7YzpD/hyK
         nh5C5Mc6w/smJLXytz3UdTY0tsyAxfl6iZE8jQXiMu4LCXd5OL/uZ598vZ80zNOO9zqp
         YeNX+hlPsiVKDC9BqxwkeSYEi6mnbWkIAomr/PaytwATq3RzjF63h4LD1KBNzqHsJ66W
         cjlXCcXkuB2vMn8Xo2bWuvE0d8IwnuuWrAdr+jBsQZ6ZTy0aoLu5Yir0TLiwbsgn+8pz
         Xy9a1OjfBu6GJO/G3m1pCbYCL1rQf7G9ze6hiNRXuf78ku0fJ77uXK4rea928KgQWqMM
         5rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zxv3k2LNTXK2UfWwvpsLgcIoMZzsm62VM3hpM3Z9Sf0=;
        b=p3njx5gPSaq3gdvzMfuKBTYUuiaCvJwXXiUH74MnZITJg9KqPRKhPXqKJrIiHRzSjH
         XmrBYfYqcJAMI481QpfuvtU91RJnQS4WUrXunXdcPLgXXi4fntrUPuRJvuaYVt6lbl9R
         Amj2jW7FvgPbJF6YZ7hXL2Uw032M0HHw3tUAi7K4BiLRictgpj7GETugyJEqGpf9pD1Y
         T5ntzRSN0StDZRBTBZKS2j5y2GF0MNtr8S4CExQIGUVMpkEIdBdeIfsXkCkEac7A1C/U
         pvIWs5PU8Z/8lB33H1W65QMQ60eg/66ZIEd2bNhLzbZbSnuue9VAd+mSPUXLKOBsErrW
         BIHw==
X-Gm-Message-State: AOAM532OxoCldFFF3gQjLIeP9x+tYdQFaK9hSktV6dDtdGBd9fearyim
        3xhKsw8VkmL16g6emPzG9wvSyz/WYSldXhEfeDw=
X-Google-Smtp-Source: ABdhPJxAQfXo1YHv6J+0BHCWFxV1X3gJneiC4lsyP7wLvske4QdT4+6iV3M6GKCEb3B66+krAqyTPONAVOGo+NcDJy8=
X-Received: by 2002:a05:6402:845:b0:412:ad14:863e with SMTP id
 b5-20020a056402084500b00412ad14863emr10250173edz.380.1645855299911; Fri, 25
 Feb 2022 22:01:39 -0800 (PST)
MIME-Version: 1.0
References: <YhWbWOd6PeF1RZw1@google.com> <20220224052259.30498-1-newren@gmail.com>
 <YhkE2vxI4nM3ut0K@google.com>
In-Reply-To: <YhkE2vxI4nM3ut0K@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Feb 2022 22:01:28 -0800
Message-ID: <CABPp-BFpOWAuaA7DpS8FBty=LdNu3UFbnkq1zsM68fnE9m93eA@mail.gmail.com>
Subject: Re: [PATCH v3] repo_read_index: add config to expect files outside
 sparse patterns
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 25, 2022 at 8:33 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi,
>
> Elijah Newren wrote:
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks, and sorry for the slow review.  My one remaining area for nits
> is the documentation, but that can be improved iteratively via patches
> on top.
>
> [...]
> > --- /dev/null
> > +++ b/Documentation/config/sparse.txt
> > @@ -0,0 +1,28 @@
> > +sparse.expectFilesOutsideOfPatterns::
> > +     Typically with sparse checkouts, files not matching any
> > +     sparsity patterns are marked as such in the index file and
> > +     missing from the working tree.  Accordingly, Git will
> > +     ordinarily check whether files that the index indicates are
> > +     outside of the sparse area are present in the working tree and
>
> Junio mentioned the "sparse area" could suggest that the area is
> itself sparse and devoid of files, so it might not have been the best
> choice of words on my part.  Perhaps "whether files that the index
> indicates are not checked out are present in the working tree" would
> work here?

I rewrote the paragraph.  I think it's more clear now; I'll resubmit
it here soon.

> > +     mark them as present in the index if so.  This option can be
> > +     used to tell Git that such present-but-unmatching files are
> > +     expected and to stop checking for them.
> > ++
> > +The default is `false`.  Paths which are marked as SKIP_WORKTREE
> > +despite being present (which can occur for a few different reasons)
> > +typically present a range of problems which are difficult for users to
> > +discover and recover from.  The default setting avoids such issues.
>
> The git-sparse-checkout(1) page never describes what SKIP_WORKTREE
> means, so it might not be obvious to them what this means.  Also, the
> "can occur for a few different reasons" may leave the user wondering
> whether they are subject to those reasons.  What the reader wants to
> know is "I should keep using the default because it makes Git work
> better", so how about something like
>
>  The default is `false`, which allows Git to automatically recover
>  from the list of files in the index and working tree falling out of
>  sync.
>  +
>
> ?

I like this.

> > ++
> > +A Git-based virtual file system (VFS) can turn the usual expectation
> > +on its head: files are present in the working copy but do not take
> > +up much disk space because their contents are not downloaded until
> > +they are accessed.  With such a virtual file system layer, most files
> > +do not match the sparsity patterns at first, and the VFS layer
> > +updates the sparsity patterns to add more files whenever files are
> > +written.  Setting this to `true` supports such a setup where files are
> > +expected to be present outside the sparse area and a separate, robust
> > +mechanism is responsible for keeping the sparsity patterns up to date.
>
> Here I spent most of the words explaining what a Git-based VFS layer
> is, which is also not too relevant to most users (who are just
> interested in "is `true` the right value for me?").  How about
> reducing it to the following?
>
>  Set this to `true` if you are in a setup where extra files are expected
>  to be present and a separate, robust mechanism is responsible for
>  keeping the sparsity patterns up to date, such as a Git-aware virtual
>  file system.
>
> ?

I like this, but I also added in some of the wording suggestions from
Junio here, so it's
a bit longer but has both some of his suggested wording and yours for
slightly different aspects that I think works well together.

>
> > ++
> > +Note that the checking and clearing of the SKIP_WORKTREE bit only
> > +happens when core.sparseCheckout is true, so this config option has no
> > +effect unless core.sparseCheckout is true.
>
> Good note.  Same nit about the user not necessarily knowing what
> SKIP_WORKTREE means applies.  Also, we can remove the extra words
> "Note that" since the dutiful reader should be noting everything we
> say. :)  I think that would make
>
>  +
>  Regardless of this setting, Git does not check for
>  present-but-unmatching files unless sparse checkout is enabled, so
>  this config option has no effect unless `core.sparseCheckout` is
>  `true`.

I like this too.  Thanks for the suggestions, the proposed changes,
and the review.
