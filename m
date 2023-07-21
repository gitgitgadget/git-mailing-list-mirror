Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF950EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 18:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGUSed convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Jul 2023 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGUSec (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 14:34:32 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1873EB
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:34:30 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6348a8045a2so16097766d6.1
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 11:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689964470; x=1690569270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dg8Drxz4Jg9E0L6QQocjno+OIwYSN5e0rEbcOSsj/fE=;
        b=S8M6BjDLirK+OQUBQufBC8BrpGylCGYBmgYNkoa5CVV454dtvu9Te55LkIjrdTVkuI
         gkTmcSpw0ml0VIAKXyL5QhmVM24dHumFbOLKZKq5PvWlmPMzWNEbnP3NfGzP8I7fHF0/
         af20diiY87gRX06ZXkC9zCBHu5vM/jip22oNME7hPEievOZlstDjHB10mB3HMQvh4eab
         ArKrThlsrEYRBH+3WTye500gsLxm6rTas0V7n9CAzskRn/kribY4BZ29nGfs51mw+ctT
         M0Wqn5GuVr6DqhQyj2GMnUZcuDHyleq4dlxsE5ApdG9EY9nwfumpqQa52/zMk7EbkKDs
         I4Ng==
X-Gm-Message-State: ABy/qLYIhVkpiQxyZSsPIogIn+lcBw5BfJimj3Xe6r40r5nSnEJpGFmn
        fI2cFRRSRvNN4OPWbQwdxKc9aK443y35bu61XrE=
X-Google-Smtp-Source: APBJJlEBYZT3V1MgVDbobGhzChQdavbsA93KdWi6GxBJ/F2bbd5aiNGBFACVjLB0HS+mbOkDYHU+coJeNNIYTek4mEQ=
X-Received: by 2002:a0c:f24d:0:b0:636:34e2:fada with SMTP id
 z13-20020a0cf24d000000b0063634e2fadamr898820qvl.23.1689964469651; Fri, 21 Jul
 2023 11:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689960606.git.me@ttaylorr.com>
In-Reply-To: <cover.1689960606.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jul 2023 14:34:18 -0400
Message-ID: <CAPig+cR8S_fEvZfMb=_hHOMy+_Q_MbvRaYcZbp678x7G7E=TQA@mail.gmail.com>
Subject: Re: [PATCH 0/5] commit-graph: test cleanup and modernization
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2023 at 1:31 PM Taylor Blau <me@ttaylorr.com> wrote:
> This short series addresses a few style nitpicks that I noticed while
> looking through the commit-graph tests while writing [1].
>
> Most importantly, it removes many instances in t5318 that change
> directories outside of a sub-shell, altering the current working
> directory of subsequent tests. This makes it difficult to run a subset
> of tests, or otherwise include `cd "$TRASH_DIRECTORY"` at the top of
> each test.
>
> The first two patches are predatory, the next two are the substantive
> test clean-ups, and the final patch cleans up some intermediate state
> necessary to perform the clean-up over multiple commits.

Nice to see this being cleaned up. I had tackled this script, as well,
back in November 2022 as part of an unsubmitted patch series which
removes _all_ unprotected `cd` commands from all test scripts. t5318
was one of several particularly egregious cases.
