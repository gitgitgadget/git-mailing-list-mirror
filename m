Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81EC4BA06
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4482075D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 23:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FdombNVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgBYX4G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 18:56:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40953 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBYX4G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 18:56:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so426126pfb.7
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 15:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wloxQNnvidh/h4WTa4+SacYT0PNMngv8E/fd1jcaxF8=;
        b=FdombNVMENvBZk1inHCo0K6KaBimHj0D6nxg8eX7oomObg1S2EVPgnr0uXvBJ4eCNr
         B10Zd20IkN0pfIRTzHdwouKmoyIzezqYozRF4jppKsx2abs4Nvbg1MvXzDetN3BuoSc3
         91MsIB1uIaoZfgS3hRoiCOtn4QjyAlRK056ixnrvEmWdPR50fvXzOI3G76ob65S7t9rl
         ofVV31KOamwDY4GI9XXhuvWERkDwSHWsXyv/gpkVgfZHMcfmU+qNOxffItWhAkgaJN/q
         OWGlT2IKD9sO++motugSLuqzcerjO4DCPa4I0ILVhLMIZ9sntFO/4EBnnEmQcP5rMS1A
         lIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wloxQNnvidh/h4WTa4+SacYT0PNMngv8E/fd1jcaxF8=;
        b=cWhS6JdRM/A9OfJ0HGJkZpkHfLJTutsGO3CLZPNWJzux/MLD6iJ20yq1FF4rxJBABx
         rDudsHB93Av0AeH+aVRhG8+lv0elSttbx2XQMv8pcqb243e3FlS0/zR3Dqrl4R9rl3kS
         FgheS11LUs4GUynwLqYw31R2i/98jC41+wCQbUnk3wtiBQazojtFYXsVCEG1R0AaTb9j
         84bY3XqxVJ4XJ9mZb9rIv2E/lVjQZcUqVR9X0jg249JR6qNWFnrfGGIwLZkOIW7kbCUX
         Yd7g3W43vuJTq33H4ADUoXTAdYzQQbFenRwZlhDy0ng7KW475/MYIrrNLpRreUl6rqN2
         Nx/Q==
X-Gm-Message-State: APjAAAXfV+wvkMSMo3j7WjWsk565iZhq0VVvwfo+oI1swFc7rRpJQkeq
        BUx4HEkZiqbohB5AUkcGfQUDc+Q2jm8=
X-Google-Smtp-Source: APXvYqyeImJe6tnjg1EdwQKj4DRFWmSuXVKBiNRxuQj/JPMU2mkGDzWL3hPmf97OgNT2DBggzux8iA==
X-Received: by 2002:a63:6101:: with SMTP id v1mr956357pgb.318.1582674963574;
        Tue, 25 Feb 2020 15:56:03 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id c26sm220123pfj.8.2020.02.25.15.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 15:56:03 -0800 (PST)
Date:   Tue, 25 Feb 2020 15:55:58 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
Message-ID: <20200225235558.GG212281@google.com>
References: <20200220015858.181086-1-emilyshaffer@google.com>
 <20200220015858.181086-8-emilyshaffer@google.com>
 <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
 <20200220232812.GH2447@google.com>
 <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
 <20200225220838.GB212281@google.com>
 <xmqqimjukzzv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqimjukzzv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 25, 2020 at 03:29:08PM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Hm. I guess I got the opposite impression from you way back in v1. I do
> > wish it had been communicated a little more clearly; it's frustrating to
> > perceive a reversal after seven months of review. But that's probably on
> > my own reading comprehension :)
> 
> Well, seven months is a long time for anybody to learn from repeated
> reading and gained experience to form an opinion and get affected by
> others' opinions.  In any case, this is one of the reasons why I try
> to discourage people to have too many topics in flight before moving
> on to a new and different topic---the risk of ending up with fliping
> and flopping is just too high when you give people chance to forget.
> Rather, I'd prefer to see something simple to land first and then
> later refined.

I think it's exactly what happened with this topic. It's easy to say
"don't have too many things out at once" in theory - but becomes less
easy when you combine it with things like quarterly planning at dayjob,
etc. In fact I have been trying to revive and push through old topics I
had in flight because I had this same realization - my six topics were
only each updated every month or so, meaning everyone (including me)
forgot what was going on from revision to revision.

I wonder whether it makes sense to try and finalize the bare minimums of
this feature, and then move the rest of the work to their own topics. I
see a couple benefits:

 - Users can start trying out 'git bugreport' when they write us mails
   much sooner. Even the template alone would increase the quality of a
   number of the reports I see come into this list.
 - It may help insulate this topic from 'feature creep,' which in my
   opinion has plagued it from the start. While the entire topic of 15
   patches is in flux, it's hard for someone else to write their own
   patch adding, say, midex/commit-graph support, and so I feel
   obligated to write it myself - which of course increases the amount
   of time the topic lives on in review.
 - Of course smaller topics are easier to review, and a commit-graph
   expert is much more likely to click on the subject "[PATCH]
   bugreport: gather commit-graph diagnostics" than they are to click on
   the subject "[PATCH] add bugreport utility". That is, I'm guessing
   there will be more reviews on the semantics of the patch (is it the
   right diagnostic info? is it useful?) than there have been so far.

The downside is mailing list churn, and the possibility that with a
minimum 'git-bugreport' checked in I find something better to do. I'm
not too worried about the former; after all, that's what this list is
for, right? As for the latter, after 7 months of flip and flop I don't
think the risk is greater than it is now anyways ;) I think it makes
sense to send the following topics:

/* To me, this sounds like minimum viable bugreport. "What went wrong,
 * and how do I build the same binary as you so I can reproduce it?"
add git-bugreport tool:
 - bugreport: add tool to generate debugging info
 - bugreport: gather git version and build info
 - bugreport: add uname info
 - bugreport: add compiler info

bugreport: add git-remote-https version

bugreport: include shell info
 - help: add shell-path to --build-options
 - bugreport: include user interactive shell

bugreport: include config info
 - help: move list_config_help to builtin/help
 - bugreport: generate config safelist based on docs
 - bugreport: add config values from safelist

bugreport: collect list of populated hooks

bugreport: include object store info
 - bugreport: count loose objects
 - bugreport: add packed object summary
 - bugreport: list contents of $OBJDIR/info

I'd like to send that first topic as vN+1 of this one, and I can hold
the rest of the branches locally until we get it ironed out; once that
topic makes it through to 'next' then I can send the rest again. What do
you think?

> On this particular issue, I actually do not have a preference.  As
> long as the topic has a coherent position/stance, any one of
> 
>  (a) we do as much i18n as possible to help end-users, or
> 
>  (b) we stay away from i18n to ensure the reports are machine
>      readable, or
> 
>  (c) somewhere in between with a clear criterion where you are
>      drawing the line (e.g. "the introductory text is what we want
>      the end-user to read, so it is i18ned, but the report about
>      their environment are primarily for our use and we avoid
>      localizing so that we can process mechanically"),
> 
> is fine.  The important point is that we choose what we do with a
> solid guiding principle behind the decision.
> 
> In practice, every string in bugreport.c you have control over the
> use (or non-use) of _() around it, but codepaths that you call from
> existing parts of the system are likely to have their messages
> localized if they are meant for Porcelain use.  So from that point
> of view, (a) would be easier to arrange than (b), I suspect.

Hm. Sounds convincing enough to me.

 - Emily
