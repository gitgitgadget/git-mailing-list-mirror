Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8176BC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAVQBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjAVQBs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:01:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D131A4BF
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:01:48 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x4so7161979pfj.1
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqFUU6rtDH4a0WTRDnFdbIvEzb+tgNGK1v0yJqDhsT4=;
        b=HJdpcXSeGqVaNeH+anlHSe8w20AmDDRrsTGm64D2MiPYjmFjJhAYAEvUrJDKwHh6AN
         cIXYaXzLQp2vlmaZvxqTB4M3uMgkClCCMw6GUE+8dXLQn8WGlQKEA36oGEMV5P60QZYZ
         TtMl+zD2rUVe3BF6wRQvmtEBDRfgPHdOUQW8xselXDSaZs+31++FAFaZJwHHq609i8IN
         +dzksodth82o8AjV18Pjg8mIGd3cESOIhnLrLk+NM7pqX3VeX6/jGowU8z0Q0t94grmd
         d2jqNIxnTTMg0Pr47YZDeIg/t2wV0WsrGgCDiuR0w1ps02gP4OrVokQkGImD8YfPncJd
         b2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqFUU6rtDH4a0WTRDnFdbIvEzb+tgNGK1v0yJqDhsT4=;
        b=S0fQ3bTquNpVZkLpi7/LlBzOzEuYBJ8XGPuUTE5n5X8nQI6OIM6xLdgJOWRF+Aa6KA
         bIEUlQSSKBA1Ev9riSOhNPD7gRPKH8mUcO4jrWZrdUM6cmp90zoDCTqJ8+uvYvnqoqyx
         GqQ8sXHh35cL601khNywIdyuATieN/R07E9hKVVo5r9/zOcxlEOsya+BqadVefWy3DUp
         RNMJ2WC5B3azT4doCUEdyXcYPrBJiwB92tpCqvDiCrYUqHl0vDXUQTjShvtZMG5ir658
         EqGoFLpUeuItjHlxI2ifew3LJhVt08opHpYafZuGJZg/4EnANi/GXgdkq9e5lo8B+UZB
         HrMQ==
X-Gm-Message-State: AFqh2kpIikdOE8lNHQ5AbI2+gdess/p4NfWHtxtcv6719eAPC48SToF1
        EJB25NK0LbCsKmuFWvaQYkDrTV8kaXw=
X-Google-Smtp-Source: AMrXdXu19OrNvTW1CdIL6Da/D5XZmrHz8AqglOk4YFH30QXmIr8xvhNH/mKy1IAKomLPvKe8KLZoCQ==
X-Received: by 2002:aa7:946b:0:b0:58b:c873:54e1 with SMTP id t11-20020aa7946b000000b0058bc87354e1mr26901710pfq.24.1674403307332;
        Sun, 22 Jan 2023 08:01:47 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z20-20020aa79594000000b0058de2c315e6sm9101963pfj.158.2023.01.22.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:01:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] MyFirstContribution: refrain from self-iterating too much
References: <xmqq3583uyk0.fsf@gitster.g>
        <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
Date:   Sun, 22 Jan 2023 08:01:46 -0800
In-Reply-To: <20230122071156.367jwwt3d5txvkl4@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Sun, 22 Jan 2023 08:11:57
 +0100")
Message-ID: <xmqqcz76tv6d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> +Of course, you still may spot mistakes and rooms for improvements
>> +after you sent your initial patch.
>
> I can't resist the question: After outlining what not to do and why,
> could there be a hint what to do ?

There already is and it is the theme of the next paragraph.

People on the list do not have to see your patch immediately after
you wrote it.  Instead of seeing the initial version right now that
is followed by a series of "oops, I like this verison better than
the previous one" rerolls over 2 days, reviewers would appreciate if
a single more polished version came 2 days late and that version was
the only one they need to review.

Wait, re-read what you wrote, fix the problems you find locally, all
without sending it out until you find no more "oops, that would not
work" and simple typos.  Sleep on it.  

Of course, people are not perfect so they may still find issues
after they sent their patches out.

> It may be, that the author justs spots a simple typo, or there may
> be more heavier changes to be done.
>
> Should the author just respond to her/his patch as a reviewer does ?
> Like:
> Ops, there is a "typax", I should have written "typo".

Follow that with the same "I will fix this typo when I reroll, but
I'll wait for reviews from others" as the other one, and it would be
the second best thing you could do (the best is to avoid having to
say that, of course).

> Or:
> Re-reading my own stuff, I think that things could have been done
> in a way like this....
> Lets wait for more comments before I send out a new version.

Again, very good.
