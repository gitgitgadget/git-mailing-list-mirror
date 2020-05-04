Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D262C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A0420705
	for <git@archiver.kernel.org>; Mon,  4 May 2020 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BoLoMHRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgEDXKh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 19:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgEDXKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 19:10:37 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C295C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 16:10:37 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so93996pfx.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 16:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Vv93us/tXa3Iovc7mXAuGZE/vMbMA891ZNMd6fpYuI=;
        b=BoLoMHRkO0wUk1QsDTWQk09w3DIzPuBq4AKd+3bZmBv+MUKz+i3zkJs2vkcjmVETSp
         NsPjtSpyJ9EN98rRUir9/WdA3P/mhd6M8yoFGAIpZ7Y4zuWzxnMOps0j8/C9p6e29Bl/
         PUtfKqWVMdV4uHrBF21fNcKeJ4lBqmpaZupFiSqf00HFTTCPneXnrVndyzeFZVoUznLc
         1hDJirBvliVNv/tTTULnxhYRiDvnGoaD8tbrCINojjXp1Kdf7dGYy1rU28yLhV+uDnYs
         e5rZSfqwHs+zGYi/sELZrv3IcgQ81IE+M5QPaykMDBgMroDfp4j0T4sljkbIvnLf92L2
         BfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Vv93us/tXa3Iovc7mXAuGZE/vMbMA891ZNMd6fpYuI=;
        b=f6AgZXaZc7YYAu7DC8QLFsJo9rGQpf4uOg6l7895BmyluvaW8qttXfA+aNha/sCh+V
         XFOmU1AvA17UPdV4A55azFfjsjNH7TaXsAznguXjH6tXpsuA1WtHf2fGrnS9ndSNL0b+
         3hduH3dtifCCMfzUnxGiKVM8VFGTxTQUkuc3SVm7JGbGzeMS80zZgFDe1wzNLksADgHn
         BeeRBtEHnjUmM8yJ5eiPoot25k3TB5T0pKn2Uai22WTW5Lgz2jG8QFeMVk1Sri1bursc
         wo5SOEj+T8QBStwH2Kfd9lm6a9rieE8ErsMGocri8h5iMJ1ftc/dQTum3/xIPS/UBEEW
         FUIQ==
X-Gm-Message-State: AGi0PuYudRqfFsBUAtwaqQUObZ7bFFNV03NGUCypTbYjdqkS+da/RfSg
        ocAKcaFkRNvpuwkAbEfKjJg=
X-Google-Smtp-Source: APiQypJtoYN4fnvYJtq7ezBo0129i93gilBrSNTCJviB2D1dZc6m6P3u/bfHNmcMpht4m54HC61Nig==
X-Received: by 2002:aa7:9491:: with SMTP id z17mr276125pfk.264.1588633836812;
        Mon, 04 May 2020 16:10:36 -0700 (PDT)
Received: from gmail.com ([2605:e000:1f00:8fca:acee:fc2c:d94f:4569])
        by smtp.gmail.com with ESMTPSA id m14sm119226pgh.66.2020.05.04.16.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:10:36 -0700 (PDT)
From:   N6Ghost <n6ghost@gmail.com>
X-Google-Original-From: N6Ghost <N6Ghost@gmail.com>
Date:   Mon, 4 May 2020 16:10:34 -0700
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200504231034.GA34485@gmail.com>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <alpine.LFD.2.21.2005041340480.220155@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.2005041340480.220155@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 01:43:15PM -0400, Robert P. J. Day wrote:
> On Mon, 4 May 2020, Simon Pieters wrote:
> 
> > "master" is an offensive term, as it can be interpreted as being
> > slavery-origin terminology. See
> > https://en.wikipedia.org/wiki/Master/slave_(technology)#Terminology_concerns
> >
> > The Python programming language, and various other projects, have
> > taken a stance and moved away from offensive terminology including
> > "master". See https://bugs.python.org/issue34605
> >
> > When different projects using git decide to move away from "master"
> > as the name of their main branch, inconsistency ensues between
> > projects. See https://github.com/desktop/desktop/issues/6478 (and
> > "Related Issues and Projects").
> >
> > To avoid offensive terminology and to avoid further inconsistency, I
> > think git should use a different branch name than "master" when
> > initiating a repo. I don't have a strong opinion, but I like "main"
> > since it shares the first two characters and it's shorter.
> 
>   please, no ... this is just massive and unnecessary churn, and it
> opens up a ridiculous can of worms. if you change this, then of course
> you will have to reword everything related to data buses that are
> defined to work on a "master-slave" basis. and would you have to stop
> describing your competence in a particular field as having attained a
> "mastery" of the subject matter?
> 
>   this is just a bad idea.
> 
> rday

I would agree, this would be a huge can of worms. and is not really needed. 
the word "master" is embedded in our lexicon in many places. calling out
one historical use, and then saying becuase of that use all the other
uses can no longer use that word in our lexicon. is just a bad idea.

thats not how language should work.

-N6Ghost
