Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D125C4363A
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35962076B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 15:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OrPvbSHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgJ2PjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgJ2PjF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 11:39:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F65CC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 08:39:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id w21so2633103pfc.7
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xm4AgRB+Wkqtj36bSlELPIWRw2HS1JsQdeCUYllGAIY=;
        b=OrPvbSHhWmhDs3VUEG/0wVbh8HyaMfKA4DAtDOUxIm2p7Exyh/uPr1j859A0y4eMuO
         PQ2GfxBhY5Lp1D6ReEN4iL1j6LensyB5yTPGtDuCvG7Zbjmo5qAjsYY0K4rmZ+DWGDrY
         +K2p+Zeu1kfh5TrusnBLB3qkaoS26B25BcVeh2CsPy0fto3HBowhgU6Zs4iotWgVkBA3
         ICZ85lfBVypnnYoqjYvPDYSe6M6jhXuYviCRWZfsxKyGUWfSd4Y6W++qPHsojSeh5DUY
         wazo1nCH/AWuu4TcNrcYuWfzYU98ro7gMd/jNwbk1FgeaYLKbBlMnsagUq0L5gmREFDi
         irKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xm4AgRB+Wkqtj36bSlELPIWRw2HS1JsQdeCUYllGAIY=;
        b=QG/S69dgCoJlSGxZ4Ot9ZWusg8h4iNC/K9p4k/GWbktWXvQxde7qLz+2IoNfDHFxoT
         AD3REJPhZCRozsgEKuCpifWRCDKZJH4oOjGXJB/4QhSxNGPgEaxDWY05lfMWhLBRa8fU
         c11+RdQy3fWprV2mmHAaxizYUfqryL6NCAvIrCuDs4BXcFGmXo+rLG0xj7f3CsF7McJN
         N5fiA5lcDPcyAY12FnRnL1k3CgCKL8HWM8NTP2CjkkwY4CzuzVMd698jCEqIOa7ugbBm
         1PEyxYEHipSEBo8xJ+xPRjIF6qLmADPCXZbCV2+1NsbVeK916CPBsSxg9kXZ/ZbqQRNr
         TbNg==
X-Gm-Message-State: AOAM533MGdN9mvTID3QJPQpimPtuFIqhlvLfnT53VQs8de+tjj8WAv20
        Omx0XzBa425mAo//ejAyJZpZZA==
X-Google-Smtp-Source: ABdhPJwFopuaQQKb5M2F+LiuidtOHYz+/Dv0jKmLDqmyXKu7PtOMzt02g/qu14emUmYiVijEDb+TvA==
X-Received: by 2002:a63:c750:: with SMTP id v16mr1367280pgg.424.1603985944415;
        Thu, 29 Oct 2020 08:39:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id j15sm3415749pfn.43.2020.10.29.08.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:39:03 -0700 (PDT)
Date:   Thu, 29 Oct 2020 08:38:58 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        h@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/9] doc: propose hooks managed by the config
Message-ID: <20201029153858.GG2774782@google.com>
References: <20200909004939.1942347-1-emilyshaffer@google.com>
 <20200909004939.1942347-2-emilyshaffer@google.com>
 <87mu0ygzk1.fsf@evledraar.gmail.com>
 <20201022005848.GD2774782@google.com>
 <87zh4chi73.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zh4chi73.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 23, 2020 at 09:10:24PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> You already use "hookdir" for something else though, so that's a bit
> >> confusing, perhaps s/hookcmd/definehookcmd/ would be less confusing, or
> >> perhaps more confusing...
> >
> > "Hookdir" might be the wrong word to use, too - maybe it's better to
> > mirror "hookspath" there. Eitherway, "hookdir" and "hookspath" are
> > similar enough that I think it would be confusing, and "hookcmd" is
> > already getting some side-eye from me for not being a great choice.
> >
> > Some thoughts for "a path to a directory in which multiple scripts for a
> > single hook live":
> >  - hookset
> >  - hookbatch (ugh, redundant with MS scripting)
> >  - hook.pre-commit.all-of = ~/last-minute-checks/
> >  -  "   "  .everything-in = "   "
> > ...?
> >
> > I think I named a couple silly ideas for "hookcmd" in another mail.
> 
> To both of the above: Yeah I'm not saying you need to do the work, just
> that I think it would be a useful case to bikeshed now since it seems
> inevitable that we'll get a "find hooks in this dir by glob" once we
> have this facility. So having a config syntax for that which isn't
> overly confusing / extensible to that case would be useful, i.e. as the
> current syntax uses "dir" already.

