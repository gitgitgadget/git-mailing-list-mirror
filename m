Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E1CC433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJSVWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 17:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSVWd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 17:22:33 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B4918BE11
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 14:22:33 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 187so15617425iov.10
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mE0WhC0XXEVeU2u0HY45YoFnz9flr09GkBT57/AgBQs=;
        b=IeqG70zQU7IBBRJchOC7zIUN+DjM56wyCkpACfTC9MfMA6blmh9/Ih7WFKcSwdw4Ul
         c0uupu/AhpH3IbOZsM8bcJckNktN/1hcEW+tEZe89fJDmCw7jPWoevm3L1heuV2wvX8l
         ErDaGd/+CqYCrdwqiz/9FU7o0EmM2WWqObAlADVDtC952z/0LhteQl8unyMHHMw5l+N2
         P0/VABno5UhvBkolV9jZGCjoz+7jjU7QsJ1B8q+wOVqBU1/3Pv0Cou4UgLuWa89g4oWk
         VmdFOPsjy4i/Ejjk0Sv6jesrBzESiTw9uMjcXQ/twopxzKC1+Qi926oEnPny/jgYgdDE
         J/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE0WhC0XXEVeU2u0HY45YoFnz9flr09GkBT57/AgBQs=;
        b=jhqx4gU5PJkS2ArakgVDqaoaDhOAN27su4mK9uem7c3BuGO3iKMU9MGVDQtlqbru26
         NVXLOYg4KjZDeFB+NtNamERNhP0jqfPTLO015yV8O7pfwRy+rFrrjeKM/mYEVE01/q+Y
         7HScgW4f8mE/3ZNzAfF6W7CoTMUefebneHezfibKfCO4UwixAcz61h7yGL4qNhbkK6Uv
         iIi8zGWgSfK16IF3iCF6pIsSPEDT9Bqu21JCW/GlmtJllREQKIBs64/GvXdwIlTr01Ah
         bQ3y9iNtyKnKWfx8EA/DoSongjw4UuctcNjyn4jXxbZSek2gqaMNrNeUbK8lagN+Z87E
         Wq9g==
X-Gm-Message-State: ACrzQf1KotK3MPeac3k/fzTwYjo1JEE8nkdIy9MOydd32g8aFnwMmb6x
        sfSF5ykIA/fLny3+lCO31eCIKA==
X-Google-Smtp-Source: AMsMyM5XrBXYsw778i72faSRLPDrAAxTRrthNPLfm0C+F4XR7s9fZYh4HMyBlt5H3dT2Vy6c5+XVLQ==
X-Received: by 2002:a05:6638:150c:b0:363:a4f4:fdc6 with SMTP id b12-20020a056638150c00b00363a4f4fdc6mr8131051jat.185.1666214552450;
        Wed, 19 Oct 2022 14:22:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a6-20020a92d346000000b002f9b55e7e92sm2378219ilh.0.2022.10.19.14.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 14:22:31 -0700 (PDT)
Date:   Wed, 19 Oct 2022 17:22:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julia Ramer via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v2] embargoed releases: also describe the git-security
 list and the process
Message-ID: <Y1Bqlmo7kP/4A79B@nand.local>
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
 <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
 <xmqqa65rr6g1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa65rr6g1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 11:53:18AM -0700, Junio C Hamano wrote:
> "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Julia Ramer <gitprplr@gmail.com>
> >
> > With the recent turnover on the git-security list, questions came up how
> > things are usually run. Rather than answering questions individually,
> > extend Git's existing documentation about security vulnerabilities to
> > describe the git-security mailing list, how things are run on that list,
> > and what to expect throughout the process from the time a security bug
> > is reported all the way to the time when a fix is released.
> >
> > Signed-off-by: Julia Ramer <gitprplr@gmail.com>
> > ---
>
> Thanks for an update that is excellently written.

Yes, indeed.

>  - Would a reader, who has "stake" in the healty and secure Git, be
>    helped if we spell out that they are welcome to ask joining the
>    security list and how?  It feels a bit too obvious after reading
>    "anybody may contact", which is both the right way to self
>    nominate for the membership and the natural thing I expect such a
>    reader would do, so we may not need to.

My personal feeling is in agreement with yours, which is that it is
probably obvious, so I don't think it's worth spelling out explicitly
here.

>  + The packager whose release artifacts can be exchanged among
>    security list participants under embargo is not limited to Git
>    for Windows, even though we've only seen exchanges between
>    Victoria and Veronica this cycle for that particular
>    distribution.
>
>  - The world is not limited to only Windows, mac and Linux.  Windows
>    is not all that special.

I agree, I think that mentioning Git for Windows in this document is not
strictly necessary (e.g., if there were a new "Git for Foo" that came
out tomorrow, I would not consider this document out-of-date), but I
likewise wouldn't object to it.

>  - I wonder if we want to record the name that is used to refer to
>    the "private repository controlled by the project" on the
>    security mailing list somewhere in the documentation.  If you are
>    a stakeholder, being on the mailing list *and* having access to
>    that repository are two things we need to make sure you have to
>    partcipate in the coordinated embargoed releases.

This repository (git/cabal) is already well-documented on the mailing
list, so I would have no problem including its name here, too.

> Here is a patch that summarises some of the above on top of your
> patch.  I only tried to address the bullet items with "+" in front
> in the above list.

All looks good to me, thanks.

Thanks,
Taylor
