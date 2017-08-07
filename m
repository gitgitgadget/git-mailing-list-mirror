Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC7B2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdHGRKt (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:10:49 -0400
Received: from 1.mo176.mail-out.ovh.net ([178.33.254.253]:39094 "EHLO
        1.mo176.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdHGRKs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:10:48 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo176.mail-out.ovh.net (Postfix) with ESMTPS id 50E046B132;
        Mon,  7 Aug 2017 19:10:47 +0200 (CEST)
Received: from [10.0.2.127] (86.200.136.234) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 7 Aug
 2017 19:10:46 +0200
Subject: Re: [PATCH 4/4] imap-send: use curl by default
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
CC:     Git Mailing List <git@vger.kernel.org>
References: <c74c8c386f2c2d8b6cebd4addf925d0121986067.1502114584.git.nicolas@morey-chaisemartin.com>
 <71479602-fabc-1861-124b-90b26b952344@morey-chaisemartin.com>
 <CAN0heSoRXX_9-yzFf=2Obj_5WosLwK4UtrFrLsw8asdUea1+Yg@mail.gmail.com>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Message-ID: <890d4028-1351-a7b9-1797-cf419d5f01e8@morey-chaisemartin.com>
Date:   Mon, 7 Aug 2017 19:10:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:55.0) Gecko/20100101
 Thunderbird/55.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoRXX_9-yzFf=2Obj_5WosLwK4UtrFrLsw8asdUea1+Yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: fr-xx-classique+reforme1990
X-Originating-IP: [86.200.136.234]
X-ClientProxiedBy: EX1.indiv2.local (172.16.2.1) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 11463631377836206045
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelkedrkedugdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 07/08/2017 à 18:37, Martin Ågren a écrit :
> On 7 August 2017 at 16:04, Nicolas Morey-Chaisemartin
> <nicolas@morey-chaisemartin.com> wrote:
>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
>> ---
>>  imap-send.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 90b8683ed..4ebc16437 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -35,13 +35,7 @@ typedef void *SSL;
>>  #include "http.h"
>>  #endif
>>
>> -#if defined(USE_CURL_FOR_IMAP_SEND) && defined(NO_OPENSSL)
>> -/* only available option */
>>  #define USE_CURL_DEFAULT 1
>> -#else
>> -/* strictly opt in */
>> -#define USE_CURL_DEFAULT 0
>> -#endif
>>
>>  static int verbosity;
>>  static int use_curl = USE_CURL_DEFAULT;
> So this is now basically "static int use_curl = 1;".
>
> Do we need a compile-time escape-hatch in case someone really needs
> to avoid curl, e.g., because they have a too old version? I suppose
> there is a conceptual difference between the "default", i.e., the value
> of USE_CURL_DEFAULT that is assigned to "use_curl", and the "default
> default", i.e., the value that is normally assigned to USE_CURL_DEFAULT.
>
> Martin

The curl code depends on USE_CURL_FOR_IMAP_SEND so even with use_curl == 1, it won't be an issue for people without curl (or old one).
I wasn't sure whether to drop the define or not and figure it might be worth keeping in case in change in the future for some reason.
I don't mind dropping it and hardcofing the default to 1

Also on a side note, I have a case where authentication works with --no-curl but fails withs --curl. Still trying to figure out why.

Nicolas
