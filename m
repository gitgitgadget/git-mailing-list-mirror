Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E9C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71036216FD
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 19:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbhASTWp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 14:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbhASTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 14:13:49 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5625AC061575
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:13:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t17so16321054pgu.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0WST5k4ASI4GN2B2jlVxNCQ/elx1rCpHcr1NlPdpt64=;
        b=uquR4wyMokACam870AQZMyuu/BjAIHv0R13vHTEc6Pi4DLHraIfK/t1P6qSk77KkCr
         zNm4rtA3FykdehplRP1W0AWj1soEGrkFNwpTZc4iXNTqeaQ2jcdLpyjcfJTn+jdxNofO
         vn9zfoXP37F0Cd5gyV0JEFp/aKEfDJeahA9l4taZWITsZeCAm7Ik0dkgrWKu9vOA6Gkq
         jaetjEaswCfmIpO9DaqIeaxEO58kDPi3zAWJQEqMjD0V6jGRTv9YSf6w4vuOzbJ/7ZgU
         fufLc2VeADoiwvAsO+yRxH4a4iodk9D0146Jl6pH+co7OAEQ3A0tDVZi3A8X4fOCk4Vp
         w4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0WST5k4ASI4GN2B2jlVxNCQ/elx1rCpHcr1NlPdpt64=;
        b=hX03cHE1d1HTc+SqU0MEsjvSuUIbCQyZ9flKdJ0QrkNPNwfcpx3QskPD8VB+OlmbVS
         K+TpPqr8RZRb95oCOuaQ7Y87130xAHd1i+OvbSSWATVg9vygoXLbP+Ijx2TO3rt7foFz
         FOo0jMte/3ML4rqEDPheOJJHehBlGlAoWx6mmsOkXNWw/UFATAwa0Lw+TsG1TAdsT3Go
         J5zl3CoZxUxwcVkhbohGn3RVBTMb4rg75DN6tA2rfrmIiynssMQonPOAXRkwB46BqaiV
         0PYEy29oOPPrlny7YVCJaP1EjnbJwWTcrxUPl0Ys7z2kuu3Tcy9vOOJglSAWBeBaX9OB
         xMYQ==
X-Gm-Message-State: AOAM530h6fPagL+9+2XNBpYTu/7e7WAvuGowzsVNwH36O3iMJFFWPAH7
        g4+fOdkXwYNravZKNrY7qal+4R34piSIWoc4iSwK
X-Google-Smtp-Source: ABdhPJwwAwAwlqaCDMhlbHHhMYyMc4+9KOL6A+jWqu7EdkSNCp+vrJ/zPKaJCnLrEYN9N7RcUy7oIf/LqWn0uIKIsucT
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:ac93:b029:db:c725:e321 with
 SMTP id h19-20020a170902ac93b02900dbc725e321mr6333688plr.41.1611083588666;
 Tue, 19 Jan 2021 11:13:08 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:13:06 -0800
In-Reply-To: <d2ca2fec-a353-787a-15a7-3831a665523e@gmail.com>
Message-Id: <20210119191306.1500480-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <d2ca2fec-a353-787a-15a7-3831a665523e@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: RFC on packfile URIs and .gitmodules check
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     me@ttaylorr.com, gitster@pobox.com, jonathantanmy@google.com,
        git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm contributing a quick suggestion for just this item:
> 
> >>> This happens because the fsck part is currently being done in
> >>> index-pack, which operates on one pack at a time. When index-pack sees
> >>> the tree, it runs fsck on it (like any other object), and the fsck
> >>> subsystem remembers the .gitmodules target (specifically, in
> >>> gitmodules_found in fsck.c). Later, index-pack runs fsck_finish() which
> >>> checks if the target exists, but it doesn't, so it reports the failure.
> >>
> >> Is this because the gitmodules blob is contained in the base image
> >> served via the pack URI mechansim, and the "dynamic" packfile for
> >> the latest part of the history refers to the gitmodules file that is
> >> unchanged, hence the latter one lacks it?
> > 
> > That seems like a likely explanation, although this seems ultimately up
> > to what the pack CDN serves.
> >> You've listed two possible solutions, i.e.
> >>
> >>  (1) punt and declare that we assume an missing and uncheckable blob
> >>      is OK,
> >>
> >>  (2) defer the check after transfer completes.
> >>
> >> Between the two, my gut feeling is that the latter is preferrable.
> >> If we assume an missing and uncheckable one is OK, then even if a
> >> blob is available to be checked, there is not much point in
> >> checking, no?
> > 
> > I'm going to second this. If this were a more benign check, then I'd
> > perhaps feel differently, but .gitmodules fsck checks seem to get
> > hardened fairly often during security releases, and so it seems
> > important to keep performing them when the user asked for it.
> 
> It might be nice to teach 'index-pack' a mode that says certain
> errors should be reported as warnings by writing the problematic
> OIDs to stdout/stderr. Then, the second check after all packs are
> present can focus on those problematic objects instead of
> re-scanning everything.

My initial reaction was that stdout is already used to report the hash
part of the generated name and that stderr is already used for whatever
warnings there are, but looking at the documentation, index-pack
--fsck-objects is "[for] internal use only", so it might be fine to
extend the output format in this case and report the problematic OIDs
after the hash. I'll take a look.
