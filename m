Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69C61F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeGIPAY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 11:00:24 -0400
Received: from s019.cyon.net ([149.126.4.28]:42400 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932903AbeGIPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 11:00:22 -0400
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 11:00:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
        Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iTbdvD23kY+jAKhAaV1j8Std91bkC7vBDoHzlknZXkY=; b=h5JHSfhFYDGzxP+kpMqTPS3pSa
        4t4BndibBKz9mn7i29+i8Ufa89vHHY4PASfBKFVKErjxA7kXOWjhjE9JId11GlI+CddlIHtY6Uk7h
        YEvqZxgM2vA1PxKDKaJN8pE5uLUD0ROX8XwKOk37A2MsZQ7Bc8Y04oEsrP0WiuW+hyCGO4MZ0ueim
        7DTAUOgy/TycdQWO59jsXKha3Lp4NsaXsOz1rcKk8RFrKRNPWUCgbj5Xj5K9x1ZXRoMDqu3+9+T90
        jVvvZ4/scNiiyHTCh8K7rw/tF/HrdfNT395m/f9uGkjp4NEWflx94P8dXzk+r+aWbLXLbyL7i1s28
        ibwd6Z7Q==;
Received: from [10.20.10.230] (port=60002 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fcXSn-00BPqO-2C; Mon, 09 Jul 2018 16:48:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 09 Jul 2018 16:48:28 +0200
From:   Beat Bolli <dev+git@drbeat.li>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
In-Reply-To: <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-7-dev+git@drbeat.li>
 <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
Message-ID: <0ceeb342fec1d0868b81cd64941df53c@drbeat.li>
X-Sender: dev+git@drbeat.li
User-Agent: cyon Webmail/1.2.9
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

Am 09.07.2018 15:14, schrieb Johannes Schindelin:
> Hi Beat,
> 
> On Sun, 8 Jul 2018, Beat Bolli wrote:
> 
>> In ISO C, char constants must be in the range -128..127. Change the 
>> BOM
>> constants to unsigned char to avoid overflow.
>> 
>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>  utf8.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> diff --git a/utf8.c b/utf8.c
>> index d55e20c641..833ce00617 100644
>> --- a/utf8.c
>> +++ b/utf8.c
>> @@ -561,15 +561,15 @@ char *reencode_string_len(const char *in, int 
>> insz,
>>  #endif
>> 
>>  static int has_bom_prefix(const char *data, size_t len,
>> -			  const char *bom, size_t bom_len)
>> +			  const unsigned char *bom, size_t bom_len)
>>  {
>>  	return data && bom && (len >= bom_len) && !memcmp(data, bom, 
>> bom_len);
>>  }
>> 
>> -static const char utf16_be_bom[] = {0xFE, 0xFF};
>> -static const char utf16_le_bom[] = {0xFF, 0xFE};
>> -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>> -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
>> +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
>> +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
>> +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
>> +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
> 
> An alternative approach that might be easier to read (and avoids the
> confusion arising from our use of (signed) chars for strings pretty 
> much
> everywhere):
> 
> #define FE ((char)0xfe)
> #define FF ((char)0xff)
> 
> ...

I have tried this first (without the macros, though), and thought it 
looked
really ugly. That's why I chose this solution. The usage is pretty local 
and
close to function has_bom_prefix().

Would an explaining comment help?

Beat
