Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA1C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC34C60FC0
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 18:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349066AbhICSew (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 14:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhICSev (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 14:34:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317A0C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 11:33:51 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id l18so193847lji.12
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PlTcxRUytZzrShhFb/VKc1Q7/OYfpDzS2X3DRrKi/nk=;
        b=R+OxSFe/ruoW931BFjbuvlkJYckUON3av5naUahe4HulCMk4QH1/ywcTeIdm3KHd49
         fq9YDtT8CTUGfxwVzbAmmYV5NFVnCLnLp3CHoSrIjHrebcUktJqAHyCZsK/eZ8bVVPVu
         vXONM5+pBEdXU/T9bjktaNWbvx2A26gesKtN1Rn8crkfwSrngDcYb/EZyMWV9HWq9LEf
         LtjieCm2PJKxFZqxoWbDYEjQCBEAtz9o2mhNH9timBDLwmBqI16GwUw8/qcL60DmVhgy
         /StpvMuoETJNooaVqfLFFSaHMtcCl5LrG3ku84Hr3yzT51nmNhVO82kzGh/KxIP52Ymr
         JKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PlTcxRUytZzrShhFb/VKc1Q7/OYfpDzS2X3DRrKi/nk=;
        b=ADiwsR5IVN6tbhjXeme/AAqK47yTP4kFfxvBXOD7eT8QeBi3OxTbcOqXunKdgzfqCL
         f8OZCJ4ehg/rg6GiGYVAIaj61a5KeFqdIX/pUv0imDuRPj+t9hKkPgdUbxhlGAa0v5+L
         cTaZyGInF/VNSsqjOA53KpfXwmZEO5t7DXdQ8iDgwFDvD/FoKRhRAquVSoOH538LUUJw
         OJtp2BOEDFub2SZ0VNruqcPlmgFDDlk5n0jf8QFnAX1++NZ/7YOpdC+Xuh15tKwDPFnH
         zPS9bbs7rEF6otIixHacElkDv2fCYB0OHVBE9jlUOk5Cz5zPIHZGX95n1YVhYishYwpJ
         JaJg==
X-Gm-Message-State: AOAM531pI6Pf0/8phg8kgYeeYZiOgLk+Iww4JgBcZ83157kMnmV/cg1U
        P0ScMc1jLsF7jQLGB56+M8QBqKq/4O6ga06uIK7X8w==
X-Google-Smtp-Source: ABdhPJzj2/rBcxhXD9fODJYjulULSRktZo0q6PqVoFBUO9qrr+ytdwCCihTgdrenIGVHGR0S4t873AI2aeDLssPOZY8=
X-Received: by 2002:a2e:4a19:: with SMTP id x25mr264245lja.235.1630694029314;
 Fri, 03 Sep 2021 11:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local>
In-Reply-To: <YTGLLQCvlnT17jo8@nand.local>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Fri, 3 Sep 2021 11:33:38 -0700
Message-ID: <CAJoAoZnHk9shE0D4UHVhd3zTqDBmOeCHvf0ukjEt5k5B6u=jcQ@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Taylor Blau <ttaylorr@github.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 2, 2021 at 7:41 PM Taylor Blau <ttaylorr@github.com> wrote:
>
> Are we interested in participating in the December 2021 round of
> Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
> application deadline.
>
> Christian, Peff, and I discussed off-list that we would each try to pull
> together funding for one intern from GitHub and GitLab respectively.
>
> If we're interested, the project submission deadline is September 23rd
> [1]. By then, we'd need:
>
>   - Volunteers to act as mentors

I'd be happy to mentor actively during the application stage, but I
don't have bandwidth to host/mentor an accepted intern this term. I
would also be happy to be CC'd, pinged, and so on on any reviews from
interns which aren't receiving enough love.

>   - Updates to our applicant materials on git.github.io (project ideas,
>     as well as potential microprojects).

Will bring this up with Google folks today and see if we've got any ideas.

Thanks for mentioning it, Taylor.
