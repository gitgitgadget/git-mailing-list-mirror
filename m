Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994781FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 18:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbdA3Sls (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 13:41:48 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:19582 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbdA3Slr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 13:41:47 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3vBysc35Hkz5tlB;
        Mon, 30 Jan 2017 19:41:40 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8A15E1E7D;
        Mon, 30 Jan 2017 19:41:37 +0100 (CET)
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
Date:   Mon, 30 Jan 2017 19:41:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1701301643260.3469@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.01.2017 um 17:01 schrieb Johannes Schindelin:
> On Sat, 28 Jan 2017, René Scharfe wrote:
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 87237b092b..66cd466eea 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -527,6 +527,16 @@ static inline int ends_with(const char *str, const char *suffix)
>>  	return strip_suffix(str, suffix, &len);
>>  }
>>
>> +#define SWAP(a, b) do {						\
>> +	void *_swap_a_ptr = &(a);				\
>> +	void *_swap_b_ptr = &(b);				\
>> +	unsigned char _swap_buffer[sizeof(a)];			\
>> +	memcpy(_swap_buffer, _swap_a_ptr, sizeof(a));		\
>> +	memcpy(_swap_a_ptr, _swap_b_ptr, sizeof(a) +		\
>> +	       BUILD_ASSERT_OR_ZERO(sizeof(a) == sizeof(b)));	\
>> +	memcpy(_swap_b_ptr, _swap_buffer, sizeof(a));		\
>> +} while (0)
>> +
>>  #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
>
> It may seem as a matter of taste, or maybe not: I prefer this without the
> _swap_a_ptr

The purpose of these pointers is certainly to avoid that the macro 
arguments are evaluated more than once.

-- Hannes

