Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF5C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 18:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69112067D
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 18:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqDlpiST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKUSfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:35:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45760 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfKUSfb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 13:35:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id w7so1940746plz.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 10:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qeurFnhuKBVf6OXIuvX32XPAX4kSPAbGGSR3nbKExFc=;
        b=aqDlpiST8z9/UxIM26voRRkYOLNGj3uErNCqjhQNO68uKX/dc0kc5BkPUxUW7RnE2v
         lto9bnQILsPPh6L0A2QP49wDFs1wBpfareyP071acLoOKjxRnJ/t7iddWpsGh87M88NS
         8OwP8If115xcWktv5IiMuweA2yF44+F72QUSZlWpPSt/SLfQg0mhy0w5GW5Hqig4db5w
         RCyA34egUhJMpaX6Rqth957r7EB6aKNJkL/l0IwtWY/WynQAMNHQiufY9VbLo8zILCtK
         G3BWjANY+A/Q+6rLS7DYhGfpoEkEXt7C2LuAFsriJyEWoq3QTZhaFz16sZStwkHfKtqK
         tu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeurFnhuKBVf6OXIuvX32XPAX4kSPAbGGSR3nbKExFc=;
        b=VMaDWKo1po96jdUBONttDsBVV9AiEu6Sn5Nvc2K5V+J+NodzvfBOO7GZNKfuJDQntC
         sda3ahkRSsXoEGsBp2cpW1gfYC2sE5CZZO1PdUjZMFcDxRFVFFWOFgmLotIY4Wi/u3lu
         8LLP1idLnLWvqtjkh+pm56zZm/D3LsUxOaAHoINDe0BVZVm227JvTWVrhUB9B1fBrjYT
         Cy+Lhg7BuRV0yJlyU1AO2WOXzFHUzk/pHrBAec48MrOzhtuf6cd5MJ5tANayZWaAEemZ
         h8fLL1i76p9wzXHi8uY+MGiK61RXBi7UphGqCkEh7yCmIUtpMX/Tk1JFzJYCCBu5zBem
         aWuA==
X-Gm-Message-State: APjAAAVrm/gbxxnrAej+jfBhiS0JxTj/Cnp8AfzWgxbeLu/6VgXVIxAn
        TH3/YT66qlab9oFVTy0DV+Q=
X-Google-Smtp-Source: APXvYqzA2zL8xx0VfJARqihXfTuTb2qQ2E+/gQgSx0c8ZMCL3q0+jIoyf2xGJpAp5q7k5yge3EpsYg==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id fa8mr13172029pjb.90.1574361330861;
        Thu, 21 Nov 2019 10:35:30 -0800 (PST)
Received: from generichostname ([216.52.21.197])
        by smtp.gmail.com with ESMTPSA id f33sm3953713pgl.33.2019.11.21.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:35:29 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:35:39 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 7/8] range-diff: passthrough --[no-]notes to `git log`
Message-ID: <20191121183539.GA99414@generichostname>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
 <0cb86b383b9c115c9c6077d47f0c124a96b30acf.1574207673.git.liu.denton@gmail.com>
 <xmqqwobvb2cj.fsf@gitster-ct.c.googlers.com>
 <20191120191258.GA73969@generichostname>
 <CAPig+cQ0xO2ya=3ok=GPV2Ji2HJSFvCtokiRpWJhBAR1skqKVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQ0xO2ya=3ok=GPV2Ji2HJSFvCtokiRpWJhBAR1skqKVQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, Nov 21, 2019 at 07:43:18AM -0500, Eric Sunshine wrote:
> On Wed, Nov 20, 2019 at 2:13 PM Denton Liu <liu.denton@gmail.com> wrote:
> > On Wed, Nov 20, 2019 at 01:26:04PM +0900, Junio C Hamano wrote:
> > > Denton Liu <liu.denton@gmail.com> writes:
> > > > +#include "argv-array.h"
> > > >
> > > >  int show_range_diff(const char *range1, const char *range2,
> > > >                 int creation_factor, int dual_color,
> > > > -               struct diff_options *diffopt);
> > > > +               struct diff_options *diffopt,
> > > > +               struct argv_array *other_arg);
> > >
> > > I thought a mere use of "pointer to a struct" did not have to bring
> > > the definition of the struct into the picture?  In other words,
> > > wouldn't it be fine to leave the other_arg a pointer to an opaque
> > > structure by not including "argv-array.h" in this file?
> >
> > Without including "argv-array.h", we get the following hdr-check error:
> >
> >         $ make range-diff.hco
> >         In file included from range-diff.hcc:2:
> >         ./range-diff.h:16:14: error: declaration of 'struct argv_array' will not be visible outside of this function [-Werror,-Wvisibility]
> >                             struct argv_array *other_arg);
> 
> Did you forward-declare 'argv_array' in range-diff.h? That is, rather than:
> 
>     #include "argv-array.h"
> 
> instead say:
> 
>     struct argv_array;

*facepalm* Damn, sorry for the brainfart. I completely forgot to do
that.

That being said, I'd prefer to just include the header for consistency
since we already have the #include "diff.h" up there. Or alternatively,
I could write a patch to change both into forward-declarations.

Personally, I prefer to avoid forward-declarations whenever possible
because it adds duplication. If we have a strong preference for one or
the other, should we include it in the CodingGuidelines?

Thanks,

Denton

> 
> which tells the compiler that the type exists, thus allowing you to
> deal with pointers to the struct, as long as you don't try to access
> any of the struct's members in code which has seen only the forward
> declaration. You would still need to #include "argv-array.h" in
> range-diff.c, though.
