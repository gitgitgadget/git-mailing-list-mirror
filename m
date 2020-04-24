Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3D1C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD32820767
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chIlqbtP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgDXLnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgDXLnH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:43:07 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DFAC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:43:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so4693034pfa.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Z0z34NtfSNFjf51ztnR02cjMyvfQDaf8diJgoyXsRY0=;
        b=chIlqbtPBP1nfGCTrtBt7gGGoSnszlpt4Rfg8iOywfVP6Yp9qqsJjyrffsBtGw29g6
         rMbvocZ68lMws1ckpvWElKSHgbtn9N1NoqVN14kDUqnwHoLpsNChk5jcFW2U2Tl/aI9s
         oFnwD5a3rpVFcc/ax1sVPy7FtY4+jv15PealiLJPCgaPh7NcKP0W9nOIpyupughtCN2s
         TeWiUztHcINcbxTOYQDHaNe5icgasdHDipSkFd7K2nOn9tCNdUIUSt9oSMBMpoQiZAD6
         Oy40mjLlkau+hZclSXN0CqeeXc2ZtSPOeMfs/6/lJRGsuoODSU7zGDnNKES3YY+EPo7D
         L6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z0z34NtfSNFjf51ztnR02cjMyvfQDaf8diJgoyXsRY0=;
        b=VtQriJALMNjcLYlKjK3ZMCAha1WOPI+GFttBdHur83i0n7yMgai1h1nuq1hG3fQJXB
         aNGrgIZdKD0N1O/h22n38za5PGslysTP3qP67YIOwdMm9h6JbeBGoEs6CwvmJrQ/roHt
         LQdK1xrtGR0zYZSQYl2wxlZqUo7Wb5Jw9STba91PcHGHJ1FcnwZzB3tDDpehLuGTgJtT
         L9YF5P3buJB3STfJrG921yR0C373a9iW/3sOOwJjB5vFVSHo0hbAHDxP27lsF5VHqm3y
         paDQUVC/F2/k/utKPmJrTfSccJRm/duv8iuQtzIPqiwxZKspoijNQEMik9w/nQ57MUSH
         s42g==
X-Gm-Message-State: AGi0PubuQTupZt+npoxM2LW3VzfB2lgzSieRIHxIIUxVu+Ko4cxWSLst
        K6/VXiAcEWIS2RLlGWLBFYw=
X-Google-Smtp-Source: APiQypIeGAKk7uvehOiVW6sPJOnIPLLhElPcroywVG36kqYo80IgtJkudV6Vx0vBdAtRg8iYwyEXag==
X-Received: by 2002:a62:cf81:: with SMTP id b123mr8906025pfg.84.1587728585946;
        Fri, 24 Apr 2020 04:43:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id u12sm5595377pfc.15.2020.04.24.04.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 04:43:05 -0700 (PDT)
Date:   Fri, 24 Apr 2020 18:43:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 2/4] date.c: validate and set time in a helper function
Message-ID: <20200424114302.GG1949@danh.dev>
References: <cover.1586856398.git.congdanhqx@gmail.com>
 <cover.1587644889.git.congdanhqx@gmail.com>
 <0d0e4d8edce37dfef13e573588f0c043ddf07f6a.1587644889.git.congdanhqx@gmail.com>
 <xmqqzhb2ez1q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhb2ez1q.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-23 13:18:25-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > In a later patch, we will reuse this logic, move it to a helper, now.
> >
> > While we're at it, explicit states that we intentionally ignore
> 
> "explicitly state", perhaps.
> 
> > old-and-defective 2nd leap second.
> >
> > Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> > ---
> >  date.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/date.c b/date.c
> > index b67c5abe24..f5d5a91208 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -539,6 +539,22 @@ static int set_date(int year, int month, int day, struct tm *now_tm, time_t now,
> >  	return -1;
> >  }
> >  
> > +static int set_time(long hour, long minute, long second, struct tm *tm)
> > +{
> > +	/* C90 and old POSIX accepts 2 leap seconds, it's a defect,
> > +	 * ignore second number 61
> > +	 */
> 
> 	/*
> 	 * Style: our multi-line comments ought to be
> 	 * formatted like this.  Slash-asterisk that opens,
> 	 * and asterisk-slash that closes, are both on their
> 	 * own lines.
> 	 */
> 
> But I am not sure we want to even have a new comment here.  After
> all we are extracting/reinventing exactly the same logic as the
> original.  Why we allow "60" might be worth commenting, but if a
> minute that has 62 seconds is a mere historical curiosity, then is
> it worth explaining why "61", which we never even wrote in the code,
> is missing from here?

I think single line like:

	/* We accept 61st second for the single? leap second */

Or something along the time, is good enough. Not sure if we want the
word "single" there, though.

I think majority of people don't even know about leap second.
Probability that know about 62nd second is rarer, I think.

> > +	if (0 <= hour && hour <= 24 &&
> > +	    0 <= minute && minute < 60 &&
> > +	    0 <= second && second <= 60) {
> > +		tm->tm_hour = hour;
> > +		tm->tm_min = minute;
> > +		tm->tm_sec = second;
> > +		return 0;
> > +	}
> > +	return -1;
> > +}
> 
> I am a bit surprised to see that you chose to unify with the "check
> and set" interface of is_date (now set_date).  I was expecting to
> see that we'd have "check-only" helper functions.
> 
> This is not a complaint, at least not yet until we see the result of
> using it in new code; it may very well be possible that the "check
> and set" interface would make the new caller(s) clearer.
> 
> >  static int match_multi_number(timestamp_t num, char c, const char *date,
> >  			      char *end, struct tm *tm, time_t now)
> >  {
> > @@ -556,12 +572,8 @@ static int match_multi_number(timestamp_t num, char c, const char *date,
> >  	case ':':
> >  		if (num3 < 0)
> >  			num3 = 0;
> > -		if (num < 25 && num2 >= 0 && num2 < 60 && num3 >= 0 && num3 <= 60) {
> > -			tm->tm_hour = num;
> > -			tm->tm_min = num2;
> > -			tm->tm_sec = num3;
> > +		if (set_time(num, num2, num3, tm) == 0)
> >  			break;
> > -		}
> >  		return 0;
> 
> This caller does become easier to follow, I would say.  Nicely done.

Yes, when I looked around date.c

I saw that the only usecase for validate time is for setting it.
And the incoming patch also has that usage.

I chose to unify those code path to not buy me too much trouble.

I'll take that "Nicely done" means this unification is OK for this
series.

-- 
Danh
