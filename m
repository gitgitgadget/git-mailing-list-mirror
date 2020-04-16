Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37657C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EBD021841
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 11:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmeQ6IFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506274AbgDPL2X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2632854AbgDPLQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 07:16:28 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68AC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 04:16:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d24so1243012pll.8
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 04:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+Y7wdXUooVPWT3vErVhtAQ9Onb7qepjNj5H23q56x0=;
        b=gmeQ6IFL63Hdl5DfrbRUCsLQy1f/hDGPW6XJvB9qH4N1bu6mLR3aPSTaMTXU1MM8x+
         F7r1kPi8iCCZrInbS4fQoN3nNrGoP59Mg6JzWQCD7krvOBquVlcJyjvfZM31sdtT8gzG
         wcQuRKv4etmc6kUSKIou4AX8O1g+5F2u2wcgYtMmFR7aWRc6UF2slO8jWYWiX+IJYg2I
         n2PDU+1+p+qJZKi6xwaxLK5VSPRJX7NfuWhknXCIlPWvuwcBRLKa7s4s5WuN+h2VzJyu
         t8pemUV/nX9g3swCkl7tS3EPqrlHkG+Jns0w0uoiyhl36idWBslwmMat/bwcvhgoFNWf
         ie4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+Y7wdXUooVPWT3vErVhtAQ9Onb7qepjNj5H23q56x0=;
        b=JDcdQ7zxlbWISQ7I6XrsjP1WFu9qgzCgFnK5AJx0gUs01cyg6TyuF/B18fh6cJyHQ6
         +CQ73pRRcMSgJLG0L34BPEHJg5zQ90GkeMI2JR4mZ2ZxVtRnxIERludpV/pkV6KYZTI6
         5TXyNYoW1sVg9SFyXWWUh+ctalvhkpuvUyRLdbD64uuFUOFWsouUahKaVSgFy8dz5t98
         C2I7F8gWJ7fXVZDKJs2xyE0X4ISCu3GRMsFpdA8nyfrlPJJ5SspqcNCgruVb0Mcoakqm
         xCZdoHx/EGvHhTuTzOc360/Kf7cldSjLQBnOkRVgtF0mFj9RaTktFNYmD6oszWWG/LN8
         Stiw==
X-Gm-Message-State: AGi0PuZDpRiDAKGzxVyh6R3XCwooJyAYx/bK5zsQVqFUKbDvly4WyS70
        zonAedAkhirCfqT/baJgwR+Bn/TK
X-Google-Smtp-Source: APiQypLpk+ko+0xtIZz9Kdbtz23vFMWn7L5q5kmQNKHbti2WUJxH60Zio+FmBW+thMPGPEHExn1eTg==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr9869128pls.323.1587035772409;
        Thu, 16 Apr 2020 04:16:12 -0700 (PDT)
Received: from localhost ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id n8sm4439362pfq.213.2020.04.16.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 04:16:11 -0700 (PDT)
Date:   Thu, 16 Apr 2020 18:16:08 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
Message-ID: <20200416111608.GB2285@danh.dev>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
 <20200414202401.GC1879688@coredump.intra.peff.net>
 <xmqq5ze094gg.fsf@gitster.c.googlers.com>
 <20200415154157.GC2464307@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415154157.GC2464307@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-15 11:41:57-0400, Jeff King <peff@peff.net> wrote:
> On Wed, Apr 15, 2020 at 08:03:11AM -0700, Junio C Hamano wrote:
> 
> > > I worry a little this may conflict with other approxidate heuristics.
> > >
> > > The only one I can think of is an actual unix timestamp, though, and we
> > > already require that to have at least 9 digits (plus anybody wanting to
> > > use one robustly really should be using @12345678).
> > 
> > I am OK with 1/2, but I'd worry a LOT about this one, if we didn't
> > require 9 digits.  60/100 * 60/100 * 24/100 ~= 8.6% so limiting the
> > hour/min/sec to sensible values is not a useful protection against
> > ambiguity.  We'd essentially be declaring that a raw UNIX timestamp
> > without @ prefix is now hit-and-miss if we take this change, were
> > there not the "must be at least 9 digits" requirement.
> 
> Yeah, that was exactly why I poked at it.
> 
> Curiously, a1a5a6347b (Accept dates before 2000/01/01 when specified as
> seconds since the epoch, 2007-06-06), the commit which introduced the
> 9-digit rule, specifically says:
> 
>   There is now still a limit, 100000000, which is 1973/03/03 09:46:40
>   UTC, in order to allow that dates are represented as 8 digits.
> 
> but running "test-date 20100403" even back at that commit does not seem
> to work (nor does it work now).

