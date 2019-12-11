Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DEAC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0932121556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gssz1mVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfLKXZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:25:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35893 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfLKXZq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:25:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so208805pll.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ZMVvQUfzieOoBTVH53N92xrp6qs97KdsRRXMyuBhe8=;
        b=gssz1mVBxe8xIVZMOEP+BBTnMqowmmUnqtoeCJXQW+UYLw1Xyn5wmsRFP9UzybSQUe
         OOwirU5JRpz3uD7c4IfpkgnNX1K2o1VGsdroHx0Bisbe4myDweiBcBXWeWaJPi7UB74+
         F94urCgFRKcOC93PAtT35aO/LuCkKvzo+ArQBUXY007LmcwNjUUM7t604ud7nitjwhTl
         dEVZG62ITQ0OtH/j3x/wUq0lneZYalZhyyewWuLfLoBeYLTO1y6YHhJHBwYmO6YqlGL2
         wuZsEVOUtUcJcm/nlyYe6tKKDMYfnjeebrMaLBidmvn08UfYm6p1yL/Z0vYzC0xaEHVO
         yDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ZMVvQUfzieOoBTVH53N92xrp6qs97KdsRRXMyuBhe8=;
        b=OBqO/KrUi6seF2Q3SYalfPkvXXqcB+lwnls9f8MsV4xH/diBpw6NoYgt4UKwefPY9R
         WV9uQIs9NcqnfIwJcMW0mBsA4LdOvfTaCuTwAjyr9MQctiak1/4cxj6MK2Sko1Ptvjv7
         x/ihDi2t4y1JL4XcY3YSxtqNiMXmMAT4offziMrZ/RNXPORZSyG+gAKndFkl25gCbxb8
         I083ost5TYAk+pLSYzKF3RM8Zi4i9HY9cV7t01GwIo8vJ0E6HtlCaUszfalEEdC8zeJN
         hiPh3Rk8cg5oob5I9mcEp3wHgJEtDd1njmFCfDb1h+bxa0Gr/nvNIlZt4wgiPQMIiLBs
         7uYQ==
X-Gm-Message-State: APjAAAVWtihUiq7B/PbFvAg4p1nt3VZIeE/no8CipcJZ+juA4H9g2zFy
        Yaq3X7BYH/lBTDonhaw37hUOnY3+nOI=
X-Google-Smtp-Source: APXvYqzal+9tkPDCJVU16O/yCLaTjJtHQHRxThP0c6GFu4cC+zrpgHb3rVM6MoW5d+OV/sVsbG7P4Q==
X-Received: by 2002:a17:90a:7bc3:: with SMTP id d3mr6625580pjl.86.1576106745724;
        Wed, 11 Dec 2019 15:25:45 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id r62sm4468484pfc.89.2019.12.11.15.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:25:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:25:40 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Matthew Rogers <mattr94@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] config: add string mapping for enum config_scope
Message-ID: <20191211232540.GE8464@google.com>
References: <20191211220933.48678-1-emilyshaffer@google.com>
 <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com>
 <20191211231146.GC8464@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211231146.GC8464@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 03:11:46PM -0800, Emily Shaffer wrote:
> On Wed, Dec 11, 2019 at 02:19:57PM -0800, Junio C Hamano wrote:
> > Emily Shaffer <emilyshaffer@google.com> writes:
> > 
> > > If a user is interacting with their config files primarily by the 'git
> > > config' command, using the location flags (--global, --system, etc) then
> > > they may be more interested to see the scope of the config file they are
> > > editing, rather than the filepath.
> > >
> > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > ---
> > > Note: This commit has been cherry-picked out of the "configuration-based
> > > hook management" topic, at
> > > lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com
> > >
> > > It turned out that I wanted to use it for git-bugreport as well - to
> > > explain the origin of the configs we are printing in the bugreport,
> > > without directly exposing the user's home directory path.
> > >
> > > This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
> > > which I believe hasn't been mailed yet; but that change is targeted
> > > towards the builtin config command, rather than the config library.
> > > Since I wanted to use the library, I'm sending on my own now. Maybe
> > > this commit will be useful to that change's author.
> > 
> > One thing I wondered about this in the original version was if the
> > returned value should be localized.  In the context of the original,
> > the --porcelain mode refused to give this information in its output,
> > so it was OK to always localize the returned value to satisify the
> > other caller who wanted end-user-facing output.
> > 
> > But as a more general helper, I am not sure if this is the most
> > useful way to implement it.  Shouldn't the function rather return
> > the machine-readable tokens and allow callers to localize it as
> > needed with its own _() around the returned value?  I dunno.
> > 
> Hm. I think that's a good point, and allows this helper to be used for
> something silly like putting together a sample invocation to 'git
> config' if desired. It's meant to mirror the scope given to 'git config'
> - which makes me think that no, it shouldn't be localized, since the
> argument isn't localized either.

Huh. One interesting piece is that the code talks about .git/config as
"repo" config, whereas 'git-config' talks about "--local". Does it make
sense to teach this enum stringifier that CONFIG_SCOPE_REPO means
"local"? I think CONFIG_SCOPE_REPO is used for "--worktree" too, so
perhaps it's better to let "repo" mean "local or worktree".

> 
> Ok, I'll take the locale marker off.
> 
>  - Emily
