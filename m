Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6115FC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 02:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiKJCOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiKJCOG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 21:14:06 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552041B1F2
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 18:14:06 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s10so291821ioa.5
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 18:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u2vq0+oaSjZ0eZxTqcTJZ9NkJJAZmVGIWJQ/uHKVJjE=;
        b=Ji4mw5wqpYhn6f1oe0lW0Tz1+/dm4lXJzsikQ55VC0aXGPGNwaVo8kVA+yriqxwvLy
         Q+VBQkupND0SrGpiUIyyybuUY1qKiwlHt6sOHw3+qHX/G0uzmojOTr9WQkjsJDhdpU8l
         HA6Bg2u+arjlb61gPK/JgmTe2V0rPwC6kg/lTHvbfw8Ugh1jTEZ5lAET606sotzNLhtR
         fFG/UeJy/4iHXHZZhTVpohMkvMcAGrj4plJN3q54D3Ge3y2CIq/cXtM0Key30GmH/flB
         4AqJiaUU0pjfCB9K86zi4ESmq5pn6Yse2Y6FFweJjiTnxLZz8QFwMBNMKTpiuDJkVfq2
         1hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2vq0+oaSjZ0eZxTqcTJZ9NkJJAZmVGIWJQ/uHKVJjE=;
        b=IsMDLCtdxYG8Yp4UwFKwSTye85Q+0hxsY9OvMq56eXh3e/XOnhLt200oVzJJ7cFXpz
         Ig7QxVJqzu3qIU1FtqRslbO1eMBVxF8XqiLugIKp5dwriYu7JAFEQR8V9wSbVCKEf+HG
         TApUFMA1Pe4VXrpKtwfRJRXqUkwN44zsGhz6I34v1Y2snt/6ySs2lXdG0jWXXRtsy/XT
         qowSpd9v+HkiaqhL2IyfQ5KkjM2SQbMHMpesRia5tvoX8Uh/6A//YqgfOQjG699ntYLh
         61RgOX5DRM5zkjawfyMhz5w7t1c812+mnayYj9H5A3fRYoQdpirm0lz1SvPGEesX/tXP
         D3sg==
X-Gm-Message-State: ACrzQf3KUxTZI7LKWH5oeEotAnAiuDMi3ig7BmtLuS4RS2HPrZcAW12p
        b/8NUmsa/PCUeFCQy+/mERXRbg==
X-Google-Smtp-Source: AMsMyM4Hw7jOR/u3qTBzg84BCXlb7Tppk0kTfU8nLux7pcalvVhUcl7BMJf1XmQ4jJOK6Wda63kGcQ==
X-Received: by 2002:a05:6638:15c5:b0:375:978b:53b with SMTP id i5-20020a05663815c500b00375978b053bmr2230473jat.218.1668046445591;
        Wed, 09 Nov 2022 18:14:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r4-20020a02aa04000000b0036368623574sm5285165jam.169.2022.11.09.18.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 18:14:05 -0800 (PST)
Date:   Wed, 9 Nov 2022 21:14:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 0/4] git: remove --super-prefix
Message-ID: <Y2xebII98xXBZqPq@nand.local>
References: <20221109004708.97668-1-chooglen@google.com>
 <Y2wYnpASncR2E0Ja@nand.local>
 <kl6lwn833cp0.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lwn833cp0.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 03:55:39PM -0800, Glen Choo wrote:
> > It looks like this series is broken, at least in my application of it.
> > On the first patch, running t7401, for example, I get:
> >
> >     BUG: builtin/submodule--helper.c:121: cannot have prefix 'sub/' and toplevel_cwd_prefix ''
> >     Aborted
> >
> > after running the first test (-x shows that it happens after running
> > 'git submodule summary', unsurprisingly).
> >
> > I pushed out the result of what I have to the 'gc/remove--super-prefix'
> > branch of git@github.com:ttaylorr/git.git. As you'll see, the base is
> > 'master' (as of 319605f8f0 (The eleventh batch, 2022-11-08)) with a
> > --no-ff merge of 'ab/submodule-helper-prep-only'.
> >
> > Let me know if I'm holding it wrong.
>
> No, the problem seems to be entirely on my end. (I could've sworn I sent
> this to CI..)
>
> Given that we have another competing RFC, it doesn't seem like a great
> use of time to reroll this just to unbreak "seen", but let me know if
> I'm missing somthing.

No problem. Let's drop this one for now, unless you have strong
objections.

Thanks,
Taylor
