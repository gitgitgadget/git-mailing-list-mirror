Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C759AC43334
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 08:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGXI70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 04:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXI7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 04:59:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C32C12AA3
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 01:59:24 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 281DB5D101;
        Sun, 24 Jul 2022 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658653163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQQ6ROCcsQHTiGFYu9vYDFSOOgCgFwM0LYzF+PDlFw4=;
        b=PxRdExesbZG9prJpjOvH1JIQFhmZoJXXQauF7dZqNERWZv7BrAofFPIrwt24mS8FYgBy1B
        mHBZ/9XYPtQJyCxT7NmLGvMiMwDU3ar2x5LC53R0uuyUX3cWrOIMYHc3x+Iqk1aAgZm5zL
        u53YMJMmKF2j0nWMVMrAHXtjqTo6LBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658653163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQQ6ROCcsQHTiGFYu9vYDFSOOgCgFwM0LYzF+PDlFw4=;
        b=aaGyVU8247bZh5o8OZ8F+mdwOOcqXs/3eQJeFLsAhpxFVqlsRs+ia+fwsxg5qXfIvTjvc2
        quShIps6DHamgCCw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F34A62C16F;
        Sun, 24 Jul 2022 08:59:22 +0000 (UTC)
Date:   Sun, 24 Jul 2022 10:59:21 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220724085921.GH17705@kitsune.suse.cz>
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
 <20220722203642.GD17705@kitsune.suse.cz>
 <CABPp-BFGLXRvwZGdF543me2qBXq3HB-TuzW6j7GVb6ATw3qNeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BFGLXRvwZGdF543me2qBXq3HB-TuzW6j7GVb6ATw3qNeQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 10:10:11PM -0700, Elijah Newren wrote:
> On Fri, Jul 22, 2022 at 1:42 PM Michal Suchánek <msuchanek@suse.de> wrote:
> >
> > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> > > On 21/07/2022 19:58, Hilco Wijbenga wrote:
> > > > On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wrote:
> > > >> Ęvar Arnfjörš Bjarmason <avarab@gmail.com> writes:
> > > >>
> > > >>> This has come up a bunch of times. I think that the thing git itself
> > > >>> should be doing is to lean into the same notion that we use for tracking
> > > >>> renames. I.e. we don't, we analyze history after-the-fact and spot the
> > > >>> renames for you.
> > > >> I've never been a big fan of that quality of git because it is
> > > >> inherently unreliable.
> > > > Indeed, which would be fine ... if there were a way to tell Git, "no
> > > > this is not a rename" or "hey, you missed this rename" but there
> > > > isn't.
> > > >
> > > > Reading previous messages, it seems like the
> > > > after-the-fact-rename-heuristic makes the Git code simpler. That is a
> > > > perfectly valid argument for not supporting "explicit" renames but I
> > > > have seen several messages from which I inferred that rename handling
> > > > was deemed a "solved problem". And _that_, at least in my experience,
> > > > is definitely not the case.
> > >
> > > Part of the rename problem is that there can be many different routes to
> > > the same result, and often the route used isn't the one 'specified' by
> > > those who wish a complicated rename process to have happened 'their
> > > way', plus people forget to record what they actually did. Attempting to
> > > capture what happened still results major gaps in the record.
> >
> > Doesn't git have rebase?
> >
> > It is not required that the rename is captured perfectly every time so
> > long as it can be amended later.
> 
> "so long as".  Therefore, since it can't be amended after the commit
> is accepted/merged, it is required that this auxiliary data be
> captured perfectly before that time if it's going to be captured at
> all.
> 
> Did I read that right?

Or it will be broken after it is merged, just as many other things in
commits that are accepted into history that is not to be modified
anymore.

The only point I can see here is that if there is any user-crafted
metadata that describes renames then it should be considered advisory,
and an option to override it should exist because it may be wrong.

Nonetheless, if such feature existed users that are willing to generate
such metadata and review it before it gets merged may get more out of
the rename tracking than can be done automatically today.

Thanks

Michal
