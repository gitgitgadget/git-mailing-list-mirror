Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A2DC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7C124656
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi5wL9+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0WtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:49:20 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37600 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0WtU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 17:49:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so4303836plz.4
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 14:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uEEaCD/QiTR1WYB7PdgIbTChCoC6dalaokgsOC5TwDU=;
        b=gi5wL9+ml4DhnAnN/+aMA/WGPjTnMzxi4olLPRcxOS2FbAnLOM4OycQI2mwTbkKm38
         xAHygfQSIYTWJIRpWelM2QKqutUS8PtjyF9RijtMuVU8pt0AzYZCY3p778LoPbtsOpwE
         q+vyAZuk4URVVbGchgkuO2jtr3mKr+z7IYCS+e2juofXa+lSrpgZXJKz+NDgbZzkN81l
         kzwy8iWlDnJC0txOPzFwpBaQN4T2TQyIRKMucT6ci+2OHU/NM5vrNL+5FbJSgFudQyLD
         +4G7vEuP0zSHgnyS4ZeT0JZGH05L7ZdQx/aVSp43ERcJtqGJOBHP8jtO/r6IAnjPBt+n
         znQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uEEaCD/QiTR1WYB7PdgIbTChCoC6dalaokgsOC5TwDU=;
        b=caySuFF2qxbA8HpB91KyAgnNKXyL3zHttKaXh3hA5fLWBz4QlX3V3lXmNkqmOaLKvy
         4yKZv7L/7wsEqapSHQhQBFPxTYJN8JHEDa3Fd88J5ilwCaeIVmmR3jzU0OqjSQPp52O1
         bkxDnZnSfjjmkAexipqiGZI+A/3nJqynUaPnMYQ1Q9WVPBQN70CdvgHL9jPklBJ/ndiP
         5/LBYp4zutyF3hxyvTV/62Kt+WqJNHDk7VJm4Ck3g4DA1opL5EL2bpoWohQvnrItpz2z
         3JvaFpYir2fhm2JYIkTouVD0EORO7t7UkCyrI0VT8V1BgqQoftZWDGyloKT3Rx5YqlR5
         kywA==
X-Gm-Message-State: APjAAAW/laWGdKd6LxokEXbp3WyWL9qj6KIVAUtHzvoy4XuRtswslPpZ
        KIqJ2KZLanyl7FwTZjOr5dJGEQ==
X-Google-Smtp-Source: APXvYqxNd3thkmirctyzORKcNkfOBFc4LhLQ1oixMyzROKJLor1Bj+kVh+fTaU+FdKBQ8TgRuO5IWQ==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr1069245pjb.123.1580165359167;
        Mon, 27 Jan 2020 14:49:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 132sm17667808pgd.76.2020.01.27.14.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 14:49:18 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:49:14 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200127224914.GB233139@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
 <20200127222019.GA233139@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127222019.GA233139@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 02:20:19PM -0800, Emily Shaffer wrote:
> On Fri, Jan 17, 2020 at 04:03:19PM -0500, Jeff King wrote:
> 
> > (like trying to replace the use of "repo" in Android)
> 
> Oops, you saw right through us ;)
> 
> > It would make more sense to me to either (or both):
> > 
> >   - make sure that .gitmodules has enough information about which branch
> >     to use for each submodule
> 
> Hum. I don't work with them day to day, but aren't we already in that
> state? Is that not what the 'branch' option for each submodule means?

I've been corrected off-list that the 'branch' in .gitmodules is used
during 'git submodule update --remote', but not during 'git submodule
init' or 'git clone --recurse-submodules'. Then, for the problem in
discussion for this thread, it seems like a better choice is something
like 'git clone --recurse-submdoules --use-gitmodules' or whatever we
want to call it - e.g., rather than fetching the branch where the server
knows HEAD, ask the .gitmodules to figure out which branch?

It seems like that ought to live separately from --single-branch. In the
case where you very strictly only want to fetch one branch (not two
branches) I suppose you'd want something like 'git clone
--recurse-submodules --single-branch --branch=mysuperprojectbranch
--use-gitmodules' to make sure that only one branch per repo comes down.

With n submodules of various naming schemas, provenance, etc., I don't
think there's a good case for recursing --branch one way or another; it
seems like filling out some config is the way to go.

I guess we could also teach it to take some input like
--submodule-branch-spec=foo.txt, and/or a multiply provided
--submodule-branch foo=foobranch --submodule-branch bar/baz=bazbranch.

  [foo.txt]
  foo=foobranch
  bar/baz=bazbranch

With that approach, then someone gets a little more flexibility than
relying on what the .gitmodules has set up.

> >   - offer an extra option for the default branch to use for any
> >     submodules. This is still not general enough to cover all situations
> >     (e.g., the bar/baz you showed above), but it at least makes it
> >     relatively easy to cover the simple cases, without breaking any
> >     existing ones.
> 
> Yeah, this is sort of the direction my mind went too - "not
> --branch recursively, but --submodule-branch". But that breaks down when you've
> got a nontrivial number of submodules, at which point you're gonna have
> a hard time unless you've got the .gitmodules configured correctly.
> 
> 
> Well, as for this patch, let me try it with just --single-branch and see
> whether that works for the case the user reported. I can head back to
> the drawing board if not.

With only half the rework of my patch done, I'm starting to convince
myself it's not actually going to work :) Well, I'll still try and see.

 - Emily
