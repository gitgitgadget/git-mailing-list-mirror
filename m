Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7BD41F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbeEQW6D (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:58:03 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40979 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeEQW6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:58:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id g21-v6so7237076wrb.8
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oMiJp0pWR4phNAjY/YL1p/Yk8zK8+hEy0Ynk8p8EL7w=;
        b=gRtMf+g3MNRCMO/kM+2dutfMEV4+K99CujKXnCJmruE4RDct5XCXCBMmnGDM3MoFJ8
         VYbRo1eSdRuRhsjmr5C5aylOVGnfeRs1U4en8w76Hnfnx97dEBvlqRLqIu1Ueo5oB8hR
         F3eumWP9KCagWaHVcF3QLCIZoMWgGtQt9eKKN9OXdZIu0NWkUrCsjoX2UQJ9mb5h9kBQ
         yCtIboAj9SNEKvVrTJj1B1eqG9E0i9opoaEj7rHRIE5BbvSjcU/g5yaqlpWFiBUUb4UA
         BysXpSkd1p9wDCp22KR4MaPmit3fGjPpbM/JrjD+09ECz2dH8OctFwMZrJ9iyLP5mRCh
         p3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oMiJp0pWR4phNAjY/YL1p/Yk8zK8+hEy0Ynk8p8EL7w=;
        b=fgM9vX9Mqg7/f5yzTA+bD/D5HQtDwImIUE6HP3EqeaeBm2Zb9/DM0/KNPjjLhy/AJB
         Z2GN6HtNb2WW4oSCO1Ds7qFJ1yJxDdbRHb9DyVwzCHUabI2c0MqRwxVTM0idcH0CK/T1
         xZMun/SIQJm1P7GbMd3Gx18Sl61EYQjOTBcA5FvmVl2zGK1kczF1otLR36Ba3MabLhY7
         QQCYvoZocO5t3U22ctx7TNC94B1AGp0B/06n3XJbp+JRsNucnQ0vevYIXB2AWHpJ+t5o
         tJq5CWpaT9xJxGneBk9LFPCNulzY31xj5Kq54pLFhOEm4hIHQEziS9hhDvq+4LFoTprT
         JW1w==
X-Gm-Message-State: ALKqPwcncKef+EHZT+yUuTU0CM/ZfNT6d7arZHZ/Tt+iufEpql5tUwvu
        uQJXNoTHo+B2Rn+YGpXruDw=
X-Google-Smtp-Source: AB8JxZqp1BRy5TMLKiCHKzRjpDC+nV9UxHqRDSIArC5q+yyiviF1b0kQCqs/FWTGLj7GUMN2PsJzgw==
X-Received: by 2002:adf:884c:: with SMTP id e12-v6mr6118958wre.30.1526597880766;
        Thu, 17 May 2018 15:58:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s5-v6sm7380153wra.48.2018.05.17.15.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:58:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] grep: handle corrupt index files early
References: <20180515010425.149200-1-sbeller@google.com>
        <CACsJy8AcG6zGa9vLCwm2B4ishyJVWdFQ2YV0FOZTor_0x8Q64g@mail.gmail.com>
        <CAGZ79kYYy-r+Zs_6yg1ZVRNsBcTUdPWE=FeHrp_=0cV0Uf_GfQ@mail.gmail.com>
        <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
        <xmqqbmdf6p1t.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbvjoTq5079Ks+h2HNb+D99RELYPcJk2=pvZf9-Y8dToQ@mail.gmail.com>
Date:   Fri, 18 May 2018 07:57:59 +0900
In-Reply-To: <CAGZ79kbvjoTq5079Ks+h2HNb+D99RELYPcJk2=pvZf9-Y8dToQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 17 May 2018 10:21:23 -0700")
Message-ID: <xmqq36yp6gaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, May 16, 2018 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> With a majority of call sites dying like this though, I wonder if we
>>> should just add repo_read_index_or_die() with die() inside. Then the
>>> next person won't likely accidentally forget _()
>>
>> Yuck.
>>
>> That sounds like inviting a major code churn.  I tend to agree that
>> it would be a good clean-up for longer term maintenance, but I am
>> not sure if I can honestly say I'd look forward to such a clean-up
>> at this point in the cycle when there are tons of large-ish topics
>> in flight X-<.
>
> ok, consider the series
> https://public-inbox.org/git/20180516222118.233868-1-sbeller@google.com/
> retracted for this cycle; I will keep it around and resend it at some future
> date, hopefully.

Thanks.  I didn't realize you've _already_ done that.
