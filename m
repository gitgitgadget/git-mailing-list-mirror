Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CCFC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKV5E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 16:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKV5C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 16:57:02 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B0A4877F
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:57:01 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id h206so4492917iof.10
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iCM81TUMbf4MTRrAgzZQvLA35DjK3PmJFw8r+Uco+Y=;
        b=SxoEFn7WPIO3tW0bkINyVJdf4C4EYUC3E+IH3oBFp0ogIvTniD3WrvHmKXKlstOp+O
         M4qCufhK4tz/IwpyhtCSKm6pDPnnUYvS+b6SfuurgI/HRFYLMoP/6ZobA0xWy7N7vjID
         9Zkq3elNToJAyScdhU2wyhM07za8f3C9DIK7DeDs3AI6V6KFpGJgZM7/SjQgW6fPU8hs
         wqpxu7ows9PL5erbGxA58ld9HwZ6PVu6l7aQmsleILsaubbcQHOpWo7+GORSyvRxz3LU
         6CkuSAbiqVhZZ+HGhwP8bSQfJGiOB+NZ+h0mFSqJZERxQPhqrzCw1/uuqJKbvCAE58Eb
         8ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iCM81TUMbf4MTRrAgzZQvLA35DjK3PmJFw8r+Uco+Y=;
        b=B84Ytv0mOwXszmH+MQiq4dAgSxrGIDXgCajp35upJcCIVL2xazbehoERUd6wCP91ir
         rMHTnvZFDPRaPibMo0rAdwdcsBkoInm3OWgtDe2THzlR0nI0cpHpfwOOZ/QD8ZKdbjSb
         AleCNu/dDJ2Dm7BTS5KyRxK8NIt6242BzkTYcRWLBemFY/95rpbPoixWe04KN1jtQPwl
         BGuis3jTCtJceH8PNCl1slFF+tKBlZAX4g0FkfqCGnkTnGc+7+4GxxWdPw1G7YyEqOYU
         V8oAZ/0pTlMPyD3p1yGbf7JTyxYWYZ4qTFNLh22f/IDNssEdhzjJ7mhKEL4869A1NMx9
         FI9g==
X-Gm-Message-State: ANoB5pmwhZFWLMGVOAZL38voYf12ph4VUMk7HYvraL6K9Psqxo5ezS8Y
        DI4fbY8Mta6Xh30XfPQobMmN8w==
X-Google-Smtp-Source: AA0mqf7H6nzK0rEiuAYWdiKxIKudg4Cpew7/EVDGcCKHsuQcjvSPZ5mszoePf3FEnweMadWA3RVRMA==
X-Received: by 2002:a05:6602:2012:b0:6d2:76f4:e041 with SMTP id y18-20020a056602201200b006d276f4e041mr1915237iod.11.1668203820953;
        Fri, 11 Nov 2022 13:57:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c18-20020a023f52000000b00375687c7861sm1177371jaf.108.2022.11.11.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:57:00 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:56:59 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/3] chainlint: sidestep impoverished macOS "terminfo"
Message-ID: <Y27FK61h4awaNYJf@nand.local>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
 <pull.1413.v2.git.1668152094.gitgitgadget@gmail.com>
 <de482cf9cf1c791418e4279523123580f330245b.1668152094.git.gitgitgadget@gmail.com>
 <221111.865yflo7p7.gmgdl@evledraar.gmail.com>
 <CAPig+cRwDeGyniiVGqmdMePgmR6GiYQOvNP+GUeT__zpuWV1Fg@mail.gmail.com>
 <CAPig+cRCSg=iVLUmLG=W47ofojU56CcFsobNZK5z5h9LdzXs0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRCSg=iVLUmLG=W47ofojU56CcFsobNZK5z5h9LdzXs0Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 12:15:12PM -0500, Eric Sunshine wrote:
> So, I think the fixed-up colorizing as implemented by v2 of this patch
> series is good enough for now. It can always be revisited later if
> something warrants it.

Yeah, agree. Let's not let perfect be the enemy of the good ;-).

Thanks,
Taylor
