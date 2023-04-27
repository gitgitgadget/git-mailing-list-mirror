Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751BC77B7C
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 23:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344263AbjD0Xhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344262AbjD0Xhc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 19:37:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321173C17
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:36:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-64115e69e1eso6528504b3a.0
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682638604; x=1685230604;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BScHSNvD1R/6N7nk52BBWVwSQX7dt/Rw0/7FxQW1UPM=;
        b=YBv/rGGKE3Q9jgczLPuSkZ83AekCepgICTm6EZXyF8Wi9mNX2O40y1ZyeOiKlZK3Au
         1YufkBgn81DJX1g4w3gNYlJRoiT6mT/bWcwhxV0oAzNK2x+h80riURmE2YQwJUeTYoo+
         8AveAr+/qiOiBRALxPUGB56gcK5I3BP2MPH5JpDRxEBWSW/cmARresgE178SQ9gKxTaT
         77eNFytbzPtJZ6siUXE7fkzz7VW2Bcn0xUNoz2QmVIF8RISWrCGuZClpTWncBETJtV3S
         0xIkainXt5+ES5gmKwFYCiBCar1A0JaCitVX4bvX7C+wpvLV7wgWbRTCdmQsIxXSxDpT
         ChUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682638604; x=1685230604;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BScHSNvD1R/6N7nk52BBWVwSQX7dt/Rw0/7FxQW1UPM=;
        b=I5Ggflo6Nk7nzSkq5FzpWDfSkD2xoSCxSEVBimQraypvMmg0qd9R4rEVo99S+2Du+M
         P2hzYdANs2KbmHwY38Dnpocl9EA8JV1F+ZVi26IIOCQdzUwKD1TVx7HMQDfMHSxug28N
         zQkdvfBONxQDj3XXHa7AIX/CpA5YXdkPN1GvylLIdO9HOcelpbs9sZjWPSAGfn1WTJ1A
         uw9AD55FRAJtJ8uv1BVUW5lL2SrRs62glhEAhLzD+L5aGm1fZoYk7vGQ98NXgqtwDTf4
         t6WKpPhDP5iBDd/lal12JxjobIPsaJGRbVF1EjVClEYmkjRRh69J+xAZL3ZodM+/W+Fe
         mEnw==
X-Gm-Message-State: AC+VfDwEPx0aWUG/sVzhpwD2gDsd0quXD0g0lA2vWUx7WJQQ/g2zEnIl
        QrHX9c+fCW/PmtMVl+AQMga4w9Ecl4HPbA==
X-Google-Smtp-Source: ACHHUZ45YsEbkgqWGmDbHc6EbpUoGyyJHV7ob8nHa0TNXyRdh8wQqdpVscG7pfdTGVAd0C8c9RKl4tKzB0SDAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:90a:9005:b0:24b:6d01:584a with SMTP
 id i5-20020a17090a900500b0024b6d01584amr2283777pjo.0.1682638604410; Thu, 27
 Apr 2023 16:36:44 -0700 (PDT)
Date:   Thu, 27 Apr 2023 16:36:42 -0700
In-Reply-To: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Mime-Version: 1.0
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Message-ID: <kl6lcz3onbhx.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] setup: trace bare repository setups
From:   Glen Choo <chooglen@google.com>
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> From: Glen Choo <chooglen@google.com>

I can confirm that I did write an initial version of this, which Josh
cleaned up for the mailing list (thanks!). Most, if not all, of the
mistakes are originally mine.

> To make this transition easier, add a trace message to note when we
> attempt to set up a bare repository without setting GIT_DIR. This allows
> users and tool developers to audit which of their tools are problematic
> and report/fix the issue.  When they are sufficiently confident, they
> would switch over to "safe.bareRepository=explicit".

One alternative to this is to trace all of the repository setup process.
E.g. if we traced the data points in t/t1510-repo-setup.sh, like GIT_DIR
and whether the repository is bare, you could reverse-engineer whether
we've hit the "set up a bare repository without GIT_DIR" case, but
that's significantly more complicated. If the goal of this patch is to
make it easy for users, tool developers and sysadmins to see if
"safe.bareRepository=explicit" might be tripped, giving a single,
meaningful event is much easier way to get there.

It would be nice to trace all of the repo setup eventually, anyway, and
I don't think this change precludes that.

> Change-Id: I8e8b5e70ce8c6c81ec4716187c27c44da38b35db

Leftover from Gerrit, perhaps?

Unsurprisingly, I don't have comments on the diff, at least not anything
that Junio hasn't already spotted.
