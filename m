Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1257C4338F
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E88160F57
	for <git@archiver.kernel.org>; Tue, 27 Jul 2021 00:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhG0ARK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 20:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhG0ARK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 20:17:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EA6C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:57:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j1so15398989pjv.3
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=niXLb99VsDACXcJ5xe6wMbh3fCWRK9cDWF8AaxsNRno=;
        b=o3f4qppvgQ7vO4z7e7P8KC2YQ4w5f/GcKXN49HxwIQyWGZzdr5f80KsN5xqzAlz7Yj
         zupybHCbkCLTdGT6S7QoQJm6EF0NEE4BHvAJUAJrUSVc5neWZYi9jI1QnL2ngNY2iPO5
         uhMagOTue4vmyZR1GwY10AcfGDkpXzt7DoAoD+He3jNhCOgda2f0YjnBG6mMSuuyytF/
         4NQoO4xu/sw0wzkJkzockitn64DdHiuiKbkmIwhw+FFjuzjZXKnP5dgPKt4nDUUti912
         WD5oZuROk8d3A9GA/g0K0guETu/kJRBZnuCbpSLAAH86Rwakf6rn5Nf4a8F2+7S0Nrad
         DA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=niXLb99VsDACXcJ5xe6wMbh3fCWRK9cDWF8AaxsNRno=;
        b=kBs/lPqQ51k6ex6doX1wd68bSaFRBngGOIbcofG587s1QT3i/LB/riMw/rDohj86g2
         QJxJ3dqO2C6kdqhsDjR0BsuJXuFYDk+qJ92T41cb0qo4KXqQ+z/S0tmLIIm0zajNdXew
         P2x8rB5I3N7hncg0YFtJP7U0YaEXHzbyYP829sFI1z0Kr1xIETr7SfCzO+MOUTqG/2yn
         v1tjIJHintshEluP0y3AqO1Gf4poITjb71xIbJ47iWlK2Uu0cotgA9fbkeGbFqm9frBl
         yPxrQOJ/ZfHXeUh7MSL46WHgNuPG6dw9QwgpN7otrTBawrqRWWRxnQaivNmfW2yLDTVd
         jcIA==
X-Gm-Message-State: AOAM531aO5I10MQENn0DJeqcNeTkrm8GR2g3r5OOML0+ypoaVgpdCAxQ
        sg4VQqd5zaDlG7b5jWaSOwKqxA==
X-Google-Smtp-Source: ABdhPJyplJz5483VTHS480Nki5+jk7Jwq+BXWXzqUws9sQj8wp0PtsvgBVSyC3FqOeHU0B/WPWhTzg==
X-Received: by 2002:aa7:8d10:0:b029:303:8d17:7b8d with SMTP id j16-20020aa78d100000b02903038d177b8dmr20278224pfe.26.1627347456767;
        Mon, 26 Jul 2021 17:57:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:bde2:a44c:48a7:2f4])
        by smtp.gmail.com with ESMTPSA id e23sm1274793pfd.26.2021.07.26.17.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:57:36 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:57:30 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, iankaz@google.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v2 2/2] hook: remote-suggested hooks
Message-ID: <YP9Z+pDT6eZtlJhi@google.com>
References: <87o8awvglr.fsf@evledraar.gmail.com>
 <20210720214809.3596513-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720214809.3596513-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 02:48:09PM -0700, Jonathan Tan wrote:
> 
> > This is a bit orthagonal to what you're going for I guess, so sorry in
> > advance about the "but what about" bikeshedding you must be getting
> > tired of by now...
> 
> No - thanks for taking a look. More ideas are always welcome.
> 
> > ...but this part makes me think that if this is all we're aiming for as
> > far as server-client interaction is concerned we'd be much better off
> > with some general "server message-of-the-day" feature. I.e. server says
> > while advertising:
> > 
> >     version 2
> >     agent=...
> >     # does protocol v2 have a nicer way to encode this in the capabilities? I think not...
> >     motd=tellmeaboutref:suggested-hooks;master
> 
> Right now we don't have a way in capabilities to include arbitrary
> strings, although we can extend it if needed.
> 
> > Client does, while handshake() etc.:
> > 
> >     # other stuff
> >     command=ls-refs
> >     ....
> >     0000
> >     # Get motd from server
> >     command=motd
> >     0001
> >     refat suggested-hooks $SUGGESTED_HOOKS_AT_OID
> >     refat master $MASTER_AT_OID
> >     0000
> > 
> > And server says, after just invoking a "motd" hook or whatever, which
> > would be passed the git version, the state of any refs we asked politely
> > about and the client was willing to tell us about etc.
> 
> Ah...so the main difference is that it is the server that computes
> whether a message is shown, based on information provided by the client
> (different from my patches wherein the client computes whether a message
> is shown).
> 
> I'm not sure how this is better, though. We don't need to build another
> mechanism to print server messages (since it can already do so - the
> same way it sends progress messages), but then we lose things like
> translatability, and we have to build another endpoint for the server
> ("command=motd").
> 
> Also, one thing to think about is that we want to be able to prompt
> users when they run hook-using commands (e.g. "commit"). With my
> patches, the necessary information is stored in a ref but with your
> idea, we need to figure out where to store it (and I think that it is
> not straightforward - I'd rather not use config or extra files in the
> .git directory to store remote state, although if the Git project is OK
> with doing this, we could do that).

I think this is a pretty important point. To me, the ideal flow looks
like this:

 - I clone some repo, planning to just use the source code. I ignore the
   hook prompt.
 - I notice some bug which is within my power to fix. I have forgotten
   about the hook prompt, because I was having so much fun using the
   source code in the repo.
 - I 'git commit' - and 'git commit' says, "Did you know this repo
   suggests installing a commit-msg hook? You can install it by running
   'git hook install pre-commit' and run it by running 'git commit
   --amend --no-edit'. You can audit the commit-msg hook by running 'git
   hook magic-audit-command-name-tbd'. You can hide this advice <typical
   advice-hiding advice here>."

That way I don't add privilege (tell my computer it's OK to execute code
I didn't look at) until the very possible moment. This workflow also
captures changing intentions - I did not clone the code intending to
contribute back, but at the moment my intentions changed, I was nudged
to answer differently to a question I was asked with different earlier
intentions. That use case isn't easy to capture with a MOTD, unless you
run one on push, at which point it may be too late (e.g. if while fixing
I also accidentally uploaded my oauth password, and now it'll live
forever on GitHub in infamy).

MOTD approach also makes it hard to *update* hooks when the maintainer
so recommends - would be nice to have something baked in to notice when
there are new changes to the hooks, so we hopefully don't have
developers running hook implementations correlating to the date they
most recently cloned the project.

 - Emily
