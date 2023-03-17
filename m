Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5914BC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCQUmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCQUmI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 16:42:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A517555506
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:42:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5416d3a321eso57804587b3.12
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679085722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbWhBANpPeWjWucB2Qi3RvqwQNqv+H3bjHOe3c8ZLyQ=;
        b=AWXisJA90v4j5DVB3cfFKxmStt0XYrdtV7n2SlYc3QNb/HVlQrjoRT4LNaihx22rQO
         QXDx/tg8QbrSa2tNU5PIiK4ZqmgLtc1UcIUdr7DNYCk6B6okUw8oJGWsFFVsGRCj7+fY
         Ze89f42Z+S9N2+DAeaV96ICMnSYVZXqUyBzSVOyIxjoBATs3sPKvFGIne46SolC0OaCl
         QmlC2eZVr00gJc5R1mx/0W20yGuQxZzM7iNm+WfEAyGu0gMbtphQk6JuA5S/mWuBl8Ss
         GYSft+Hmw8y1XuOpxwFPSlNT/QctW0b+IiRZ7M3oG4Lmo5pz67fsHM4aaWH847JWT/qF
         QLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679085722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbWhBANpPeWjWucB2Qi3RvqwQNqv+H3bjHOe3c8ZLyQ=;
        b=eW2UBZUVlHGWZMIH9+PDCah9sZflz0kUav4ub/mRU3VHu/E10w+ZuxwXfXZPJ+qmNP
         447BdzR3VWAWpMohrW+CfR22Zzx0ON3P0DIGowkDJA2IEq2eYA4eDtT3QHwXc1TsWi0T
         H5B81l70PPNy8VrsX1HjZzk3mq7dc2BFrlkRSLD96LuVx+wuxkrSKjbfjxMfbQoMDPkt
         fSH6Q/RkRikV00igPl08/4zKad7PJgDT3p+qZpKobIhDTJTNlzkubTHcvhA8Jy+7xLFX
         BWTBjWdcjD/EH5PRWxvfdKkx53aycDI5aSnW3aDWduRRUJJM9z2ys15s3xyut7M7xolP
         mhCg==
X-Gm-Message-State: AO0yUKXwNVGiaLSjf6PHBocEC6kPfP+rp1bHrtFHfRcvSjwzcGPV6Zl+
        dcrTPhUG9M27xxRxxQZlX2DTxkE5xxSAEg==
X-Google-Smtp-Source: AK7set9VEDGd3574SFhUvEatnMiOCimY9rwc1AuOpniEdpifq4rrrxdPzBnHdGYrwUBtyJkpLbLd5Oc0WyPncA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:e508:0:b0:544:5fc7:f01f with SMTP id
 s8-20020a81e508000000b005445fc7f01fmr5108705ywl.4.1679085722727; Fri, 17 Mar
 2023 13:42:02 -0700 (PDT)
Date:   Fri, 17 Mar 2023 13:42:00 -0700
In-Reply-To: <20230302220251.1474923-3-calvinwan@google.com>
Mime-Version: 1.0
References: <20230209000212.1892457-1-calvinwan@google.com> <20230302220251.1474923-3-calvinwan@google.com>
Message-ID: <kl6l7cvfun3b.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v9 3/6] submodule: move status parsing into function
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, avarab@gmail.com,
        newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> A future patch requires the ability to parse the output of git
> status --porcelain=2. Move parsing code from is_submodule_modified to
> parse_status_porcelain.

If my mental model is correct [1], i.e. that we are implementing a
parallel version of is_submodule_modified(). I think we should be more
explicit in this patch and the next, e.g.:

  In a later patch, we will implement a parallel version of
  is_submodule_modified(). Refactor its "git status --porcelain=2"
  parsing code so that we can reuse it both the parallel and
  non-parallel versions.

If so, then this is pretty much doing the same thing as the next patch,
so if the --color-moved diff isn't too bad, I think we can squash them,
which will make the commit message easier to write too:

  In a later patch, we will implement a parallel version of
  is_submodule_modified(). Refactor its setup and parsing code so that
  we can reuse it both the parallel and non-parallel versions.

  - Setting up the subprocess is moved to prepare_status_porcelain()
  - XYZ is moved to verify_submodule_git_directory()
  - ABC is moved to parse_foobarbaz()

Just an idea. I don't think squashing is necessarily better, but being
explciit that we want a parallel version of is_submodule_modified() will
make this easier to follow.

[1] https://lore.kernel.org/git/kl6ljzzguqss.fsf@chooglen-macbookpro.roam.corp.google.com
