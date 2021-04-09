Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C2FC433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA71610A8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 16:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhDIQiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIQiu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 12:38:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DBCC061760
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 09:38:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n67so5900055ybf.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XyKsdtymXCQdLVlwA9vaeYfJyLGrS32EMl00I8I/wRs=;
        b=Osozdf6c7t2HxsemUDHIul50XBY8N+HvrceUFqUo5G8a5yLLqatI1sVZaORGOG7+XJ
         L5XjtuIh7CAuWXuctgmZC0WJZR8PkKYYRDKT3awXihPNE77uD1FfCEV2+z5l0iLciQv+
         glaRdBcd4CtRKWgTC6bnyRwOUzgeWRXjlob46mG9ulWzl0oU77xvmidNksLI2kXlyLVG
         ZuMdeWy/oRZGm2q3KmVAq6ffd688AaMhLBsLPB+Ji/LJd+xyrPc4+5CCHdmCpptk6xaa
         8QaqSi094c0NG3r8Uw9m9uHOCjzo7AXDgoDgyYy57DPfD5cQ8nhBgLoajLEw8x3Kf4ZD
         /dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XyKsdtymXCQdLVlwA9vaeYfJyLGrS32EMl00I8I/wRs=;
        b=mOZ7IH8rBjR0bAKVdvzhJDkTVYfIaHEfeqcpweoxco+JiPxNDtY/HuiBx+HixZZR9I
         5+TaS2GT5hS04peFVuNcoy7b8WUhgrH5XLOOuNAjr+DAXQG54sxTeirgx0OpK0UNWnEH
         fy0tDf8cMNDHTKcjsIXy9cOjTIdzrm2JLl9nntyWEzd7tPs2ZeULI/ajLjIVKPhUaDKB
         roq5yUqo7+u2smJdAKSS9T0Nwh1sBlhWH2T4K+6kEaWyu+RBImxbGF6lUTMnHkXcYfLj
         5W4HuvlPKo4MBUzBaBNrP+e02ndH5dfFTFl7nJ13p9HdhOKOu3/JuBzZ8DAT3YNtF0Ba
         QGlQ==
X-Gm-Message-State: AOAM533QHcLBp27vCPCfPw7w/7p6tJxBnUFzPJjQPhQgjI4zgHNGd59o
        yNubtoz6SggFM3NCTbJXafPaGvL1fYekNjkSp5js
X-Google-Smtp-Source: ABdhPJxT+wQsw1UUKlRyYk5x/sInkiL/skraHHHnRHVZm2SFJi/np7Ct1yOI6MYEwKcEhYYww1GP9bnUtHvWxF9z9rkp
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2e49:: with SMTP id
 b9mr20941154ybn.184.1617986317099; Fri, 09 Apr 2021 09:38:37 -0700 (PDT)
Date:   Fri,  9 Apr 2021 09:38:35 -0700
In-Reply-To: <xmqqczv4nhem.fsf@gitster.g>
Message-Id: <20210409163835.2560428-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqczv4nhem.fsf@gitster.g>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: Re: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > There are 2 code paths that do not go through fetch_refs_via_pack() that
> > needed to be individually excluded: the bundle transport (excluded
> > through requiring smart_options, which the bundle transport doesn't
> > support) and transport helpers that do not support takeover.
> > Fortunately, none of these support protocol v2.
> 
> I am a bit puzzled by this mention of "Fortunately".  If one says
> "this shiny new feature only works with protocol v2" and "transport
> X does not support protocol v2", doesn't it imply that the shiny new
> feature cannot be used with the transport X, which is unfortunate?

I meant to say that we don't have to do much about these cases because
they are out of scope for the support that we planned (protocol v2), but
perhaps "fortunately" is the wrong way to say it. Perhaps a better way
of explaining it is that most code paths go through
fetch_refs_via_pack(), and for the ones that don't (bundle transport and
non-takeover transport helpers), we need to address them separately. But
in this case, we are not planning to support either, so we just check if
we have requested independent negotiation and if yes, report failure.

> I can understand "while interacting with the bundle transport, you
> cannot do independent negotiation, but there is nothing to negotiate
> with a static file that is a bundle anyway, so nothing is lost" as
> an explanation, though.
> 
> >  Documentation/technical/protocol-v2.txt |  8 +++
> >  builtin/fetch.c                         | 27 +++++++-
> >  fetch-pack.c                            | 89 +++++++++++++++++++++++--
> >  fetch-pack.h                            | 11 +++
> >  object.h                                |  2 +-
> >  t/t5701-git-serve.sh                    |  2 +-
> >  t/t5702-protocol-v2.sh                  | 89 +++++++++++++++++++++++++
> >  transport-helper.c                      | 10 +++
> >  transport.c                             | 30 +++++++--
> >  transport.h                             |  6 ++
> >  upload-pack.c                           | 18 +++--
> >  11 files changed, 275 insertions(+), 17 deletions(-)
> 
> It is a bit surprising that there isn't much code removed, as I
> expected that we'd be factoring out and reusing existing code used
> in negotiation for fetching into a new helper function (hence the
> existing codepath would lose a lot of code to be replaced by a call
> to a new helper function), but that is apparently not what is going
> on.

That's what I was trying to do (hence the earlier patches), but the main
thing I ran into is that a lot of the fetch code assumes that you're
fetching at least one ref, so I couldn't use a lot of it without more
code updating. Having said that, I may have missed more opportunities
for reuse.

> I'll have to revisit this step and the next step tomorrow.
> 
> Thanks.

Thanks for taking a look.
