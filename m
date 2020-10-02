Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEBEC4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A11020719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 21:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcIBI5mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJBVmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 17:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 17:42:54 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1622C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 14:42:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z40so3059515ybi.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MsFfEFI3EQjrWU87HKolFgqeg0W+Q9yqLl0t6mKPYoU=;
        b=YcIBI5mPbRH3vbYwQ8zi3VCAH1z3R4IffiKDEyj/hh8UHEOqL6e3JFJUFTEeNEtDOM
         RbXEQBm8sB+3vUxbz39g4VnYiu4+ritzwBIGgRxx0E76W6IF4wky9W5B0lQ9Jsyz6IRs
         HvcidFURvoHrLKS/uwde2JxJfK5QDMQJzk1zDE6LV+lv2rR8GETokWJvz2QRGStYVBI5
         LILZZDDltMqMfatnM9yCB4J02w8QkYQIke5dGiUPpMXjac7iuzsReoegwCrNxdPI+DGF
         EB/vWsYdtmD+LHCJoJFcLvu9a9OKoKbYRYXlFv62LNeDWAVNx3aqYjqfJcLyUCrGi5gI
         gTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MsFfEFI3EQjrWU87HKolFgqeg0W+Q9yqLl0t6mKPYoU=;
        b=gGnZQCLmgohBAp1Y7iNb2WNJjZPV9cmu9Qxdd7nOAt5twWtWOseDJkMzEaNQWS0nD4
         GUdeSTG1m4oYrH9CV5VZL2AA6PQjALUfK+g8wBwc2dQIHCX8l2j3lwM1Q3CDvNL0Rx//
         z6JbKEORtmw/YxxCsFC4WaCFQdKwEB35jhli3bbxMiAfL8wpOu+uTHoMXitrFxVK40sP
         8LVpmtbAKopK4MvbVPmja7NRt1W43zWblUVSrvFhLkxcW1njvSvLEy69dHHtAzfmQ7f7
         wN9u0RUuRNQ8KsC5RH4ldkHkkQQoMGZPsXeE/qQDUxL581/zSzEYXA7C6TBY/4HlSreW
         FBTg==
X-Gm-Message-State: AOAM531YxikTVFyhIgfZmjiq/klPuc0XsuYr38I/l/obDAgoOptYtdO3
        siEcjRm1eDG+0w/fZkDP1bz/QRBeThRQ
X-Google-Smtp-Source: ABdhPJy5do3Sbmfxi+QNnwyPdb0D9/69Jhrg0odBeOn3U999UmbV3Sm9yri1znWKR5dXTBubJAvl9/MC5twr
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:55c6:: with SMTP id
 j189mr5919161ybb.253.1601674971946; Fri, 02 Oct 2020 14:42:51 -0700 (PDT)
Date:   Fri,  2 Oct 2020 21:42:51 +0000
In-Reply-To: <xmqqtuved70y.fsf@gitster.c.googlers.com>
Message-Id: <20201002214251.76114-1-shengfa@google.com>
Mime-Version: 1.0
References: <xmqqtuved70y.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
From:   Shengfa Lin <shengfa@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> [...]

> Regarding the implementation, the posted patch to "git commit" uses
> the "futz with TZ early inside the git process" approach, but I
> think we should not do so for another reason.  Our setenv() may not
> be early enough---before the code that decides to call a setenv()
> is run, there are many things that are outside your control (like
> the tracing subsystem, repository discovery, etc.) will run, and if
> any of them does something that triggers tzset() to be called, it
> will be done with the value of TZ the process started with, and our
> setenv() that happens much later won't have any effect to it.
> 

Setenv for TZ early in the git process even at the beginning of
cmd_main does not set TZ for things run earlier. In this sense,
user setting TZ themselves would be consistent. On the other
hand, we may not require "things" run earlier to have consistent
TZ depending on whether user time would be exposed.

> Another thing is that setting TZ ourselves would affect hooks and
> other programs we spawn as subprocess, which may or may not be
> desired, depending on the reason why the user is forcing UTC.
> 

Should not setenv for TZ bluntly because of risk of undesired side
effect

> All code that create object headers like committer, author and
> tagger lines use the same git_author_info() and git_committer_info()
> API, I think, which eventually goes to fmt_ident(), and they produce
> a pair <number of seconds since epoch, offset>.  This gives us an
> entirely different opening to tackle this issue from, because the
> "number of seconds since epoch" part won't change the value no
> matter what timezone you are in.
> 

A good candidate for handling in a centralized and controllable
manner.

> You can let the existing code produce its natural result and then
> when the "force UTC" flag is set, override the offset part to +0000
> if and only if the timezone was obtained from the current
> environment (this if-and-only-if is necessary, because you do not

I don't understand "if the timezone was obtained from the current
environment. How do we tell? getenv("TZ")?

> want to rewrite and force UTC when you run "git commit --amend"
> without the "--reset-author" option to update a commit that was
> created somewhere else to UTC).  That way, we do not have to futz
> with TZ environment or tzset.
> 
> Just something to think about.

Does this mean we need to make sure "git commit --amend"
without the "--reset-author" will not trigger regeneration of
timestamp through datestamp in "date.c" but with the
"--reset-author", it will?

Preferable not to futz with TZ environment.
