Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3735EC5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26FF22227
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 14:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xL+9J8wI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKLOnA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 09:42:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E0C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:42:58 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id l2so5431995qkf.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 06:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=veWaU2fZ3ISTGlOL7yXJR3Tbxev4tKlLu+HPeTgJId0=;
        b=xL+9J8wIsP8GvOBmF0xOLZcurERFosc7hwSaQmoxXZ1f608OeVifOZgIDN1pRjriu8
         getmFDn/KLuDjegMWBgicCYWK8iKTdiMspkwU3OW3zW5yLO7xhnsKlwS0TuJnwKQ1EBP
         Qch2/pIIahB4gNHIfHbq2U/9fozBHueYLYbiTyD6ED1f12riKNTj/ZysmBIOWcYx7c0y
         hOBy4h1yeMR8mCspiar8xvSZwX4QbOapL6+KNPLHxfzKTazRToeztxWBXfz9MNuNlzAi
         rQq0CclvzifzYFavuOP3pqnoL0zYmCqy8e9OwiObTNnJxS5X/Rc+yD1wKaFhsl4MkuDM
         Py+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=veWaU2fZ3ISTGlOL7yXJR3Tbxev4tKlLu+HPeTgJId0=;
        b=g6th4f7bEq2//oRiv3uXWo5Jg/Tm/QiKWvaw5e6298WHqSLa6lA5PNnEay/maF5n4W
         GxdsyGs46fnuJvWecO9IW7tHVAp/ZU9kzoqbOz/YzxqgxIe85ynXoO6nC3ld1fhrBZcF
         Fy6nlpEGDCQVVklcC224j6BYB2VYbI2RiYj7enfIvJLuZVVzMMtDy7vZRxRAd5BkFbTE
         k9f62X25EpaId6WOV7zOyYm9PhC1Imn7IutI82/MyHf7WkRgq3ZDHh/rmSA7deLfPkJI
         QvFzy5ZmzRRbGNmLjtx3zQ+aGullMqUGKjJgk6JtaEX3wkLfVbkFci5dvyoewY/fJZ0m
         JnFA==
X-Gm-Message-State: AOAM531ZPnMf71dApoC9SR1/oDlME4ps3Bo8amwCIAUVaJHU/22X+3HK
        RJBw3FJegMY5IZzCJsKtzavE6Q8TNIPe4wrL
X-Google-Smtp-Source: ABdhPJyBb4Q4lxQx6qGOSVqEbmb1IRgexSQlb62ousal5fKuBiirFeHEE/DT97R/g/b5/1LSQxL8xQ==
X-Received: by 2002:a37:444d:: with SMTP id r74mr32242qka.105.1605192177110;
        Thu, 12 Nov 2020 06:42:57 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:508e:3ccd:52c2:244c])
        by smtp.gmail.com with ESMTPSA id o16sm5063867qkg.27.2020.11.12.06.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:42:56 -0800 (PST)
Date:   Thu, 12 Nov 2020 09:42:53 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     "herr.kaste" <herr.kaste@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: commit-graph.c:1068 when doing `git pull`
Message-ID: <X61J7bWDXO/r7Ob5@nand.local>
References: <CAFzd1+7xQHgaOYKW7WZaWCPdp85Pfk8k_M-gVtBq6Wf7bbJTzg@mail.gmail.com>
 <CAFzd1+7VxaGGMVKicuy8KnWdZoBxEHY8xS9kK1VF0Tgai=Kcxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFzd1+7VxaGGMVKicuy8KnWdZoBxEHY8xS9kK1VF0Tgai=Kcxg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Caspar,

On Mon, Nov 02, 2020 at 08:12:07PM +0100, herr.kaste wrote:
> A
>
>     $ git commit-graph write
>
> did the trick.
>
> Let me know if you think there could be something useful to reproduce,
> somewhere.

I think this is worth trying to reproduce. The first message you're
seeing about the commit-graph-chain.lock already existing is a
red-herring: it's likely that the last time you tried to generate a
commit-graph, that it hit that same BUG() and left the stale lock laying
around. (I can't remember off the top of my head whether we still run
the atexit handlers upon a BUG(), but even still, I could believe that
some other stray process left it laying around, too).

So, what's interesting is why your commit graph ended up in a state that
it got some commit without all of its parents. If you could reproduce
that state, that would be interesting.

Are you using shallow or partial clones?

> Regards
> Caspar Duregger
>
> Am Mo., 2. Nov. 2020 um 19:30 Uhr schrieb herr.kaste <herr.kaste@gmail.com>:
> >
> > Hi all!
> >
> > I'm stuck with this error message
> >
> >     $ git pull
> >     BUG: commit-graph.c:1068: missing parent
> > 104f5eb377763b2ed9663e8949aed265b69f000f for commit
> > c59ed9b7b6d4268ae6cb1069a9b51e02ad9aa1d8
> >
> > This happens since the last `fetch --prune origin`.
> >
> > If I do it again, I get
> >
> >     $ git pull
> >     fatal: Unable to create 'C:/Users/c-flo/AppData/Roaming/Sublime
> > Text 3/Packages/GitSavvy/.git/objects/info/commit-graphs/commit-graph-chain.lock':
> > File exists.
> >     ...
> >
> > And upon removing that file, I get the first error message again.
> >
> > I actually don't know yet how to move on from here.  I'm stuck, so I
> > appreciate any help.
> >
> >     $ git --version
> >     git version 2.29.2.windows.1
> >
> >
> > Regards
> > Caspar Duregger

Thanks,
Taylor
