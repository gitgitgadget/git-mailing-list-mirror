Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C6C56201
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776BB246E8
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CyLUjNwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgKRXNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRXNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:13:37 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E60C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:13:36 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id y21so2699032qve.7
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mukTogMOcaNhEcmWs5Z+flgS/09EzqdB1tOLEHR99+Y=;
        b=CyLUjNwCcIn8YlU3ktnsZt9nTisAYPEjxADePFbNdA+7kUurSoZMpNRvVLkMiUcygs
         bvSDPqUCt2wEcMHNeTfCMxtpP/XUUiqF+rHGj/NxDiVw6VvZbtJmKsnHPfIcSIQrNy14
         /3rXNojSrk0R7Y3JmvDaEuvoznXqobSqGoxMI6GMLVg5KEYLWM4/UN7Xd13OXHcugmUo
         qKlhwvA9bKeGhmUo91s0+m4IxSq30hb9FVUBEDiF3Ig2TbqLNw/j11KUditbO9ZDKfg3
         +EHit+u/GCKnqUGgNKq7G8XZmzJRe6/aVfLQZSGt483bpsoqCp/tWjVBm/LFx8Z7LxEx
         vJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mukTogMOcaNhEcmWs5Z+flgS/09EzqdB1tOLEHR99+Y=;
        b=SuyyFILjJkqpuhZoS8K1v2KunDaCR86NQ9pfcWhO1YQp7svZOVpL6WAVKZ3vjOjk8N
         uh1lB1pYCwuT/eiL9mFGnlEK3X3h01QAbfYS8JPC3XtZe2O4vcaAOrpH533+djyLSCwN
         c9FM8JoH63NcnW55UowwIdH23OuNbenKfqXQ7mP68MnF5YMLYMGJKLJFmzcbngL+zJT+
         K4kISuYv4ARgWDy5bngudRqt3bWomOC7glMV5BmDsgSLMM5IBGgde1eY9otwrkB8ikkV
         2Fn3vLJG9KqaAxBmd1WFVzIwDns6V6dvao1Y/6u8C2P78MEeqwfojZliLFVLa3hTFu0J
         J69w==
X-Gm-Message-State: AOAM531QgoyCCI3WPqmX0OBJ1+12t8bApB+Mu7I0cowjf9oAB8wEo85A
        vCcE+pTL+qUnVyOpmzzMJOIzfxuFBxI+8WCIhodT
X-Google-Smtp-Source: ABdhPJxxG7z3lukT+n3MbFuj+ok5+wjr1tXts5MvHO+zmVejIjChwcmGOohF8SeCwqpa8986/XPq6dwSyxYw896Dq+hs
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b65b:: with SMTP id
 q27mr7025333qvf.8.1605741215970; Wed, 18 Nov 2020 15:13:35 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:13:31 -0800
In-Reply-To: <xmqqd01sugrg.fsf@gitster.c.googlers.com>
Message-Id: <20201118231331.716110-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqd01sugrg.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: Re: [PATCH v2 2/3] submodule: port submodule subcommand 'add' from
 shell to C
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     shouryashukla.oo@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        Johannes.Schindelin@gmx.de, liu.denton@gmail.com,
        pc44800@gmail.com, chriscool@tuxfamily.org, stefanbeller@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Whew.
> 
> This was way too big to be reviewed in a single sitting.  I do not
> know offhand if there is a better way to structure the changes into
> a more digestible pieces to help prevent reviewers from overlooking
> potential mistakes, though.
> 
> Thanks.

I just took a look at this, and one thing that would have helped is if
you ported the end of the function first in a commit, and work your way
backwards (in one or more commits).

After reading through the whole thing, I saw that this is mostly a
straightforward start-to-finish port (besides factoring out code into
functions), but it would be much easier for reviewers to conceptualize
and discuss the different parts if they were already divided.
