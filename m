Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA14BC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9BA20663
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRpYRBy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfLKX11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:27:27 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfLKX11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:27:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so138972pgf.1
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59ek6zBVfOWrlMtR5YXu7lNrSniYVdLK2ya4gk+imTo=;
        b=tRpYRBy6HxKc72c+a6JH+wSIrpnq52xe6RepbsJ+cWytoBkJzeXV2QOaL6kRAvOI4v
         Bq8bJtwfuOB90vf6Lj10G+/QMtNhSZHcfvzhCFMeq7uUyqT0h+SAMvN7XzRdyEPuiqJz
         znZVQWlcK5Tx0BCFIE8ohUOnfotBA9N8bwk7v9+X79Z3BMSPLDXfvmcJE3F/LR9ICg3z
         s4Jdm/hDsaaSj06uFXjMBpnQa9deqbzkWcpbJp4mIPD9j7W3AOhRAEhmVC7lt+JIbD8o
         nAbLNSJoVNbiT7miN7tNm3FcKcVvKTOdlZdmQY+dZLDRSk5cizwxNrPbl9sZEf5/mc5M
         hIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59ek6zBVfOWrlMtR5YXu7lNrSniYVdLK2ya4gk+imTo=;
        b=RPgu34KO207WltwGMNLA8PAgaXHeOPiChWlOAZdWqCZ9wI/M5G4HOXIcxFZeFklM89
         881vYF0yg+JFthL/4q5HUaH+GY6Ifk2D9DWLQFdsJWDICmsk6I6WmqWg0K5N1/+UeeNC
         Pel+HW+H5g0593Y5X2sH+Ewb5+Bh3UOPXltzhNPhEkosPIaULE4B0oUjDQmzM97+BWr+
         klzqiee38WZ+RBtG9k8QvmJ9EtU2dFgfdTc2LS8KNxXhRfiuqPOXw7wX969jDsghmlH2
         yAm9oKHFpeXKDhhGXNYiHZsnW+Z378gR067h/DyHDv48jxy4MvTKusUCzpTJvk2i53ZA
         3IbQ==
X-Gm-Message-State: APjAAAX8R5VOrU6w12WyPJGD+RmsC2JpkivP8WGpfcqZiMhfgkx00qTY
        /NH+TrrCmPWtKo/2v9NcvlDacV+dIyc=
X-Google-Smtp-Source: APXvYqytlI021cKsasPkBfUv5x17gDPPwOm24jDbg8Pi0Y1TM043SNEWnk1NikCc5iMGIT4GFnKq7A==
X-Received: by 2002:a63:e608:: with SMTP id g8mr6889764pgh.448.1576106846147;
        Wed, 11 Dec 2019 15:27:26 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id in19sm3434834pjb.11.2019.12.11.15.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:27:25 -0800 (PST)
Date:   Wed, 11 Dec 2019 15:27:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Matt Rogers <mattr94@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH] config: add string mapping for enum config_scope
Message-ID: <20191211232721.GF8464@google.com>
References: <20191211220933.48678-1-emilyshaffer@google.com>
 <xmqqsglqmrn6.fsf@gitster-ct.c.googlers.com>
 <20191211231146.GC8464@google.com>
 <CAOjrSZuOOG=MbetP0RWYwLB+Zv5EZAHqkvkm0+WkBmSqxXiVTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOjrSZuOOG=MbetP0RWYwLB+Zv5EZAHqkvkm0+WkBmSqxXiVTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 06:14:44PM -0500, Matt Rogers wrote:
> Another thing I also want to point out is that outside of this
> function... when git config is called with the --local, etc. the
> config scope is not actually CONFIG_SCOPE_LOCAL but
> CONFIG_SCOPE_UNKNOWN.  This is because the config machinery pretty
> much equates --local and --file=./.git/config as pretty much
> equivalent (assuming ./.git is the actual repo directory location).
> So just something to keep in mind.

Hm, that's interesting and sounds like a bug to me. But for this helper,
which is context independent, I don't think it should be addressed.

By the way, we're glad to have you contributing Matt - as a point of
order this list tends to prefer bottom-posting or inline replies.
Welcome!

 - Emily

> 
> On Wed, Dec 11, 2019 at 6:11 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> >
> > On Wed, Dec 11, 2019 at 02:19:57PM -0800, Junio C Hamano wrote:
> > > Emily Shaffer <emilyshaffer@google.com> writes:
> > >
> > > > If a user is interacting with their config files primarily by the 'git
> > > > config' command, using the location flags (--global, --system, etc) then
> > > > they may be more interested to see the scope of the config file they are
> > > > editing, rather than the filepath.
> > > >
> > > > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > > > ---
> > > > Note: This commit has been cherry-picked out of the "configuration-based
> > > > hook management" topic, at
> > > > lore.kernel.org/git/20191210023335.49987-1-emilyshaffer@google.com
> > > >
> > > > It turned out that I wanted to use it for git-bugreport as well - to
> > > > explain the origin of the configs we are printing in the bugreport,
> > > > without directly exposing the user's home directory path.
> > > >
> > > > This seems to have similar work to https://github.com/gitgitgadget/git/pull/478
> > > > which I believe hasn't been mailed yet; but that change is targeted
> > > > towards the builtin config command, rather than the config library.
> > > > Since I wanted to use the library, I'm sending on my own now. Maybe
> > > > this commit will be useful to that change's author.
> > >
> > > One thing I wondered about this in the original version was if the
> > > returned value should be localized.  In the context of the original,
> > > the --porcelain mode refused to give this information in its output,
> > > so it was OK to always localize the returned value to satisify the
> > > other caller who wanted end-user-facing output.
> > >
> > > But as a more general helper, I am not sure if this is the most
> > > useful way to implement it.  Shouldn't the function rather return
> > > the machine-readable tokens and allow callers to localize it as
> > > needed with its own _() around the returned value?  I dunno.
> > >
> > Hm. I think that's a good point, and allows this helper to be used for
> > something silly like putting together a sample invocation to 'git
> > config' if desired. It's meant to mirror the scope given to 'git config'
> > - which makes me think that no, it shouldn't be localized, since the
> > argument isn't localized either.
> >
> > Ok, I'll take the locale marker off.
> >
> >  - Emily
> 
> 
> 
> -- 
> Matthew Rogers
