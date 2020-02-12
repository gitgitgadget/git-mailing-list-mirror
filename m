Return-Path: <SRS0=D6Hn=4A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3908C352A4
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FF2206D7
	for <git@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="hGaKLfFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgBLU51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:57:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39494 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgBLU51 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Feb 2020 15:57:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so1411315plp.6
        for <git@vger.kernel.org>; Wed, 12 Feb 2020 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UIElGDRto8wx1eLuz3K2EgwPxmZCfbuWYxcjLSpOO/U=;
        b=hGaKLfFZMNlBDTUtl0lziMcgts+yBbjRw09d8nESJpXkz7k58zWZQDKoBsSSu0weN9
         Di5tX7V/L/by1v5b3F3XamPQw9rIDys1oprzPQGNw7EN5vF3MO2bDeKAbAhXXuXDq1Ir
         O8+PGNHscopsLySuOOuvxr78TT7WveI+j6wGI14Q9Rhxjg/k28V1WujMUi3NQifyw21g
         b4NWvtg/JVKlEVjeM3qek3JTZq5uDKDULRgv+L4Bz9j35e6u6Tg/mULIeOB2bK9DLHXw
         5bZey4IhROZrUf5vzY90psVJSWGHK8rmgiTqFhcjtRHuB4Rp4MzwY86XL/KAmMlLRdlx
         rzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UIElGDRto8wx1eLuz3K2EgwPxmZCfbuWYxcjLSpOO/U=;
        b=f9kGVjxKHjvGVVvWFcmqR4pVlCnbBAXRcJUXXGcfwEu1WC+Vn5SkEibEpysbxabKc7
         J50gFn7f+uCPL6jrGJ2m29QaNSmUECnuotqcDjJsa47JoQ3fOQMtabBPJ15rZXFVd9jz
         PqJzj3vBqR2F0sEYd06pZqIj5t/c/jGbRhOH5SYxW7GTQrtCeqNdkvi+/mwX6HbdagOV
         DmYPE1MWRb9tkXADjr4iSzuLmJTWGn3Jeyd8M3OuPAxStHwtBqMzGe34VZG50Ve+A56s
         TeBjHhEy4Iyg32QbC0aCepBU8jsb4gXLLkSCMHzHdVLLWKx55lq08SjV4QoV1eSekv6i
         y4Rw==
X-Gm-Message-State: APjAAAUTcXAiNZrnSVGHOowEBaVgsSydYtMCNqI8hCh/Pood5IBg9qGQ
        39dIWk8ofleQIBfRa35oGaH62bEuxhiMQQ==
X-Google-Smtp-Source: APXvYqzTV8fIsu+R9k+cqaecDHtZOsmqnOLFNwtc9V7bbYgNHP26x9kkTp3I3rTwLC0/QQPbTtW/Pg==
X-Received: by 2002:a17:90b:1245:: with SMTP id gx5mr984626pjb.105.1581541046449;
        Wed, 12 Feb 2020 12:57:26 -0800 (PST)
Received: from localhost ([205.175.106.8])
        by smtp.gmail.com with ESMTPSA id v7sm145614pfn.61.2020.02.12.12.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 12:57:25 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:57:25 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200212205725.GF4364@syl.local>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <97406f9e-b8ef-b5b9-3987-cdef843b31a5@gmail.com>
 <xmqq8slaz1cp.fsf@gitster-ct.c.googlers.com>
 <20200210194253.GA46461@syl.local>
 <CACg5j26ROdUAqCNPMRoORweEEDaUyeZvSPKS0bYLt9qYART4bA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACg5j26ROdUAqCNPMRoORweEEDaUyeZvSPKS0bYLt9qYART4bA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 01:08:48PM +1300, Heba Waly wrote:
> On Tue, Feb 11, 2020 at 8:42 AM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Mon, Feb 10, 2020 at 11:30:46AM -0800, Junio C Hamano wrote:
> > > Another thing.
> > >
> > > advise_ng() may have been a good name for illustration but is a
> > > horrible name for real-world use (imagine we need to revamp the API
> > > one more time in the future---what would it be called, which has to
> > > say that it is newer than the "next generation"?
> > > advise_3rd_try()?).
>
> As I mentioned earlier, this patch is meant to be used as a transition
> between the current advise() and the refactored one.

Ah, thanks for pointing it out, and I'm sorry that I missed reading it
in my first review. Your idea sounds quite good to me, and thanks for
working on this.

> So the name is just temporary and it'll be renamed to advise() once
> the transition is done.
> But if we want to keep both functions, or want a better name because
> it's an open-source project and the author might not complete the
> transition, then I'll try to think of another name.
>
> > What about calling this new API 'advise()'? The first patch could call
> > it 'advise_ng' or whatever other temporary name we feel comfortable
> > using, and then each subsequent patch would update callers of 'advise()'
> > to use 'advise_ng()'. Once those patches have been applied, and no other
> > callers of 'advise()' exist, a final patch can be applied on top to
> > rename 'advise_ng()' to 'advise()', and update the names of all of the
> > callers.
> >
>
> Yes, that's what I would like to do.
>
> > This makes for a rather noisy final patch, but the intermediate states
> > are much clearer, and it would make this series rather self-contained.
> >
> > On the other hand, having a version of 'advise_ng()' on master makes
> > this topic more incremental, meaning that we can pick it up and put it
> > down at ease and have more self-contained projects.
> >
> > I don't really have a preference between the two approaches, but if we
> > go with the latter, I do think we need something better than
> > 'advise_ng'. Maybe 'advise_warn'? I don't know.
> >
> > > Thanks.
> >
> > Thanks,
> > Taylor
>
> Thanks,
> Heba

Thanks,
Taylor
