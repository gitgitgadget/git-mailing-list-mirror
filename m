Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5003FC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDMSvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMSvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 14:51:33 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050CFFF
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 11:51:33 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id lh8so2962345plb.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681411892; x=1684003892;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKpTcz51KfMgGwWyX5xXZstOaSXB4yuqDCgGD3wqDnE=;
        b=fWPRgzgRxMTVkgDj5xGoTMN0KlC6P0fgU27KM1o7+avgCStzFIujxdm1TOM1o0S0Hm
         YXAxI7gOIE4zZ2VDc20WoB6PK0fgwNiyH+UhrZqsScY7EgJbW6sxI58EUSPbyt2MXwvL
         fmnIitos5q/EeLIlXNS/KZa9Wk3rUlaeYXw1CScgzq51sv2snudPuEnnwsY6fBsp2787
         hRGflDwuI4JgBuNZZKC3Qq8Ef9poYtsrMH0PrX4Ie6CY2pC2+SLYEf+XtW/wRjgllQyP
         rYffEIp1CIxbaHmPljFR/jbqRmjncfdcuIv3mci0GdKOZS23WZgZkXjtXiAVZ1RzOxUd
         kyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411892; x=1684003892;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KKpTcz51KfMgGwWyX5xXZstOaSXB4yuqDCgGD3wqDnE=;
        b=FNt+bUqveMphCd5ReKLCZxRtlrLwgMOhBV6PmtLmt2Rh32DFPMQHp0yt69wXTZ1CQy
         23z0RDBeKiF14umDoYfXnwVy30fb2BoCkvwKgX6Ct21qeTqJxMqJiHTaLcfrXmLl9EMR
         F1a4TXGA1IZSeZNI4HTDOQiJjXM0tNq+QPBgHuvZuqmKcnxbnm8UivsFpOsUw4eAgYbv
         MRX0GQVqCOCnz6eOcPuSUkTX1+YJnxPXUCByaR7xMKEzxnNClZMG3JmgTAvdfECqKYZb
         LEF/X7X/oxODwe5W6wjM7XaUS0Wd+MR8chwDVzjivSWN0jpGvtr9IDwhcR7pZqPAoFNw
         7X3g==
X-Gm-Message-State: AAQBX9fOiIkk4AVRgrfkYWgsoZ4DqlGo87S7vtVrF5zme2pj8lQ6frnr
        B4qBMVvIbeEmXnmeScoyxLNb7wlWQRQ=
X-Google-Smtp-Source: AKy350ZsdFe2imMEyQzm5WvTuG87jyNXO9P8QZCPR2uBwPS154pODAZUq4dwhYNL3A3UCanrRlOjaQ==
X-Received: by 2002:a17:90b:17c9:b0:246:a228:1359 with SMTP id me9-20020a17090b17c900b00246a2281359mr7985115pjb.23.1681411892215;
        Thu, 13 Apr 2023 11:51:32 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id v14-20020a17090a088e00b0023cfdbb6496sm3552728pjc.1.2023.04.13.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:51:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?=C3=86va?= =?utf-8?Q?r_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/2] cocci: add headings to and reword README
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <4a8b8a2a6745e791e35296e34f530b5f40f51c27.1681329955.git.gitgitgadget@gmail.com>
        <xmqq8rew7q9s.fsf@gitster.g>
        <kl6lleivk4r1.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 13 Apr 2023 11:51:31 -0700
In-Reply-To: <kl6lleivk4r1.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 13 Apr 2023 11:37:38 -0700")
Message-ID: <xmqqmt3by5sc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> From: Glen Choo <chooglen@google.com>
>>>
>>> - Drop "examples" since we actually use the patches.
>>> - Drop sentences that could be headings instead
>>>
>>> Signed-off-by: Glen Choo <chooglen@google.com>
>>> ---
>>>  contrib/coccinelle/README | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> Makes sense.  Will queue.  Thanks.
>
> I believe this was directed at just the cleanups in this patch and not
> the recommendations in the later patch?
>
> I was confused for a moment when I first saw this, and someone else
> mentioned off-list that they also thought you meant you'd queue both
> patches.

Yes, I did mean that this step made sense (not implying anything
good or bad about the other step).

I ended up saving both on 'seen' so that we can keep track.  I do
not think it is a problem---people can comment more on the patch and
I expect we would update it further.

THanks.



