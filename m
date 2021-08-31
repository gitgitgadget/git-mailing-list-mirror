Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEB3C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7725E60FD8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 11:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241087AbhHaLCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhHaLCt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 07:02:49 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3CC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 04:01:54 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z18so34006324ybg.8
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KIStqNAy2HNE4sMh1FwjSwhtUaXENcyhISXshy0b/k=;
        b=OhaGX57hIh4s11KZytGgUlRg9udHsKKgKTZ08TsaSJ1A9hvaW60+SRlJq4iFdEHpYt
         +oRTmsU8E0mvAQU2g2fGCwWk3qRhAsUqfUgO3PYLnSj0/gLXlz9em3aFGamwAiXTDTKF
         yD6FCxBufJ8ZGI0jzUwW5/oyry7Y4PJKgJCy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KIStqNAy2HNE4sMh1FwjSwhtUaXENcyhISXshy0b/k=;
        b=t0cSvNYe/BtZGUc7XRMSEO5zEbV+h7rYmRwFYcp76RdmTm70/1hhnzTTbHNVxXGeqt
         apJLq5zyy9z1+/fo/4MbP1pONzdGSTAFCWN8QC/n77tz0CxqC5ShlqwNybH7B0jB0RqX
         sBeZpYMb04T0tCyjEz+6IC8xuDwrsTWqirvA+CFCALsMrFqoXIw+MInjGyvs37QR4679
         iukyahprI56vs9Orsedzke8QUaxaMvjV2W0ttniHg4USxvJ3fm12clNCLY1jqtik2FRI
         6qOOshh19xcnsMIJZwU5+2n9cO1NSwL9qmWPYQH0jXGA5V9XbmBmQQEyYCUPfGLW03QH
         sOuw==
X-Gm-Message-State: AOAM532T1elSpeMQaYXpdbYYSzQmlL9mjQJbj4Q49+ZF3kVoiHx1j0We
        p2CCwRlhGi80+V3IaDOv15ShAtuXM80BfQtcCU1dc5tiAdI=
X-Google-Smtp-Source: ABdhPJyG0bdWN0uoUdzDnt6Ntqn0u7F8HFDnpaHEcjKRPhgnmL+HrL4X+W4tEVc7nQnPDJ6K52N3SDGJoFSm2Y3D46w=
X-Received: by 2002:a25:e013:: with SMTP id x19mr30434614ybg.366.1630407714018;
 Tue, 31 Aug 2021 04:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1032.git.git.1623098845733.gitgitgadget@gmail.com> <CAJDDKr4rXEZDH4ZNU1ieUcfpOseikOVVfFQ=1tG9YNr2nibLCQ@mail.gmail.com>
In-Reply-To: <CAJDDKr4rXEZDH4ZNU1ieUcfpOseikOVVfFQ=1tG9YNr2nibLCQ@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Tue, 31 Aug 2021 12:01:23 +0100
Message-ID: <CA+kUOamRLtsArhjMpo7A28=6vPabry8KsjM022gZ4nxDj0wU-Q@mail.gmail.com>
Subject: Re: [PATCH] use get_merge_tool_path() also in is_available() to honor settings
To:     David Aguilar <davvid@gmail.com>
Cc:     Michael Schindler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Michael Schindler <michael@compressconsult.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 30 Aug 2021 at 01:09, David Aguilar <davvid@gmail.com> wrote:
> I'd like to extend 47eb4c6890 (mergetools/kdiff3: make kdiff3 work on
> Windows too, 2021-06-07)
> but in order to do so I need a reliable way to special-case Windows so
> that we only do the x -> x.exe translation there.
>
> What's the best way to detect Windows? t/test-lib.sh seems to detect
> Windows using "uname -s" and
> checking for matches against *MINGW* or *CYGWIN*. Is that reliable /
> recommended?

I don't think there's a single canonical way to do this, but that's
certainly an effective way.

However I'd suggest not adding special-case code for Cygwin here, only
for MinGW: the general design principles for Cygwin are such that
*nix-native code should require minimal changes to work on Cygwin, and
in particular the Cygwin compatibility layer should look after adding
that extension, rather than requiring the application code to handle
the special case. Both approaches would work, but I think it makes
sense to follow the general Cygwin design principle here of not adding
unnecessary special casing to handle it, and to leave it to the Cygwin
compatibility layer instead.
