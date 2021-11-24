Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75F3C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbhKXWgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 17:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbhKXWgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 17:36:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A643C061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 14:32:52 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so16943359edq.7
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 14:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DZe4H5HGPOz3EZinkMVtMQHvcOVZZp3hZSevTJMw68M=;
        b=JTlbMLIqO/PPylOQKEBwhIbSSD5SYVjvPLEkmrtH8wiFOk/v56Um2aqcawQlI2qzwI
         Sl2Sl01f+VBuJaiSwp8heaBJPp0RPVDqW6yv6AsbcygkKg2uv4OlorcyLZiNufEIoVR3
         XuzlG0p/eXQGSOsW+gBl0QMXEADz4EKJvrDyac+1vNjzIx1xgPZusxbnzLWXPdqM0b55
         5XKEoLFlB1apGgUzXu5PlXiSLFDOIF3kZnHY5OGi6sTgXNMbPxPV4aU/I3bGx2t+eINR
         RChL3WvAIrh208wRzU55BoXGqEKuqRWLrR7e3kuyP2xakCxtOEIpKFxyLE09MXDxoTfs
         Ab7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DZe4H5HGPOz3EZinkMVtMQHvcOVZZp3hZSevTJMw68M=;
        b=SRCchFYTT4qg/C/b656wYEXyNr8YO42IV1pEQadkJq9T+9iVHzFTgTxYye9RbcSy/e
         DoHWc6dkLNlrkVqmIMRVVRYykDCjsfkhzcx13Pkm4QlSPolGWlpLPJLYbqFBDrHEjlKL
         HxTGlZD1lJOkna0KN4v5h+9+WbpTu/1QdJvJDuBUPNGNYdKuOfda+0WK6VOr5aFo3gjr
         3M5PvjGR5vX+zrSBejbRXiL0UxTsrAPhpKtjbxpVRjHL0xG39D95wGXHXGzIutVJSqPD
         UvAG05jut8o538TUuoU4uVlXsyAthpD8D833nz+BdF/1K/hk1IPuM0rmWCtrqBHnupks
         x8gg==
X-Gm-Message-State: AOAM532inx0feE0KWm2YfzPtpTFDqrGZruU+uNXVwLD4QXqU6dWyn2Sc
        Eq3XOUctrmOG2G5owSpEk4TkB41+pUCW0AtG8cvWe7ze
X-Google-Smtp-Source: ABdhPJxO1u5Y8ggeiHlhQ6Fg0LXm1uXKPDJNDPJXuFAhPY5unslVmrsVZrvkS2YqJ4RRdObAx3xs43/K2vU5DdlJItU=
X-Received: by 2002:aa7:c50b:: with SMTP id o11mr31134807edq.160.1637793171104;
 Wed, 24 Nov 2021 14:32:51 -0800 (PST)
MIME-Version: 1.0
References: <CANiSa6iNpm6--qHpUFYhPfSi+ounGttA8=TAsep18A-=iyoFEQ@mail.gmail.com>
 <xmqqmtltz1vp.fsf@gitster.g> <CANiSa6iAXAXeDCh_OK=-wLPQiFSWFxRyCSC0SVvTJ8Gp4wdQ7w@mail.gmail.com>
 <xmqqwnkx9p40.fsf@gitster.g>
In-Reply-To: <xmqqwnkx9p40.fsf@gitster.g>
From:   Martin von Zweigbergk <martinvonz@gmail.com>
Date:   Wed, 24 Nov 2021 14:32:39 -0800
Message-ID: <CANiSa6iNmzKv_-6wH-LmbsRQKWiL3ZwTU5MKUZKzZR8xnMjGAg@mail.gmail.com>
Subject: Re: Letting tools partially resolve conflicts in a file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 24, 2021 at 2:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
> > The solution I had in mind for letting merge tools communicate partial
> > resolution was to let them take 3 inputs (as today) and produce 3
> > outputs (perhaps by overwriting its 3 inputs). That way they can leave
> > conflicts in a conflict-marker-agnostic way. ...
> >
> > Correct. My team at work hopes to create a language-aware mergetool.
> > The "#includes and imports" I mentioned is just one case that such a
> > tool could resolve. Hopefully it can also figure out cases like where
> > both sides modify an array (on a single line), or where an expression
> > is modified on one side and re-wrapped on the other. The thing is that
> > it will obviously not be able to handle *all* conflicts, so we want to
> > leave remaining conflicts for the user, so that's where this idea
> > comes in. I don't foresee having more than one such tool in the chain
> > before the user gets involved.
>
> Hmph, OK, so the part I guessed that more than one such tools are
> chained together was incorrect.  I do not find it too implausible to
> wish to first let the "include/import" tool to clean up the fallout
> of renaming the include/module files this source depends on, and
> then let the "renamed variable" tool to handle the fallout of
> renaming a local variable in a file in this source file, in this
> order or the other way around.  It may be a tall order to write a
> tool that can handle *all* coflicts, but it would be a nice future
> to see that multiple tools, each of which specializing one corner of
> its own, work well together.

Yep, I agree that it's desirable to allow multiple tools in the chain,
even though we don't currently have any plans for more than one tool
in it (plus the final "interactive" tool). And to be honest, we won't
even be using Git (this project is done in the scope of Google's
Mercurial-based tool). However, if the project to write a
language-aware tool works out, it should of course also be useful for
Git projects.
