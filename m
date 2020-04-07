Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C05C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFF1207FF
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqebOUii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgDGO0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:26:54 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37531 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgDGO0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 10:26:53 -0400
Received: by mail-pj1-f65.google.com with SMTP id k3so834025pjj.2
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaPDLhplFwraFeLZk6/PjAt9DY2L3LusMrWJC065Y78=;
        b=ZqebOUiighUgGbPbnOcRt/DSzabMDAFfDdD6Fcmc0RKrT40aW3fvkSWXVGZ1l8XOWN
         R71xFfePXEA/dsfEaDLbzyC7TavIIBV8UrJs7IqSjVXShmTgyRcj2iBc2XDe8LwUH39a
         4la2DJkCxKbaPfBCg1I17wOu4eUiYKsJkIKvxsjUJE/vpAvgq64A3NHRX2dmeJ0VIi4o
         0RlwWSn7GBU8loWRontn/Cue4htCiRadDUah71/g4WT7BDZ61+aShzKSOSoPr61jBie5
         HkIleBTcm/9UV+4p/VJ4zvb2i1I+yutTruAm9GhT7YoIZiiKayXvOCg1T4rc7UvhGTsf
         v1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaPDLhplFwraFeLZk6/PjAt9DY2L3LusMrWJC065Y78=;
        b=Q2m4Pie4NEb6rbhzSKM9A6zyQRnW5i9v8yUQVEnkCOrApX+F4XZnL76p+e4Qz3AoWY
         75ianf9e+foUJJxCgybLoNq32xdBuoMPFRATiAdO+XAjDwO12k7+8TCZeBgtQc/x+tKe
         wSAtWRt4ikh51bNU7R6D+XEUpG5wJH8+6difQg9FKAd3erhkSljVILIW1ZiYcB3tpIsv
         INsQPjDUUFje3tvXYLfYsAsoAwEbw96KVDRfNZrU+8l9SFJWXMPu1T3F6wJH5BdDylZd
         lUFFRyAEfDxdkn/cC/cYAEqs2M/PPD5r0hxlmhqfxL64Qf8ZHgOR7xH0eP4l7kHhpDDe
         nsZQ==
X-Gm-Message-State: AGi0PuZE1CN0Mg83A3Q+SIKCgvUFMhMVFwv28wZfwrcdWIWjLDGBCN4x
        R+bljMlVaxGdCNLLuXzmQGY=
X-Google-Smtp-Source: APiQypL4m/EFu4bBgYKnPiXkxSUvfMeb2dI6ox1wc4GhxSWuloYfD5k+TSpLlYEdw0JYK9/SqoZXsA==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr2667938plr.160.1586269610925;
        Tue, 07 Apr 2020 07:26:50 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id mn18sm1818311pjb.13.2020.04.07.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:26:50 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:26:47 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200407142647.GB1963@danh.dev>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
 <20200407005004.GB2568@danh.dev>
 <8946b9bc-06c2-3269-0fea-c9ba5b60d0ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8946b9bc-06c2-3269-0fea-c9ba5b60d0ba@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-07 06:59:08-0400, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/6/2020 8:50 PM, Danh Doan wrote:
> > On 2020-04-03 20:16:21-0400, Derrick Stolee <stolee@gmail.com> wrote:
> >> On 4/3/2020 5:40 PM, Junio C Hamano wrote:
> >>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>>
> >>>>  * git run-job <job-name>: This builtin will run a single instance of a
> >>>>    maintenance job.
> >>>>    
> >>>>  * git job-runner [--repo=<path>]: This builtin will run an infinite loop
> >>>>    that executes git run-job as a subcommand.
> >>>
> >>> What does this have to do with "git", though?  IOW, why does this
> >>> have to be part of Git, so that those who would benefit from having
> >>> a mechanism that makes it easy to run regular maintenance tasks but
> >>> are not Git users (or those that want to do such maintenance tasks
> >>> that are not necessarily tied to "git") must use "git" to do so?
> > 
> > I also agree with Junio,
> > I don't think Git should be responsible to be a scheduler.
> > It's the job of either tranditional crontab, at on *nix, or scheduler
> > on Windows.
> > 
> >> That's a reasonable reaction. The short version of my reasoning is that
> >> many many people _use_ Git but are not Git experts. While a Git expert
> >> could find the right set of commands to run and at what frequency to
> >> keep their repo clean, most users do not want to spend time learning
> >> these commands. It's also worth our time as contributors to select what
> > 
> > And now, people will need to learn _both_ Git existing maintainance
> > command, and new scheduler (Do I understand it right?, I haven't go
> > through all patches)
> 
> The point is that they would not need to learn the existing commands.
> They could accept the community's "best practices" by running the
> simple command to start background maintenance.

We could provide some "best practices" by an FAQ.
People can refer to it for "best practices" and run their favourite
choice of scheduler.

> In an "enterprise" environment, the users would not even need to learn
> the command in the first place, because the engineering tools team
> could configure the maintenance tools using the necessary setup scripts
> to built the repo.

In that "enterprise" environment, if the engineering tools team could
configure the maintainance tools using the command that introduced
together with this series, that very engineering tools team could
configure the scheduler to run required Git command, or create their
own wrappers. In such "enterprise" environment, most of computers'
software set are configured to be installed, the engineering tools
team know which software're installed in which system, they should
know which set of scheduler should be run, it should be simple for
them to configure their system.

> > Yes, it could be a setup it once and forget, but,
> > if there's a problem with their local repo, they will scratch
> > their head to understand what wrong with them.
> > 
> > It's easier to destroy their repo, and it's harder to know what
> > operation is running in their computer.
> 
> That's why we need to be careful. Luckily, these steps have been
> tested in the wild for over a year with great success (as part of
> VFS for Git).

No offence but I find this quote could be applied:

There are two ways of constructing a software design: One way is to
make it so simple that there are obviously no deficiencies, and the
other way is to make it so complicated that there are no obvious
deficiencies. - Tony Hoare.

Adding this set of commands to Git gonna made Git over-complicated,
IMHO.

-- 
Danh
