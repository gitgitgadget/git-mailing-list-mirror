Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0089B2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdBWX6I (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:58:08 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:35893 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbdBWX6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:58:07 -0500
Received: by mail-it0-f41.google.com with SMTP id h10so4042361ith.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 15:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hL9M8gQ9XDtdq3I01piQAZwbwL6q/Hvt+1QSPJmsstQ=;
        b=kDzgW7Y+axy0fTnUTjcMmQi9XYU2nJ1uwXzMXEgChlg6WSuj1ZFg2LaOM62E5u81sL
         RENMpz6my++pS2f4/4Xrk+I0kmGw52rMsR26JShC4e01htqmugTooKt2UuV5KBsuKDmL
         X1kUvtvbBRv4gHeo/9c0FnKb5hh5oIxxOvdn3ncDq6z0ON3kIngM6Vmu+VtJu41Pl8OD
         U77/+fgjyZRPMvyhTCB6VAX2q2VQhWng1bpBwnlRll+cUehHRsOPm7zm+2Bt8FCruySY
         XSLqkdYSRAnVcNT68Eq/8tVk8C6rFcrQYku69LT4zkrnc2J1BhZPmBMtOzU13/ZcmZ+4
         hb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hL9M8gQ9XDtdq3I01piQAZwbwL6q/Hvt+1QSPJmsstQ=;
        b=gp23IIXREox/JmQGz+C/Ll6ZJN4hpYmQhf3UeJ9yYtGGH58PO5whVi28TR+69ozezD
         DoTEv4pQ9IZZ6gPVGjE1bDZ4hv+fkXRARcmMWB4UFq7dFghfFgRBqar7ZZPrs0mOdVAv
         UlfjH0j+o3BdwERNhGzZZYToNrNLLDFaNhf3/YFkY2i35ym1YXyCm7O8jwSuNTTsdbFA
         Kp3tKpvRdD74n9OisBu9omGjDozDpceF0Ez3LI5hFfpaudzGxL8ATr/ivAqPlQIj+kj9
         3FXnrCzU46GdVJIJmduubhQHcKJOqWAJFuxiMqI3grxb4fl61n+Z0Bsdklr4/CenVdh9
         4BpQ==
X-Gm-Message-State: AMke39kVMIRGAPLXobbhYqXHw32VHNZ2BGQASYFBuQ2osji0AUBhCNySbumrMORHb7fdMoObwTBfH0FAwFZB/8nM
X-Received: by 10.36.169.12 with SMTP id r12mr212975ite.69.1487894286007; Thu,
 23 Feb 2017 15:58:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 23 Feb 2017 15:58:05 -0800 (PST)
In-Reply-To: <20170223234728.164111-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Feb 2017 15:58:05 -0800
Message-ID: <CAGZ79kbf6tWjgV6V96gBzjPABHrEAdL0zhmrRqdNw9ZQQ-2QXw@mail.gmail.com>
Subject: Re: [PATCH 00/10] decoupling a submodule's existence and its url
To:     Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 3:47 PM, Brandon Williams <bmwill@google.com> wrote:
> There are two motivations for decoupling a submodule's existence from the url
> that is stored in .git/config.
>
> 1. Worktrees can't really be used with submodules since the existence is
>    checked based on the shared .git/config.  This means that two different
>    worktress have to have the same initialized submodules.  By decoupling a
>    submodule's existence from the url, two different work trees can be
>    configured to have different submodules checked out.

cc Duy for this one:

Well once we have the per-worktree configuration, e.g. [1] we can *technically*
have different submodules in different worktrees by saying

  workingtree0: submodule.<name>.url = git://example.org/real-submodule
  workingtree1: submodule.<name>.url = bogus
  workingtree2: submodule.<name>.url = more bogus

and once we used the URL in the first workingtree all urls are
degraded to a boolean flag,
so the different (possible bogus) content does not do harm, only user-confusion,
because the model of the URL being the flag indicating existence doesn't quite
fit multiple working trees.

[1] https://public-inbox.org/git/20170110112524.12870-3-pclouds@gmail.com/

> 2. Easily configure gorups of submodules that a user is interested in.  In a
>    repository with hundreds of submodules it would be difficult to easily tell git
>    which modules to worry about without having to individually init all of
>    them.  Instead, a pathspec can be used to more easily select or deselect
>    groups of submodules.
>
> This patch series works to do this decoupling and instead allows a user to
> configure submodule.active with a pathspec to use to check if a submodule is
> initialized.

Thanks for stating both intentions!
Stefan
