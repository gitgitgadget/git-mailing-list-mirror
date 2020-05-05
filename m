Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40212C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171F6207DD
	for <git@archiver.kernel.org>; Tue,  5 May 2020 16:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY7+Ly08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbgEEQ7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729553AbgEEQ7h (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 12:59:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2819CC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 09:59:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so1057077plo.7
        for <git@vger.kernel.org>; Tue, 05 May 2020 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9/LEmXaAe73Tvgh3yWd8TVVRbC8qgYdm2A7OdjkcOLY=;
        b=fY7+Ly08/gCUuRiLQ19m2pPg41s+PhMGd7eES1qGQuyjUpQzoISwFilGrrnaVHNFD7
         LhsJpHmtWaI0O8UQX2jnJxrW0fh0PIjJK/Sf2lMwE5KoXXnFo5B7f2dnOGMhWtMjCpq6
         3NE7D6EXMY6wxoVD4QClGkHs7bz0S2AqTYdyVdTfsMduv760b8d9a1/frTZPByyAkqXb
         VGoskybu6az7Gbgz/j41rWvsNkrqTqoRWOLCS+3Q13XmonZYEt3BIG2OZSO+BAsEy66d
         pmM5t13mAoaKsAQ42Twqam+XiEfUPr8T+2mn0Xciwtm3591HaxaxJw+WuthW70gNd1UW
         +gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9/LEmXaAe73Tvgh3yWd8TVVRbC8qgYdm2A7OdjkcOLY=;
        b=H/UV7hcGJYS6fMJQeswpwvtx+R6uYQCxBFSFZSwQu/oEDb8R7f5DqaNHAYCbrn8FTu
         wOohBaINcsNHcL6RhtSL+Eb8cD1y2B/d92fkwUhfQWzBMVhDU3KOMYhzFkh8TBzXfn9R
         /sdSsfdX/Wug5VTu6gWbI5L1tvfd56vkydeDPVRbyj6DEgGgl3qdtTBf7/Bno6SWFO+V
         WC7jwnGptV/R0Z5vVCwtaXJhvY1MdYL0MxfYmDkJstmDZQ6o+hXWkTxHOMBipHZD8NKk
         WKO+zBN1mjw7GDf8trELGNf+LT2PS5uvNiEglrhOU4CWy09WzvXQ8YshuFYylIg8d5TN
         edLw==
X-Gm-Message-State: AGi0PuZGdDcub4kmGiHFFcf7tu8YsctWLiRb4JurXHjPyf2jPRP+iWo2
        amRGFF+Amw+JDIsAdIQjvvI=
X-Google-Smtp-Source: APiQypKCyafRTPKG0wGGfz6KbtoMm2XKgINs+U1CgjLeYbpH/RgYH9q8kH6J/D+z3QWgONvOKiMh8Q==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr1916515pjb.216.1588697975626;
        Tue, 05 May 2020 09:59:35 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id o9sm2518776pje.47.2020.05.05.09.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:59:34 -0700 (PDT)
Date:   Tue, 5 May 2020 23:59:33 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] SubmittingPatches: advertise GitHub Actions CI
Message-ID: <20200505165933.GC927@danh.dev>
References: <cover.1588607262.git.congdanhqx@gmail.com>
 <cover.1588695295.git.congdanhqx@gmail.com>
 <48752d8b164bc0b11f4d82016415811a0b2bf08b.1588695295.git.congdanhqx@gmail.com>
 <20200505164740.GB64077@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505164740.GB64077@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-05 12:47:40-0400, Jeff King <peff@peff.net> wrote:
> On Tue, May 05, 2020 at 11:26:39PM +0700, Đoàn Trần Công Danh wrote:
> 
> > From 889cacb689 (ci: configure GitHub Actions for CI/PR, 2020-04-11),
> > GitHub Actions was introduced as an alternative CI system for Git
> > project.
> > 
> > Let's advertise it to Git's contributors to help them test Git on
> > various platforms before submitting to Git.
> 
> I think this makes sense. Two things:
> 
> > +Alternately, you can use GitHub Actions (which supports testing your changes
> > +on Linux, macOS, and Windows) by pushing into a branch in your fork
> > +or opening a GitHub's Pull Request against
> > +https://github.com/git/git.git or a fork of that repository.
> 
> Probably "GitHub Pull Request" would be more idiomatic English.

I guess you're right.

Well, I'm not native English speaker.
I was thinking, this kind of Pull Request is specific to GitHub,
and it's different from git-request-pull(1), So, I use "'s" :)

> Do people need to enable Actions on their forks for the branch push to
> work? I didn't need to for my fork of git/git, but I'm not sure if that's
> because I was playing with Actions months ago and forgot, or if having
> actions enabled on the parent repo makes it work.

It's a long time from the first time I tinker with GitHub Actions,
I couldn't recall if I need to enable it explicitly.

I look into GitHub support pages[1] and GitHub tells me that
GitHub Actions is enabled by default for everyone, and every repo.
We need to disable GitHub Actions explicitly, if we don't want it.


> When I made a new repository that was not connected, I had to explicitly
> enable Actions on the site before it would run the workflow file.

It seems like GitHub Actions will be triggered automatically if GitHub
finds any files in "$TOPDIR/.github/workflows/*.yml"

[1]: https://help.github.com/en/actions/getting-started-with-github-actions/about-github-actions#disabling-or-limiting-github-actions-for-your-repository-or-organization

-- 
Danh