check-parse 2010-04-03 doesn't work either.
check-approxiate is going through different code path via
approxidate_digit, but I'm not really sure which action should be take

> Doubly curious, some nearby code blames to 9f2b6d2936 (date/time: do not
> get confused by fractional seconds, 2008-08-16). So why don't fractional
> seconds work right now?

It doesn't work in that time, either:

	$ git checkout 9f2b6d2936
	$ make
	$ ./git --version
	git version 1.6.0.3.g9f2b6
	$ GIT_AUTHOR_DATE='2019-04-16 00:02:03.19-04:00' ./git-commit --allow-empty -m msg
	$ ./git-log --pretty=format:%aD -1
	Fri, 19 Apr 2019 00:02:03 +0700

The different is whether we stick the timezone (west of UTC) into the
fractional or not. If we have both those conditions:

- Specify the timezone west of UTC
- Stick it with the fractional part
- The fractional part is parsed to  number less than 32

The the parser will think it's US style of month/day

Judging from the test code, it's likely people that write the code and
the test get used to separate time and timezone.

And it's unlikely anyone will  write fractional parts with only
1 digit (yield 100% positive with sticking timezone), or 2 digits
(which yields 32% positive with sticking timezone),
for 3 digits, the positive rate is 3.2%

> 
> They sure don't seem to:
> 
>   [the 17 becomes a day-of-month]
>   $ t/helper/test-tool date approxidate 12:43:50.17
>   12:43:50.17 -> 2020-04-17 16:43:50 +0000
> 
> But I wonder if the new patch breaks the example from that commit
> message, which does work now:
> 
>   [current version; the 17 attaches to "days ago"]
>   $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
>   12:43:50.17.days.ago -> 2020-03-29 16:43:50 +0000
> 
> It looks like the answer is yes:
> 
>   [with patch 1/2 applied; now it's a fractional second]
>   $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
>   12:43:50.17.days.ago -> 2020-04-15 16:43:50 +0000
> 
> TBH I'm not sure how big a deal it is. The input is rather ambiguous for
> a strict left-to-right parser, and I'm not sure this case is worth doing
> more look-ahead parsing. But it's worth making a conscious decision
> about it.

Hm, I don't think "12:43:50.17.days.ago" is a normal input from user
but I think "12:43:50.3.days.ago" on Monday wouldn't have much less
user when compare with "yesterday at 12:43:50.17"

> One alternative would be to restrict the fractional second handling only
> to the parse_date_basic(), which is quite a bit stricter. It shares
> match_digit() with approxidate(), so we'd probably have to pass in an
> extra flag to match_digit() to change the rules. It also means that:
> 
>   2020-04-14T12:43:50.17
> 
> would parse a fractional second, but:
> 
>   yesterday at 12:43:50.17
> 
> wouldn't.
> 
> > > We could probably tighten the heuristics a bit by insisting that the
> > > month and day be sensible. Or even year (see the 1900 to 2100 magic for
> > > the 4-digit year guess).
> > 
> > I do agree that we'd want 0 <= hr <= 24, 0 <= min <= 59, and 0 <=
> > sec <= 60 (or should this be 61?), but it is for correctness of the
> > new code.  It wouldn't have any value in disambiguation from other
> > formats, I would think.  So, from that point of view, I would buy
> > something like 1969 as a lower bound, but I am not sure if we
> > necessarily want an upper bound for the year.  What mistake are we
> > protecting us against?
> 
> No particular mistake. I was just suggesting to keep the heuristics in
> the new code as tight as possible to leave room for later changes (since
> approxidate by its nature is heuristics and hacks piled atop each
> other).
> 
> I do agree that year bounds are a questionable restriction. Right now
> Git's date code can only handle dates between 1970 and 2099, but it
> would be nice to change that.

2100 is used inside is_date, which is the place we try to guess what
     does those number could mean in multiple format.

I don't think we have ambiguity when parsing ISO-8601 compact date.

-- 
Danh
