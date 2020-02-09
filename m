Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64125C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FC320838
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="t/EYI8Bl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgBIXKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:10:43 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53181 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBIXKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:10:43 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep11so3368531pjb.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6l970MjcI4dnE71QwhTDTMsxh4SOI6457fvnju9sjho=;
        b=t/EYI8Bla1qS6GOUd2Gjs5LopfCs0TEfL58hXN7CUKCqUeTEOFfe+3beBNWkfISzgy
         qc+77boYmto84iBq7TIVoHAHm29vryHiHJqgP1Fwt+x/rw0XoK3d01MRFva1QCwRXdGo
         KnZdt9jYVZ1ao8RsDJPNKYUm0befR7xRvNCedNKGY0zQh/x/6lCGZZKEYWRilpkhqJrT
         1zGa1I8BaTBW56HvE6WGnRW+Mf2h5dTCgmrgmYvwHyXSW40mkTd2uF6B6coNkdZvzQ8I
         Uc1mK4jepKkfJkwRxAmSwhICPZ7+UrJZ0wsplnXMK4PVfYQ9qLasRvaV9g50VO/cMR7G
         VWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6l970MjcI4dnE71QwhTDTMsxh4SOI6457fvnju9sjho=;
        b=j451Cal3KH3KIuIPP6lBqAB3mSLBR3yHnN8t5z8Brc1MEyqh5bor4qaobFxly6wJ0G
         jPIJvVsezpliAx76gPH67KzQ3INFmgRDk9UbjNIQTAFHX7REVwknTEpE6plOtViQJyex
         QUNRn+329zQBktvYZc6X/IQzH9k633H7MqSkURxNnQQ0ripMDtDD9fVHv6THMh6TxqrP
         1EDHH6a39PZQdYhmQdlkY5XK0Q6JhLYvrByGlRsvuwggehSq4wjYAATXZM6XsP0hWGyH
         JlYpG8dCGh5yFSotUl5ymLC7wxS2WSQ6zpaCsU+UsILv90Ao/2A8G5gro8WXR2ykycsD
         LzkA==
X-Gm-Message-State: APjAAAXJLY17jDUgPw6pJ1pSolYOS37QHIycuO3AXI+q14rtDO6Z8J64
        K+07VamIisXxpMqt8mtr5LbvseutW244yc37
X-Google-Smtp-Source: APXvYqxiZa7SvHjhyqaAzGFeiqjzLHX6I0utpgWLpqctnpwWnjeN+8ZWuTSAQ5A3FwygnbqI0jzBnw==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr9606754plv.297.1581289841645;
        Sun, 09 Feb 2020 15:10:41 -0800 (PST)
Received: from localhost ([2601:602:9200:32b0:317f:c53e:b83c:7fcb])
        by smtp.gmail.com with ESMTPSA id q29sm10091365pgc.15.2020.02.09.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 15:10:41 -0800 (PST)
Date:   Sun, 9 Feb 2020 15:10:40 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2] strbuf: add and use strbuf_insertstr()
Message-ID: <20200209231040.GB4530@syl.local>
References: <019be197-e0aa-1234-e16f-6561d8340023@web.de>
 <b31c46a8-380b-3528-27a5-a2dddacaf837@web.de>
 <CAPig+cQdJ0NJSWZN-2ckeLB7RfU9GZ7LGvVX4y+Q1daPnW8WsA@mail.gmail.com>
 <60b491a1-2b71-d5a5-398f-e6743e2c617a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60b491a1-2b71-d5a5-398f-e6743e2c617a@web.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 09, 2020 at 07:28:31PM +0100, René Scharfe wrote:
> Am 09.02.20 um 18:36 schrieb Eric Sunshine:
> > On Sun, Feb 9, 2020 at 8:45 AM René Scharfe <l.s.r@web.de> wrote:
> >> Add a function for inserting a C string into a strbuf.  Use it
> >> throughout the source to get rid of magic string length constants and
> >> explicit strlen() calls.
> >>
> >> Like strbuf_addstr(), implement it as an inline function to avoid the
> >> implicit strlen() calls to cause runtime overhead.
> >>
> >> Signed-off-by: René Scharfe <l.s.r@web.de>
> >> ---
> >> diff --git a/mailinfo.c b/mailinfo.c
> >> @@ -570,7 +570,7 @@ static int check_header(struct mailinfo *mi,
> >>                 len = strlen("Content-Type: ");
> >>                 strbuf_add(&sb, line->buf + len, line->len - len);
> >>                 decode_header(mi, &sb);
> >> -               strbuf_insert(&sb, 0, "Content-Type: ", len);
> >> +               strbuf_insertstr(&sb, 0, "Content-Type: ");
> >>                 handle_content_type(mi, &sb);
> >
> > Meh. We've already computed the length of "Content-Type: " a few lines
> > earlier, so taking advantage of that value when inserting the string
> > literal is perfectly sensible.
>
> Well, yes, but it would be more sensible if we'd have only a single
> string here.  At the source code level we have two string constants that
> happen to have the same contents.  Handling them separately is
> reasonable, I think.
>
> The compiler is merging those two, and resolves the other strlen() call
> at compile time, so the generated code is the same.

Yes, if 'strbuf_insertstr' weren't inlined, I'd be less eager to make
this suggestion, but since it *is* inlined, I don't think that the
compiler will generate substantially different instructions whether we
use one or the other here.

> > Thus, I'm not convinced that this change is an improvement.
>
> The improvement is to untangle the handling of those two string
> constants and to use a C string without having to pass along its
> length.  That doesn't make the code clean, yet, admittedly.

Agreed.

> > Digging deeper, though, I have to wonder why this bothers inserting
> > "Content-Type: " at all. None of the other cases handled by
> > check_header() bother re-inserting the header, so why this one? I
> > thought it might be because handle_content_type() depends upon the
> > header being present, but from my reading, this does not appear to be
> > the case. handle_content_type() calls has_attr_value() and
> > slurp_attr() to examine the incoming line, but neither of those seem
> > to expect any sort of "<Header>: " either. Thus, it appears that the
> > insertion of "Content-Type: " is superfluous. If this is indeed the
> > case, then rather than converting this to strbuf_insertstr(), I could
> > see it being pulled out into a separate patch which merely removes the
> > strbuf_insert() call.
>
> Interesting.  It makes sense that handle_content_type() wouldn't need
> such a header prefix -- it's only called if its existence in the line
> has been confirmed.  And I also don't see a hint in the code that
> would justify the insertion.
>
> Do you care to send a follow-up patch (or one against master if you're
> not convinced by my reasoning given above)?

I certainly can't speak for Eric, but for my $.02 I don't think that
it's worth holding this series up. This seems like a separate issue to
me, and I'd rather it not get get in the way of a perfectly good patch
in the meantime.

For now, this increases the churn a little bit, but that is the price
we have to pay for the new 'strbuf_insertstr' to be applied/used
consistently.

I'd be happy to see this go further, but I'd be just as happy to stop
where we're at.

> Thanks,
> René

Thanks,
Taylor
