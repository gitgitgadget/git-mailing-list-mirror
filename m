Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726E7C433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3843265295
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCHTO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 14:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhCHTO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 14:14:28 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76FC06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 11:14:28 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gv10so224850pjb.3
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 11:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=v+sqrTv+V4ez4WFQtjegovqL5hGrcSSAGp1MFk6+OTo=;
        b=GXm1uCLWDgwn14Qi75FMuFBRkkDc0FEVF9k2RvqYH2Q100UHU+ZHtuYNIuUN7fO/ns
         tUhpB0llq7av+TRx6lX5PF936anTkMe4MnVqzBG16aSs5OHQiP3Z9sm/fpLgd4Ar3YQA
         ZYbN7SkJl9xH3sMh6pnbc8X6+rjF9A4wLs9708/VGquvDbaHEuS+IQaaqVWGrIypsNNc
         z66ucoJ+ZGMoGUx7BSN3W8zTr6I089mbTRQfO6u9N+eQsFCBs8sITGGqHc5FMo0EqcX3
         J48fcWtTJ06f9z364CTKQE4Of9alYJp1nfA/Mg9p3lgb6vwmVhK7UFR3FTic2bBYTB9N
         rCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v+sqrTv+V4ez4WFQtjegovqL5hGrcSSAGp1MFk6+OTo=;
        b=FJmnRClet5efo6XoF0OTLfMp9h11J9lLsS1Imtxmu++/3HxeziUJlfIghwyDucgLcK
         88O0ZXciPKE8FAad13Ja92u9GhjfveoN5Og8WuHzyb5cYVnCTtb48E4mqtLPO6SJ+3IW
         81NQmMnlRqhy+S9QFexS6xPVC40x8YFZRVj0VsEj9mJwVcac4d3tXuIU5LDBOgLgnhSH
         DB2YxQKtwYCZVZ6E6qjjBc5ymxDzuQN3Xj4kfgVRMXs0QbdfXGMfC/fVvcs0T3OB80Vd
         BxK5DHRutIlaJ5djCpijj7bDIglwuY1WpJZsmvKdrH5soVuVH2V14ZDzscc9j9rRF2Gx
         BfJw==
X-Gm-Message-State: AOAM5332ZbfO52At0x7k0ESdnTUag3khnxrlBi8tGlLHEMp3/JcEhFmX
        WAuXnDC8nFYB/ytJRD6NkStaueDRrhsecyDjO0Fk
X-Google-Smtp-Source: ABdhPJz7Si6NMyP5brECeP1fOYG5R9F5HCnIKovEPzNMCwiC82+/GEhvOhG5MvaC/F/H6HjO1FL4knGk+Nt4/z7+y0Tk
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:b08b:b029:e4:deb:69a9 with
 SMTP id p11-20020a170902b08bb02900e40deb69a9mr21587163plr.35.1615230867708;
 Mon, 08 Mar 2021 11:14:27 -0800 (PST)
Date:   Mon,  8 Mar 2021 11:14:24 -0800
In-Reply-To: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
Message-Id: <20210308191424.12149-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqv9a58a18.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > I should probably have written more in the commit message to justify the
> > unification, but it is also part of a bug fix (in particular,
> > --fsck-objects wasn't being passed to the index-pack that indexed the
> > packfiles linked by URI) and for code health purposes (to prevent future
> > bugs by eliminating the divergence). So reverting that commit would
> > reintroduce another bug.
> 
> Not necessarily.  Unifying two that do not inherently have to be
> identical makes it impossible to pass two different things, and that
> is what we are seeing in the bug this patch is trying to fix (by
> forcing the two to be identical by eliminating the unpack-objects
> codepath in certain cases).  
> 
> The right "fix" for the original bug would have been to keep them
> still separate yet making it easy to pass args that must be used in
> both of them, no?

OK - I'll do this.

> >> > -		if (do_keep && (args->lock_pack || unpack_limit)) {
> >> > +		if ((do_keep || index_pack_args) && (args->lock_pack || unpack_limit)) {
> >> >  			char hostname[HOST_NAME_MAX + 1];
> >> >  			if (xgethostname(hostname, sizeof(hostname)))
> >> >  				xsnprintf(hostname, sizeof(hostname), "localhost");
> >> 
> >> I do not quite get what this hunk is doing.  Care to explain?
> >
> > The "do_keep" part was unnecessarily restrictive and I used a band-aid
> > solution to loosen it. I think this started from 88e2f9ed8e ("introduce
> > fetch-object: fetch one promisor object", 2017-12-05) where I might have
> > misunderstood what do_keep was meant to do, and taught fetch-pack to use
> > "index-pack" if do_keep is true or args->from_promisor is true. What I
> > should have done is to set do_keep to true if args->from_promisor is
> > true. Future commits continued to do that with fsck_objects and
> > index_pack_args.
> 
> > Maybe what I can do is to refactor get_pack() so that do_keep retains
> > its original meaning of whether to use "index-pack" or "unpack-objects",
> > and then we wouldn't need this line. What do you think (code-wise and
> > whether this fits in with the release schedule, if we want to get this
> > in before release)?
> 
> How bad is the breakage this one is trying to fix?  I know it would
> only affect folks who have to interact with the server that uses
> packfile URI feature, but do they have a workaround, perhaps with a
> configuration knob or command line option to ignore the packfile
> URI,

Yes, there's a workaround (to disable packfile URIs from the client side
using a config variable).

> and how large is the affected population?

The only issues I've seen are within $DAYJOB, and there, we can carry
our own patch to fix this issue. So the affected population (right now)
is probably not much (if it even exists).

> I cannot shake the feeling that we are seeing band-aid on top of
> band-aid forced by having chosen to go in a wrong direction in the
> beginning X-<, and prefer to see the code drift even further into
> the same direction; hence my earlier suggestion to go back to the
> root cause by first reverting the wrong fix that introduced this bug
> and fixing the original bug in a different way.
> 
> I dunno how involved the necessary surgery would be, though.  If
> this is easy to work around, perhaps it might be a better option for
> the overall project to ship the upcoming release with this listed as
> a known breakage.

I don't think it's too difficult - I think we'll only need to filter out
the --pack_header when we figure out the arguments to pass for the
packfiles given by URI. I'll take a look.
