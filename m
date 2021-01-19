Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D2DC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD8223107
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 20:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbhASUQH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 15:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391717AbhASTCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:02:54 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4524AC061573
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:02:14 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id l7so20595148qvp.15
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NQU3WaplyaZwyB5jjgbV3bdluv7ydrYG20vQPGlb73s=;
        b=mMtf7knahGnd9hiqrBlO4koKnuj0BB9TL4nSgR2/hzL5PR0Al02mhvYaYX+z5aZv+b
         M6MWEFI34PF+at6WEWSY5K2mDh05NDIxxDb7Okb+ji9sD9lQHdACquW46hB2Q0sIkrcG
         QJ8TegIjBW97yyeCVS74kTSeebT1x4PmfjxuEZX/QWm+jCmOuMcDVWNoQMTx+45uo4lK
         XOT5PQE5yB1IqU+6vR1pZjXGu8ABF+85ok8vzEfrCybknpjX9usftaHFt63MOIF7vpnt
         OwVb/DJcNueN+Xgt55dDF8JKYKdCec2phTm/skxt6pQA23fC+4hhO87xA0AEZokXIMF0
         E1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NQU3WaplyaZwyB5jjgbV3bdluv7ydrYG20vQPGlb73s=;
        b=pUx0M11bzs0cWeD2pzIGF12kjGjz8MRNy9CMZKhEDqGsm0TmVPMcHESXvwzmTBs381
         TTimZsymtmuK+tkWTE+v+r4vSeTWdyVlVYcbAYgKTA34kt86+TGcutCknKcsfnOiNGlC
         JClVRKlCTk6eIeFO+ffEgRYCtvkqvpjwsr7hsI6iIReMPBBDe2KdX7MglhdQ0eyc5bvK
         tx07iLyDTU4yqLaJsLd2xHEv4HqSUSBuU98sQBZh+ppM/gVe/FbSCIubwcnfho/NYryS
         Ojuw8z1NeNrbvehrHft5G2ECQGoFTg1nnC9N6/GgQWAm3fuT+v/eFSIDkof/vfrkAmie
         DLeA==
X-Gm-Message-State: AOAM531nO7e6Xq5b5XIxSgltX953GV/SVntL17EBOAoIibaVzPBLFxU7
        8qc4VcApcz1JbzmmH3Cj+mJnQPpI+CLhM+WgT9ft
X-Google-Smtp-Source: ABdhPJz33xHctq9CPFJNMkl6L0E+Y3Y/7NGLoxkUGMBC+49rdlDI1OMn3M51YrdI0+qTAJW2QouGVSTYL+RTWNbqgaMF
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:f046:: with SMTP id
 b6mr5574935qvl.14.1611082933431; Tue, 19 Jan 2021 11:02:13 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:02:09 -0800
In-Reply-To: <YAJcDr0EPkKk0aR/@nand.local>
Message-Id: <20210119190209.1497399-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YAJcDr0EPkKk0aR/@nand.local>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: RFC on packfile URIs and .gitmodules check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     gitster@pobox.com, jonathantanmy@google.com, git@vger.kernel.org,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Is this because the gitmodules blob is contained in the base image
> > served via the pack URI mechansim, and the "dynamic" packfile for
> > the latest part of the history refers to the gitmodules file that is
> > unchanged, hence the latter one lacks it?
> 
> That seems like a likely explanation, although this seems ultimately up
> to what the pack CDN serves.

In this case, yes, that is what is happening.

> > You've listed two possible solutions, i.e.
> >
> >  (1) punt and declare that we assume an missing and uncheckable blob
> >      is OK,
> >
> >  (2) defer the check after transfer completes.
> >
> > Between the two, my gut feeling is that the latter is preferrable.
> > If we assume an missing and uncheckable one is OK, then even if a
> > blob is available to be checked, there is not much point in
> > checking, no?
> 
> I'm going to second this. If this were a more benign check, then I'd
> perhaps feel differently, but .gitmodules fsck checks seem to get
> hardened fairly often during security releases, and so it seems
> important to keep performing them when the user asked for it.

That makes sense.

> > As long as the quarantine of incoming pack works correctly,
> > streaming the incoming packdata (and packfile downloaded out of line
> > via a separate mechanism like pack URI) to index-pack that does not
> > check to complete the transfer, with a separate step to check the
> > sanity of these packs as a whole, should not harm the repository
> > even if it is interrupted in the middle, after transfer is done but
> > before checking says it is OK.
> 
> Agreed. Bear in mind that I am pretty unfamiliar with this code, and so
> I'm not sure if it's 'easy' or not to change it in this way. The obvious
> downside, which Jonathan notes, is that you almost certainly have to
> reinflate all of the trees again.
> 
> But, since the user is asking for transfer.fsckObjects explicitly, I
> don't think that it's a problem.

We might be able to avoid the reinflate if we do it as part of the
connectivity check or somehow teach index-pack a way to communicate the
dangling .gitmodules links (as you suggest below).

> > As a potential third option, I wonder if it is easier for everybody
> > involved (including third-party implementation of their
> > index-pack/fsck equivalent) if we made it a rule that a pack that
> > has a tree that refers to .git<something> must include the blob for
> > it?
> 
> Interesting, but I'm sure CDN administrators would prefer to have as few
> restrictions in place as possible.

That rule would help, but it also seems inelegant in that if we put
commits that have the same .gitmodules in 2 or more different packs,
there would be identical objects across those packs (besides the reason
Taylor mentioned).

> A potential fourth option that I can think of is that we can try to
> eagerly perform the .gitmodules fsck checks as we receive objects, under
> the assumption that the .gitmoudles blob and the tree which contains it
> appear in the same pack.
> 
> If they do, then we ought to be able to check them as we currently do
> (and avoid leaving them to the slow post-processing step). Any blobs
> that we _can't_ find get placed into an array, and then that array is
> iterated over after we have received all packs, including from the CDN.
> Any blobs that couldn't be found in the pack transferred from the
> remote, the CDN, or the local repository (and isn't explicitly excluded
> via an object --filter) is declared missing.
> 
> Thoughts?

The hard part is communicating this array to the parent fetch process.
Stolee has a suggestion [1] which I will reply to directly.

[1] https://lore.kernel.org/git/d2ca2fec-a353-787a-15a7-3831a665523e@gmail.com/
