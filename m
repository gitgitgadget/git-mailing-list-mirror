Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A0C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 02:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89317215F2
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 02:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbUvxwtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfK1C5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:57:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33806 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfK1C5t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 21:57:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so6412265oig.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 18:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyS3t8dMr0xmJaGUq9B54r8ajVD64zPyi0VA6jA0sUk=;
        b=TbUvxwtd4voQBLaAYJRyixxuyz9CH3gp8p69ECmjhX58efeXtjDe4uQmpkN+sRrVBT
         zi9aaFzpah04ut3HXdHPhygMpXspPV85LeNJjZ+0qg9Z53OAxa4ioZKFKU28CS92OmTF
         5LVFLI5xCwVn9Kq2a1jA4YU1aeoMy9VIX61xZ72KLagTtxpWvYEqQX3lRYwA7/GuNfoH
         OceXp5g2jtTVMnEq/NiN0e80WsJuRSQJW92Z07yq/uua1Qg9I8ZyP6vkeV9O+YLvGliV
         0cWycMS2kFcgMUPN4BQr2O5cI1x8CnaQfW2rg4ZipdLSUmjgBqM6JAwI8T8aw6mrbG5h
         slAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyS3t8dMr0xmJaGUq9B54r8ajVD64zPyi0VA6jA0sUk=;
        b=q8OhdXoAgJ4Q/m5c7WZJVKBUIX51sVDTjkEuG7uRd8TRpt4bZ9sRfMi5bJCBF2EhyE
         M3+lrd+KYKQEEx3HIiiVQGBe9kOUHv7/e9YHUreLMHnQNdm/8smGXz/lFDBkvT5N2OYr
         AtlPHMn2Mvwzzg5CDNbiNCpgvDm53B2HUJgaM//cmTmpe/VgnPQ6Bj+ui83sS/bDRAV+
         9TjwxElXTVcNYlbFQ6fFbnh7zd5b/b5hRSsntE1XhJtolGgbYFwVMFtirCw64YGA1Y8c
         2U1UvOL42EMUcRJY0k/nkut4eiaFFN7w9xJIvoI5c4228yHr9UyQQFJ6M/FJof7Onfqy
         1k/A==
X-Gm-Message-State: APjAAAXA+16hdC4znaxUcQpb/qcmL93Dcadti9XcZIj04NDDbglxERSl
        MPcE+lCKDky3NxOgwOAnuow0Oo/81uofKUBbg+pohC3O
X-Google-Smtp-Source: APXvYqy4R9Qvvne4TriQZF9thWkmFv3K33FBjoBwo85VeJV+QwkKSki3uXpaQ4KaJ8Wa8YRdgkDfzSXEOncgsRZk88Q=
X-Received: by 2002:aca:4f4f:: with SMTP id d76mr7017630oib.167.1574909866970;
 Wed, 27 Nov 2019 18:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com> <20191128012807.3103-5-yang.zhao@skyboxlabs.com>
In-Reply-To: <20191128012807.3103-5-yang.zhao@skyboxlabs.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Nov 2019 18:57:35 -0800
Message-ID: <CABPp-BEa883U+m1emhZHU4s5EqsJHyRiPvjnsyw6_0guKLUsLg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] git-p4: use utf-8 encoding for file paths throughout
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 5:32 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
>
> Try to decode file paths in responses from p4 as soon as possible so
> that we are working with unicode string throughout the rest of the flow.
> This makes python 3 a lot happier.
>
> Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
> ---
>
> This is probably the most risky patch out of the set. It's very likely
> that I've neglected to consider certain corner cases with decoding of
> path data.

Yes, this does seem somewhat risky to me.  It may go well on platforms
that require all filenames to be unicode.  And it may work for users
who happen to restrict their filenames to valid utf-8.  But this
abstraction doesn't fit the general problem, so some users may be left
out in the cold.

I tried multiple times while switching git-filter-repo from python2 to
python3, at different levels of pervasiveness, to use unicode more
generally.  But I mostly gave up; everyone knows files won't
necessarily be unicode, but you just can't assume filenames or commit
messages or branch or tag names (and perhaps a few other things I'm
forgetting) are either.  I ended up using bytestrings everywhere
except messages displayed to the user, and I only decode at that
point.


Of course, if perforce happens to only work with unicode filenames
then you'll be fine.  And perhaps you don't want or need to be as
paranoid as I was about what people could do.  So I don't know if my
experience applies in your case (I've never used perforce myself), but
I just thought I'd mention it in case it's useful.
