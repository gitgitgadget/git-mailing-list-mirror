Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87802C433F5
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637F261216
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 19:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhKET2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 15:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhKET2J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 15:28:09 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0555C061714
        for <git@vger.kernel.org>; Fri,  5 Nov 2021 12:25:29 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e136so22044195ybc.4
        for <git@vger.kernel.org>; Fri, 05 Nov 2021 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INLvjVLd5BVEq5l3kDUHNcPkQG4AgB9EZAlTMoNo/vY=;
        b=G8cKzhHb4Q7GzKh5fDx5B5uckmtKR3bxQQKmgz0RAKGTY5FQ7xAh6X0YC+gKKm3KSZ
         TfLnJkf1md7WW3LyzhPPWmC9Y6HhCDAeCyJelRxzh8QB2TDrMQoOUUIuLauBT6Pfyvum
         7dO4LlmgjwtqPdWvNm8zMF14Thoqw+747lxnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INLvjVLd5BVEq5l3kDUHNcPkQG4AgB9EZAlTMoNo/vY=;
        b=D9f2oWpuKYTXwJRS11JpfVYSPiwjC5JDOz6k1UIcMprNgJmeR1kZxkXtdUcwuGrSaX
         hEkStQ9rT5i9RD6lPz/TaarW2dJJ3VjjTomxsEPXq+QySqdD08ugG4lLuXoS2JbkC2bm
         LbN1qeX8XA+IlHrpqCENncP7sw9YiSBgQKvtcFC1LJHnBDjGFfxo0v168kqFvQtbJtn+
         T8KhpHrT8/bCDDsiqvBi+PtlI10vZANhOqlgCVf+9osqJJw3BmfI+vDtj7EuBZ+15IB3
         GjQ2G7FMgzlKpW9oj8F0nT+6AKfPe3t2WKboHzGd+vFZ1U+r87rD+T1ZdbCWNxfdxERu
         3Exw==
X-Gm-Message-State: AOAM532mcJ3xggBgvJzakOuoh3WOwTImbnGtOCgMnRrhlMeQz1uRWkQA
        3FtvsBLMnhevJYSpyzpEkqvb8SsG+YdDnYfYQDS6F8sXWvo=
X-Google-Smtp-Source: ABdhPJwPpznDw+fHc2RWf6mPqrZqrHO+Qy5yABPwq26wTJYVTPrMePwquL9wa1O9sf6+LcYYbBNGODT4vrlf1u+gzWA=
X-Received: by 2002:a25:b294:: with SMTP id k20mr63265715ybj.232.1636140327456;
 Fri, 05 Nov 2021 12:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211104192533.2520-1-adam@dinwoodie.org> <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org> <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g> <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
 <xmqqv916wh7t.fsf@gitster.g>
In-Reply-To: <xmqqv916wh7t.fsf@gitster.g>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 5 Nov 2021 19:24:53 +0000
Message-ID: <CA+kUOamwQmK6te66sE+EVLPhwmBFZ+CXC9p=HJ4y0KC0wnkNsQ@mail.gmail.com>
Subject: Re: [PATCH] t/lib-git.sh: fix ACL-related permissions failure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Fabian Stelzer <fs@gigacodes.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 5 Nov 2021 at 19:11, Junio C Hamano <gitster@pobox.com> wrote:
>
> Adam Dinwoodie <adam@dinwoodie.org> writes:
>
> > This is probably a much broader conversation. I remember when I first
> > started packaging Git for Cygwin, I produced a release that didn't
> > have support for HTTPS URLs due to a missing dependency in my build
> > environment. The build and test suite all passed -- it assumed I just
> > wanted to build a release that didn't have HTTPS support -- so some
> > relatively critical function was silently skipped. I don't know how to
> > avoid that sort of issue other than relying on (a) user bug (or at
> > least missing function) reports and (b) folk building Git for
> > themselves/others periodically going through the output of the
> > configure scripts and the skipped subtests to make sure only expected
> > things get missed; neither of those options seem great to me.
>
> I agree with you that there needs a good way to enumerate what the
> unsatisfied prerequisites for a particular build are.  That would
> have helped in your HTTPS situation.
>
> But that is a separate issue how we should determine a lazy
> prerequisite for any feature is satisified.
>
> "We have this feature that our code utilizes. If it is not working
> correctly, then we can expect our code that depends on it would not
> work, and it is no use testing" is what the test prerequisite system
> tries to achieve.  That is quite different from "the frotz feature
> could work here as we see a binary /usr/bin/frotz installed, so
> let's go test our code that depends on it---we'll find out if the
> installed frotz is not what we expect, or way too old to help our
> code, as the test will break and let us notice."

I can see how they're separate problems, but they seem related to me.
If OpenSSH were not installed on my system, Git would be compiled
without this function and the tests would be skipped. If OpenSSH is
installed but the prerequisite check fails, Git will be compiled with
the function, but the tests will be skipped. In the first case,
function some users might depend on will be missing; in the second,
the function will be nominally present but we won't be sure it's
actually working as expected. Both issues would be avoided if the
tests were always run, because suddenly both sorts of silent failure
become noisy.

I'm not actually advocating that -- running all tests all the time
would clearly cause far more problems than it would solve! -- but
that's why I'm seeing these as two sides of the same coin, and
problems that might have a single shared solution.
