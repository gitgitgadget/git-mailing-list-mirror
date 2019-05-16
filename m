Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6430C1F461
	for <e@80x24.org>; Thu, 16 May 2019 19:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEPTLP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 15:11:15 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:11824 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfEPTLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 15:11:15 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 454gxr0n1Xz5tlF;
        Thu, 16 May 2019 21:11:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2F505496E;
        Thu, 16 May 2019 21:11:11 +0200 (CEST)
Subject: Re: [PATCH v2 1/7] run-command: add preliminary support for multiple
 hooks
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514002332.121089-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1905141653130.44@tvgsbejvaqbjf.bet>
 <20190515224425.GK7458@genre.crustytoothpaste.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Message-ID: <91532c2d-7536-6e15-728b-bd18256b2ef3@kdbg.org>
Date:   Thu, 16 May 2019 21:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515224425.GK7458@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.05.19 um 00:44 schrieb brian m. carlson:
> On Tue, May 14, 2019 at 05:12:39PM +0200, Johannes Schindelin wrote:
>> On Tue, 14 May 2019, brian m. carlson wrote:
>>> +/*
>>> + * Return 1 if a hook exists at path (which may be modified) using access(2)
>>> + * with check (which should be F_OK or X_OK), 0 otherwise. If strip is true,
>>> + * additionally consider the same filename but with STRIP_EXTENSION added.
>>> + * If check is X_OK, warn if the hook exists but is not executable.
>>> + */
>>> +static int has_hook(struct strbuf *path, int strip, int check)
>>> +{
>>> +	if (access(path->buf, check) < 0) {
>>> +		int err = errno;
>>> +
>>> +		if (strip) {
>>> +#ifdef STRIP_EXTENSION
>>> +			strbuf_addstr(path, STRIP_EXTENSION);
>>> +			if (access(path->buf, check) >= 0)
>>> +				return 1;
>>> +			if (errno == EACCES)
>>> +				err = errno;
>>> +#endif
>>> +		}
>>
>> How about simply guarding the entire `if()`? It is a bit unusual to guard
>> *only* the inside block ;-)
> 
> I can make that change.

But then we'll have an unused argument in some build configurations.

-- Hannes
