Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D5FC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825D720855
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 14:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqGIHBP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHNOus (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 10:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgHNOur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 10:50:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F413C061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:50:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so4497504pjr.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YHL6Gl20U7VRd6bfiBD07bSv6qNS3eVmBFntFGAQ4RU=;
        b=XqGIHBP4slcgQBaVG7m2wpZqcjnHm6RGKeneDWlBh5xkmovpertghBxPbwLdfLhAYc
         JB3OXtwuiU1KVuqW6W0pLXlwm9n4Q2HA3O9Uvl710g0mguv1zKUVeQHDVlyhFMuMgink
         FyWkrklRgiedGEQg0vabvIITmhQRH+oD9sbsFriVaglFotrZf7+QLtGuHLQZbQ8M3YwG
         ANi9nVIKFyN7oa828jQxdhap4ceptv8kfs3yDj2smRZjFUDezd+1R5mh727FwoKQ1TU5
         V3kDjC5tOb8O92GZIT7t0qxFqqBUPQH6ZvCPkn4rnpKQUK875drRRzLc7F7Hi5/Gjjnj
         tzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YHL6Gl20U7VRd6bfiBD07bSv6qNS3eVmBFntFGAQ4RU=;
        b=f/wZkCVxrq/eIyEv2v2Af1Ml472/Uxz96Q9sOrlbqVFo0BSNwOsKEBfl4kFiAzeuOL
         Iv3lUELah0p2RzVhYISiQYlfO47bxgrL+S3urB3261tYDewSfGEkXCQwfwMGJrho8ytv
         yzlLIXPOInmqrRhsrWhxYsP/09PQxaCU1x/Jkyw3tV2eHqrkiTdrocmkbcm/KWncdM//
         rtq6zihd8/PkaXqyCMGKF3h4DD28FoL+KEISKddta/RTxxqJWyGnJD4tnrd8vDq4CVgC
         jlmeMgfEx24dds5L6ay+pO5VKrFIaA1HFcqdeGeR9H1D/FPIvOJ55Udp2zf9H3ZLNoYQ
         WjCQ==
X-Gm-Message-State: AOAM530fidXc3gsrSWIPaVk0oNVebZ6mztrdLW2o7vqaYf0V0xTlvNJ8
        Pqn2aP3bSxQM7PNkb+tDRQk=
X-Google-Smtp-Source: ABdhPJyMLJHxJec6zWhh7+Se6x67+ega+XdfsTyVzrCv8NG6vD/tfxRELz4b+7P6OurHixCB/e5UIQ==
X-Received: by 2002:a17:90b:1890:: with SMTP id mn16mr2519655pjb.230.1597416645690;
        Fri, 14 Aug 2020 07:50:45 -0700 (PDT)
Received: from localhost ([2402:800:6374:3f71:3e6:8db2:d7ba:5d94])
        by smtp.gmail.com with ESMTPSA id q7sm9581984pfl.156.2020.08.14.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 07:50:44 -0700 (PDT)
Date:   Fri, 14 Aug 2020 21:50:43 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/2] revision: differentiate if --no-abbrev asked
 explicitly
Message-ID: <20200814145043.GB9518@danh.dev>
References: <cover.1596887883.git.congdanhqx@gmail.com>
 <cover.1597364493.git.congdanhqx@gmail.com>
 <9a26c5b6110081cd8d029f2ab0327c4a1d228ef7.1597364493.git.congdanhqx@gmail.com>
 <xmqq8sei125k.fsf@gitster.c.googlers.com>
 <20200814005947.GA9518@danh.dev>
 <xmqqzh6yyr1t.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzh6yyr1t.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-08-13 18:06:22-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > Let me list some combination here:
> >
> > * none of --abbrev --no-abbrev --full-index -> default short index
> > * --abbrev --full-index                     -> full-index
> > * --full-index --abbrev                     -> full-index
> > * --abbrev --no-abbrev                      -> full-index
> > * --no-abbrev --abbrev=[n]                  -> shortened index to n char
> >
> > So, we can't use full_index bit, because --no-abbrev can be defeated
> > by --abbrev, but --full-index will always win --abbrev.
> 
> Sure, I wasn't suggesting to flip the flags.full_index bit upon
> seeing "--no-abbrev".  When --no-abbrev is in effect (i.e. the last
> one among --no-abbrev, --abbrev, or --abbrev=n), .abbrev field is
> set to 0.  So wouldn't it be sufficient to say
> 
>  - If flags.full_index bit is set, show the full object name
> 
>  - If abbrev is 0, show the full object name
> 
>  - All other cases, after clamping the value of abbrev to reasonable
>    value, truncat the object name to that length
> 
> What am I missing?

No, you didn't miss anything.

It's obviously me, who screwed up the logical thinking.

Originally, I come up with something along the line in 2/2:

	int abbrev = o->flags.full_index ? hexsz : DEFAULT_ABBREV;
	if (!o->abbrev)
		abbrev = o->abbrev;

I couldn't recalled what I wrote, but that logic requires 1/2,
after I come up with 1/2, I re-analysed 2/2 and come up with current
logic.

I failed to re-visit 1/2 to check if it's necessary.
It's all MY fault.

Sorry for wasting everyone's time in 1/2.

Please eject 1/2 from this series.

-- 
Thanks

Danh
