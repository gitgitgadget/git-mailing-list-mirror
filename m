Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FDC433E0
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BB764E58
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 20:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhBQUGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 15:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhBQUGF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 15:06:05 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928CC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:05:25 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h10so10726225qvf.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1fuSP6u28TeiepD+Nh/zxT0T1GTM8ZDDIXw5ibSPduw=;
        b=N6DGXcs5Gj9aaaRF1OBtOwATkZu27N53CLANRJZdSQMVp4+eRoYB3qqYlvuqCk5MPQ
         GJpB5JVNfEhPfYRFWTTvRnh9t+NnuZM3YgUNWuX6Oqj9filRZ8d9mvOmbSoHpGe7aQGG
         2W5OqqW4k/2IMn+fcta2/DzNBjBf6m0oE4vvisrPsAj6WxfwhUWw2yg2GkD8IQzH4o1S
         F7caVoLhBHsByDWu7uiNHhh9dwbQMcl0tTaCdtceBm+ZmNqvIwENsdu9wwg/7QCSnUqG
         WTnuBaJxwJdBLy2R1d5GCs3hV2b9Wf22R2VUbN4X8g+sFU/aX39iKB2cBx4cZWPgTYxA
         lxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1fuSP6u28TeiepD+Nh/zxT0T1GTM8ZDDIXw5ibSPduw=;
        b=UMZg7VzJ8afcwya7qTcYbTFgYOuxs5kupMn3IIsZI/q+vZi88BtAQ5DmZExU5Q+UBj
         gNeOvO49VPIt2ulvNxqzTOde1WZk9VW5l9qafnsWeV9D+/aiaTTWZ5UU5c6157bSQx65
         auWfHybevktE5yPN36hkBjBwOIAb+3G49dgICNtfrwSJ6NRpeByuWO6KHhBsUVe7wPvp
         QRdjgEXfASi6KqOcy3EYdDMeg5U3DJD4Hp73WE78JRWwoGOD3rtmFoNejXjJCIL/I+W1
         QWq/+6+DD56Z18GCioMGSUIw/sYKgbMfACrhoJa2eYMttRiFKLql+DyABkVM3ZUjoxuF
         c6iQ==
X-Gm-Message-State: AOAM531/4qBze8la0TT3vAhmr2XzFnyqXKR38syWWueyME1N+3EvQWhG
        va5NMeSfARu1jiA60MkGEy/mfhi6ODc3whafOzSk
X-Google-Smtp-Source: ABdhPJx/hWT0wpP8exVTHvedj6ZqYsf/i8ts0KGMv4TXc91UXw8NQuMJjoeIEDwqRFV5x8QniNaNixjQlXJXr9DbbUuR
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:aa19:: with SMTP id
 d25mr791337qvb.46.1613592324178; Wed, 17 Feb 2021 12:05:24 -0800 (PST)
Date:   Wed, 17 Feb 2021 12:05:22 -0800
In-Reply-To: <87blcja2ha.fsf@evledraar.gmail.com>
Message-Id: <20210217200522.875107-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <87blcja2ha.fsf@evledraar.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: [PATCH 4/4] fetch-pack: print and use dangling .gitmodules
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I tried that first, and the issue is that IDs like
> > FSCK_MSG_GITMODULES_MISSING are internal to fsck.c. As for whether we
> > should start exposing the IDs publicly, I think we should wait until a
> > few new cases like this come up, so that we more fully understand the
> > requirements first.
> 
> The requirement is that you want the objects ids we'd otherwise error
> about in fsck_finish(). Yeah we don't pass the "fsck_msg_id" down in the
> "report()" function, but you can reliably strstr() it out of the
> message.

We can't strstr() because of false positives (if, e.g. there is a
submodule name that contains the string we're looking for), but looking
at report() in fsck.c, the message ID is the very first thing appended,
so I think we can use starts_with().

> We document & hard rely on that already, since it's also a
> config key.

Ah, good point.

> But yeah, we could just change the report function to pass down the id
> and move the relevant macros from fsck.c to fsck.h. I think that would
> be a smaller change conceptually than a special-case flag in
> fsck_options for something we could otherwise do with the error
> reporting.

I agree - I thought this wouldn't be possible, but like you said, we can
reliably make use of the string in report() (or pass the ID, like your
patch set [1] does) so we should do this.

What would be the best way to proceed, now that we have at least 2 patch
sets (mine and yours) in play? I was thinking that I should update my
one to use the string reported in report() (with starts_with()), so that
both our patch sets can be reviewed and merged in parallel, and after
that, update the fsck code to use the ID instead of the string.

[1] https://lore.kernel.org/git/87blcja2ha.fsf@evledraar.gmail.com/
