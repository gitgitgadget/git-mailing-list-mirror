Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED4C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FB72071A
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 21:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg+ZjA17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfKYVnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 16:43:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41546 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYVnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 16:43:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id t8so7025599plr.8
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 13:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yt1EY6OzqlUxAKsLzn9dGmeDGp0x9s93tRq5IzMeWaA=;
        b=Eg+ZjA17ICnrZLjCw7KTv6syWPyPWkr9iqDCKD6R0vR5w5wUe5jq/KzDiT6OxuUoOX
         SkPRtBem7Ba3YrakyW3yHq1H0EM6KzY1m+3Fz5g4OtNC17a2Dy0ILwCZiaePqfnb0XHs
         lmF2eEH3ntWAGDwwVji9eltSJq0szmtfG9hYGG3GRuoNbbMOQUB6jQE1O7he26yowBdd
         Ik2xi2mfgpstZywvXxsZN31e4JhnOYOgizManrB/tzyavBNiydFDZDc1Jj+QLLeZDjCk
         TwiGYjro9dCxvEvo8RAWP58JwinQU1HPAwwywmVZ91HG/ns+x8Ed7OEvLNU+syFUG+Cc
         zbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yt1EY6OzqlUxAKsLzn9dGmeDGp0x9s93tRq5IzMeWaA=;
        b=CuGkz7RsFcZwMDfYZtMJcY1IteCk07t1nLPNtMOeag3jybMDY+E3rNXNYDogtZJ3EA
         9DcbIeQ+40bT7gijWjJGaFeYCwQ0+pciyd/gB5fnZJgDv6n7PLuDuFvHihNr6X7xj/iq
         Q+tTtCWjk1DjJ6ySKBm8iDF2UMc7QTpH/2Zq8juKSHbWlCYmhfcfD2Qlcqh5tFpUJlxs
         GGCpeW9ixpyBseIgZofXAA/w1m7JrwAjhrtnlK/yNhhkKqur1vQZmBH+mSBkHJQHZGd9
         YTBD0WoXKB6d+Agy/kDcAlk0DPnqjMV1PZAxMUCdVp+F5LNmZQD/MShbETfDE3sSaJNU
         hYWw==
X-Gm-Message-State: APjAAAUhunLSvno51H7GciJNJZGseR43xjD8KT+2r3gXCt9llc0f7fd/
        H9vMvCS9iaoBX8b73urIS87kNAVp
X-Google-Smtp-Source: APXvYqxxjQlSZZGoY/JB/vndJ0mJ5d8zZaS8Onug1MtCJ4QZzBlXJmHZO+PVoc/1WqAQWBOqUDwbgg==
X-Received: by 2002:a17:90a:252d:: with SMTP id j42mr1568650pje.131.1574718188435;
        Mon, 25 Nov 2019 13:43:08 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id o14sm10123563pfp.5.2019.11.25.13.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 13:43:06 -0800 (PST)
Date:   Mon, 25 Nov 2019 13:43:04 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 13/22] t5317: use ! grep to check for no matching lines
Message-ID: <20191125214304.GA73230@generichostname>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
 <85c2f8ca2704e54c2d0e6e65822a04d21e383f6a.1574449072.git.liu.denton@gmail.com>
 <CAPig+cTE_cYQi=Ys5tKYbs6bRXf9moNqO6zo1M_hn6w9HfL-bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTE_cYQi=Ys5tKYbs6bRXf9moNqO6zo1M_hn6w9HfL-bQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sat, Nov 23, 2019 at 01:21:29AM -0500, Eric Sunshine wrote:
> On Fri, Nov 22, 2019 at 2:00 PM Denton Liu <liu.denton@gmail.com> wrote:
> > [...]
> > While at it, drop unnecessary invocations of 'awk' and 'sort' in each
> > affected test since those commands do not influence the outcome. It's
> > not clear why that extra work was being done in the first place, and the
> > code's history doesn't shed any light on the matter since these tests
> > were simply born this way[1], doing all the unnecessary work for no
> > reason, probably due to copy/paste programming...
> 
> Taking this wording literally from my review comment[1] is (again)
> fine, but I ended the fragment intentionally with "..." with the
> expectation that you would fill in the remainder, not expecting you to
> copy/paste the fragment blindly. Without the remainder -- the part
> which is supposed to follow the "..." -- the reader if left hanging.

My mistake, I interpreted the "..." as a stylistic writing choice as
opposed to an indication for me to fill it in. I'll fix it up for the
next round.

Thanks,

Denton

> 
> [1]: https://lore.kernel.org/git/CAPig+cQviTjwLSZ+QkC62B58mq6z3yDA-XhPVJQYRq0inEo9nA@mail.gmail.com/
