Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F929C3DA6F
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 18:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjHXSkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Aug 2023 14:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243034AbjHXSkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2023 14:40:39 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D35E50
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:37 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-592976e5b6dso704137b3.2
        for <git@vger.kernel.org>; Thu, 24 Aug 2023 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692902436; x=1693507236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x09GLFkT/jkqyS2REqAfNWesaN5PRBZhQfNdoz7zxIk=;
        b=X78UaMlWFSqH/WD6nr3ZZLpEqdW0qkMsKh8dtwUe1ntesO5tRNWYQ5FoEMaRJmMyY9
         GOHIRNkAGh4POqQ12ystta11qdYKnxJCvFhqZF4NK2YqhErFfpGdm1GEebQmguFUoWQ3
         +glCAF3rT1qd+A8bOanX7bG+Jw1pFyKJN4FKfnq6hM8pwS+QSwmGxCoBUjv0m9JUoJ+f
         FS4bPUkQ5/KhGR5zlDrhDKCd2VKPb6fOQq0C96sKZ0brV18iqzhatV4qcUm9egUsCdgC
         NrjgQlMD9mxIJMZ6IL/3UNxY8Qb4vqNZYs9hRN0rYBO6ukKlp+2NevYKPUgzRl/7zDI5
         Zd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902436; x=1693507236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x09GLFkT/jkqyS2REqAfNWesaN5PRBZhQfNdoz7zxIk=;
        b=l3T9E2ZLgC+LtiMOeBm0gRwBdgIZqunjCwoPFh0RnqpV4FR2LYzfP900s9xIeK1BDm
         U2zbcOYX0vBHfKPf0XRZmXXg3GlXbBLImjDYcrqNptskqtrGGiLA8tku9do3pn3vQmeI
         4TSgJyt4IMxBvwZ+DlZ3jch7n56UpNyYAexsY8br5h9LM9iuYmP/rGO9YKByoz9tQdob
         UITssyGm2x3yS8xOhUL+nRXM3Ax6achIpT4LP84ZiVLp2hsxfdBmq7zffO0ymbnn2efX
         Yckfjuq6SjTizVrMWCXJztdBP3+ffVw79QZ8UVoKJ7j8clWQDQttwGe6YFNe4epqWUH8
         Plwg==
X-Gm-Message-State: AOJu0Yzfpgi9bm6d3la0NklTXb+rlzPQSCwm0gHLNwa8pR/28j4Gdd9u
        xX94MEl0fn8J8HPyIerz2gX5jAZyySKQeAjqB3VXVg==
X-Google-Smtp-Source: AGHT+IEKw6fgcTfrklW0J07V8f2Wlq3S/JDft+Lc2flMnSaWXm6KL58cFxDJ5fJZ9OZpZ9sqMf1PnQ==
X-Received: by 2002:a0d:cb89:0:b0:584:6d71:f465 with SMTP id n131-20020a0dcb89000000b005846d71f465mr17232182ywd.12.1692902436365;
        Thu, 24 Aug 2023 11:40:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x3-20020a818703000000b00570599de9a5sm38249ywf.88.2023.08.24.11.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:40:35 -0700 (PDT)
Date:   Thu, 24 Aug 2023 14:40:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
Message-ID: <cover.1692902414.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on another topic that cleared up some leaks, I wanted to
see if any new tests became leak-free, so I ran:

    $ make SANITIZE=leak
    $ make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test

, and was surprised to see so many tests appear in the "failed" list
(indicating that they are free of leaks, but did not mark themselves as
such).

In fact, the patch I had written at the time didn't make a dent one way
or another in the list of leak-free tests, as the same results were
produced on 'master' without my changes.

This series marks all leak-free tests as such, meaning that the above
"make test" invocation will pass after this series. The bulk of the
tests which are marked here in the first patch were always
leak-free[^1]. The remaining two patches address a couple of special
cases of tests which are also leak-free.

Thanks in advance for your review!

[^1]: At least as far back as v2.38.0, when the "check" mode of
  GIT_TEST_PASSING_SANITIZE_LEAK was first introduced.

Taylor Blau (3):
  leak tests: mark a handful of tests as leak-free
  leak tests: mark t3321-notes-stripspace.sh as leak-free
  leak tests: mark t5583-push-branches.sh as leak-free

 t/t3321-notes-stripspace.sh | 1 +
 t/t5571-pre-push-hook.sh    | 1 +
 t/t5583-push-branches.sh    | 1 +
 t/t7516-commit-races.sh     | 2 ++
 4 files changed, 5 insertions(+)

-- 
2.42.0.3.g4011eb6a8b
