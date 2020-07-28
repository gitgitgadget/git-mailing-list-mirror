Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C91C433E0
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 17:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD9B20825
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 17:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPhzlxiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgG1RPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbgG1RPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 13:15:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38345C061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 10:15:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u185so11302392pfu.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IHxTHnhtrgJ3hl0GwwjoFCK+NegSPfB4X03JijvlGpo=;
        b=sPhzlxiOtk7CqazrkoOs/b/kFFA16yzIhnA43x/Xxno82j8BcBOwwIue7Mss2p19tU
         nQ4QlLROqI4znbOSIQzKE5EVC0/M3O/1bIQwzGeYG7ZRTCb42BjA5PeC3hJ8hZ/mkH3c
         Vy3Y+awIEclQVBlmsFfxxzje8U2oSm4b3fTJFzkG62S0vs76yUSQYuHAKZ8B33kxYHk3
         R9hYhvnfNTABi0/OsBh/NCh+s5NMASgOc+zJgvC9eq8oCDJ1bctZvkgMq/v616kEtw5c
         59jrPNsCnnzfzdEawy6dJZNwGsNbbn+GsN1/pmRnyCfQ8ZT3XVubuhcHnFkcw1vGNpqT
         cVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHxTHnhtrgJ3hl0GwwjoFCK+NegSPfB4X03JijvlGpo=;
        b=gu/U88wLTrJVUCDoxbyeqmeeQO5YpE0Kzx7HO8dnEs/vC7N31QV9AdNz370sj2r1tx
         /RmazrtbGCDoGTboRqj4pIsxkbI6dH8JmCDnTQCahGVqMmgQGKyQovpWvhKz25pkxtWl
         bVXUDaOebk6LD0ebVZFPMSVWDFv449l0NogTWRSZdQcPVDVgdBsVtIG5+w8XGN1I9kEy
         AkmfPleo3jy2VCbXVw1WeL+mWbl3rZWpwWXSduvEfY3WLgge7UlyPNjaVX7auD5JlgGD
         OZBkvohpsNULvoz3tdaOIhncBEVFd7dScF2wSjEnOCcS7+g4vNrf5fG4EedKKY6iFwUB
         CkAQ==
X-Gm-Message-State: AOAM533Q1fUO3xX6Ed5mTTymh6KnlslBJNOaLYP+zENxfRhtd54U8mMS
        zXcKrxZ2dgZkilExcaa7Lungzyh6
X-Google-Smtp-Source: ABdhPJyQy0lvE68zjRWnY7c8LtKIEh08OWQXsxpMdjh32YCJ+cVm1IUkndMg2BoPtBNaOlJ15l8Y/Q==
X-Received: by 2002:a62:2b85:: with SMTP id r127mr24348116pfr.239.1595956512745;
        Tue, 28 Jul 2020 10:15:12 -0700 (PDT)
Received: from [192.168.208.44] ([49.207.128.54])
        by smtp.gmail.com with ESMTPSA id z9sm18989309pgh.94.2020.07.28.10.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 10:15:12 -0700 (PDT)
Subject: Re: Git Inclusion Summit
To:     Taylor Blau <me@ttaylorr.com>, Eric Wong <e@80x24.org>
Cc:     Carmen Andoh <candoh@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
 <20200726040226.GA19030@dcvr> <20200727151023.GB62919@syl.lan>
 <20200728100726.GA24408@dcvr> <20200728162528.GH87373@syl.lan>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <6b4b3f77-a479-4d7b-d7c2-e3e35e658ac7@gmail.com>
Date:   Tue, 28 Jul 2020 22:45:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728162528.GH87373@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-07-2020 21:55, Taylor Blau wrote:
> On Tue, Jul 28, 2020 at 10:07:26AM +0000, Eric Wong wrote:
>>
>> Jitsi w/ audio-only certainly seems to be a step in the right
>> direction and would be more inclusive.
>>
>> Is there any speech-to-text transcription done for the hearing
>> (or extremely bandwidth) impaired?
> 
> It looks like such a thing exists:
> https://jitsi.org/blog/a-speech-to-text-prototype/.
> 

Yeah. A link with current information appears to be:

https://github.com/jitsi/jigasi#using-jigasi-to-transcribe-a-jitsi-meet-conference

>> It'd ideally go to #git on IRC (or something that doesn't
>> require a browser to trigger swap storms on old systems).
>>
>> Even for people with good hearing, acceptable audio quality for
>> speech seems tricky to get right, being dependent on mics,
>> bandwidth, codecs, background noise, speaker/earphone quality,
>> etc.
> 
> I haven't look hard enough to see if it supports redirecting its output
> to an IRC channel, but my guess is that it probably doesn't.

I believe you're right. From the link above:

> Currently Jigasi can send speech-to-text results to the chat of a
> Jitsi Meet room as either plain text or JSON. If it's send in JSON,
> Jitsi Meet will provide subtitles in the left corner of the video,
> while plain text will just be posted in the chat.

> In either
> case, hopefully disabling audio and video is possible within Jitsi's web
> UI, and you should be able to read or write in the chat as well as read
> the transcription.
> 

I think there's just one catch. The transcription as of now appears to
use Google Cloud speech-to-text API. Well, its Google. I'll let you make
your own inferences. In any case, it hopefully wouldn't be a concern for
people who _read_ the transcription.

-- 
Sivaraam
