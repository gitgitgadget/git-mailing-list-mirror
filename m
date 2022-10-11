Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D10C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 21:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiJKVQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJKVQN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 17:16:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F094AD47
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 14:16:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t186so12441567yba.12
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6EIlo0o4lkbAIgBjYokhf/9dCty+KF7CbdpprAHoqA=;
        b=aufwPTmpZAWpoS6JTTM1FSupYEOsihN0V+AQsQ7HZ9bDfWxjLhDlj3U3/vggMaqhQh
         wrpu5pPC/98rIxLj/z0/j7DTXk/QctUViJDjAyBDnnUDTnl3zfk+HLai28hTjrKFOpni
         n5RW5AlCq+ij8tW958FfE2OSzgouQQvY9w8rjPyOMcJrIV+zvulq3/j0AcaonOqP3XeV
         NY7oRrtEfzjwwxDUPoswfOLp9GTjyFONnm+MxU7ZPtopFNV0ncxT7y+n8K5xJbA8H5oU
         IA3B4K5uCheb9oQOQa/4CxwaRnOB4cZNICXvb7FK2l4jsEfTs4uq4T7c6r0a+RD5ULbn
         vw2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6EIlo0o4lkbAIgBjYokhf/9dCty+KF7CbdpprAHoqA=;
        b=X9LjH8Fz3aK0TgastVSgc9IXQxO/0ClfwLOtinkm7GRoQCYzrwmSd+hRmVD74kOK7I
         q1KpudAYT778AGhmGgT+zynt93VxvKctFInATSlCN9BkEsHYHkyoxbqQpdHeaOrA6rUw
         jeCrBpDwKPSVdgOy7/dG6rg98QVO+Ty06bOp9skP9QW2uM2ZBDxca4AFpfkd7i3RpBb+
         GCO1vBRNPty++e8xKPtcAF3AiW4IqjvupUbWUBuLOMKN/OS9weEK1bWKGk9K8Egx6shQ
         ZBtxGhD1Gu5lLfjWZvyehogb7Q3Im+9c5CtEe1DStCm4oGTYs3ZQlFxRnK63V8qGykOO
         iNDg==
X-Gm-Message-State: ACrzQf0IauocyMkbq9FuFH1iMCfydj3CtbLRWFzhHm13RNgSZxWn9fsB
        ZmAes+sPhAn+K8QqIosY0ifXZ6Xq+RUp2IAPT40=
X-Google-Smtp-Source: AMsMyM6GBk9F3+wHAZdWLjHSgCMhtWfoBJHF3Fz6dJ3SnpY21QYNs2obOslyvyHA7E8WMgoE4DFHf+fCZdDCI548vYA=
X-Received: by 2002:a25:3a02:0:b0:6bb:fce3:7b06 with SMTP id
 h2-20020a253a02000000b006bbfce37b06mr25305507yba.89.1665522970777; Tue, 11
 Oct 2022 14:16:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+P7+xrnAXceHJbBYV8Z9Ay9xbkzpiX3P0wXLwN7jfnifW2OBQ@mail.gmail.com>
 <kl6lzgeblap2.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lzgeblap2.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 11 Oct 2022 14:15:59 -0700
Message-ID: <CA+P7+xq3NGGTq2U2Di9ZTBO3buqeEMb2smC=v78V9Subt2cDMw@mail.gmail.com>
Subject: Re: issue with submodules using origin remote unexpectadly
To:     Glen Choo <chooglen@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2022 at 11:12 AM Glen Choo <chooglen@google.com> wrote:
>
> Hi Jacob! Thanks for the report!
>

Thanks for responding!

> I think we'd need a bit more info, specifically:
>
> - How did you rename the remote?
> - What command is doing the submodule fetch?
>

I am doing a git pull --rebase in the superproject, and I renamed the
remote in the submodule using git remote rename.

> Or, if you could include a reproduction script, that would be really
> helpful :)
>

I'm not sure how to do this, because it is only an intermittent
failure. I suspect it has to do with when the submodule actually needs
to update.

Perhaps I can come up with something though. If I can, I'll send it as
a new test.

> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > Hi,
> >
> > I've been running into an issue with submodules trying to fetch using
> > "origin" even though the submodule does not have a remote by that
> > name. (I recently switched the submodule remote name)
>
> How did you rename the remote? e.g. did you run `git remote rename`, or
> did you rename it manually? I'll come back to why this might be
> important...
>

I renamed it using git remote rename.

> >
> > remote: Enumerating objects: 210, done.
> > remote: Counting objects: 100% (207/207), done.
> > remote: Compressing objects: 100% (54/54), done.
> > remote: Total 210 (delta 123), reused 197 (delta 119), pack-reused 3
> > Receiving objects: 100% (210/210), 107.20 KiB | 4.29 MiB/s, done.
> > Resolving deltas: 100% (123/123), completed with 48 local objects.
> > From <redacted>
> > ...
> > Fetching submodule submodule
> > From <redacted>
> >    85e0da7533d9..80cc886f1187  <redacted>
> > Fetching submodule submodule2
> > fatal: 'origin' does not appear to be a git repository
> > fatal: Could not read from remote repository.
> >
> > Please make sure you have the correct access rights
> > and the repository exists.
> > Errors during submodule fetch:
> >         submodule2
>
> I assume this is `git fetch` running in the superproject?
>

Its git pull --rebase, but I suppose as part of this it will run
something equivalent to git fetch?

> > I thought at first there might be some configuration value in the
> > parent that is selecting origin, but I can 't find one. I also thought
> > maybe its some sort of defaulting to origin but I looked through
> > submodule code and didn't find one.
> >
> > Is it just that submodule code is not resilient against changing the
> > default remote name away from origin?
>
> Yes, in a sense, though I'm not sure if this is the source of your
> problems.
>

Hmm.

> When fetching with `git fetch`, submodules are fetched without
> specifying the remote name, which means Git guesses which remote you
> want to fetch from, which is documented at
> https://git-scm.com/docs/git-fetch. I believe (I haven't reread this
> very closely) this is, in order:
>
> - The remote of your branch, i.e. the value of the config value
>   `branch.<name>.remote`

So basically if its checked out to a branch it will fetch from the
remote of that branch, but...

> - origin
>

It defaults to origin, so if you have the usual "checked out as a
detached head" style of submodule, it can't find the remote branch.

> This is why `git remote rename` matters, because `git remote rename`
> will also rename `branch.<name>.remote`. If you have a branch checked
> out in your submodule, you might want to double-check your .git/config.
>

I do not have a branch checked out, I have it checked out as detached
head, as is the usual style for "git submodule update" would do.

> But... I'll mention another wrinkle for completeness' sake (though I
> don't think it applies to you). If you fetch using `git submodule
> update`, the submodule is fetched using a _named_ remote, specifically:
>
> - If the superproject has a branch checked out, it uses the name of the
>   superproject branch's remote.

Right, so that explains why I can re-run git submodule update after a
git pull --rebase and it works.

In theory wouldn't it make more sense to use the remote based on the
URL of the .gitmodules file?

> - If the superproject does not have a branch checked out, it uses
>   "origin".
>

I suppose one option would be to make this configurable. I started
using "upstream" as the default remote name for most of my
repositories when I began working with forks a lot more.

> >
> > Thanks,
> > Jake
