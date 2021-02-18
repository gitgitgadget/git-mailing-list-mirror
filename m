Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9EBC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251A164EAF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 23:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhBRXDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 18:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBRXDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 18:03:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC5C0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 15:02:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 127so4466737ybc.19
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 15:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=S+kBhWEof9sM5QhWpu8GOxiQDDjDuVDTcHbTnimu4QE=;
        b=p+R/oHQHka1kPcBoT6/KhiOS3cXiM9hwSk58o9xgXQLJGHTE2wO9SsJoDhV7I1QIQd
         xDughKVrOiEa+Wem8/9Lc4UOChq6qVg00TSqpwsm0R0DAOSAzIbpoGPe0pGHc1Ry51Cb
         ulM0V+rBom2i3KShR/RlgJ4uL6GF1WfjONgnCkdJW1cMhgWxTAPHIkiyeT077aLnytES
         4OFaNqKtNBPRwa5E0V3a1ZK68MTkZlvsvGUKSlSe/ooNtjduW/OsaTH19hQL+BBa1aTP
         TYSRXZVDi00/k2B+v6J/SvcSIWD6+3W6VWHxNxVSZfyCXzx9syAf4/M72GXSugWqMZKf
         Qewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=S+kBhWEof9sM5QhWpu8GOxiQDDjDuVDTcHbTnimu4QE=;
        b=fvFEVZyeHfpKO50Myo2yyQIaEALprHMfn7rCImWlLFs8aqhDX0ttF4CrBBhBp7fvwj
         1oaZTHep4acxrgqFfK3l03qPme+i6Y2mKTQ25WfAaEUxKMg9DN9i+tZbkgbaH+rfudAA
         pYBzlpk2pPo5dXAak/1XdAAnKtVpLAkmXYhVM3b/B/WB2ZwM2LL+t9Na6w5LUZoI5gdM
         WVpLJ5+I4Mb9Z52Rb1dQhR/omYpG7utSS4GNTkfOW7zIDohsx4kJN3Px3m3r9MxckM8N
         HmiPyiWtcopCSgJcU3t7olbS0Ubac2tqU8fGqjUCE3tkFy3IC/I1V92RdS71/vf4qAu1
         RuAg==
X-Gm-Message-State: AOAM531wVpm1VCeTHLQFg79wvKzZXAcGU1b9b2PLC9eFWdxRZ+T8Zagy
        N1O9VFCGwbQ+lidY6j2EpLghT2ClkQlEeUPuW7S3
X-Google-Smtp-Source: ABdhPJy5D+1Y/b/XGBOwIqbZW1vmjFn5VG/FqDGoE6DkqMrEGUrhtg5dToTz1I7POY2Zb+f315D1eZ0GDD+zx95vp2L8
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:412:: with SMTP id
 18mr10039214ybe.366.1613689377217; Thu, 18 Feb 2021 15:02:57 -0800 (PST)
Date:   Thu, 18 Feb 2021 15:02:48 -0800
In-Reply-To: <xmqqwnv6gnuq.fsf@gitster.g>
Message-Id: <20210218230248.1165266-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqwnv6gnuq.fsf@gitster.g>
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > The idea of adding negotiation to push has been floating around for a
> > while. Here's my implementation of my idea of reusing a lot of the fetch
> > mechanism to perform the negotiation.
> 
> Finally? Yay!

Thanks.

> > The basic idea is that when a client pushes, the client will first
> > perform the negotiation steps that it normally does during a fetch,
> > except that it does not send any "want"s and it only uses the commits to
> > be pushed as negotiation tips (instead of all refs). Once the client has
> > received enough ACKs that all ancestral paths from all tips to the
> > original orphans are blocked by ACKed commits, it will proceed with the
> > push, using this information to determine the contents of the
> > to-be-pushed packfile. (This check is done by the server when doing a
> > user-triggered fetch.)
> 
> So when pushing 'HEAD' to some ref, we say "I have HEAD^{commit},
> HEAD^^, HEAD^^^, ..." and they keep saying "never heard of it" for
> each of them until they find "ah, I know that one" with an ACK, at
> which point we can stop traversing our side of the history behind
> that acked commit (because everything behind it is common between
> us). And that way, we know what we do not have to send (i.e. what
> we should use as the negative ends of "rev-list --objects A..B";
> their ACK lets us discover "A").

Yes, that's right.

> Do we take advantage of the ref advertisement the other side
> perform, or is this v2 only and we even skip ls-refs?

My plan is to make it v2-only, but I don't think that there are
technical limitations in adding it to v0. I'm planning to skip ls-refs
(the current proof-of-concept code still calls ls-refs but doesn't use
its results). If we need to take advantage of the ref advertisement, we
could just use push's one.

> What do you mean by an "orphan", though?  Except for that part, I
> think what you wrote the above makes quite a lot of sense.

By "orphan" I meant the commits that don't have any parents - so, the
root commits.

> When we have an "--allow-unrelated-histories" merge with a history
> they've never heard of, we'd end up digging down to the root of the
> unrelated side history with "have/nack" exchange.  On the fetch
> side, we have "give up with too many nack" band-aid.  Do we inherit
> the same from the fetch side?

Yes. (But like fetch, this "in vain" check triggers only after the first
ACK.)

> >  - Do we need statistics in the commit message to show the performance
> >    gains?
> 
> Not until we see the thing fully working, I would say.

OK.
