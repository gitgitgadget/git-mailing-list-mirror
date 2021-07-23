Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF768C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970860EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhGWPHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhGWPHV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:07:21 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B6C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 08:47:53 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n2so2293262eda.10
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 08:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=YNwHAIS+4lI0hNhn57g2DplwoEx1yXnRRSDo8MffC9Y=;
        b=r92SIm3jBhEu5iPh1dwCWeA09XUoEkunV69KKB1ttvD7z/xXjUan19jb7WEvaIkF54
         OYM5aWWdsxRLFnFDc/F65KsNMGDj8wrlhUrjEhRKwzLnGgB40HAcf59Aw6T0SjRzVBxj
         eY+oZdC/NzauIZeVxAm/E3E8KFJddnljsvzMvUb5jmOTEtKdYef8FHf1SMKJiHADLGn2
         Eju8KQ7uj3soS4wrOM/S/wyVP/yI3NeLRWispEu4TZKFPIGPaQWbP+nHDl785UZYKdLi
         gqicxDFyzcRC6iNrHNXAiAHmmZfd48QfvyTiY9WqL2vMAwndwOpECeG4NjtWzP7UPubz
         F0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=YNwHAIS+4lI0hNhn57g2DplwoEx1yXnRRSDo8MffC9Y=;
        b=Dw76mFehbH3/QMRLd5uRg5WoH3ZbuucxDNxQxGmm/EXMVubBEFrIhtK4ZyVm0VMilf
         708xWKJsZYVnggvCAQnek5BeaF7U0j9ua6nyuAvHP4avTN36f7nn2LIM5fgiCSg3Lce4
         ohDVuE+Z1AXx+Id7IPuIuxgjNNkg4ooHtdMIqqjs2aqmDADaX3x6NACxvCvpz+07KB/+
         hZVxOaQlsGVoWEX4vfVFVXbP1k4eJAFs4/rNweACEcLXmb6CBQvlJHxGosV0WXD1dZFM
         RafDYzzMmRRFk5bsXVj52xjQDgeGW3cunF8sROXk9xsODnQC9CYRP+CVgC9f96E2n5D0
         FHKQ==
X-Gm-Message-State: AOAM530waPySXmXWJ8XL7KygSLP4EhC8WgdnCAkx9YekOr94JtmL29TN
        z4AgJxdJCLMs1g4Fm+I/MBc=
X-Google-Smtp-Source: ABdhPJzDO4jylYyt8GzoqUfAaHE9CKtDpXt4Lqjr8lvCs4Cx9xWSFx5dnL+C8HCohEY8MUKceb5D2Q==
X-Received: by 2002:a05:6402:2206:: with SMTP id cq6mr6345735edb.209.1627055272077;
        Fri, 23 Jul 2021 08:47:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id dg20sm388923edb.13.2021.07.23.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 08:47:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     Tom Cook <tom.k.cook@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Bug: All git operations fail when .git contains a non-existent
 gitdir
Date:   Fri, 23 Jul 2021 17:47:18 +0200
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
 <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
 <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
Message-ID: <87o8atrpz7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 23 2021, Atharva Raykar wrote:

> On 22-Jul-2021, at 18:43, Tom Cook <tom.k.cook@gmail.com> wrote:
>> On Wed, Jul 21, 2021 at 11:59 PM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>>> 
>>> On 2021-07-21 at 09:17:36, Tom Cook wrote:
>>>> What did you do before the bug happened? (Steps to reproduce your issue)
>>>> 
>>>> Add a git submodule to a git repository.
>>>> Overlay-mount that submodule to another place in the filesystem.
>>>> Attempt any git operation in the overlay-mounted path.
>>> 
>>> I'm not sure about what you mean by an overlay-mount operation.  Can you
>>> provide some specific commands that we can run at a shell that reproduce
>>> the issue?
>>> --
>>> brian m. carlson (he/him or they/them)
>>> Toronto, Ontario, CA
>> 
>> The easiest way to reproduce it is this:
>> 
>> $ mkdir test
>> $ cd test
>> $ echo "gitdir: /foo/bar" > .git
>> $ git ls-remote https://github.com/torvalds/linux
>> 
>> We happen to use overlay mounts in our build system in a way that maps
>> a git submodule from one place to another so that its "gitdir" is
>> invalid and then attempt a `git ls-remote` from that location which
>> unexpectedly fails.  But the above reproduces the problem well enough.
>
> 'ls-remote' needs a valid git directory for the case where the URL is not
> explicitly supplied (to read the git config and learn the default remote).
>
> Making a special case for when an explicit URL is not given is not as
> straightforward as it seems, because by the time 'ls-remote' even knows about
> its arguments, it already takes a worktree prefix and sets up the environment,
> for which a valid Git repository path is required.
>
> I am not too familiar with this area, and I don't know how feasible it is to
> delay setting up the environment until after looking at the 'ls-remote'
> arguments. At a cursory glance, it looks difficult to do without large
> structural changes to the code.
>
> This might have been less of a problem with old-form submodules, where '.git'
> was an actual directory, rather than a text file pointer [1], but newer
> versions of Git discourage their usage.
>
> [1] https://git-scm.com/docs/gitsubmodules#_forms
>
> PS: we prefer bottom posting or inline replies :)
>
> ---
> Pointers for others who might be interested in looking into this:
>
> The immediate cause of this seems to be 'setup.c:setup_gitdir_gently()' [2]
> which calls 'setup_gitdir_gently_1()' with the 'die_on_error' argument set
> to true. This function then calls 'read_gitfile_gently()' with the same flag,
> which errors out when it runs 'is_git_directory()' [3], because the path in
> the gitfile is not a valid repository.
>
> [2] https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/setup.c#L1234
> [3] https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/setup.c#L784-L799

The timing of this reply after [1] suggests that you may not have seen
that patch that fixes this issue (sans Junio's outstanding comments on
it).

Perhaps your E-Mail client is forcing threading by subject only, not
In-Reply-To chains?

1. https://lore.kernel.org/git/patch-1.1-fc26c46d39-20210722T140648Z-avarab@gmail.com/
