Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E5B1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeKNKLx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:11:53 -0500
Received: from avasout05.plus.net ([84.93.230.250]:52105 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNKLx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:11:53 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id MilwgTft2b8UmMilxgFG8H; Wed, 14 Nov 2018 00:11:09 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cOzOTGWN c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=qtP0Vn8_3-U2oNTCd-kA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v5 02/12] sha1-file: provide functions to look up hash
 algorithms
To:     Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-1-sandals@crustytoothpaste.net>
 <20181104234458.139223-3-sandals@crustytoothpaste.net>
 <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <000ff851-3068-36f0-4fff-1e69cd24cbec@ramsayjones.plus.com>
Date:   Wed, 14 Nov 2018 00:11:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <06e5bc95-b901-163a-5088-888878187ca2@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCi4QQBm8WU4sosRJH3N2vp/46+KdOM7bK9sC52wmccE8rkFXDcalsKKoEb6lrZSa1HPPjGNDBQsAperQ/D611FdHEkRafXoTZU5Qzk4TDsfi3QThVlH
 2d7Tg6x4DbGh0p0IcVvxVzo26Sb6Eps8jyZf/RVVCyBtgHXfvnQTgx9RB6hfGcAuc7epvyiXsgxewA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/11/2018 18:42, Derrick Stolee wrote:
> On 11/4/2018 6:44 PM, brian m. carlson wrote:
>> +int hash_algo_by_name(const char *name)
>> +{
>> +    int i;
>> +    if (!name)
>> +        return GIT_HASH_UNKNOWN;
>> +    for (i = 1; i < GIT_HASH_NALGOS; i++)
>> +        if (!strcmp(name, hash_algos[i].name))
>> +            return i;
>> +    return GIT_HASH_UNKNOWN;
>> +}
>> +
> 
> Today's test coverage report [1] shows this method is not covered in the test suite. Looking at 'pu', it doesn't have any callers.
> 
> Do you have a work in progress series that will use this? Could we add a test-tool to exercise this somehow?

There are actually 4 unused external symbols resulting from Brian's
'bc/sha-256' branch. The new unused externals in 'pu' looks like:

    $ diff nsc psc
    37a38,39
    > hex.o	- hash_to_hex
    > hex.o	- hash_to_hex_algop_r
    48a51
    > parse-options.o	- optname
    71a75
    > sha1-file.o	- for_each_file_in_obj_subdir
    72a77,78
    > sha1-file.o	- hash_algo_by_id
    > sha1-file.o	- hash_algo_by_name
    $ 

The symbols from hex.o and sha1-file.o being the 4 symbols from
this branch.

I suspect that upcoming patches will make use of them. ;-)

ATB,
Ramsay Jones


