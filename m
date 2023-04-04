Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984C7C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 16:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjDDQiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjDDQiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 12:38:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69801FD4
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 09:38:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id r7-20020a17090b050700b002404be7920aso32709750pjz.5
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680626288;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKqfPmKPIk1QbOyjtgI8/590j+oEIN1pRazV+I2i1Ig=;
        b=Aek9Xe2aeqWAqBpn76J45Eyav/3H3jzO1fJI2jw8Bedy1jjcnASB4f/pQQHqOGifi9
         7z/HOItyDGi5nLtus4CK6t4ZGAHuYrKuD6nfyKTuDI7yfzmcdqEttn1tVezFlXxyK7sJ
         bcM53q40UpBRT1PC+4wpTwC1HzrAvyQYczdb2meutjab4f7shAOIn4LGg17d7C9JGsci
         A/I753zpp8psSMxk6wMIPVhfwAQvbOdL5/FQCOadTD+/2a+DL83SnFfd7jxBQDIlNr2B
         pJQ4Fmb0e+IXxq73aWLlpCJhuYC1GSNPPZXsWzERUFdvM2HN6p1aZz72fI9tPIM/3WfX
         2dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680626288;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKqfPmKPIk1QbOyjtgI8/590j+oEIN1pRazV+I2i1Ig=;
        b=Nk36qoF/ZUorkKTHFJuy+8OP3nBTCIQFo2YRsGcGvCMqyYc40qW1IL5/phqEnf5pwt
         2lYP17pKluWEuIR339jN7rtBOplsPTsSgTOcSeiWdBOuiTE5++o/Lw/WBnW/t3ULRudv
         fFC41Me0+2kK2jsGAMt5R7i8xkkplMbQ6sYnV4TUKdd6/hIpBaSRZu4NzQ3UgRriNBcL
         LlBfCIwFlPzR3L/MhTRuH04CpAiZX0B5+Ycyd9LFKrWH93ugxmh6UAh1sJFwDHHIrXFb
         kGam1b3kT4ISa6v2euBvju4IVUSBJoHiMXH+lKgh0ChtXjJK6Hokm5jafzwrsJsPN06A
         i5UQ==
X-Gm-Message-State: AAQBX9eW9EQ1vflIMGifFscQdSbHnbTML/KJlKXzZixdjFDGba9yZn14
        /vXGKel/mB2J1kl7iRPYElQ=
X-Google-Smtp-Source: AKy350afjO35Gw+htujwpZQgEMw4YyKH5nTuTXkgSLbUv1LgAos/HnFz8CacSEhdM64402Xrbglc5Q==
X-Received: by 2002:a17:90a:1042:b0:237:3dfb:9095 with SMTP id y2-20020a17090a104200b002373dfb9095mr3645267pjd.6.1680626287916;
        Tue, 04 Apr 2023 09:38:07 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a0f000000b00502e7115cbdsm7742682pga.51.2023.04.04.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 09:38:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel =?utf-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>
Cc:     git@vger.kernel.org
Subject: Re: mirror clone does not keep HEAD updated
References: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x>
Date:   Tue, 04 Apr 2023 09:38:07 -0700
In-Reply-To: <harpgnimhcdp2m6hww7ht7pgxvchllvrncnwoxkivaorb5xhm7@5rcr2p7hcp4x>
        ("Daniel =?utf-8?Q?Mart=C3=AD=22's?= message of "Tue, 4 Apr 2023 17:16:57
 +0100")
Message-ID: <xmqqileb1u34.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Martí <mvdan@mvdan.cc> writes:

> I'm testing `git clone --mirror` to properly mirror a repository on
> github.com. It appears to be working well, except for keeping HEAD
> correctly in place.

There is no such feature in "git clone" or "git fetch" to check what
branch the remote HEAD is pointing at and move the local copy around.
For a long time, even "git clone" did not have a reliable way to see
where the HEAD at the remote site points at, and it used heuristics
to guess what name to give to the first branch on the local side.

Modern versions of Git these days have a protocol level support to
convey that information, and I think it is feasible to invent such a
feature to automatically repoint refs/remotes/$remote/HEAD to
whatever remote-tracking branch found in the refs/remotes/$remote/
hierarchy.

I do not think anybody is working on such a project, though.

We are pretty much "somebody should initiate the process to scratch
their own itch, and we will help them in doing so" community, so you
or somebody who reads this thread interesting will hopefully start
such an effort ;-)

Thanks.
