Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE63C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7099D206DA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="a19NUvkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHCQA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgHCQA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 12:00:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008DBC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 09:00:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b79so35522515qkg.9
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sYHxTxoEeJvKC6V+u6YPmglId9v/kueVrfYt0+1qV/g=;
        b=a19NUvkTyTvdGoDO5PStOmtuKLlC1+jH9/jaS/l94Td729ulsVvjySZy3B/T8NL7PH
         JY7dR4Xglw7jJWIj0gCOnDJtobZYGdj5SfrYWVeLhSGzaGaU8tjX041mrY4HCngrMrXf
         FG9F4UOVDQTTSWG0c6fDHln8mXz00sjBmFCXaxf4V34W1o86EV7RGmXxIRkN9mti9xBq
         JAzRjXqKeOaeJk1OmRhj66uRqtH2OfVkujoch6pxZdKmSJPRfGEzuhRyki+2VLc34wxQ
         7H9997PYi9HPFu9VyWwwXcuVzq3L1HAuTSBase7nHHqZQu7uWE2s8Yx15BH1DkRkQHtz
         067w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sYHxTxoEeJvKC6V+u6YPmglId9v/kueVrfYt0+1qV/g=;
        b=KQuZd9G++eOsJF5iOyGgiUB/Dc9uIiTEtNu4gM70GMWLsujSZroFPBeQz26SUH+1OS
         yqEfkcf+60f4OGs4APRQKtzCocVgOmj0GZ/kl1kUyANeVfHW+LqY4A8sqidHxcpAnLUC
         fglA2n3J3o86jkjRvAltvCkzx/vZ10Mn0ldhPhwbqUdnh6eq23IRhuYLW+OSe+sKgM1d
         vMEfT/xMaqMHs6Yvp5CHlf1LisKH6RFM7dUW3KSmKwE7hIxwBMWT0RhkkRdYpLaMIjLa
         E3igCXmcZFkPxfZVsbJxBKR1u8YWIGJjnVmNN7hfmgFokKZ+wgJEp2cL53oNFGpnruRZ
         wxOw==
X-Gm-Message-State: AOAM533cq/JT3MY5SCn+FRiQfIr+iw+hcvJDJoKa0mkfvr0NO0kIYKQ6
        lEJlLGBZVZsPTfrfEwKB13rNR+oDly6N1A==
X-Google-Smtp-Source: ABdhPJw6XqzDoBF5sut2FRBZAY0TqN4YWJ9BuhMKgbcURMx6CqKPl5acdWl0uMw4opJtT6alRDIAIg==
X-Received: by 2002:a05:620a:150f:: with SMTP id i15mr16941652qkk.152.1596470454016;
        Mon, 03 Aug 2020 09:00:54 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id y9sm22232589qka.0.2020.08.03.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 09:00:53 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:00:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
Message-ID: <20200803160051.GA50799@syl.lan>
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 08:15:58AM -0400, Matt McCutchen wrote:
> [Apologies if there is an existing thread about this; I searched hard
> and wasn't able to find one.]

Perhaps this isn't exactly what you're going for, but I raised a similar
point a couple of months ago:

  https://lore.kernel.org/git/20200611010720.GA21728@syl.local/

> I've just become aware of the discussion that the name of the "master"
> branch should be changed.  I'm not taking a position on this now, but
> it seems enough people want to make the change that we should resolve
> the technical problems, of which I see several:
>
> 1. Allowing tools to be configured to change the default name for new
> repositories.  Work on this appears to be well underway with no
> fundamental obstacles.

Yes, this was released with 2.28. Users can set 'init.defaultBranch' and
have 'git init' respect it when creating the first branch in a new
repository.

> 2. Renaming the branch in existing repositories.  I've seen a number of
> guides for how to do it in the central repository, and they all seem to
> expect users with existing clones to manually reconfigure them all at
> once.  To me, that amount of disruption would be unacceptable for
> central repositories I'm in charge of (admittedly few with few users,
> so I imagine some will argue I should leave it to the bigger players to
> complain about this), whether or not one believes that the social
> justice benefit of changing the branch name in personal clones merits
> the work at all.  I found only one guide that addresses this problem:
>
> https://github.com/chancancode/branch-rename#gradual-migration
>
> It includes a procedure to mirror the "master" branch from the new
> default branch so that readers of the central repository don't need to
> reconfigure anything.  Writers need to be reconfigured.  That seems
> reasonable to me.
>
> Unfortunately, the mirroring method seems to be specific to the
> repository hosting service being used.  If services supported standard
> git hooks, that would probably work, but I can understand if the
> services don't because it's unwieldy to execute shell scripts without
> introducing security risks.
>
> This guide seems well thought out to me on a first read, but I suspect
> there may be aspects that could benefit from a lot more scrutiny from
> experts, and I want to encourage them to provide it.

This is more-or-less what I was proposing in the message that I linked
above. Maybe a more solidified proposal might look something as follows:

  - We could introduce a mechanism to mark certain refs as aliases to
    other refs. For example, a remote might publish its
    'refs/heads/master' as an alias to 'refs/heads/main', so that any
    reads or writes to the former get applied to the latter
    transparently.

  - A ref alias can be annotated to say "I am a transition ref alias",
    i.e., that clients should be taught to rename their copy of 'master'
    to 'main' (and update remote-tracking refs accordingly).

  - Clients can enable/disable automatic branch renaming.

I am a little uncomfortable with the idea that a 'git pull' would modify
'refs/{heads,tags}' in addition to 'refs/remotes'. We expect that 'git
pull' will touch remote refs, and we sometimes expect it to update
non-remote refs when they are remote-tracking.

So, I think that you'd only want to let ref aliases automatically
rename remote tracking references, and only if the user opted in to
automatic renaming.

I'm not sure, though. I haven't thought about it too much.

> 3. Ensuring that tools detect the default branch of a given repository
> in an appropriate way rather than assuming "master".  Where applicable,
> the remote HEAD symref is probably the best thing to use.  See for
> example:
>
> https://github.com/chancancode/branch-rename#packages-considerations
>
> This category would also include git's feature of leaving the target
> branch name out of the merge message, for example.  I believe the
> necessary work on git itself is underway; other tools may lag.
>
> For read-only tools, this mainly matters for central repositories that
> eventually delete their "master" branch, which may not be all of them,
> but again, it sounds like there will be enough such repositories that
> we should consider the problem.  I don't see any fundamental obstacle,
> but this may benefit from more scrutiny as well.

I'm less qualified to talk about what's going on here, but my
understanding is that providers and tool-makers are quite aware of this.

> I'm aware that asking others to do work is often poorly received.  This
> message is just to get people's attention so they can do the work if
> they wish.
>
> Thanks for reading.

Thanks for your concern.

> Matt

Thanks,
Taylor
