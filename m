Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E3C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3493216FD
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3zM0usv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgEBG5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 02:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgEBG5y (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 02:57:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329EFC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 23:57:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s10so4543245plr.1
        for <git@vger.kernel.org>; Fri, 01 May 2020 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e9GVIhoVBaQ+YAVh+abEu4gjoF2FxDJaxrb05OXtORM=;
        b=g3zM0usvH4w5u42ciSGgefgAh8aJ9XrDqCcVyAQ0FZ8n/fzfT5vAYgbXGyYlsSKMMj
         8sx5MepVdvIQJoxT2LCU4l8eVvkFzjvxwjpSCiRG/mthlNOHXRdOFPcbPUfDxW1PcAXL
         vXSw1PT0y07F2PPLFQQW/bthqe3ALe9u9ADluG9rjnfQZgsUhGDHQkZZhxdis93kGk3i
         utsucgsXkSe1b/bdbpjXduGrH8kst4bQur6QT5StYi2TNqzRbEaYPb59ZOPNXSK4uh1g
         BCzAgs+sQEd+y8Y4ncYOrf/CkLdCbvDLLl12kcu2gpSlrnQuuKzaX1dRUXN4QjTlN/le
         SLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e9GVIhoVBaQ+YAVh+abEu4gjoF2FxDJaxrb05OXtORM=;
        b=eJMMk9JVR62lITPZmaR+IUNu8NQnNaZDyjAfhJ0uC634b4RIjXewt7QLiiMPb/nKrj
         oM4wgkg3SVsolbXydGxdvBFm5zireMdPw3dOfttxJ9Nm115iBqSIyH4QHebHa1XWYndo
         C7qollqVWLrVka9itRXYTY3CzRx4GS5BEoxH7rzchJBAMux33+42sImREZxDsonSLzPh
         hvRqDIpVALPiJ5CVLrVOsB2gXOKOiVQWLTAqyOYZXIVzlUXyHTtb5CshlTwZB3X9DkiA
         Lq/zaQpPhD2K2wyGOI7iKA/HBfApu19u+YSZxT7p4gweFCiI9ZZugFsq/ZtL9YqE7cab
         AkqA==
X-Gm-Message-State: AGi0PuZv7QVWveCW6bKnDX6DejoH5XKcD+p3UUbNeCibBN6JE62FcMYc
        4pFzwgdsOF/Ex2IAHXbGDn3do5BJ6kT+MA==
X-Google-Smtp-Source: APiQypI8kehk+p29UmS6PnOmQVUg1MZGRX6JSqq2KuG4R7Bmczx+dWhCxh6KCu1e43OO8+mJDGK9AQ==
X-Received: by 2002:a17:90a:a402:: with SMTP id y2mr4363637pjp.24.1588402672324;
        Fri, 01 May 2020 23:57:52 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id c2sm3813219pfp.118.2020.05.01.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 23:57:51 -0700 (PDT)
Date:   Sat, 2 May 2020 12:27:45 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
Message-ID: <20200502065745.GD5582@konoha>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-4-shouryashukla.oo@gmail.com>
 <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/04 08:56, Elijah Newren wrote:
> > +[[fetching-and-pulling]]
> > +How do I know if I want to do a fetch or a pull?::
> > +       A fetch brings in the latest changes made upstream (i.e., the
> > +       remote repository we are working on). This allows us to inspect
> > +       the changes made upstream and integrate all those changes (if
> > +       and only if we want to) or only cherry pick certain changes.
> > +       Fetching does not have any immediate effects on the local
> > +       repository.
> 
> Maybe change that last sentence to "Fetching does not modify the
> current branch"?  The local repository certainly gets bigger, and the
> remote tracking branches are updated as well as their reflogs, and it
> might trigger a gc, all of which sound like immediate effects to me.

I meant changes in terms of the user's code. Yep you are right, I need
to be precise here.

> > +
> > +       A pull is a wrapper for a fetch and merge. This means that doing
> 
> ...for a fetch and merge or a fetch and rebase.  This means...
> 
> > +       a `git pull` will not only fetch the changes made upstream but
> > +       integrate them as well with our local repository. The merge may
> 
> ...with our current branch.  The merge or rebase...
> 
> > +       go smoothly or have merge conflicts depending on the case. A pull
> > +       does not allow you to review any changes made upstream but rather
> > +       merge those changes on their own.
> 
> I don't understand this last sentence.  You can definitely review
> changes made upstream after a pull; e.g. git log @{u}@{1}..@{u}

I meant that the pull will apply the changes right away and one does not
get the chance to review what is being applied before it has been
applied (something a fetch does). I need to be more clear here,
understood.

> > ++
> > +This is the reason why it is sometimes advised to fetch the changes
> > +first and then merge them accordingly because not every change might
> > +be of utility to the user.
> 
> I don't understand the purpose of this paragraph.

I intended to emphasise the difference between a fetch and a pull; the
fact that fetch just brings in the changes from the remote and doesnot
apply them to our code/files right away, while a pull does so.

Also, a nit but, we are supposed to use 1 SP or 2 SP after a full
stop(.)? In India we use 1 SP, is it different in other countries?
