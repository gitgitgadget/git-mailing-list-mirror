Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1BC1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 06:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfFRG6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 02:58:22 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:7909 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRG6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 02:58:22 -0400
Received: from bsmtp7.bon.at (unknown [192.168.181.103])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 45Sd7x6dDDz5v93
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 08:14:05 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45Sd7w6vdsz5tlT;
        Tue, 18 Jun 2019 08:14:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id C9BE12148;
        Tue, 18 Jun 2019 08:14:03 +0200 (CEST)
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
 <20190616185330.549436-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
 <20190618012943.GB8877@genre.crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
Date:   Tue, 18 Jun 2019 08:14:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190618012943.GB8877@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.06.19 um 03:29 schrieb brian m. carlson:
> On 2019-06-17 at 19:05:03, Johannes Schindelin wrote:
>> I guess it does not *really* matter all that much, but this does spawn a
>> new process (and I think it actually spawns 4 on Windows, for reasons, and
>> spawning processes is super expensive on Windows).
>>
>> We might actually want to think about using something like this instead
>> (which admittedly looks a bit like gobbledygook to the uninitiated, but it
>> definitely avoids any spawned process):
>>
>> test_oid_to_path () {
>> 	echo "${1%${1#??}}/${1#??}"
>> }
> 
> I'm fine making that change. The original design was because we had
> other code that used that technique and I didn't see an obviously better
> solution. Now you've provided one and a good justification.

Regardless of how it is implemented, I have another gripe with this
helper: the way it must be used requires a process: $(test_out_to_path $foo)

And looking through this patch series, I see a gazillion of *new*
process substitutions $(test_something...) and $(basename $whatever).
Can't we do something about it?

-- Hannes
