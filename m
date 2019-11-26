Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F65C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04FC20835
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 18:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+SgzXBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKZSlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:41:08 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:34509 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKZSlI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 13:41:08 -0500
Received: by mail-pf1-f201.google.com with SMTP id z10so12407624pff.1
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rOBsn+HxXuyB/bXl5nxb7l6rgNL2FD9rN+nDSkRI548=;
        b=W+SgzXBBt/6e9bNhaEEJ5mwRwTLGYdYM/pDhl9WuWOEApZzY824iAxv/ASlBduSD7+
         sNn+GbcWZTi7mvgimtshYKTGCwTKniPNmnYCLFNqAQHYTirxmlpqFNYE2lUQaThG+HL+
         tQacrorwi2m3M5jfFrgg+y01oZfI5h3WgBtG0RRr737gGS7poo5wQuEXwJZ5GdulETug
         1Q+TPDWVVq7cG/s/nLdwxR6XWOAsmiLNkWkBm+0bWeQn7y5F1Dqbnoc/A4PKuuM31ljc
         8qTzxjihyVkIVphz5I+ZpsUGNk792ZQL05H8HPh4t6zZ7/kSZokyuJxbjwmEwGrxIQyF
         sJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rOBsn+HxXuyB/bXl5nxb7l6rgNL2FD9rN+nDSkRI548=;
        b=BnHZufVJlqJiBK3GEy/F07VSemBHsvi3+N2PeryGPvHB28WQ3L6NgzvYvHwP+v3Fa1
         DobvNc10IHAOvUf4sExKC7Z0a4yVqvY4jxtjuQS4yAUVsc46MT956hL5tQzj0eep7jv0
         tAgjNi3T3mXk31r0Z7/lg7979Di+nIXMCzotsxsQs5KcihLB9HPP6DQRlC7N9CvhWbKT
         zyDXgU6voXeHB0lW6M4ljc5U3uVMyumeBXH7tG9A8nvceEyiyQzDIq7V8oO4gGUjaGd1
         rlkh4iidUiPXYWtKZnlkMMxJZjOWfHQPJoCOAoesxCUhA/LZW+ECWJz9lWCcWxl8/949
         RQOg==
X-Gm-Message-State: APjAAAXZDEMXzghMMaseOv3EnC2NvD+k06KiUhft+VTN5iE7W3z3s6d5
        aoOzc+wm782jIqu8fP5tdnIZkOo2mUwPn3jVq8Xe
X-Google-Smtp-Source: APXvYqwHuSKGGZjAdN6NNkxA3ReF39yeqfAUgbO+fCzJ5Z7oTJDEe8O1BA8SA/zAIRmXVhuwPZGQ2knNlsYmymEsgI/f
X-Received: by 2002:a63:4c14:: with SMTP id z20mr31891491pga.10.1574793667791;
 Tue, 26 Nov 2019 10:41:07 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:41:03 -0800
In-Reply-To: <20191124174332.30887-6-alban.gruin@gmail.com>
Message-Id: <20191126184103.146421-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191124174332.30887-6-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: Re: [PATCH v4 5/5] sequencer: directly call pick_commits() from complete_action()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     alban.gruin@gmail.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Currently, complete_action(), used by builtin/rebase.c to start a new
> rebase, calls sequencer_continue() to do it.  Before the former calls
> pick_commits(), it
> 
>  - calls read_and_refresh_cache() -- this is unnecessary here as we've
>    just called require_clean_work_tree() in complete_action()

require_clean_work_tree() and read_and_refresh_cache() seem to be
different functions - can you explain why running the former is a good
substitute for running the latter?

>  - calls read_populate_opts() -- this is unnecessary as we're starting a
>    new rebase, so `opts' is fully populated

My comment from [1] has not been addressed. Quoting it here:

> So complete_action() (the function modified in this commit) is called
> only by do_interactive_rebase() (in builtin/rebase.c), which is only
> called by run_rebase_interactive() (in builtin/rebase.c) when command is
> ACTION_NONE, so indeed, we're starting a new rebase. But where the
> options fully populated? I see that in do_interactive_rebase(), it is
> initialized with get_replay_opts(), but that seems different from
> read_populate_opts().

[1] https://lore.kernel.org/git/20191119204146.168001-1-jonathantanmy@google.com/

>  - loads the todo list -- this is unnecessary as we've just populated
>    the todo list in complete_action()

Both functions indeed have their own todo lists that they pass to
pick_commits(), but I don't see (at least, by glancing at the code) that
both these todo lists are identical.

>  - commits any staged changes -- this is unnecessary as we're starting a
>    new rebase, so there are no staged changes
>  - calls record_in_rewritten() -- this is unnecessary as we're starting
>    a new rebase.

OK - I don't know enough about the rebase mechanism to verify these, but
these seem reasonable to me.
