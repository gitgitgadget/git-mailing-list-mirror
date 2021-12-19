Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A78CC433EF
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 22:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhLSWXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 17:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhLSWXb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 17:23:31 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08186C061574
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 14:23:31 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id y9so7697587pgj.5
        for <git@vger.kernel.org>; Sun, 19 Dec 2021 14:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kXvK3Wq13DlZVwwK9qR2EQ4mFn+h2X5puPyBbtUT6U=;
        b=B4O379y7LJjWUJQ9i+gmmcABKnGkDZu7dQVQuIjydTSD7ECtM8u0qZP3w3HHIrPUaB
         7iRAAAvJnntxZfII9LGhAJMcYZuCD55rJzRJepY4GVrbsHCzB5mdpoDswl0neyUow0as
         cDmfnkOHMs6kgEB0SBuwWNiczuFCmfUSs9Pjqw6EefHujrf2/zIlfSA/Dgz2hkZ6afF6
         h9kgvwy3XE+P9fHzEn5CzuFOqwI+UhcGAQozQnJ9fQLDApoPG0kkTYzJmPC9dA6kVfhJ
         igNEi/AWTOABvUY+mGj2j2bbKBcu/ym40+WHxwblUovGHNlAArP/J9VqV3aLQjI2n5y8
         DKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kXvK3Wq13DlZVwwK9qR2EQ4mFn+h2X5puPyBbtUT6U=;
        b=NwQdScEL6zDSivtN8Kq7x9EjwSyFJTu7ZrwpioKHSvr5WaaBEb2TDONIvOq3CBgkFA
         YsIFGovYUUklo5ILlRnwy1yskCC2knxZHwc2ppZgsIucP+0EZOSHIVGM2GAR9cGjYz39
         cBHSQ6XnpizlMfmZZAqk5MBbJmd6u/diLQyCJ+VRXvlqVb+KIPr5Hk9aDf5DSJvK09YQ
         o32V+tA49fidQPOBKsRQVH4J8ApjWFU4ebZzz300JzT8ZHLFrqqbN1ttPvMf8S0g6MEn
         zlaCTjB/1G5PaVg+D0f8WyjpoEDHMZp8sJuDTwqOt8heOIr2XBEFTb7fw8n2X6kny2q2
         qpWQ==
X-Gm-Message-State: AOAM530NZGaFJd2MdI9MFmAx+gU+LQVMu06nsWxXpkZ3CVFhW4oJjXfq
        y5KxiNqw/A/4ncQ83+1/wdl1iVazOYQpkk0l5I3iF/RhMe8=
X-Google-Smtp-Source: ABdhPJytFriLDz4FKeZLzvXTiKf0S/eRVd1BnF4irkZOa6D5NXochyGo5OlGR2HUcIV8OEmiJjniBTBmvuOyCoLkhUM=
X-Received: by 2002:a63:a1a:: with SMTP id 26mr3144353pgk.212.1639952610508;
 Sun, 19 Dec 2021 14:23:30 -0800 (PST)
MIME-Version: 1.0
References: <CABceR4bZmtC4rCwgxZ1BBYZP69VOUca1f_moJoP989vTUZWu9Q@mail.gmail.com>
 <e992d4b4-f9e2-a8f9-22da-e9d342c7bede@sunshineco.com> <CABceR4YVd4remACJkxwSCTSYB2v3Zn1BsjKHbzeve8uHiZv1pA@mail.gmail.com>
 <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com>
In-Reply-To: <003f01d7f51f$f7bb0860$e7311920$@nexbridge.com>
From:   Sean Allred <allred.sean@gmail.com>
Date:   Sun, 19 Dec 2021 16:23:19 -0600
Message-ID: <CABceR4aP8BVr10RYS_0PFG7ExRTJ3tB541JGC4DJ7CUsMg9+Jw@mail.gmail.com>
Subject: Re: Bug report - Can create worktrees from bare repo / such worktrees
 can fool is_bare_repository()
To:     rsbecker@nexbridge.com
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> what about the comparison code where is_bare_repository_cfg is
> compared with 1 (it is a boolean and sometimes set to -1). This
> would not generally pass a code review.

I'm sorry, I'm afraid I don't completely follow.  Wouldn't the most
straightforward change be to simply follow the documented
recommendation when we create the worktree config in `git
sparse-checkout init`?  Specifically,

    @@ -374,6 +374,9 @@ static int set_config(enum sparse_checkout_mode mode)
                           "core.sparseCheckoutCone",
                           mode == MODE_CONE_PATTERNS ? "true" : NULL);

    +    if (is_bare_repository())
    +      git_config_set_in_file_gently(config_path, "core.bare", "false");
    +
         if (mode == MODE_NO_PATTERNS)
             set_sparse_index_config(the_repository, 0);

Are we saying the comparison within is_bare_repository() may not be
appropriate in this case?

---

Or maybe it makes more sense to call set_git_work_tree() somewhere
sensible such that get_git_work_tree() will return non-null.  Doing a
deeper dive into the code, that might be the *real* root cause
(assuming the_repository->worktree is NULL in this scenario; I have
not run git through a debugger).  Such a change could have
farther-reaching consequences, though.
