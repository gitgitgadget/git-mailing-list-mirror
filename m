Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433AA1F454
	for <e@80x24.org>; Sat,  9 Nov 2019 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKILfH (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Nov 2019 06:35:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36037 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKILfH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Nov 2019 06:35:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id c22so8783581wmd.1
        for <git@vger.kernel.org>; Sat, 09 Nov 2019 03:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFwmDZmeqYXccppoSKnzuwVLfywsV2XX4Ny2AbBS0SU=;
        b=IIaw2DWlMNEcFMeeTAWzdJiduvsoDdyDJmpl+yN7+TQUsJkeXWG2LOOz8X3AG53K/r
         JO6aRN1QPNz3KTbZTYD/DxBiDzWgl7DALY4snicDEgbz9rKn4C5dfNOszEuYVfButpFC
         IJiHQCOQCoqvJUteibVP55t8EGjQHGQHN/XvsgRAUTPIfHtQkAxbu/9zdYPkOCXMDvra
         RMUcjzaLgxuo+rJxIg2T1wlnu3/d1b1u8+AwHy03HkOkJaT0OTp3uCgrhWkINCwGmWgE
         AKZXg1hsBw8/cK4ijVXIbiuK5FCy/G9rZDJClgSSh/JwAlLWbMWEREIbgrndRyWYC0+N
         w5YA==
X-Gm-Message-State: APjAAAVW1Qh+XKehIKTFJqxd6Llxe41nXPBRNoS8KV8x+pgB21Tq7cqy
        /nwiStPI7V4jkOZcYIF0cV+uSYhP67vs1hpgNKHgBJtU
X-Google-Smtp-Source: APXvYqytiIagBh07xUEyOzT+ODdFVz4Ch1S0jvphYHi3zeNx5qnvCpIL/G9nXylO//LQdXyGcOm3/Gw2O7hNgsRHfqM=
X-Received: by 2002:a1c:3843:: with SMTP id f64mr11776578wma.129.1573299305284;
 Sat, 09 Nov 2019 03:35:05 -0800 (PST)
MIME-Version: 1.0
References: <20191017162826.1064257-1-pjones@redhat.com> <20191017162826.1064257-2-pjones@redhat.com>
 <CAPig+cS6SzLdgmzffNkg72YSiDQ9eQRqTK12NsraKpGbkJFY_w@mail.gmail.com>
 <20191018194317.wvqphshpkfskvkyh@redhat.com> <CAPig+cTExu1+XyhUaq=yY09CAK6NN_BQViQETU8_fbGxu3jWzg@mail.gmail.com>
 <8c583f0c-c359-0fbe-2ffa-304db82b0a86@gmail.com>
In-Reply-To: <8c583f0c-c359-0fbe-2ffa-304db82b0a86@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Nov 2019 06:34:53 -0500
Message-ID: <CAPig+cS9KXAH2+gUTV+q9p95Dc20TOt5naN5uH1_TjSaeL53rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Make "git branch -d" prune missing worktrees automatically.
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Peter Jones <pjones@redhat.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 8, 2019 at 9:56 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> On 08/11/2019 10:14, Eric Sunshine wrote:
> > Perhaps there is some way to address the pain point without breaking
> > the fundamental promise made by git-worktree about being careful with
> > worktree metadata[*], but the changes proposed by this patch series
> > seem insufficient (even if the patch is reworked to respect worktree
> > locking). I've cc:'d Duy in case he wants to chime in.
>
> I agree that we want to preserve the safe guards in the worktree design.
> I wonder if detaching the HEAD of the missing worktree would solve the
> problem without losing data. In the case where something wants to
> checkout the same branch as the missing worktree then I think that is a
> good solution. I think it should be OK for branch deletion as well.

I would feel very uncomfortable making "automatic HEAD detachment"
(decapitation?) the default behavior. Although doing so may (in some
fashion) safeguard precious information in .git/worktrees/<id>, it
potentially brings its own difficulties. For instance, if someone
takes an action which automatically detaches HEAD of a missing
worktree which had some branch checked out (and possibly some changes
staged in the worktree-specific "index"), and then builds more commits
on that branch, then that worktree gets into a state akin to rebased
upstream (for which git-rebase documentation devotes an entire
section[1], "Recovering From Upstream Rebase"). While a power-user may
be able to recover from such a state, allowing the general Git user to
get into such a situation by default seems contraindicated.

I'm not even convinced that hiding the suggested "auto-detach"
behavior behind a configuration variable so power-users can enable it
is entirely a good idea either since, while it may eliminate some
pain, it also potentially allows abandoned worktree entries to
accumulate.

[1]: https://git-scm.com/docs/git-rebase#_recovering_from_upstream_rebase
