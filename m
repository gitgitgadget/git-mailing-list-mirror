Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80DB21F461
	for <e@80x24.org>; Sun, 30 Jun 2019 20:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfF3U7i (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 16:59:38 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:13120 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfF3U7i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 16:59:38 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45cND73s8pz5tl9;
        Sun, 30 Jun 2019 22:59:35 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id EF1074A8F;
        Sun, 30 Jun 2019 22:59:34 +0200 (CEST)
Subject: Re: [PATCH] t5319: don't trip over a user name with whitespace
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.261.git.gitgitgadget@gmail.com>
 <d4a3f56b-5eaa-1325-f8c1-be6797a9ac03@kdbg.org>
 <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <1a5bb5f9-e090-7f42-ec3f-cd74bcad831f@kdbg.org>
Date:   Sun, 30 Jun 2019 22:59:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAPig+cRpOHRgtCXXiqAZtmEtkWnMy7=4GsTVv0XB9R3fF0-66A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.06.19 um 21:48 schrieb Eric Sunshine:
> On Sun, Jun 30, 2019 at 2:57 PM Johannes Sixt <j6t@kdbg.org> wrote:
>> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
>> @@ -443,7 +443,7 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
>> -               MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
>> +               MINSIZE=$(stat -c %s .git/objects/pack/*pack | sort -n | head -n 1) &&
> 
> Unfortunately, this is not portable. While "stat -c %s" works on Linux
> and MSYS2, neither that option nor the format directive are recognized
> on BSD-like platforms (I tested Mac OS and FreeBSD), which instead
> need "stat -f %z".

Ouch! I did notice that stat(1) is not in POSIX, but hoped that it was
sufficiently portable. I need a new idea...

-- Hannes
