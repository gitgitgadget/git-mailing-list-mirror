Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3756FC7619A
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 01:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDIB2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Apr 2023 21:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIB2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2023 21:28:31 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0347ED8
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 18:28:30 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54ee0b73e08so45995567b3.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2023 18:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681003710; x=1683595710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ly02XY4pRM8Xc/XSaXihcgbiYhFrrocuyeD8yYbB6E=;
        b=olYwb/pJsNdgwEi6k5/BHIe3Q8WGG+lisx6ZjN/5SRkY3S41xbOrPkuavDz5Z38mz8
         6s1DU/wuGasB4lRl+IV4CggRqpZZJveMgCpq7jFohB/WAHFbm/VRzjfcNcrSl0F0nwCJ
         YEEcB0qLuHT82lR9Slq3SQJfB7jLLHQumuZb/SUboJkjvP3Sg03lnUS2NrWTTzR1tbvE
         Q1j37i9iWjPzBOq11fk95i3BNEqyAP+vQ347Wh8mUMZ4Ea2eBLc5XwQIgh85k5xOibeF
         XrCqwoFEx5tVpQ5RkPZxoxClkVo/D18wCKuArnKfhQIi83tXQn3UUWbSpeYaFKoZs9Ga
         HHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681003710; x=1683595710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ly02XY4pRM8Xc/XSaXihcgbiYhFrrocuyeD8yYbB6E=;
        b=suYXvDC8ur/XLpJXs35CjJ27/wuyV5GiDVpIeK+hXQ5v5z4/UjnkjcMcOxzzS/0KLg
         rXN9mKarr8toyFHYmbu41/5mck0krPwJ8T53b7L55bJvOosqUO3w7/V5xms+9NtlnAz7
         bO5+g9QHfjgDQmCbJYFWai7XzMOn4EsN4BONzUQLQ/PM6T3jK+llyh7isFDjS5OkfSYr
         Iyiy3vTguqD2V0dnrjee7l4qIAz9ZGphq2iLuvhewsb9cTsJ5/NNoKVo+2/eqNyiJvWB
         S10V+LlrFd0tVOBellFUkd56heWgLbPIQgGowOyrQztCx1sQ8UoAwQ+QFSkfa6z1IOUe
         8yWA==
X-Gm-Message-State: AAQBX9caqrpF1Am6LwZGSmlhTJYU2U7grRKNZ7tuqCvhik85fSwzH3Nb
        iyWMUhMowvUtneC3xlVNTV8jWw==
X-Google-Smtp-Source: AKy350Yrx1Xw8YGRr1PpM3DG/Trzu0ZYrXx6IrY302TFY2s4YhoKa0aiUt4a6CBES/t1zk0Cf+GWNw==
X-Received: by 2002:a81:6d83:0:b0:54e:df41:62f5 with SMTP id i125-20020a816d83000000b0054edf4162f5mr2281955ywc.18.1681003709677;
        Sat, 08 Apr 2023 18:28:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 188-20020a250dc5000000b00b7767ca749csm2075588ybn.57.2023.04.08.18.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 18:28:29 -0700 (PDT)
Date:   Sat, 8 Apr 2023 21:28:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        johncai86@gmail.com
Subject: Re: [Question] Can git cat-file have a type filtering option?
Message-ID: <ZDIUvK/bF7BFqX5q@nand.local>
References: <CAOLTT8RTB7kpabN=Rv1nHvKTaYh6pLR6moOJhfC2wdtUG_xahQ@mail.gmail.com>
 <xmqqy1n3k63p.fsf@gitster.g>
 <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8SXXKG3uEd8Q=uh3zx7XeUDUWezGgNUSCd1Fpq-Kyy-2A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2023 at 02:27:53PM +0800, ZheNing Hu wrote:
> Okay, you're right. It's not "ungraceful" to have each task do its own thing.
> I should clarify that for a command like `git cat-file --batch-all-objects`,
> which traverses all objects, it would be better to have a filter. It might be
> more performant than using `git rev-list --filter | git cat-file --batch`?

Perhaps slightly so, since there is naturally going to be some
duplicated effort spawning processes, loading any shared libraries,
initializing the repository and reading its configuration, etc.

But I'd wager that these are all a negligible cost when compared to the
time we'll have to spend reading, inflating, and printing out all of the
objects in your repository.

Hopefully any task(s) where that cost *wouldn't* be negligible relative
to the rest of the job would be small enough that they could fit into a
single process.

> I don't think so. While `git rev-list` traverses objects and performs
> filtering within a revision, `git cat-file --batch-all-objects` traverses
> all loose and packed objects. It might be difficult to perfectly
> extract the filtering from `git rev-list` and apply it to `git cat-file`.

`rev-list`'s `--all` option does exactly the former: it looks at all
loose and packed objects instead of doing a traditional object walk.

Thanks,
Taylor
