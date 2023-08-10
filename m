Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDFFC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 23:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjHJXVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 19:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjHJXVS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 19:21:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6341B270F
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:21:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bd94d2df89so18098705ad.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691709678; x=1692314478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrmkxCr8eFfq4tcgzpcMZ6+FGQkVXLKBjX7ThnY4ChA=;
        b=ueS/lsmNPUA1xFggMOZytyKfZsSuPefdktdhrsLaIv5sBSL+lFCOG90wS1jhExz6e+
         N9WjIpPj/0KBRq0ZYf0HCwgEffAwdAnCaKFkca6G6CTEmHV7ZlR76rK4SIOQU/0hqwFn
         fd6BVfQOPcCzv9qseZgkY6XlZ5S4JjdEzrF4wiZU4ul/iDvEZ6qN0PYe/yzSCJWCNIyM
         EbGvbjcypuNqRYoE8ZbPgSuOD2VDrD19ebuZJjdR+XrXUzSMW/pXVApukatO6GZcoIl8
         4bibS/+hwlpcph0+83NC6pn8EcZ9grh9/p5bFao1Rp7AV/ejeH4VoXt9RWUJMi4VXGmP
         G5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709678; x=1692314478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrmkxCr8eFfq4tcgzpcMZ6+FGQkVXLKBjX7ThnY4ChA=;
        b=TAIjy1Cqq8NB/4Z7SWlNBhGmO0EGtpVas/8NW4MJ/sFlEkwArDmCKYueebH+kpM29N
         /x2UoqvfMILo8fCZlBGFfoZ3uQInvUyJ73nXwGflZQxWLdJbS3i+zf5r7sQWTqOA9jsr
         MXSs539zUcvE/HcrngKS+eb0FPJ73J4V6qGyw2ZY08viqUBhrOfuXunsyhgk3Dmnfs4e
         zeJaNIsuapedPARfSqNXWuGWSDDYac579UarOTRFegMJXiai4IfGbrbSdj5Wwlw767EV
         w8/UoIyF6uwrWYQzkPTXcRjBrGjFMzJmamUbyCov+1rjEd1xKz5OWHQTBSO9/loACuWV
         NlKQ==
X-Gm-Message-State: AOJu0YxCb//omEs4kzOLpPvzBslyzzBnb7kLEINsxJWkMfe8l/4b3yp+
        Tej0yylFqhrOC/7GLzl3NOFG9OfCpTM8/w==
X-Google-Smtp-Source: AGHT+IGe80S8ym3+UvtKQsCObWkAOpPU4aW3INCHFVbSDq2hRCx8lUwC574Qmq2npEVv5NN0/AwvPxNWXd97zQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a17:902:f349:b0:1bc:a3b:e902 with SMTP id
 q9-20020a170902f34900b001bc0a3be902mr71204ple.3.1691709677872; Thu, 10 Aug
 2023 16:21:17 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:21:16 -0700
In-Reply-To: <20230810163654.275023-4-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com> <20230810163654.275023-4-calvinwan@google.com>
Message-ID: <kl6ledka8owj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v2 4/7] parse: create new library for parsing strings
 and env values
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While string and environment value parsing is mainly consumed by
> config.c, there are other files that only need parsing functionality and
> not config functionality. By separating out string and environment value
> parsing from config, those files can instead be dependent on parse,
> which has a much smaller dependency chain than config.
>
> Move general string and env parsing functions from config.[ch] to
> parse.[ch].

An unstated purpose of this patch is that parse.[ch] becomes part of
git-std-lib, but not config.[ch], right?

I think it's reasonable to have the string value parsing logic in
git-std-lib, e.g. this parsing snippet from diff.c seems like a good
thing to put into a library that wants to accept user input:

  static int parse_color_moved(const char *arg)
  {
    switch (git_parse_maybe_bool(arg)) {
    case 0:
      return COLOR_MOVED_NO;
    case 1:
      return COLOR_MOVED_DEFAULT;
    default:
      break;
    }

    if (!strcmp(arg, "no"))
      return COLOR_MOVED_NO;
    else if (!strcmp(arg, "plain"))
      return COLOR_MOVED_PLAIN;
    else if (!strcmp(arg, "blocks"))
      return COLOR_MOVED_BLOCKS;
    /* ... */
  }

But, I don't see a why a non-Git caller would want environment value
parsing in git-std-lib. I wouldn't think that libraries should be
reading Git-formatted environment variables. If I had to guess, you
arranged it this way because you want to keep xmalloc in git-std-lib,
which has a dependency on env var parsing here:

  static int memory_limit_check(size_t size, int gentle)
  {
    static size_t limit = 0;
    if (!limit) {
      limit = git_env_ulong("GIT_ALLOC_LIMIT", 0);
      if (!limit)
        limit = SIZE_MAX;
    }
    if (size > limit) {
      if (gentle) {
        error("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
              (uintmax_t)size, (uintmax_t)limit);
        return -1;
      } else
        die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
            (uintmax_t)size, (uintmax_t)limit);
    }
    return 0;
  }

If we libified this as-is, wouldn't our caller start paying attention to
the GIT_ALLOC_LIMIT environment variable? That seems like an undesirable
side effect.

I see later in the series that you have "stubs", which are presumably
entrypoints for the caller to specify their own implementations of
Git-specific things. If so, then an alternative would be to provide a
"stub" to get the memory limit, something like:

  /* wrapper.h aka the things to stub */
  size_t git_get_memory_limit(void);

  /* stub-wrapper-or-something.c aka Git's implementation of the stub */

  #include "wrapper.h"
  size_t git_get_memory_limit(void)
  {
      return git_env_ulong("GIT_ALLOC_LIMIT", 0);
  }

  /* wrapper.c aka the thing in git-stb-lib */
  static int memory_limit_check(size_t size, int gentle)
  {
    static size_t limit = 0;
    if (!limit) {
      limit = git_get_memory_limit();
      if (!limit)
        limit = SIZE_MAX;
    }
    if (size > limit) {
      if (gentle) {
        error("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
              (uintmax_t)size, (uintmax_t)limit);
        return -1;
      } else
        die("attempting to allocate %"PRIuMAX" over limit %"PRIuMAX,
            (uintmax_t)size, (uintmax_t)limit);
    }
    return 0;
  }
