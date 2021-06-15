Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB7C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B51961625
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 16:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhFOQip (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOQio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 12:38:44 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D7FC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:36:38 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id p5-20020a9d45450000b029043ee61dce6bso7796053oti.8
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6Xitf3InIUVjBCq8K6+ZiaZU8EpbrWP9LBfAyw1E6js=;
        b=awRlhEf7vDQnuSv3jWM5GMENUTbMBmxXcGg68LxJelAGbwILKXITixVs+teC8lJ1qJ
         0pXP2NHYUu1tM03rIJ+rQD0B/Oyh3/YnLF5LnEohD2f2NuI7ahQGJE6AoKNTFdiRmdLi
         eIdfv5xy37ankT1RLyJGuCVWAqx4J8Q85THavIqHSC7BvF99vBQu3bnKbQIett66nY9A
         j/YE33304F6arIUb3FY7JGtora3Dvd+RfRXrEETNaTII2z87RRqZ37f5Hn2+ItImVA1x
         ykmE4oHsjRktE/lu44sS3RH6y0z+HZ7eoenNxys2wk3sUvI2DefHnZQkWQ1QXFl5M5b1
         1iPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6Xitf3InIUVjBCq8K6+ZiaZU8EpbrWP9LBfAyw1E6js=;
        b=OC65SclWZdKrniV8QR6WmX6TYzmM4BSrIL26VEXe7OTLfcLN7t9UuQ+xG+V6zi9gZg
         ndnQSNbSKSHGPL1diClVXFwS1rHvXkGI9brCIqh384zMe/Lbr1WH2dKGcAupYFcqOLW3
         CFvN2z62NjTK2WDasDtiFxmueNbBzQsx0cjF084LRX8YIjOpU0lxguovzXxEXm3tn94Z
         Si5ky6ZJo15db54lF3fJI25lg+pqfqCA71pgxay4FJr45IVYTE3TAQkshedoZHJU6auP
         lOTVE0Az4ao+GUH2WK8MTTu8PCYvJVldXBOEE6sW6+V3FM5fQ+iNGJpiUY0CG8AyAN4A
         Xsyg==
X-Gm-Message-State: AOAM530oa5gJna46NJBdOmCF4ylpo1h7nk6vVTOofp2BpBu/qa5p1L/c
        kWBv+SpJd0uAlBCOzpxqoYc=
X-Google-Smtp-Source: ABdhPJya8B7AOn9/XevRq+AmnLLp3Oi6z4s/rBWOIXj9Qn1AERWRnaJlQSVtz98Mav8XI9/+uqcyqg==
X-Received: by 2002:a05:6830:1c3d:: with SMTP id f29mr150627ote.248.1623774996672;
        Tue, 15 Jun 2021 09:36:36 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c64sm1738686oif.30.2021.06.15.09.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:36:36 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:36:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c8d713faf2_1296f20819@natae.notmuch>
In-Reply-To: <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
References: <20210611202819.47077-1-felipe.contreras@gmail.com>
 <20210611202819.47077-3-felipe.contreras@gmail.com>
 <94ce6d7d-f923-edb3-12f5-4b11149c9f6f@gmail.com>
Subject: Re: [PATCH 2/2] comments: avoid using the gender of our users
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/11/2021 4:28 PM, Felipe Contreras wrote:
> > We generally avoid specifying the gender of our users in order to be
> > more politically correct, but sometimes due to lack of time and/or
> > creativity a few slip by.
> 
> s/politically correct/inclusive/

I don't believe avoiding pronouns makes us more inclusive, and I've yet
to see an example where any person would feel personally excluded from.

> Instead of "lack of time and/or creativity" perhaps be more
> generous to our fellow contributors and instead say...

I believe my wording is more generous because it implies they tried,
whereas yours implies they didn't even try.

>   but sometimes a few slip by due to habit.
> 
> > @@ -908,7 +908,7 @@ int parse_expiry_date(const char *date, timestamp_t *timestamp)
> >  		/*
> >  		 * We take over "now" here, which usually translates
> >  		 * to the current timestamp.  This is because the user
> > -		 * really means to expire everything she has done in
> > +		 * really means to expire everything that has been done in
> 
> nit: s/has been/was/
> 
> We can be a little more active here.

True. That's probably better.

Cheers.

-- 
Felipe Contreras
