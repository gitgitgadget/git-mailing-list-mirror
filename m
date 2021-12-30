Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD03C433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240276AbhL3Sqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 13:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbhL3Sqv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 13:46:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3426C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 10:46:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so102460549edc.0
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 10:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/g82JvoYlPItnHuP4GU/24VPEMaM9cEFrTN8DZho5k=;
        b=gkpRtCfAAhy+b+uKTRtiDSQzwgau07No89RcQHhieCmPlqBOnavmMnswZOZOlFvYBQ
         OqdfVdCkfG0qTn8kNOtY4cFQBGFHXvjaW3icESl5Q7T8yz04yPIkkfe1YNMMleFzWRos
         s+SAMeKeRTMsj+xRUOy00Azz/LYqxNX4G4pQ6Y982RUzI234a9J2MhcGy3ryFje4e2Ta
         aaJSgE1/2arL1D8BmWcpbWoyOXo6wICvY4sMZiVh6Ls2cQUqF0RcUNiDcFhjMxNXFydT
         GAqqpHyl+a+WbJsR1NgoXZq09vNjeN4JYoaxj9WXZcOzPByhqeLpXTvnEIdTBjm0v4QW
         AfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/g82JvoYlPItnHuP4GU/24VPEMaM9cEFrTN8DZho5k=;
        b=DgcoqDXro7wsvvQs7F2qlbu5Rvb5Ht4y37RE/OCxsScg2yyKm9dGIf8mrjhzegUWyO
         pCagkhH4tXs6N+OaMD/23VKIdDAwYP9nqimvHZ5rl64rllb3Stpch01cwB7n3I+MYX0z
         QfrkWqJnfhmuCR7LJTpGWS1UZKheIdC3j2p3WXKBp9zSCbqRgZAe61K2bou2St6EfRIf
         fIJnre/yBX53ZTmhtCbCieun/83BSTp3IsKIyiTyc0f4FLe8A4i0sTSq+FA76YXQprT2
         XzQvJMEHH9i+zxTNx3YIJC52eOtKI9iVaRdKi9HqmPoQnPStcrgUW3zFqFfQSd70Tg/p
         X9Kg==
X-Gm-Message-State: AOAM531tqrurlh05k6JysdCD6rMHjuS06PK90BtClF3i674p1GfcVGIs
        gWV4DPiNFc9oTSehgdY/ZGZBnAnpyU9OC7Ic8YY=
X-Google-Smtp-Source: ABdhPJy9KP1ymkfh0RGkJCn5FwUg3sOI2VtiiowLYEghzDe7aOs2JLz203KErXJ5KmXCbCvlnZeTxuIQFDPA0wIwZOs=
X-Received: by 2002:a17:906:4790:: with SMTP id cw16mr25837151ejc.493.1640890008689;
 Thu, 30 Dec 2021 10:46:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1101.v2.git.1640114048.gitgitgadget@gmail.com>
 <pull.1101.v3.git.1640727143.gitgitgadget@gmail.com> <CABPp-BHuO3B366uJuODMQo-y449p8cAMVn0g2MTcO5di3Xa7Zg@mail.gmail.com>
 <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
In-Reply-To: <CAPig+cQ8Y2FC8=d7DaZ46YwPCrzM6RzutiZ3ghhrHsg6y8KWoQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Dec 2021 10:46:37 -0800
Message-ID: <CABPp-BEOgYct2nZ+6Hb+3bzEZt14pcSSa2_qLT-O==SMrh_KYA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse checkout: fix bug with worktree of bare repo
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Sean Allred <allred.sean@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 29, 2021 at 11:40 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Wed, Dec 29, 2021 at 4:40 AM Elijah Newren <newren@gmail.com> wrote:>
> > On Tue, Dec 28, 2021 at 1:32 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >      ++init-worktree-config::
> > >      ++
> > >      ++Initialize config settings to enable worktree-specific config settings.
> > >      ++This will set `core.repositoryFormatversion=1` and enable
> > >      ++`extensions.worktreeConfig`, which might cause some third-party tools from
> > >      ++being able to operate on your repository. See CONFIGURATION FILE for more
> > >      ++details.
> >
> > So, if users attempt to use `git worktree add` or `git sparse-checkout
> > {init,set}` without first running this, they can break other
> > worktrees.  And if they do run this new command, they potentially
> > break third-party tools or older git versions.
>
> When you say "can break other worktrees", you don't necessarily mean
> that in general but rather in regard to sparse-checkout -- in
> particular, the sparse-checkout config settings and the
> `info/sparse-checkout file` -- correct? (Genuine question; I want to
> make sure that I'm actually understanding the issues under
> discussion.)

Yes, thanks for the clarifications.

...
> > So, I'd like to reiterate my earlier suggestion which would avoid
> > these regressions while also fixing the reported bug:
> >   * If core.bare=true or core.worktree is set, then at `git worktree
> > add` time, automatically run the logic you have here for
> > init-worktree-config.  Having either of those config settings with
> > multiple worktrees is currently broken in all git versions and likely
> > in most all external tools.  As such, being aggressive in the new
> > config settings to allow new versions of git to work seems totally
> > safe to me -- we can't be any more broken than we already were.
> >   * If core.bare=false and core.worktree is not set, then:
> >     * `git sparse-checkout {init,set}` should set
> > extensions.worktreeConfig if not already set, and always set the
> > core.sparse* and index.sparse settings in worktree-specific files.
> >     * `git worktree add`, if extensions.worktreeConfig is already set,
> > will copy both the info/sparse-checkout file and the config.worktree
> > settings (module core.bare and core.worktree, if present) to the new
> > worktree
>
> Thanks for the clearly written enumeration of how you expect this to
> work. This summary pretty well (or entirely) captures the conclusions
> I arrived at, as well, after devoting a chunk of time today thinking
> through the cases. If I'm understanding everything correctly, the
> approach outlined here solves the bare-worktree problem in the least
> invasive and least dangerous way (for older Git versions and foreign
> tools). And we don't even need the `git worktree init-worktree-config`
> subcommand (though we need the underlying functionality).

I'm glad it helps, and that we appear to be moving towards consensus.  :-)
