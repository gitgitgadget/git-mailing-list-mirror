Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D0C0044D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 03:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966F02051A
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 03:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wNjOFj05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgCQDD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 23:03:29 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42211 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgCQDD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Mar 2020 23:03:29 -0400
Received: by mail-pf1-f202.google.com with SMTP id i127so14424657pfb.9
        for <git@vger.kernel.org>; Mon, 16 Mar 2020 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T+Ft7ekdLVfxzEIB1iP8IhdREbSnZmV49PONBA1VX7E=;
        b=wNjOFj05bDucXCa1DSVGkzhC3LKf3iqW+7Yf7IAK2JwusD/gqgRvSLCTJk5Q9rTAbE
         YRdN9sSnJAdVH6ZJZFhVc1cfabupesqHlkuxd5S/I/OzXgx0mP0fFOu4fFiZ2GS+ZC8v
         9A1lLJ6NzYQ9MBzSB+xfuveOB1UjuztPEryzQ2cc59fDVzfRNg2kEQka23oKlMlKSxX3
         BeJQeNOhSrtsjOIzUpd8xq1PzwAwqgF1xWG5L802DtRh6V7qYF2gPTnKVf0cYENTTzCf
         hNoU4irqgdPdyWqSIkJ5vseg4HsOSXyG1aRUZO+8YzKoOC0kKNNeGgao/aggkomMOJsr
         iLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T+Ft7ekdLVfxzEIB1iP8IhdREbSnZmV49PONBA1VX7E=;
        b=EX+6hxpTnvv6KNfJZVU+JuOSBB6ewYjE1/QjW5ogOjRbG0Qf42AQOvube9wp4ituiW
         kSq3J01tpCNfRLj0srkXixNIrVd8QD8z3GZz0BeWxLQysytZDEb+iL/7pFfbrmWY8BxP
         nFAg7fzwr4P6BN0X4U8rgDUrrA9orms87HF6QzLPRxXQb1oQDukRIZPAEfY7zPCbZUsi
         7Ssvg73Xb6eN9SILDJADW00VNoTGKA5merUi3h1bl3NjrzjrkxFATBgA4pScqkUcMetx
         MeB7GNnF/LbJLF5IwBp3YvHBkR86Q7I6LF6TGW/chJEsh+TUIdfWA9bnasZA6g97mJK2
         OpEQ==
X-Gm-Message-State: ANhLgQ3oszaZu37Lm1s0DBuBKWQjhtr7SLm7KUhNGg0pAe86KFbriGVi
        R62Id0ZD7YOI0KFLUp68rgrXe3WXO3I6RzmgPESX
X-Google-Smtp-Source: ADFU+vvNR8uSYhO2hlcY8nqaMRI4LnhSzigO5ArcyUAnFaJ6/6BnRPWVajAX/zpeyo8R5ErAlCfxO1YXCXYgGUgmMenT
X-Received: by 2002:a17:90a:9f4c:: with SMTP id q12mr2738940pjv.157.1584414207890;
 Mon, 16 Mar 2020 20:03:27 -0700 (PDT)
Date:   Mon, 16 Mar 2020 20:03:24 -0700
In-Reply-To: <CABPp-BGcQHT5PkqYw3YRWOv8kbiSumJ+YQ3owkd_7viKWs3q7A@mail.gmail.com>
Message-Id: <20200317030324.190751-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CABPp-BGcQHT5PkqYw3YRWOv8kbiSumJ+YQ3owkd_7viKWs3q7A@mail.gmail.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: Re: [PATCH] rebase --merge: optionally skip upstreamed commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     newren@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, stolee@gmail.com,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > We've made changes in other places (e.g. opening an editor for merge
> > or rebase, push.default, etc.); is there any reason a similar change
> > wouldn't be justified here?
> 
> After another day of thought, and my attempt to figure out the reason
> above, perhaps my assumptions about the reason behind the original
> behavior, any my assumptions about the sanity of switching the default
> might not be as grounded as I thought.  Thus, my worries about yet
> another flag may be overstated as well, at least in this case.

Thanks for the further investigation. For what it's worth, I do agree
that we should think of the cost of introducing an option before
introducing it. Admittedly in my write-up [1], I mentioned my
investigation into speeding up existing behavior enough to not need my
new feature, but didn't mention the possibility of just changing the
existing behavior. (But it seemed to me that this existing behavior is
presented as a desirable feature, so I didn't think of changing it.)

[1] https://lore.kernel.org/git/20200312180427.192096-1-jonathantanmy@google.com/

This question (from your other email [2]) is probably moot if we're
going to introduce this option anyway, but just to answer it:

> >  If we
> > move in a direction where not only blobs but also trees (or even
> > commits) are omitted, we'll definitely want this new option.
> 
> Why would this new option be needed if we omitted trees?   If trees
> are omitted based on something like sparse-checkouts, then they are
> omitted based on path; shouldn't we be able to avoid walking trees
> just by noting they modified some path outside a requested sparse
> checkout?
> 
> I want grep, log, etc. to behave within the cone of a sparse checkout,
> which means that I need trees of upstream branches within the relevant
> paths anyway.  But theoretically I should certainly be able to avoid
> walking trees outside those paths.

I haven't given much thought to it, but the diffing mechanism will need
to receive a whitelist of paths and, if it ever needs to traverse
outside those, will need to abort with "there's a difference outside
this whitelist". I don't know if it supports such a thing now.

[2] https://lore.kernel.org/git/CABPp-BE83ZhezkgmwatxAhqh4rptMUggcjSwBeiSByyPTUi6Lw@mail.gmail.com/

I'll give some time for others to respond, and will send out a v2 with
your and Taylor's suggestions implemented.