Yeah. I'm not sure that it needs to happen right away. Because
hook.*.command // hookcommand.*.command gets passed right into
run_command()-with-shell, it's possible for a user who's keen to also
set `hook.*.command = find -type f /some/path | xargs` in the meantime.
And also because it's passed right into run_command()-with-shell, it's
hard to do some smart wildcarding on the .command config and try to
figure out the right syntax. I'd just as soon see something explicit
like the configs I mentioned above, which can be added pretty easily
after the fact. I think what you're mostly saying, though, is "Leave
some words for glob execution!" and that I can appreciate.

> > Hum. This seems to say "folks who started their hooks with the same
> > number agree that their hooks should also run simultaneously" - which
> > sounds like an even harder problem than "how do I know my ordering
> > number isn't the same as someone else's in another config file". Or else
> > I'm misunderstanding your pseudo :)
> 
> The prefix number isn't meaningful in that way, i.e. if you have 10
> threads and 5 hooks starting with 250-* they won't all be invoked at the
> same time.

Ok. I misunderstood, then.

> > I know I rambled a lot - I was trying to convince myself :) For now, I'd
> > prefer to add more detail to the "future work" section of the doc and
> > then not touch this problem with a very long pole... ;) Thoughts
> > welcome.
> 
> I'm replying to much of the above in general here, particularly since
> much of it was in the form of a question you answered yourself later :)
> 
> Yes as you point out the reason I'm raising the parallel thing now is
> "keep users from assuming serial execution", i.e. any implementation
> that isn't like that from day 1 will need more verbose syntax to opt-in
> to that.
> 
> I think parallel is the sane default, although there's a really strong
> case as you point out with the "commit-msg" hook for treating that on a
> hook-type basis. E.g. commit-msg (in-place editing of as single file)
> being non-parallel by default, but e.g. post-commit, pre-applypatch,
> pre-receive and other "should we proceed?" hooks being parallel.

Yeah. I think you've sold me. So what I will do is thus: before I send
the next reroll (as I'm pretty much done, locally, and hope to be ready
for nits next time) I'll take a look in 'git help githooks' and see
which ones expect writes to occur. I think there are more than just
"commit-msg". I'll add a bit to run_hooks() and a corresponding flag to
'git hook run', plus relevant documentation. I'll also plan to add
explicit documentation to 'git help githooks' mentioning parallel vs.
serial execution.

But I will plan on writing it stupidly - user configurable job number
but no dependency checking; and let the user turn off parallel execution
for everyone (hook.jobs=1) or for just one hook
(hook.pre-commit.parallel = false (?)). Like you and Jonathan N say, we
can add more sugar like hookcmd.*.depends later on when we need it.

> 
> But I'm also raising a general concern with the design of the API /
> command around this.
> 
> I don't see the need for having a git hook list/edit/add command at
> all. We should just keep this simpler and be able to point to "git
> config --add/--get-regexp" etc.
> 
> It seems the reason to introduce this command API around it is because
> you're imagining that git needs to manage hooks whose relative execution
> order is important, and to later on once this lands aim to implement a
> much more complex dependency management schema.

No, I don't think that's the reason to have list/edit/add. The reason is
more for discoverability (if I 'git help git' or 'git^TAB', do I see
something handy in the command list that I didn't know about before?)
and user friendliness ("I can't remember the right config options to set
this up every dang time"). And 'list', I think, is handy for giving
users a dry run of what they can expect to see happen (and where to fix
them, since it lists the origin). Yes, a user could put it all together
from invocations of 'git config', but I personally think it's more
useful for Git to tell me what Git is going to do/what Git wants than
for my meat brain to try and guess :)

> 
> I just can't imagine a case that needs that where say those 10 hooks
> need to execute in exact order 1/2/3/4 where the author of that tight
> coupling wouldn't also desire to roll that all into one script, or at
> least that it's an obscure enough case that we can just say "do that".
> 
> Whereas I do think "run a bunch of independent checks, if all pass
> proceed" is *the* common case, e.g. adding a bunch of pre-receive
> hooks. If we tell the user we'll treat those as independent programs we
> can run them in parallel. The vast majority of users will benefit from
> the default faster execution.
> 
> The "glob order" case I mentioned is extra complexity on top of that,
> yes, but I think that concession is sane for the common case of "yes
> parallel, but I want to always run the always-exit-0 log
> hook". E.g. I've used this to setup a hook to run push
> attempts/successes in a hook framework that runs N pre-receive hooks.

Reading this, I think I'm still missing something key about what you
think glob ordering provides. I'm not following why having the log hook
set early requires glob ordering over config ordering (since the config
ordering schema allows reordering via replacement), and I'm not
following why it's required to halt on failure.

> 
> All that being said I'm open to being convinced, I just don't see what
> the target user is, and the submitted docs don't really make a case for
> it. I.e. there's plenty of "what" not "why would someone want this...".

ACK. I'll try and go over the doc again before I reroll.

 - Emily
