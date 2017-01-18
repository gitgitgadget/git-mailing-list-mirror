Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ED8A1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbdARVQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:16:39 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:5083 "EHLO bsmtp3.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbdARVQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:16:37 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 3v3fsq594cz5tlg;
        Wed, 18 Jan 2017 22:16:31 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id CEF871CFC;
        Wed, 18 Jan 2017 22:16:28 +0100 (CET)
Subject: Re: [PATCH] mingw: follow-up to "replace isatty() hack"
To:     Junio C Hamano <gitster@pobox.com>
References: <867bafbe582df549b10729a5d688458bb6a98d51.1484741665.git.johannes.schindelin@gmx.de>
 <xmqq7f5s9nvt.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c329c981-2b92-13b5-0561-d1d2e3fa2803@kdbg.org>
Date:   Wed, 18 Jan 2017 22:16:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq7f5s9nvt.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.2017 um 20:19 schrieb Junio C Hamano:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>  compat/winansi.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/compat/winansi.c b/compat/winansi.c
>> index 3c9ed3cfe0..82b89ab137 100644
>> --- a/compat/winansi.c
>> +++ b/compat/winansi.c
>> @@ -494,19 +494,16 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
>>  	 * It is because of this implicit close() that we created the
>>  	 * copy of the original.
>>  	 *
>> -	 * Note that the OS can recycle HANDLE (numbers) just like it
>> -	 * recycles fd (numbers), so we must update the cached value
>> -	 * of "console".  You can use GetFileType() to see that
>> -	 * handle and _get_osfhandle(fd) may have the same number
>> -	 * value, but they refer to different actual files now.
>> +	 * Note that we need to update the cached console handle to the
>> +	 * duplicated one because the dup2() call will implicitly close
>> +	 * the original one.
>>  	 *
>>  	 * Note that dup2() when given target := {0,1,2} will also
>>  	 * call SetStdHandle(), so we don't need to worry about that.
>>  	 */
>> -	dup2(new_fd, fd);
>>  	if (console == handle)
>>  		console = duplicate;
>> -	handle = INVALID_HANDLE_VALUE;
>> +	dup2(new_fd, fd);
>>
>>  	/* Close the temp fd.  This explicitly closes "new_handle"
>>  	 * (because it has been associated with it).
>>

Looks good and obviously correct (FLW). I can offer a

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

but it will take a day or two until I can test the patch.

-- Hannes

