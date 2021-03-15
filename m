Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA92AC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62CD64DD7
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 08:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhCOIRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:17:06 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37714 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhCOIQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 04:16:58 -0400
Received: by mail-ej1-f42.google.com with SMTP id bm21so64611424ejb.4
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 01:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rTtbd5KaBHW8iRZcQkF5zjhjtQNkrMNLBsHkRCB43R8=;
        b=VYAQd5MV/yqA3owtexwZR5x0PhC2+3ZEpEPqhOhfkBP31uw+QqUF2KdO5s17c1+EES
         YN6Gl8B8Zcxk0yvFCmOyOuuhKBy0zTr3oT2Rhon+c+/qGv0BUKuPb4LzOI/wVOjPQhO8
         7vm2nLEJBMTtZUSRVKjyzcMv5rgbNC5/wWJFXPfzFvUIFwdr2MKRH0Sy3wNxdRTAazzh
         Mp4Y+dLPhDGT+ZJDjxVUH56lTf6qjEh3BtthSyK+2oplCTztXWQLAqx0z7ryROdW/h+o
         nBFpoOLzKO2Yd0p0H1qozq1f7QMS7wjNJD//ApqfJ80j6jUxxZtdyThXYMTDyeuZ97u6
         jiWA==
X-Gm-Message-State: AOAM532nEWsFedpvkbsC8wo0tZKFS+TcVI5lKnBXMGhxAaxCkvEhBvkk
        V6vkN5Mf37IixtumC02CftNBIZN3HayINXIrLfU=
X-Google-Smtp-Source: ABdhPJwOQhEXJg04RfduOUwp+a4t+ZffV/mxzspWOci9CoCB5sRghFJES52IknocWZQyN/kMasJ/DkGdCyGcsQpW8No=
X-Received: by 2002:a17:906:7c48:: with SMTP id g8mr22406840ejp.138.1615796216879;
 Mon, 15 Mar 2021 01:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-3-charvi077@gmail.com>
 <CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com>
 <CAPSFM5c8saGs=+OvXvZw-T2jPpdUfkmm9_BZOmZwUo=WO1sdQg@mail.gmail.com>
 <CAPig+cTBXBjZkJoGFYpzWBnEOmV52dnoBHxceuoe3pu3F0BnYw@mail.gmail.com>
 <xmqqft0y4gl5.fsf@gitster.g> <CAPSFM5f_=+S5XbE928a-q+OmaPi0iVQXZbJnHVy=ycGwdd8tGA@mail.gmail.com>
 <xmqqblbl4aro.fsf@gitster.g> <CAPig+cTO0umN4nAQi_qZEvTByCHFVavM-KbtfhkukXEUdzLPhg@mail.gmail.com>
 <CAPSFM5fQeB8dOQRzWkwAJCkHtNb2GXUWqgJUHCWoJh0vdDp_Fg@mail.gmail.com>
In-Reply-To: <CAPSFM5fQeB8dOQRzWkwAJCkHtNb2GXUWqgJUHCWoJh0vdDp_Fg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 15 Mar 2021 04:16:46 -0400
Message-ID: <CAPig+cSZ45ZKqFfzL01ZFFA=pkLRVuktLKhVC=_dPoXbHSBcBA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 3:59 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Mon, 15 Mar 2021 at 04:37, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Likewise. If you're going to re-roll anyhow, the open-coded:
> > would be perfectly fine with me too (or any simple variation on that
> > theme). Whether or not it's worth re-rolling again, I leave up to you
> > and Junio.
>
> okay, I agree too. I have updated it in the re-roll.
>
> Thanks for all the detailed reviews and suggestions.

Thanks for patiently putting up with reviewers who sometimes have
opposing or contradictory opinions and recommendations.
