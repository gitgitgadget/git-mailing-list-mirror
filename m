Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDF41F453
	for <e@80x24.org>; Fri,  5 Oct 2018 06:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeJENM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 09:12:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45276 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeJENM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 09:12:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so12230598wrw.12
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 23:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=WPCSDuLGU4fuigigvEVevH1qqvLfRBKyERfyYAlZwLM=;
        b=Dv01RM+1tjIXIne7k4TEJJTjBMu0M5ZzUxjyBoXHeC2GphgS8sFW7Um1e+471pe8J9
         Oxh6Usaj3zvAG5ddY3uuVFtrRrugnX4m5gCBM3ziiDD6cGEOHEAVmc4iSmRL6vxLtpUD
         pWXe66R7Xyl2Di013otRlDLYq2eRIGMFobu0NsBqB8aMr1/heaTNav9wEUtAWVa1tBN0
         z2JmPWSTyItvpzA9OfYduA8dw+cUWk1D/xgg+bdfca0VJZicrPxsxlFhe6dX0Tzcna8j
         sha/i+zFhqASlCTB0cSgf43shg4Al00zCDRUvs7JCm/+efHygp9ePw3PI1UZ8VOdi8L6
         YxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=WPCSDuLGU4fuigigvEVevH1qqvLfRBKyERfyYAlZwLM=;
        b=s4cRUOJT3Pv/o0f3hq+4ViTC8sQjC9GKbUnRUYywrzBcbDlmNbLy7nu8vbIZ5oBvqh
         wxRU1zLZai6y+V7VF5FNkoo98AnFPrJYl4lKhAsfMAnAgqkSwzWWDVbTG+WkNJ8AfD4n
         TXhHWc5piWFR1vesb73UfvSe/tLj79qoFUA/9tZ0Nkg0qInetmDaVdR8jUiPyreUrWnI
         SyzJvnucjauDCeuEjFlN9nE9adFtxY5QrkpTHyjwJg1sMVav5J7Z3uRSBGPgYEpngePu
         +y25Hv0nMrXCgiYHA6YmMZgu5LsVFSQWd/qtio9PpUTuwJ7xivylImHEMIDRac0BZfST
         E02g==
X-Gm-Message-State: ABuFfoi+/JJBdu4zr0X1jw1H40zC6f4NyBhu9LduQ1VBKf2AnGHsATD0
        s7a0tzvAK50QKHurhoUZot7B5esD6xU=
X-Google-Smtp-Source: ACcGV62r/sIULFxMvnzNiNi8qUn/iMv8FU/Fmb2rGoz0acIusKFjenFD7t/e3tDZPsT6m2HzF3Hcdw==
X-Received: by 2002:adf:8022:: with SMTP id 31-v6mr7542703wrk.16.1538720145411;
        Thu, 04 Oct 2018 23:15:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h64-v6sm826200wmh.27.2018.10.04.23.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:15:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Fix the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com>
        <20180928162459.17138-1-szeder.dev@gmail.com>
        <20180930144731.GJ23446@localhost>
Date:   Thu, 04 Oct 2018 23:15:43 -0700
Message-ID: <xmqqbm883omo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Fri, Sep 28, 2018 at 06:24:53PM +0200, SZEDER Gábor wrote:
>> Interdiff:
>> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
>> index c8acbc50d0..f053bf83eb 100755
>> --- a/t/t1700-split-index.sh
>> +++ b/t/t1700-split-index.sh
>> @@ -6,6 +6,9 @@ test_description='split index mode tests'
>>  
>>  # We need total control of index splitting here
>>  sane_unset GIT_TEST_SPLIT_INDEX
>
> The conflict resolution around here in 3f725b07d3 (Merge branch
> 'sg/split-index-racefix' into jch, 2018-09-29) accidentally removed
> the above line, ...

Yeah, I see it in "git show --cc".  Will fix the rerere database
entry to prevent the mismerge from recurring..

Sorry, and thanks for helping me correcting the mismerge.

