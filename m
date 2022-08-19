Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D8C32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 17:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbiHSRwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 13:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351704AbiHSRvr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 13:51:47 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352D64FA
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:25:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q11-20020a170902dacb00b0016efd6984c3so3097341plx.17
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 10:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=jWZLfDwJzGMJew6UaYiraUN91wgJc1WTUlNXhMB0LyI=;
        b=lXpMwcScFK87M0+62R4GEogaxo0ROVWPKdDcPOme4F3M3+OoROFP2k834Pf0lPKGDp
         hTpTfrPUBAdh+svHgdyUpwMm8ZJ8ILnphScOVsJhCdrH9dFcSHPc8d80hfBAP0U7UaEL
         qHTOBAJ1SQO7b8hTtpwjUIdqDzn4Qhwwu3jw43GswwFOAnq0mROM7QwZVmGaWpkwErUS
         +l4SqmpqQbi30p3xfYbS8zT8P9qzSf8TRJ3urm6qKbpSHke1Xty+QcGzosIQ4OWhRDgt
         u5GT3BO4EVdLTMTg2zj52mJ7n4J+rHllQzcz8QvnelzejR4lA4tNeD8IGdt/Qa5f1DQt
         esGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=jWZLfDwJzGMJew6UaYiraUN91wgJc1WTUlNXhMB0LyI=;
        b=ZzYrEvSATvSTWZMELmye+bvs7Z7nDii8lmHgd41XXagT3gWC5nQy8W+4uuDEdF/Hfb
         hSxfknLImGSw0LLMSMMxilPYOlFxgNdxear7Bi/YemlV3jYDo8CTPljdSlT3jCRaMshr
         WzzEqxy+k20Fzl1Amw1urEC7Wk3dQBLjMUl/kRLCx1HDCVxgw4LpK1NEhUVDNkLg56kY
         zsNxSH2H2FJ1qikibofBzYGtvjzTL0p0YZVt2qlqY8l5JXJWDkUoxzwIvebmnZnUH+hI
         cK97qi/r0Jft0u7CzRYJpXI3rjGPNgsyJtJM2J8QDaKnfMvOucFnlQ4wn7+IdmCYD6AM
         b20g==
X-Gm-Message-State: ACgBeo0qhjpBjnArDS+JaZPGQpV4QXBvuJxxkb2ZTBQbQSwhS7f/jAlM
        KVdFwtIvq5sloxyPAxcJgXo81ZTK76M3R+3ykn4n
X-Google-Smtp-Source: AA6agR7+O1x5uHDBG6TgAHKRCXOJLWve0bBgcsrt8QiV6T5LKlxjB9BsqMKNeSSIVek/a/Wzl6l00RnFtiW0PG8OeT4p
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with
 SMTP id t9-20020a17090a024900b001e0a8a33c6cmr440304pje.0.1660929923125; Fri,
 19 Aug 2022 10:25:23 -0700 (PDT)
Date:   Fri, 19 Aug 2022 10:25:19 -0700
In-Reply-To: <CABPp-BFjxFeGO+NU4HFCGqDe4aRFhqOdOxNYVDf7EJOWdT5RgA@mail.gmail.com>
Message-Id: <20220819172519.3703282-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:
> > Optional: Besides that, from what I can tell, sometimes the C commits
> > themselves are marked with ANCESTRY_PATH (when they are explicitly
> > specified) and sometimes they are not (when they are not explicitly
> > specified). It's not a bug here, but it might be worth handling that in
> > the ancestry_path_need_bottoms codepath (instead of explicitly setting
> > TMP_MARK on the bottoms in limit_to_ancestry() - that way, I think we
> > can also use ANCESTRY_PATH instead of TMP_MARK throughout the ancestry
> > path codepaths, but I haven't tested it), at least to prevent possible
> > future bugs.
> 
> That sounds like you're trying to duplicate the bug in my first
> attempt at this patch.  If you try to coalesce ANCESTRY_PATH and
> TMP_MARK, then you not only get all descendants of C, you also get all
> descendants of any ancestor of C, which defeats the whole point of my
> changes.

Ah, yes you're right.

> It's true that I don't mark implicit C commits with ANCESTRY_PATH, but
> those are always bottom commits that are the excluded end of a range
> anyway.  While those could be marked without causing problems, it
> would always be a waste of effort.

Yes, that's true.
