Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C99A20D09
	for <e@80x24.org>; Mon,  5 Jun 2017 02:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdFECCW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 22:02:22 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36551 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbdFECCU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 22:02:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id v18so4759454pgb.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 19:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4YhuucbaJhfxKuW+ToSMqfat/gHCDM0mVKF7XGJmjns=;
        b=TY2KJG9ugJ/OKB3u9ZHUaohBDwrj76BNQo0Xc9Zx+IHJ9H5FtT2ZovoWXE7aQsCsnM
         ccmuUUo219CupfiNbktCVdBiHe/yOHWWcn5G68ow4rFJ8X2iapDYhXw64rgeLDgm7Opo
         f+9xOdXLy+fPQlpRGJoBHT9cObPc/WH//3ICYhkNX//qzQYZqDPZNXui/T+37olDWUnF
         Dt53TP66UO1qEr4fHBl4CXrtIFNqAnqshBFTT4XQv3s40Ay7mMUgOLQqaLKqZPj0uPxl
         1GvzqGdrjtrbMrG6Pm76SfNqO6cYSFE8JalXSPM8vaZu7tHIZsTgfLs2HO/R44tXmhjQ
         oBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4YhuucbaJhfxKuW+ToSMqfat/gHCDM0mVKF7XGJmjns=;
        b=NtGzXMxQxTtp0RfbLxsKFwa3JP8eSX+xXqOB7b5HwY+FgFcW49w6GSeuFTr4Tvlqjl
         VCpPaFuQ9Umokx34akJLtxWQoq2leksEew3Db/LrTMeEmgagjZXC705/pqPR8tJxiz+J
         M6+m4NoeTiFDjnueTiht8guRY6nMbpD9Tv68r0FN0XXFgDAlTD0vKaPg5GvB0FPLQNnD
         TTEzbT1uKjC5yiEQpAOJJNbaYRjJWnTwa3rgrpQxdaI6ipNsjWcxYweUC8lNerxy8DAa
         zMEmRcj4qg8CG6zKQ5hmJDQJLzYty0omY/+DR3nPxgad7baxBzXNoiwzHJ34pQmMjUH8
         +OPQ==
X-Gm-Message-State: AODbwcAGm5w89r/hjh2cQyNTYhDY85YOdwXx71HEJaGwuXStnRW90kAs
        h8h4PFkdCXLPuQU3VEI=
X-Received: by 10.84.210.44 with SMTP id z41mr9172489plh.143.1496628139903;
        Sun, 04 Jun 2017 19:02:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id n2sm8401023pgd.26.2017.06.04.19.02.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 19:02:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
References: <20170602103330.25663-1-avarab@gmail.com>
        <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
        <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com>
        <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
        <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
Date:   Mon, 05 Jun 2017 11:02:18 +0900
In-Reply-To: <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
        (Christian Couder's message of "Sun, 4 Jun 2017 09:37:29 +0200")
Message-ID: <xmqqa85nur85.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sun, Jun 4, 2017 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>>
>>>> My feeling exactly.  Diagnosing and failing upfront saying "well you
>>>> made a copy but it is not suitable for testing" sounds more sensible
>>>> at lesat to me.
>>>
>>> This change makes the repo suitable for testing when it wasn't before.
>>
>> Perhaps "not suitable" was a bit too vague.
>>
>> The copy you made is not in a consistent state that is good for
>> testing.  This change may declare that it is now in a consistent
>> state, but removal of a single *.lock file does not make it so.  We
>> do not know what other transient inconsistency the resulting copy
>> has; it is inherent to git-unaware copy---that is why we discouraged
>> and removed rsync transport after all.
>
> If we don't like git-unaware copies, maybe we should go back to the
> reasons why we are making one here.

We do need git-unaware bit-for-bit copy for testing, because you may
want to see the effect of unreachable objects, for example.  

It's just that git-unaware copies, because it cannot be an atomic
snapshot, can introduce inconsistencies the original repository did
not have, rendering the result ineffective.
