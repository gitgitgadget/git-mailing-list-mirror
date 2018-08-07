Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C588208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 22:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbeHHAR2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 20:17:28 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42754 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbeHHAR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 20:17:27 -0400
Received: by mail-yw1-f65.google.com with SMTP id y203-v6so88251ywd.9
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 15:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OoG8APu3TobAdijtIO3PW4/jNghJZ2wOahJ+nZRxFGQ=;
        b=Iw8pxl1L4Vx7iOUqYmkHIiLcco6TTITcY9FpTal3lSnCuKaxTAN1VtuA8VoElejxN8
         j5g3ivIxWfeecoHwNBHtthl1WeGs8yeBMPWaBKh0ns9C/fbqwXJmg7Uh5ZlfUs7p/vHI
         9yMvTo9+tvbRxZMhPF8QxCQCWprMYKNQsK5w5Don9hwAbYBwS7ehKLN1/hFUPC9UnxWO
         084tZ9gh9kec/sX1HI9TZdK7/5nef72vdtfqYsqRLPa2Xh5ygHCMXk1vm7TjYOGiSRZG
         3W/dKHYlUTyhSSkfMKqy6jnoN85Ac4mVjEn2htI1RsaRYMiMF2sxlJiSo4azNStVhBAj
         CCOw==
X-Gm-Message-State: AOUpUlHnke5K96cqWEedETfuT59ex7A0/hGG6RCncZD6v3VxyV4SVMa3
        erHDSys2aXwOJFHYW+8xWT9AFnM2PkZ0Dpso8ys=
X-Google-Smtp-Source: AA+uWPwbnuDCv6wH8FXYE9/Ac3t9DiEgg8purmHGplfy/uYVq63yoidOPlSALhaIUqXI0+pq/9fQe26sxEmK4LubFM4=
X-Received: by 2002:a25:5bd7:: with SMTP id p206-v6mr4615ybb.287.1533679258278;
 Tue, 07 Aug 2018 15:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.15.git.gitgitgadget@gmail.com> <faf35214f0f339b792a30a3bd013056217d9a2c1.1533421101.git.gitgitgadget@gmail.com>
 <CAPig+cRrC2mf1uuQ1C4Ue4OMZQbgcxXbJ9AXs0y6RSnUrcm7Dg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808061510260.71@tvgsbejvaqbjf.bet> <CAPig+cQU-mcUBJGHeZjKeta0_ve8WMr_KL1ToO9j-d=-hS1a=w@mail.gmail.com>
In-Reply-To: <CAPig+cQU-mcUBJGHeZjKeta0_ve8WMr_KL1ToO9j-d=-hS1a=w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 7 Aug 2018 18:00:47 -0400
Message-ID: <CAPig+cTBUCytuqMZAZshPNzJ28s_vhWNKawamt1=EtNZVcYJsg@mail.gmail.com>
Subject: Re: [PATCH 4/4] line-log: convert an assertion to a full BUG() call
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 5:09 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 6, 2018 at 9:15 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I think Andrei's assessment is wrong. The code could not test for that
> > earlier, as it did allow ranges to become "abutting" in the process, by
> > failing to merge them. So the invariant you talked about is more of an
> > invariant for the initial state.
>
> My understanding is that range_set_append() is intended to be strict
> by not allowing addition of a range which abuts an existing range
> (although, of course, the assert() checks only the last range, so it's
> not full-proof).

Ignore my parenthetical comment. It is clearly wrong.

Looking at this again, I see that there is some confusion. The comment
in line-log.h says:

    /* New range must begin at or after end of last added range */
   void range_set_append(struct range_set *, long start, long end);

However, that comment was added by me in c0babbe695 (range-set:
publish API for re-use by git-blame -L, 2013-08-06) -- five years and
one day ago -- and it appears to be based upon a direct interpretation
of the condition in the assert(), including its off-by-one error.

*But*, one of the invariants of range-set is that the ranges must
_not_ abut one another, so the "at or after" is wrong; it should say
instead something like "after, and not touching, the end of the last
added range".

That invariant about having a gap between ranges is enforced
deliberately by range_set_check_invariants(). It's also signaled
implicitly by the fact that no callers of range_set_append() ever
invoke sort_and_merge_range_set() after calling range_set_append().
