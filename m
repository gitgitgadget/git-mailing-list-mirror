Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08EFC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 05:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FCE21775
	for <git@archiver.kernel.org>; Sat,  2 May 2020 05:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7EBAifL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgEBFBC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgEBFBC (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 01:01:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0ECC061A0C
        for <git@vger.kernel.org>; Fri,  1 May 2020 22:01:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so5555418pgq.13
        for <git@vger.kernel.org>; Fri, 01 May 2020 22:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEyo8coDnuKv1WDBMshtNO13VuCm/AtRYvM6qVB4KUc=;
        b=I7EBAifLxd8Q0mFb/rwiLML9mEv4aJ4/KxPELl0+5GfsyjwciUGeJz7c36d4n5ISvB
         ditqCc/OE+6hNMnyAticG7wqE9sm00tBgvwhk1E2arcFebmTiy4x4jat6V/QEykWMXwj
         r+44lfsCtuI0YnzAIwqVC5snGftb3yiyfve8J9xXm8sZvgQtkPFYyAjE5WRvtvgV+YkT
         GSkMqu77sHXzdv9IStpXhUSGOl1OkoS7iZESqURPYmDKeqe0Dip0xXuSaRxpIlq4c3iS
         K9kD/opdYv+xjp4aHjWxZeZPKEHODjsr7KnD57ml5DeFgTS0jsj/jiS2F78LQB4K6GSL
         vI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEyo8coDnuKv1WDBMshtNO13VuCm/AtRYvM6qVB4KUc=;
        b=YFvyiGsVEjrcqjU3ufNZkQ8J5Nl3s2OaAWxaEPh7FfkswgORB3Co0tIXV9qwR79yDS
         ycLL8B1E1YOsH+W1YBGAwrEesvdMUfS6F6lAvq9TQqNOzXduMxxd9GvDYpfwB3c4euI/
         p+aQxQndlONyrmX/psrfNuVC2Ca6i1ELq8ccZLV1JrZlMxYUXMdC4npuilICkv7wCSnE
         zlJoj3Uw7vfuVpIqFaQrdCkW3L1GRkjY5IJ61ydLsYRU0C/913K20y43tWJ3b8Osb9Ho
         a6pOJ5bOCeltGuYKd8cd2ZDzDSjH5E5ew9hDkbXP2nL32n1oKCQKW+PL9Mixfkaeglrg
         5elg==
X-Gm-Message-State: AGi0PuaB2Sc5NECZKJpvUpZY4AE+5ypaS5NuOxbxxdajmecsaH2YSVQq
        nB3cPjq5bVOd09DuPK2MO4/9xFtjSXQ=
X-Google-Smtp-Source: APiQypKr9Z0Ysbe7ieMShCiEZ0lzK9+nfU/sjrhf5SNXtAPhixTc1LkCobERSpIRNSuwl4Nv40I6Cw==
X-Received: by 2002:a63:5656:: with SMTP id g22mr726478pgm.89.1588395661182;
        Fri, 01 May 2020 22:01:01 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id 1sm3596475pff.180.2020.05.01.22.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 22:01:00 -0700 (PDT)
Date:   Sat, 2 May 2020 10:30:55 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v4 3/4] gitfaq: shallow cloning a repository
Message-ID: <20200502050055.GA5582@konoha>
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com>
 <20200429093811.8475-3-shouryashukla.oo@gmail.com>
 <CABPp-BG2zf8w6ouK3nn8bid_HKWh2g6Gu-UB65q3Z9V2D80X7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BG2zf8w6ouK3nn8bid_HKWh2g6Gu-UB65q3Z9V2D80X7A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/04 09:00, Elijah Newren wrote:
> > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > index 7d294306f9..6f32846e3d 100644
> > --- a/Documentation/gitfaq.txt
> > +++ b/Documentation/gitfaq.txt
> > @@ -243,6 +243,16 @@ I want to change the remote of my repository. How do I do that?::
> >  One can list the remotes of a repository using `git remote -v` command.
> >  The default name of a remote is 'origin'.
> >
> > +[[shallow-cloning]]
> 
> Why is this marked as "shallow-cloning"?

I forgot to change the heading, will fix it right away.

> > +The repository I am trying to clone is too big. Is there an alternative
> > +way of cloning it in lesser space?::
> > +       A good way to save up space when cloning a repository is
> 
> "save space" instead of "save up space"?

Sure.

> > +       by using `partial clones`. A partial clone will clone the
> > +       full history of the repository but will skip out the entities
> > +       specified by the `--filter` option one uses in `git clone`.
> > +       Any entity which has not been cloned to save space can be cloned
> > +       on-demand. See linkgit:partial-clone[1].
> > +
> 
> I like this much better than suggesting shallow clones, though you
> should mention that partial clones (currently?) presume that you have
> an always-on network connection to the original repository because
> subsequent commands may need to fetch additional objects in order to
> complete.

Alright, I will add that. Thank you for the review :)
