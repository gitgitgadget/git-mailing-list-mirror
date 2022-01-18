Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A1FC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbiARV3H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiARV3G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:29:06 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2024CC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:29:06 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w7so310688ioj.5
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eOXaZVfxaaRAp0pmKaqHZAGwzyc41GUIUaOwacTNd14=;
        b=Hpy6oqHLapPI0Vsw1Lc/7vCzEG6B6ZxF6thj5cnKOw4i91nNDQ9RobayJxJVyT1jUX
         awLgfM2pyFwTeUw2kIMoVWF1y7oRanfNKC5UaRj0TqTkJKTJyOSp++hnxifIlXUNdOeV
         IAu/MhRNM9Pvt8TYN8pODbcOGykc/Zm8nUND+mORfwGQMW2Da8PEziV6qtgx67eTRMaE
         k+QiWKPSbGWfeMl26wSHcQexgQoirhBKVoeIbUzdBKVHjQlor5hMCyQdifJqIxoYroB7
         wW8UlaWHPbTt+Ria/nT8Q2mBMzOgygoZJ8hj1stfv0tf4zfH8kx4NC3FQL7QIvwdMyGO
         p/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eOXaZVfxaaRAp0pmKaqHZAGwzyc41GUIUaOwacTNd14=;
        b=bSTM3SkrwpCKFH1PzKGtz58NpuL2ZReHNU/K2AwS0H1niHw9iM8XY2+xZWL55Yg5WZ
         Qb6BIKiFTYIIsYIVOVUDU/pObc62hLyLF0ji4ddnFJPIHIMqbYVVnegRwPv/WtpT1n1j
         LuvnIK97P97OEM97w8V+4zNR5IHbdy5X168CVrNKT2r+pUn0ZcsOkqT/Vi1mZ+4zNn2j
         k5KLmT5DH5Xc+paGrwVonjt2sHHkI/l5NplHa9pWYjULVsbKtkgABDxKfKxYswX42j7y
         mYr9Gj2HZ15VtpUeKCeGeNSDvdlXyg7dDi9d8f5Fj1xLTV58uQVAR8ggpY4kYOlt0epf
         iMww==
X-Gm-Message-State: AOAM531Y5L2/HbuJP/5nPGyKzQp8x6Th1rWE8fhdM3hTB0X63VXHYOgg
        GmR6DhzZN8aTr+1LkhzgLI1utA==
X-Google-Smtp-Source: ABdhPJyEhM6D91xxaqWHGGFRN0y1C23uTyogfBjbG9hmWqgzk9j4SPsqqUFLofhKLwFWed4hu/Kz/g==
X-Received: by 2002:a5e:8608:: with SMTP id z8mr13178142ioj.58.1642541345433;
        Tue, 18 Jan 2022 13:29:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10sm11615115ilc.73.2022.01.18.13.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:29:05 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:29:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: unset trace2 parent envvars
Message-ID: <YecxIJpaAzXRjGJG@nand.local>
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
 <xmqq35lqetzw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35lqetzw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 10:01:07PM -0800, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
>
> > This behavior breaks certain tests that examine trace2 output when the
> > tests run as a child of another git process, such as in `git rebase -x
> > "make test"`.
>
> Well explained.  The paragraph makes it clear how easy to trigger
> and get bitten by this problem.
>
> > While we could fix this by unsetting the relevant variables in the
> > affected tests (currently t0210, t0211, t0212, and t6421), this would
> > leave other tests vulnerable to similar breakage if new test cases are
> > added which inspect trace2 output. So fix this in general by unsetting
> > GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in test-lib.sh.
>
> This probably makes sense, but I wonder how it interacts with a user
> who runs "cd t && GIT_TRACE2=blah ./t0987-test-this.sh" to trace the
> entire test script, though.
>
> > Reported-by: Emily Shaffer <emilyshaffer@google.com>
> > Helped-by: Jonathan Tan <jonathantanmy@google.com>
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  t/test-lib.sh | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 0f7a137c7d..e4716b0b86 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -449,6 +449,8 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
> >  unset XDG_CACHE_HOME
> >  unset XDG_CONFIG_HOME
> >  unset GITPERLLIB
> > +unset GIT_TRACE2_PARENT_NAME
> > +unset GIT_TRACE2_PARENT_SID
>
> Hmph.  Have you noticed the more generic "We want to unset almost
> everything that begins with GIT_, other than those selected few that
> are designed to be used to affect the tests" above the part you
> touched?
>
> I am wondering if we should tweak the list there, instead of special
> casing these two and these two only. There is a pattern that allows
> anything that match "^GIT_(other|TRACE|things)", and I suspect that
> the pattern is way too loose (i.e. it allows any garbage to follow,
> and by allowing "TRACE", it also catches "TRACE2" because the former
> is a prefix of the latter), which is a problem.

I was thinking the same thing, but I suspect that this may truly be
different. That list says we should be able to keep anything that looks
like GIT_TRACE in our environment. So the same should be true of
TRACE2-related variables, I'd think.

But the PARENT_NAME and PARENT_SID variables are (as far as I can tell
from reading around) internal variables that help us piece together the
names of the Git commands we ran.

In other words, excluding all TRACE2 variables goes too far since it
prevents us from being able to `GIT_TRACE2=1 make test`. But we would
want to clear out any internal TRACE2 variables such as PARENT_NAME and
PARENT_SID.

Thanks,
Taylor
